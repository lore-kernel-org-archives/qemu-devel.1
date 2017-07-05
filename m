Received: from eggs.gnu.org ([2001:4830:134:3::10]:38447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSmFE-0003iO-Ky
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSmFA-0002cb-JM
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:29:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSmFA-0002br-6W
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:29:32 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-7-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5b1b1bb-f637-24b7-bdac-0c6c3f310c83@redhat.com>
Date: Wed, 5 Jul 2017 17:29:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170621153424.16690-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/6] nbd: use generic trace subsystem
 instead of TRACE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, den@openvz.org



On 21/06/2017 17:34, Vladimir Sementsov-Ogievskiy wrote:
> Starting from this patch to enable traces use -trace option of qemu or
> -T, --trace option of qemu-img, qemu-io and qemu-nbd. For qemu traces
> also can be managed by qmp commands trace-event-{get,set}-state.
>=20
> Recompilation with CFLAGS=3D-DDEBUG_NBD is no more needed, furthermore,
> DEBUG_NBD macro is removed from the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  Makefile.objs      |  1 +
>  nbd/client.c       | 74 +++++++++++++++++++++-------------------------=
--
>  nbd/nbd-internal.h | 19 -------------
>  nbd/server.c       | 83 ++++++++++++++++++++++++++--------------------=
--------
>  nbd/trace-events   | 68 ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 141 insertions(+), 104 deletions(-)
>  create mode 100644 nbd/trace-events
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index b2e6322ef0..a66ea34cc4 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -168,6 +168,7 @@ trace-events-subdirs +=3D linux-user
>  trace-events-subdirs +=3D qapi
>  trace-events-subdirs +=3D accel/tcg
>  trace-events-subdirs +=3D accel/kvm
> +trace-events-subdirs +=3D nbd
> =20
>  trace-events-files =3D $(SRC_PATH)/trace-events $(trace-events-subdirs=
:%=3D$(SRC_PATH)/%/trace-events)
> =20
> diff --git a/nbd/client.c b/nbd/client.c
> index 5a4825ebe0..75b28f4ccf 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -19,6 +19,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "trace.h"
>  #include "nbd-internal.h"
> =20
>  static int nbd_errno_to_system_errno(int err)
> @@ -44,7 +45,7 @@ static int nbd_errno_to_system_errno(int err)
>          ret =3D ESHUTDOWN;
>          break;
>      default:
> -        TRACE("Squashing unexpected error %d to EINVAL", err);
> +        trace_nbd_unknown_error(err);
>          /* fallthrough */
>      case NBD_EINVAL:
>          ret =3D EINVAL;
> @@ -103,7 +104,7 @@ static int nbd_send_option_request(QIOChannel *ioc,=
 uint32_t opt,
>      if (len =3D=3D -1) {
>          req.length =3D len =3D strlen(data);
>      }
> -    TRACE("Sending option request %" PRIu32", len %" PRIu32, opt, len)=
;
> +    trace_nbd_send_option_request(opt, len);
> =20
>      stq_be_p(&req.magic, NBD_OPTS_MAGIC);
>      stl_be_p(&req.option, opt);
> @@ -153,8 +154,7 @@ static int nbd_receive_option_reply(QIOChannel *ioc=
, uint32_t opt,
>      be32_to_cpus(&reply->type);
>      be32_to_cpus(&reply->length);
> =20
> -    TRACE("Received option reply %" PRIx32", type %" PRIx32", len %" P=
RIu32,
> -          reply->option, reply->type, reply->length);
> +    trace_nbd_receive_option_reply(reply->option, reply->type, reply->=
length);
> =20
>      if (reply->magic !=3D NBD_REP_MAGIC) {
>          error_setg(errp, "Unexpected option reply magic");
> @@ -201,8 +201,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nb=
d_opt_reply *reply,
> =20
>      switch (reply->type) {
>      case NBD_REP_ERR_UNSUP:
> -        TRACE("server doesn't understand request %" PRIx32
> -              ", attempting fallback", reply->option);
> +        trace_nbd_reply_err_unsup(reply->option);
>          result =3D 0;
>          goto cleanup;
> =20
> @@ -342,12 +341,12 @@ static int nbd_receive_query_exports(QIOChannel *=
ioc,
>  {
>      bool foundExport =3D false;
> =20
> -    TRACE("Querying export list for '%s'", wantname);
> +    trace_nbd_receive_query_exports_start(wantname);
>      if (nbd_send_option_request(ioc, NBD_OPT_LIST, 0, NULL, errp) < 0)=
 {
>          return -1;
>      }
> =20
> -    TRACE("Reading available export names");
> +    trace_nbd_receive_query_exports_loop();
>      while (1) {
>          int ret =3D nbd_receive_list(ioc, wantname, &foundExport, errp=
);
> =20
> @@ -362,7 +361,7 @@ static int nbd_receive_query_exports(QIOChannel *io=
c,
>                  nbd_send_opt_abort(ioc);
>                  return -1;
>              }
> -            TRACE("Found desired export name '%s'", wantname);
> +            trace_nbd_receive_query_exports_success(wantname);
>              return 0;
>          }
>      }
> @@ -376,12 +375,12 @@ static QIOChannel *nbd_receive_starttls(QIOChanne=
l *ioc,
>      QIOChannelTLS *tioc;
>      struct NBDTLSHandshakeData data =3D { 0 };
> =20
> -    TRACE("Requesting TLS from server");
> +    trace_nbd_receive_starttls_request();
>      if (nbd_send_option_request(ioc, NBD_OPT_STARTTLS, 0, NULL, errp) =
< 0) {
>          return NULL;
>      }
> =20
> -    TRACE("Getting TLS reply from server");
> +    trace_nbd_receive_starttls_reply();
>      if (nbd_receive_option_reply(ioc, NBD_OPT_STARTTLS, &reply, errp) =
< 0) {
>          return NULL;
>      }
> @@ -400,14 +399,14 @@ static QIOChannel *nbd_receive_starttls(QIOChanne=
l *ioc,
>          return NULL;
>      }
> =20
> -    TRACE("TLS request approved, setting up TLS");
> +    trace_nbd_receive_starttls_new_client();
>      tioc =3D qio_channel_tls_new_client(ioc, tlscreds, hostname, errp)=
;
>      if (!tioc) {
>          return NULL;
>      }
>      qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-client-tls");
>      data.loop =3D g_main_loop_new(g_main_context_default(), FALSE);
> -    TRACE("Starting TLS handshake");
> +    trace_nbd_receive_starttls_tls_handshake();
>      qio_channel_tls_handshake(tioc,
>                                nbd_tls_handshake,
>                                &data,
> @@ -436,8 +435,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>      int rc;
>      bool zeroes =3D true;
> =20
> -    TRACE("Receiving negotiation tlscreds=3D%p hostname=3D%s.",
> -          tlscreds, hostname ? hostname : "<null>");
> +    trace_nbd_receive_negotiate(tlscreds, hostname ? hostname : "<null=
>");
> =20
>      rc =3D -EINVAL;
> =20
> @@ -462,7 +460,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
> =20
>      memcpy(&nbd_magic, buf, 8);
>      nbd_magic =3D be64_to_cpu(nbd_magic);
> -    TRACE("Magic is 0x%" PRIx64, nbd_magic);
> +    trace_nbd_receive_negotiate_magic(nbd_magic);
> =20
>      if (memcmp(buf, "NBDMAGIC", 8) !=3D 0) {
>          error_setg(errp, "Invalid magic received");
> @@ -474,7 +472,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>          goto fail;
>      }
>      magic =3D be64_to_cpu(magic);
> -    TRACE("Magic is 0x%" PRIx64, magic);
> +    trace_nbd_receive_negotiate_magic2(magic);
> =20
>      if (magic =3D=3D NBD_OPTS_MAGIC) {
>          uint32_t clientflags =3D 0;
> @@ -486,15 +484,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const =
char *name, uint16_t *flags,
>              goto fail;
>          }
>          globalflags =3D be16_to_cpu(globalflags);
> -        TRACE("Global flags are %" PRIx32, globalflags);
> +        trace_nbd_receive_negotiate_server_flags(globalflags);
>          if (globalflags & NBD_FLAG_FIXED_NEWSTYLE) {
>              fixedNewStyle =3D true;
> -            TRACE("Server supports fixed new style");
>              clientflags |=3D NBD_FLAG_C_FIXED_NEWSTYLE;
>          }
>          if (globalflags & NBD_FLAG_NO_ZEROES) {
>              zeroes =3D false;
> -            TRACE("Server supports no zeroes");
>              clientflags |=3D NBD_FLAG_C_NO_ZEROES;
>          }
>          /* client requested flags */
> @@ -516,7 +512,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>              }
>          }
>          if (!name) {
> -            TRACE("Using default NBD export name \"\"");
> +            trace_nbd_receive_negotiate_default_name();
>              name =3D "";
>          }
>          if (fixedNewStyle) {
> @@ -565,7 +561,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>              goto fail;
>          }
>          *size =3D be64_to_cpu(s);
> -        TRACE("Size is %" PRIu64, *size);
> +        trace_nbd_receive_negotiate_export_size(*size);
> =20
>          if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
>              error_prepend(errp, "Failed to read export flags");
> @@ -582,7 +578,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>          goto fail;
>      }
> =20
> -    TRACE("Size is %" PRIu64 ", export flags %" PRIx16, *size, *flags)=
;
> +    trace_nbd_receive_negotiate_size_flags(*size, *flags);
>      if (zeroes && nbd_drop(ioc, 124, errp) < 0) {
>          error_prepend(errp, "Failed to read reserved block");
>          goto fail;
> @@ -604,7 +600,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16=
_t flags, off_t size,
>          return -E2BIG;
>      }
> =20
> -    TRACE("Setting NBD socket");
> +    trace_nbd_init_set_socket();
> =20
>      if (ioctl(fd, NBD_SET_SOCK, (unsigned long) sioc->fd) < 0) {
>          int serrno =3D errno;
> @@ -612,7 +608,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16=
_t flags, off_t size,
>          return -serrno;
>      }
> =20
> -    TRACE("Setting block size to %lu", (unsigned long)BDRV_SECTOR_SIZE=
);
> +    trace_nbd_init_set_block_size(BDRV_SECTOR_SIZE);
> =20
>      if (ioctl(fd, NBD_SET_BLKSIZE, (unsigned long)BDRV_SECTOR_SIZE) < =
0) {
>          int serrno =3D errno;
> @@ -620,10 +616,9 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint1=
6_t flags, off_t size,
>          return -serrno;
>      }
> =20
> -    TRACE("Setting size to %lu block(s)", sectors);
> +    trace_nbd_init_set_size(sectors);
>      if (size % BDRV_SECTOR_SIZE) {
> -        TRACE("Ignoring trailing %d bytes of export",
> -              (int) (size % BDRV_SECTOR_SIZE));
> +        trace_nbd_init_trailing_bytes(size % BDRV_SECTOR_SIZE);
>      }
> =20
>      if (ioctl(fd, NBD_SET_SIZE_BLOCKS, sectors) < 0) {
> @@ -635,7 +630,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16=
_t flags, off_t size,
>      if (ioctl(fd, NBD_SET_FLAGS, (unsigned long) flags) < 0) {
>          if (errno =3D=3D ENOTTY) {
>              int read_only =3D (flags & NBD_FLAG_READ_ONLY) !=3D 0;
> -            TRACE("Setting readonly attribute");
> +            trace_nbd_init_set_readonly();
> =20
>              if (ioctl(fd, BLKROSET, (unsigned long) &read_only) < 0) {
>                  int serrno =3D errno;
> @@ -649,7 +644,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16=
_t flags, off_t size,
>          }
>      }
> =20
> -    TRACE("Negotiation ended");
> +    trace_nbd_init_finish();
> =20
>      return 0;
>  }
> @@ -659,7 +654,7 @@ int nbd_client(int fd)
>      int ret;
>      int serrno;
> =20
> -    TRACE("Doing NBD loop");
> +    trace_nbd_client_loop();
> =20
>      ret =3D ioctl(fd, NBD_DO_IT);
>      if (ret < 0 && errno =3D=3D EPIPE) {
> @@ -671,12 +666,12 @@ int nbd_client(int fd)
>      }
>      serrno =3D errno;
> =20
> -    TRACE("NBD loop returned %d: %s", ret, strerror(serrno));
> +    trace_nbd_client_loop_ret(ret, strerror(serrno));
> =20
> -    TRACE("Clearing NBD queue");
> +    trace_nbd_client_clear_queue();
>      ioctl(fd, NBD_CLEAR_QUE);
> =20
> -    TRACE("Clearing NBD socket");
> +    trace_nbd_client_clear_socket();
>      ioctl(fd, NBD_CLEAR_SOCK);
> =20
>      errno =3D serrno;
> @@ -713,11 +708,8 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDReque=
st *request)
>  {
>      uint8_t buf[NBD_REQUEST_SIZE];
> =20
> -    TRACE("Sending request to server: "
> -          "{ .from =3D %" PRIu64", .len =3D %" PRIu32 ", .handle =3D %=
" PRIu64
> -          ", .flags =3D %" PRIx16 ", .type =3D %" PRIu16 " }",
> -          request->from, request->len, request->handle,
> -          request->flags, request->type);
> +    trace_nbd_send_request(request->from, request->len, request->handl=
e,
> +                           request->flags, request->type);
> =20
>      stl_be_p(buf, NBD_REQUEST_MAGIC);
>      stw_be_p(buf + 4, request->flags);
> @@ -762,9 +754,7 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply=
 *reply, Error **errp)
>          error_setg(errp, "server shutting down");
>          return -EINVAL;
>      }
> -    TRACE("Got reply: { magic =3D 0x%" PRIx32 ", .error =3D % " PRId32
> -          ", handle =3D %" PRIu64" }",
> -          magic, reply->error, reply->handle);
> +    trace_nbd_receive_reply(magic, reply->error, reply->handle);
> =20
>      if (magic !=3D NBD_REPLY_MAGIC) {
>          error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index 39bfed177c..cf6ecbf358 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -31,25 +31,6 @@
>  #include "qemu/queue.h"
>  #include "qemu/main-loop.h"
> =20
> -/* #define DEBUG_NBD */
> -
> -#ifdef DEBUG_NBD
> -#define DEBUG_NBD_PRINT 1
> -#else
> -#define DEBUG_NBD_PRINT 0
> -#endif
> -
> -#define TRACE(msg, ...) do { \
> -    if (DEBUG_NBD_PRINT) { \
> -        LOG(msg, ## __VA_ARGS__); \
> -    } \
> -} while (0)
> -
> -#define LOG(msg, ...) do { \
> -    fprintf(stderr, "%s:%s():L%d: " msg "\n", \
> -            __FILE__, __FUNCTION__, __LINE__, ## __VA_ARGS__); \
> -} while (0)
> -
>  /* This is all part of the "official" NBD API.
>   *
>   * The most up-to-date documentation is available at:
> diff --git a/nbd/server.c b/nbd/server.c
> index 0671ebc50a..52ed9625fd 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -19,6 +19,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "trace.h"
>  #include "nbd-internal.h"
> =20
>  static int system_errno_to_nbd_errno(int err)
> @@ -138,8 +139,7 @@ static int nbd_negotiate_send_rep_len(QIOChannel *i=
oc, uint32_t type,
>  {
>      uint64_t magic;
> =20
> -    TRACE("Reply opt=3D%" PRIx32 " type=3D%" PRIx32 " len=3D%" PRIu32,
> -          type, opt, len);
> +    trace_nbd_negotiate_send_rep_len(type, opt, len);
> =20
>      magic =3D cpu_to_be64(NBD_REP_MAGIC);
>      if (nbd_write(ioc, &magic, sizeof(magic), errp) < 0) {
> @@ -191,7 +191,7 @@ nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_=
t type,
>      va_end(va);
>      len =3D strlen(msg);
>      assert(len < 4096);
> -    TRACE("sending error message \"%s\"", msg);
> +    trace_nbd_negotiate_send_rep_err(msg);
>      ret =3D nbd_negotiate_send_rep_len(ioc, type, opt, len, errp);
>      if (ret < 0) {
>          goto out;
> @@ -219,7 +219,7 @@ static int nbd_negotiate_send_rep_list(QIOChannel *=
ioc, NBDExport *exp,
>      const char *desc =3D exp->description ? exp->description : "";
>      int ret;
> =20
> -    TRACE("Advertising export name '%s' description '%s'", name, desc)=
;
> +    trace_nbd_negotiate_send_rep_list(name, desc);
>      name_len =3D strlen(name);
>      desc_len =3D strlen(desc);
>      len =3D name_len + desc_len + sizeof(len);
> @@ -283,7 +283,7 @@ static int nbd_negotiate_handle_export_name(NBDClie=
nt *client, uint32_t length,
>      /* Client sends:
>          [20 ..  xx]   export name (length bytes)
>       */
> -    TRACE("Checking length");
> +    trace_nbd_negotiate_handle_export_name();
>      if (length >=3D sizeof(name)) {
>          error_setg(errp, "Bad length received");
>          return -EINVAL;
> @@ -294,7 +294,7 @@ static int nbd_negotiate_handle_export_name(NBDClie=
nt *client, uint32_t length,
>      }
>      name[length] =3D '\0';
> =20
> -    TRACE("Client requested export '%s'", name);
> +    trace_nbd_negotiate_handle_export_name_request(name);
> =20
>      client->exp =3D nbd_export_find(name);
>      if (!client->exp) {
> @@ -318,7 +318,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NB=
DClient *client,
>      QIOChannelTLS *tioc;
>      struct NBDTLSHandshakeData data =3D { 0 };
> =20
> -    TRACE("Setting up TLS");
> +    trace_nbd_negotiate_handle_starttls();
>      ioc =3D client->ioc;
>      if (length) {
>          if (nbd_drop(ioc, length, errp) < 0) {
> @@ -344,7 +344,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NB=
DClient *client,
>      }
> =20
>      qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-server-tls");
> -    TRACE("Starting TLS handshake");
> +    trace_nbd_negotiate_handle_starttls_handshake();
>      data.loop =3D g_main_loop_new(g_main_context_default(), FALSE);
>      qio_channel_tls_handshake(tioc,
>                                nbd_tls_handshake,
> @@ -396,15 +396,15 @@ static int nbd_negotiate_options(NBDClient *clien=
t, Error **errp)
>          error_prepend(errp, "read failed: ");
>          return -EIO;
>      }
> -    TRACE("Checking client flags");
> +    trace_nbd_negotiate_options_flags();
>      be32_to_cpus(&flags);
>      if (flags & NBD_FLAG_C_FIXED_NEWSTYLE) {
> -        TRACE("Client supports fixed newstyle handshake");
> +        trace_nbd_negotiate_options_newstyle();
>          fixedNewstyle =3D true;
>          flags &=3D ~NBD_FLAG_C_FIXED_NEWSTYLE;
>      }
>      if (flags & NBD_FLAG_C_NO_ZEROES) {
> -        TRACE("Client supports no zeroes at handshake end");
> +        trace_nbd_negotiate_options_no_zeroes();
>          client->no_zeroes =3D true;
>          flags &=3D ~NBD_FLAG_C_NO_ZEROES;
>      }
> @@ -422,7 +422,7 @@ static int nbd_negotiate_options(NBDClient *client,=
 Error **errp)
>              error_prepend(errp, "read failed: ");
>              return -EINVAL;
>          }
> -        TRACE("Checking opts magic");
> +        trace_nbd_negotiate_options_check_magic();
>          if (magic !=3D be64_to_cpu(NBD_OPTS_MAGIC)) {
>              error_setg(errp, "Bad magic received");
>              return -EINVAL;
> @@ -441,7 +441,7 @@ static int nbd_negotiate_options(NBDClient *client,=
 Error **errp)
>          }
>          length =3D be32_to_cpu(length);
> =20
> -        TRACE("Checking option 0x%" PRIx32, clientflags);
> +        trace_nbd_negotiate_options_check_option(clientflags);
>          if (client->tlscreds &&
>              client->ioc =3D=3D (QIOChannel *)client->sioc) {
>              QIOChannel *tioc;
> @@ -501,8 +501,8 @@ static int nbd_negotiate_options(NBDClient *client,=
 Error **errp)
>                                         &local_err);
> =20
>                  if (local_err !=3D NULL) {
> -                    TRACE("Reply to NBD_OPT_ABORT request failed: %s",
> -                          error_get_pretty(local_err));
> +                    const char *error =3D error_get_pretty(local_err);
> +                    trace_nbd_opt_abort_reply_failed(error);
>                      error_free(local_err);
>                  }
> =20
> @@ -599,14 +599,14 @@ static coroutine_fn int nbd_negotiate(NBDClient *=
client, Error **errp)
> =20
>      qio_channel_set_blocking(client->ioc, false, NULL);
> =20
> -    TRACE("Beginning negotiation.");
> +    trace_nbd_negotiate_begin();
>      memset(buf, 0, sizeof(buf));
>      memcpy(buf, "NBDMAGIC", 8);
> =20
>      oldStyle =3D client->exp !=3D NULL && !client->tlscreds;
>      if (oldStyle) {
> -        TRACE("advertising size %" PRIu64 " and flags %x",
> -              client->exp->size, client->exp->nbdflags | myflags);
> +        trace_nbd_negotiate_old_style(client->exp->size,
> +                                      client->exp->nbdflags | myflags)=
;
>          stq_be_p(buf + 8, NBD_CLIENT_MAGIC);
>          stq_be_p(buf + 16, client->exp->size);
>          stw_be_p(buf + 26, client->exp->nbdflags | myflags);
> @@ -637,8 +637,8 @@ static coroutine_fn int nbd_negotiate(NBDClient *cl=
ient, Error **errp)
>              return ret;
>          }
> =20
> -        TRACE("advertising size %" PRIu64 " and flags %x",
> -              client->exp->size, client->exp->nbdflags | myflags);
> +        trace_nbd_negotiate_new_style_size_flags(
> +            client->exp->size, client->exp->nbdflags | myflags);
>          stq_be_p(buf + 18, client->exp->size);
>          stw_be_p(buf + 26, client->exp->nbdflags | myflags);
>          len =3D client->no_zeroes ? 10 : sizeof(buf) - 18;
> @@ -649,7 +649,7 @@ static coroutine_fn int nbd_negotiate(NBDClient *cl=
ient, Error **errp)
>          }
>      }
> =20
> -    TRACE("Negotiation succeeded.");
> +    trace_nbd_negotiate_success();
> =20
>      return 0;
>  }
> @@ -682,9 +682,8 @@ static int nbd_receive_request(QIOChannel *ioc, NBD=
Request *request,
>      request->from   =3D ldq_be_p(buf + 16);
>      request->len    =3D ldl_be_p(buf + 24);
> =20
> -    TRACE("Got request: { magic =3D 0x%" PRIx32 ", .flags =3D %" PRIx1=
6
> -          ", .type =3D %" PRIx16 ", from =3D %" PRIu64 ", len =3D %" P=
RIu32 " }",
> -          magic, request->flags, request->type, request->from, request=
->len);
> +    trace_nbd_receive_request(magic, request->flags, request->type,
> +                              request->from, request->len);
> =20
>      if (magic !=3D NBD_REQUEST_MAGIC) {
>          error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
> @@ -699,9 +698,7 @@ static int nbd_send_reply(QIOChannel *ioc, NBDReply=
 *reply, Error **errp)
> =20
>      reply->error =3D system_errno_to_nbd_errno(reply->error);
> =20
> -    TRACE("Sending response to client: { .error =3D %" PRId32
> -          ", handle =3D %" PRIu64 " }",
> -          reply->error, reply->handle);
> +    trace_nbd_send_reply(reply->error, reply->handle);
> =20
>      /* Reply
>         [ 0 ..  3]    magic   (NBD_REPLY_MAGIC)
> @@ -798,7 +795,7 @@ static void blk_aio_attached(AioContext *ctx, void =
*opaque)
>      NBDExport *exp =3D opaque;
>      NBDClient *client;
> =20
> -    TRACE("Export %s: Attaching clients to AIO context %p\n", exp->nam=
e, ctx);
> +    trace_blk_aio_attached(exp->name, ctx);
> =20
>      exp->ctx =3D ctx;
> =20
> @@ -818,7 +815,7 @@ static void blk_aio_detach(void *opaque)
>      NBDExport *exp =3D opaque;
>      NBDClient *client;
> =20
> -    TRACE("Export %s: Detaching clients from AIO context %p\n", exp->n=
ame, exp->ctx);
> +    trace_blk_aio_detach(exp->name, exp->ctx);
> =20
>      QTAILQ_FOREACH(client, &exp->clients, next) {
>          qio_channel_detach_aio_context(client->ioc);
> @@ -1045,7 +1042,7 @@ static int nbd_co_receive_request(NBDRequestData =
*req, NBDRequest *request,
>          return -EIO;
>      }
> =20
> -    TRACE("Decoding type");
> +    trace_nbd_co_receive_request_decode_type();
> =20
>      if (request->type !=3D NBD_CMD_WRITE) {
>          /* No payload, we are ready to read the next request.  */
> @@ -1055,7 +1052,7 @@ static int nbd_co_receive_request(NBDRequestData =
*req, NBDRequest *request,
>      if (request->type =3D=3D NBD_CMD_DISC) {
>          /* Special case: we're going to disconnect without a reply,
>           * whether or not flags, from, or len are bogus */
> -        TRACE("Request type is DISCONNECT");
> +        trace_nbd_co_receive_request_disconnect();
>          return -EIO;
>      }
> =20
> @@ -1082,7 +1079,7 @@ static int nbd_co_receive_request(NBDRequestData =
*req, NBDRequest *request,
>          }
>      }
>      if (request->type =3D=3D NBD_CMD_WRITE) {
> -        TRACE("Reading %" PRIu32 " byte(s)", request->len);
> +        trace_nbd_co_receive_request_cmd_write(request->len);
> =20
>          if (nbd_read(client->ioc, req->data, request->len, errp) < 0) =
{
>              error_prepend(errp, "reading from socket failed: ");
> @@ -1124,7 +1121,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>      int reply_data_len =3D 0;
>      Error *local_err =3D NULL;
> =20
> -    TRACE("Reading request.");
> +    trace_do_nbd_trip();
>      if (client->closing) {
>          nbd_client_put(client);
>          return;
> @@ -1156,7 +1153,7 @@ static coroutine_fn void nbd_trip(void *opaque)
> =20
>      switch (request.type) {
>      case NBD_CMD_READ:
> -        TRACE("Request type is READ");
> +        trace_do_nbd_trip_cmd_read();
> =20
>          /* XXX: NBD Protocol only documents use of FUA with WRITE */
>          if (request.flags & NBD_CMD_FLAG_FUA) {
> @@ -1177,19 +1174,19 @@ static coroutine_fn void nbd_trip(void *opaque)
>          }
> =20
>          reply_data_len =3D request.len;
> -        TRACE("Read %" PRIu32" byte(s)", request.len);
> +        trace_do_nbd_trip_read(request.len);
> =20
>          break;
>      case NBD_CMD_WRITE:
> -        TRACE("Request type is WRITE");
> +        trace_do_nbd_trip_cmd_write();
> =20
>          if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
> -            TRACE("Server is read-only, return error");
> +            trace_do_nbd_trip_cmd_write_readonly();
>              reply.error =3D EROFS;
>              break;
>          }
> =20
> -        TRACE("Writing to device");
> +        trace_do_nbd_trip_write();
> =20
>          flags =3D 0;
>          if (request.flags & NBD_CMD_FLAG_FUA) {
> @@ -1204,7 +1201,7 @@ static coroutine_fn void nbd_trip(void *opaque)
> =20
>          break;
>      case NBD_CMD_WRITE_ZEROES:
> -        TRACE("Request type is WRITE_ZEROES");
> +        trace_do_nbd_trip_cmd_write_zeroes();
> =20
>          if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
>              error_setg(&local_err, "Server is read-only, return error"=
);
> @@ -1212,7 +1209,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>              break;
>          }
> =20
> -        TRACE("Writing to device");
> +        trace_do_nbd_trip_write_zeroes();
> =20
>          flags =3D 0;
>          if (request.flags & NBD_CMD_FLAG_FUA) {
> @@ -1234,7 +1231,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>          abort();
> =20
>      case NBD_CMD_FLUSH:
> -        TRACE("Request type is FLUSH");
> +        trace_do_nbd_trip_cmd_flush();
> =20
>          ret =3D blk_co_flush(exp->blk);
>          if (ret < 0) {
> @@ -1244,7 +1241,7 @@ static coroutine_fn void nbd_trip(void *opaque)
> =20
>          break;
>      case NBD_CMD_TRIM:
> -        TRACE("Request type is TRIM");
> +        trace_do_nbd_trip_cmd_trim();
>          ret =3D blk_co_pdiscard(exp->blk, request.from + exp->dev_offs=
et,
>                                request.len);
>          if (ret < 0) {
> @@ -1280,7 +1277,7 @@ reply:
>          goto disconnect;
>      }
> =20
> -    TRACE("Request/Reply complete");
> +    trace_do_nbd_trip_complete();
> =20
>  done:
>      nbd_request_put(req);
> diff --git a/nbd/trace-events b/nbd/trace-events
> new file mode 100644
> index 0000000000..46e4d110bd
> --- /dev/null
> +++ b/nbd/trace-events
> @@ -0,0 +1,68 @@
> +# nbd/client.c
> +nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"
> +nbd_send_option_request(uint32_t opt, uint32_t len) "Sending option re=
quest %" PRIu32", len %" PRIu32
> +nbd_receive_option_reply(uint32_t option, uint32_t type, uint32_t leng=
th) "Received option reply %" PRIx32", type %" PRIx32", len %" PRIu32
> +nbd_reply_err_unsup(uint32_t option) "server doesn't understand reques=
t %" PRIx32 ", attempting fallback"
> +nbd_receive_query_exports_start(const char *wantname) "Querying export=
 list for '%s'"
> +nbd_receive_query_exports_loop(void) "Reading available export names"
> +nbd_receive_query_exports_success(const char *wantname) "Found desired=
 export name '%s'"
> +nbd_receive_starttls_request(void) "Requesting TLS from server"
> +nbd_receive_starttls_reply(void) "Getting TLS reply from server"
> +nbd_receive_starttls_new_client(void) "TLS request approved, setting u=
p TLS"
> +nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
> +nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving=
 negotiation tlscreds=3D%p hostname=3D%s"
> +nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
> +nbd_receive_negotiate_magic2(uint64_t magic) "Magic is 0x%" PRIx64
> +nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags=
 are %" PRIx32
> +nbd_receive_negotiate_default_name(void) "Using default NBD export nam=
e \"\""
> +nbd_receive_negotiate_export_size(uint64_t size) "Size is %" PRIu64
> +nbd_receive_negotiate_size_flags(uint64_t size, uint16_t flags) "Size =
is %" PRIu64 ", export flags %" PRIx16
> +nbd_init_set_socket(void) "Setting NBD socket"
> +nbd_init_set_block_size(unsigned long block_size) "Setting block size =
to %lu"
> +nbd_init_set_size(unsigned long sectors) "Setting size to %lu block(s)=
"
> +nbd_init_trailing_bytes(int ignored_bytes) "Ignoring trailing %d bytes=
 of export"
> +nbd_init_set_readonly(void) "Setting readonly attribute"
> +nbd_init_finish(void) "Negotiation ended"
> +nbd_client_loop(void) "Doing NBD loop"
> +nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d:=
 %s"
> +nbd_client_clear_queue(void) "Clearing NBD queue"
> +nbd_client_clear_socket(void) "Clearing NBD socket"
> +nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_=
t flags, uint16_t type) "Sending request to server: { .from =3D %" PRIu64=
", .len =3D %" PRIu32 ", .handle =3D %" PRIu64 ", .flags =3D %" PRIx16 ",=
 .type =3D %" PRIu16 " }"
> +nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got=
 reply: { magic =3D 0x%" PRIx32 ", .error =3D % " PRId32 ", handle =3D %"=
 PRIu64" }"
> +
> +# nbd/server.c
> +nbd_negotiate_send_rep_len(uint32_t type, uint32_t opt, uint32_t len) =
"Reply opt=3D%" PRIx32 " type=3D%" PRIx32 " len=3D%" PRIu32
> +nbd_negotiate_send_rep_err(const char *msg) "sending error message \"%=
s\""
> +nbd_negotiate_send_rep_list(const char *name, const char *desc) "Adver=
tising export name '%s' description '%s'"
> +nbd_negotiate_handle_export_name(void) "Checking length"
> +nbd_negotiate_handle_export_name_request(const char *name) "Client req=
uested export '%s'"
> +nbd_negotiate_handle_starttls(void) "Setting up TLS"
> +nbd_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
> +nbd_negotiate_options_flags(void) "Checking client flags"
> +nbd_negotiate_options_newstyle(void) "Client supports fixed newstyle h=
andshake"
> +nbd_negotiate_options_no_zeroes(void) "Client supports no zeroes at ha=
ndshake end"
> +nbd_negotiate_options_check_magic(void) "Checking opts magic"
> +nbd_negotiate_options_check_option(uint32_t clientflags) "Checking opt=
ion 0x%" PRIx32
> +nbd_opt_abort_reply_failed(const char *error) "Reply to NBD_OPT_ABORT =
request failed: %s"
> +nbd_negotiate_begin(void) "Beginning negotiation"
> +nbd_negotiate_old_style(uint64_t size, unsigned flags) "advertising si=
ze %" PRIu64 " and flags %x"
> +nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "adv=
ertising size %" PRIu64 " and flags %x"
> +nbd_negotiate_success(void) "Negotiation succeeded"
> +nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uin=
t64_t from, uint32_t len) "Got request: { magic =3D 0x%" PRIx32 ", .flags=
 =3D %" PRIx16 ", .type =3D %" PRIx16 ", from =3D %" PRIu64 ", len =3D %"=
 PRIu32 " }"
> +nbd_send_reply(int32_t error, uint64_t handle) "Sending response to cl=
ient: { .error =3D %" PRId32 ", handle =3D %" PRIu64 " }"
> +blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching cl=
ients to AIO context %p\n"
> +blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clie=
nts from AIO context %p\n"
> +nbd_co_receive_request_decode_type(void) "Decoding type"

Please add the request->handle and request->type as an argument...

> +nbd_co_receive_request_disconnect(void) "Request type is DISCONNECT"

... and remove this one, which is now unnecessary.

> +nbd_co_receive_request_cmd_write(uint32_t len) "Reading %" PRIu32 " by=
te(s)"
> +do_nbd_trip(void) "Reading request"

Please remove do_ from all these tracepoints, in addition:

> +do_nbd_trip_cmd_read(void) "Request type is READ"

This can be removed if nbd_co_receive_request_decode_type gets
request.type as an argument.

> +do_nbd_trip_read(uint32_t len) "Read %" PRIu32" byte(s)"

This one is good.

> +do_nbd_trip_cmd_write(void) "Request type is WRITE"
> +do_nbd_trip_cmd_write_readonly(void) "Server is read-only, return erro=
r"

These can be removed.

> +do_nbd_trip_write(void) "Writing to device"

Please add the handle here.

> +do_nbd_trip_cmd_write_zeroes(void) "Request type is WRITE_ZEROES"
> +do_nbd_trip_write_zeroes(void) "Writing to device"
> +do_nbd_trip_cmd_flush(void) "Request type is FLUSH"
> +do_nbd_trip_cmd_trim(void) "Request type is TRIM"

Can all be removed.

> +do_nbd_trip_complete(void) "Request/Reply complete"

This one is good, but please add the handle here too.

Thanks,

Paolo
