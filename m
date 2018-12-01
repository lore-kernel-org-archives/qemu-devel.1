Received: from eggs.gnu.org ([2001:4830:134:3::10]:59947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gT2mH-0007fX-V5
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 05:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gT2mG-0001ka-BS
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 05:45:37 -0500
Date: Sat, 1 Dec 2018 10:45:26 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181201104526.GJ27120@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-12-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181130220344.3350618-12-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/14] nbd/client: Add
 nbd_receive_export_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, nsoffer@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, Nov 30, 2018 at 04:03:40PM -0600, Eric Blake wrote:
> We want to be able to detect whether a given qemu NBD server is
> exposing the right export(s) and dirty bitmaps, at least for
> regression testing.  We could use 'nbd-client -l' from the upstream
> NBD project to list exports, but it's annoying to rely on
> out-of-tree binaries; furthermore, nbd-client doesn't necessarily
> know about all of the qemu NBD extensions.  Thus, we plan on adding
> a new mode to qemu-nbd that merely sniffs all possible information
> from the server during handshake phase, then disconnects and dumps
> the information.
>=20
> This patch adds the low-level client code for grabbing the list
> of exports.  It benefits from the recent refactoring patches, as
> well as a minor tweak of changing nbd_opt_go() to nbd_opt_info_go(),

I would probably have called the new function
=E2=80=98nbd_opt_info_or_opt_go=E2=80=99, but then I prefer longer descri=
ptive names.

> in order to share as much code as possible when it comes to doing
> validation of server replies.  The resulting information is stored
> in an array of NBDExportInfo which has been expanded to hold more
> members, along with a convenience function for freeing the list.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/nbd.h |  15 +++-
>  nbd/client.c        | 166 ++++++++++++++++++++++++++++++++++++++++++--
>  nbd/trace-events    |   2 +-
>  3 files changed, 174 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 65feff8ba96..74d006b8d62 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -262,6 +262,9 @@ struct NBDExportInfo {
>      /* Set by client before nbd_receive_negotiate() */
>      bool request_sizes;
>      char *x_dirty_bitmap;
> +
> +    /* Set by client before nbd_receive_negotiate(), or by server resu=
lts
> +     * during nbd_receive_export_list() */
>      char *name; /* must be non-NULL */
>=20
>      /* In-out fields, set by client before nbd_receive_negotiate() and
> @@ -269,7 +272,8 @@ struct NBDExportInfo {
>      bool structured_reply;
>      bool base_allocation; /* base:allocation context for NBD_CMD_BLOCK=
_STATUS */
>=20
> -    /* Set by server results during nbd_receive_negotiate() */
> +    /* Set by server results during nbd_receive_negotiate() and
> +     * nbd_receive_export_list() */
>      uint64_t size;
>      uint16_t flags;
>      uint32_t min_block;
> @@ -277,12 +281,21 @@ struct NBDExportInfo {
>      uint32_t max_block;
>=20
>      uint32_t meta_base_allocation_id;
> +
> +    /* Set by server results during nbd_receive_export_list() */
> +    char *description;
> +    int n_contexts;
> +    char **contexts;
>  };
>  typedef struct NBDExportInfo NBDExportInfo;
>=20
>  int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>                            const char *hostname, QIOChannel **outioc,
>                            NBDExportInfo *info, Error **errp);
> +void nbd_free_export_list(NBDExportInfo *info, int count);
> +int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds=
,
> +                            const char *hostname, NBDExportInfo **info=
,
> +                            Error **errp);
>  int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
>               Error **errp);
>  int nbd_send_request(QIOChannel *ioc, NBDRequest *request);
> diff --git a/nbd/client.c b/nbd/client.c
> index a282712724d..6292de560ee 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -351,7 +351,8 @@ static int nbd_receive_list(QIOChannel *ioc, const =
char *want, bool *match,
>   * used, 0 if NBD_OPT_GO is unsupported (fall back to NBD_OPT_LIST and
>   * NBD_OPT_EXPORT_NAME in that case), and > 0 if the export is good to
>   * go (with the rest of @info populated). */
> -static int nbd_opt_go(QIOChannel *ioc, NBDExportInfo *info, Error **er=
rp)
> +static int nbd_opt_info_go(QIOChannel *ioc, uint32_t opt,
> +                           NBDExportInfo *info, Error **errp)
>  {
>      NBDOptionReply reply;
>      uint32_t len =3D strlen(info->name);
> @@ -364,7 +365,8 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInf=
o *info, Error **errp)
>       * flags still 0 is a witness of a broken server. */
>      info->flags =3D 0;
>=20
> -    trace_nbd_opt_go_start(info->name);
> +    assert(opt =3D=3D NBD_OPT_GO || opt =3D=3D NBD_OPT_INFO);
> +    trace_nbd_opt_go_start(nbd_opt_lookup(opt), info->name);
>      buf =3D g_malloc(4 + len + 2 + 2 * info->request_sizes + 1);
>      stl_be_p(buf, len);
>      memcpy(buf + 4, info->name, len);
> @@ -373,7 +375,7 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInf=
o *info, Error **errp)
>      if (info->request_sizes) {
>          stw_be_p(buf + 4 + len + 2, NBD_INFO_BLOCK_SIZE);
>      }
> -    error =3D nbd_send_option_request(ioc, NBD_OPT_GO,
> +    error =3D nbd_send_option_request(ioc, opt,
>                                      4 + len + 2 + 2 * info->request_si=
zes,
>                                      buf, errp);
>      g_free(buf);
> @@ -382,7 +384,7 @@ static int nbd_opt_go(QIOChannel *ioc, NBDExportInf=
o *info, Error **errp)
>      }
>=20
>      while (1) {
> -        if (nbd_receive_option_reply(ioc, NBD_OPT_GO, &reply, errp) < =
0) {
> +        if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
>              return -1;
>          }
>          error =3D nbd_handle_reply_err(ioc, &reply, errp);
> @@ -733,8 +735,12 @@ static int nbd_negotiate_simple_meta_context(QIOCh=
annel *ioc,
>                  nbd_send_opt_abort(ioc);
>                  return -1;
>              }
> +            g_free(name);
> +        } else {
> +            info->contexts =3D g_renew(char *, info->contexts,
> +                                     ++info->n_contexts);
> +            info->contexts[info->n_contexts - 1] =3D name;
>          }
> -        g_free(name);
>          received =3D true;
>=20
>          /* receive NBD_REP_ACK */
> @@ -828,7 +834,9 @@ static int nbd_start_negotiate(QIOChannel *ioc, QCr=
yptoTLSCreds *tlscreds,
>              clientflags |=3D NBD_FLAG_C_FIXED_NEWSTYLE;
>          }
>          if (globalflags & NBD_FLAG_NO_ZEROES) {
> -            *zeroes =3D false;
> +            if (zeroes) {
> +                *zeroes =3D false;
> +            }
>              clientflags |=3D NBD_FLAG_C_NO_ZEROES;
>          }
>          /* client requested flags */
> @@ -921,7 +929,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoT=
LSCreds *tlscreds,
>           * TLS).  If it is not available, fall back to
>           * NBD_OPT_LIST for nicer error messages about a missing
>           * export, then use NBD_OPT_EXPORT_NAME.  */
> -        result =3D nbd_opt_go(ioc, info, errp);
> +        result =3D nbd_opt_info_go(ioc, NBD_OPT_GO, info, errp);
>          if (result < 0) {
>              return -EINVAL;
>          }
> @@ -993,6 +1001,150 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryp=
toTLSCreds *tlscreds,
>      return 0;
>  }
>=20
> +/* Clean up result of nbd_receive_export_list */
> +void nbd_free_export_list(NBDExportInfo *info, int count)
> +{
> +    int i, j;
> +
> +    for (i =3D 0; info && i < count; i++) {
> +        free(info[i].name);
> +        free(info[i].description);
> +        for (j =3D 0; j < info[i].n_contexts; j++) {
> +            free(info[i].contexts[j]);
> +        }
> +        free(info[i].contexts);
> +    }
> +    free(info);
> +}
> +
> +/* Query details about a server's exports, then disconnect without
> + * going into transmission phase. Return a count of the exports listed
> + * in @info by the server, or -1 on error. Caller must free @info. */
> +int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds=
,
> +                            const char *hostname, NBDExportInfo **info=
,
> +                            Error **errp)
> +{
> +    int result;
> +    int count =3D 0;
> +    int i;
> +    int rc;
> +    int ret =3D -1;
> +    NBDExportInfo *array =3D NULL;
> +    uint32_t oldflags;
> +    QIOChannel *sioc =3D NULL;
> +    bool try_context =3D true;
> +
> +    *info =3D NULL;
> +    result =3D nbd_start_negotiate(ioc, tlscreds, hostname, &sioc, tru=
e, NULL,
> +                                 errp);
> +    if (tlscreds && sioc) {
> +        ioc =3D sioc;
> +    }
> +
> +    switch (result) {
> +    case 2:
> +        /* meta contexts are only useful with structured reply */
> +        try_context =3D false;
> +        /* fall through */
> +    case 3:
> +        /* newstyle - use NBD_OPT_LIST to populate array, then try
> +         * NBD_OPT_INFO on each array member. If structured replies
> +         * are enabled, also try NBD_OPT_LIST_META_CONTEXT. */
> +        if (nbd_send_option_request(ioc, NBD_OPT_LIST, 0, NULL, errp) =
< 0) {
> +            goto out;
> +        }
> +        while (1) {
> +            char *name;
> +            char *desc;
> +
> +            rc =3D nbd_receive_list(ioc, NULL, NULL, &name, &desc, err=
p);
> +            if (rc < 0) {
> +                goto out;
> +            } else if (rc =3D=3D 0) {
> +                break;
> +            }
> +            array =3D g_renew(NBDExportInfo, array, ++count);
> +            memset(&array[count - 1], 0, sizeof(*array));
> +            array[count - 1].name =3D name;
> +            array[count - 1].description =3D desc;
> +            array[count - 1].structured_reply =3D result =3D=3D 3;
> +        }
> +
> +        for (i =3D 0; i < count; i++) {
> +            array[i].request_sizes =3D true;
> +            rc =3D nbd_opt_info_go(ioc, NBD_OPT_INFO, &array[i], errp)=
;
> +            if (rc < 0) {
> +                goto out;
> +            } else if (rc =3D=3D 0) {
> +                /* Pointless to try rest of loop. If OPT_INFO doesn't =
work,
> +                 * it's unlikely that meta contexts work either */
> +                break;
> +            }
> +
> +            if (try_context) {
> +                rc =3D nbd_negotiate_simple_meta_context(
> +                    ioc, NBD_OPT_LIST_META_CONTEXT, NULL, &array[i], e=
rrp);
> +                if (rc < 0) {
> +                    goto out;
> +                } else if (rc =3D=3D 0) {
> +                    try_context =3D false;
> +                }
> +            }
> +        }
> +
> +        /* Send NBD_OPT_ABORT as a courtesy before hanging up */
> +        nbd_send_opt_abort(ioc);
> +        break;
> +    case 1: /* newstyle, but limited to EXPORT_NAME */
> +        error_setg(errp, "Server does not support export lists");
> +        /* We can't even send NBD_OPT_ABORT, so merely hang up */
> +        goto out;
> +    case 0: /* oldstyle, parse length and flags */
> +        array =3D g_new0(NBDExportInfo, 1);
> +        array->name =3D g_strdup("");
> +        count =3D 1;
> +
> +        if (nbd_read(ioc, &array->size, sizeof(array->size), errp) < 0=
) {
> +            error_prepend(errp, "Failed to read export length: ");
> +            goto out;
> +        }
> +        array->size =3D be64_to_cpu(array->size);
> +
> +        if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
> +            error_prepend(errp, "Failed to read export flags: ");
> +            goto out;
> +        }
> +        oldflags =3D be32_to_cpu(oldflags);
> +        if (oldflags & ~0xffff) {
> +            error_setg(errp, "Unexpected export flags %0x" PRIx32, old=
flags);
> +            goto out;
> +        }
> +        array->flags =3D oldflags;
> +
> +        /* Send NBD_CMD_DISC as a courtesy to the server, but ignore a=
ll
> +         * errors now that we have the information we wanted. */
> +        if (nbd_drop(ioc, 124, NULL) =3D=3D 0) {
> +            NBDRequest request =3D { .type =3D NBD_CMD_DISC };
> +
> +            nbd_send_request(ioc, &request);
> +        }
> +        break;
> +    default:
> +        goto out;
> +    }
> +
> +    *info =3D array;
> +    array =3D NULL;
> +    ret =3D count;
> +
> + out:
> +    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> +    qio_channel_close(ioc, NULL);
> +    object_unref(OBJECT(sioc));
> +    nbd_free_export_list(array, count);
> +    return ret;
> +}
> +
>  #ifdef __linux__
>  int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
>               Error **errp)
> diff --git a/nbd/trace-events b/nbd/trace-events
> index 570b04997ff..2cf83ebed15 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -2,7 +2,7 @@
>  nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) =
"Sending option request %" PRIu32" (%s), len %" PRIu32
>  nbd_receive_option_reply(uint32_t option, const char *optname, uint32_=
t type, const char *typename, uint32_t length) "Received option reply %" =
PRIu32" (%s), type %" PRIu32" (%s), len %" PRIu32
>  nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't=
 understand request %" PRIu32 " (%s), attempting fallback"
> -nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '=
%s'"
> +nbd_opt_go_start(const char *opt, const char *name) "Attempting %s for=
 export '%s'"
>  nbd_opt_go_success(void) "Export is good to go"
>  nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown =
info %d (%s)"
>  nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred, uint3=
2_t maximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
> --=20
> 2.17.2

This is all straightforward, so:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
