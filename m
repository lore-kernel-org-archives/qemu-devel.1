Received: from eggs.gnu.org ([2001:4830:134:3::10]:58724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gT2eE-0005DE-QJ
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 05:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gT2eD-0006UH-PN
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 05:37:18 -0500
Date: Sat, 1 Dec 2018 10:37:08 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181201103708.GH27120@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-9-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181130220344.3350618-9-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/14] nbd/client: Refactor
 nbd_receive_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, nsoffer@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On Fri, Nov 30, 2018 at 04:03:37PM -0600, Eric Blake wrote:
> Add some parameters to make this function reusable in upcoming
> export listing, where we will want to capture the name and
> description rather than compare against a user-supplied name.
> No change in semantics to the existing caller.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/client.c | 66 +++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 19 deletions(-)
>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index 1dc8f83e19a..27785c55d0a 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -232,18 +232,21 @@ static int nbd_handle_reply_err(QIOChannel *ioc, =
NBDOptionReply *reply,
>      return result;
>  }
>=20
> -/* Process another portion of the NBD_OPT_LIST reply.  Set *@match if
> - * the current reply matches @want or if the server does not support
> - * NBD_OPT_LIST, otherwise leave @match alone.  Return 0 if iteration
> - * is complete, positive if more replies are expected, or negative
> - * with @errp set if an unrecoverable error occurred. */
> +/* Process another portion of the NBD_OPT_LIST reply.  If @want, then
> + * set *@match if the current reply matches @want or if the server
> + * does not support NBD_OPT_LIST, otherwise leave @match alone.
> + * Otherwise, @nameout and @description are malloc'd to contain
> + * NUL-terminated copies of the reply.  Return 0 if iteration is
> + * complete, positive if more replies are expected, or negative with
> + * @errp set if an unrecoverable error occurred. */
>  static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *m=
atch,
> -                            Error **errp)
> +                            char **nameout, char **description, Error =
**errp)
>  {
>      NBDOptionReply reply;
>      uint32_t len;
>      uint32_t namelen;
> -    char name[NBD_MAX_NAME_SIZE + 1];
> +    char array[NBD_MAX_NAME_SIZE + 1];
> +    char *name =3D array;
>      int error;
>=20
>      if (nbd_receive_option_reply(ioc, NBD_OPT_LIST, &reply, errp) < 0)=
 {
> @@ -253,7 +256,12 @@ static int nbd_receive_list(QIOChannel *ioc, const=
 char *want, bool *match,
>      if (error <=3D 0) {
>          /* The server did not support NBD_OPT_LIST, so set *match on
>           * the assumption that any name will be accepted.  */
> -        *match =3D true;
> +        if (want) {
> +            *match =3D true;
> +        } else if (!error) {
> +            error_setg(errp, "Server does not support export lists");
> +            error =3D -1;
> +        }
>          return error;
>      }
>      len =3D reply.length;
> @@ -290,30 +298,49 @@ static int nbd_receive_list(QIOChannel *ioc, cons=
t char *want, bool *match,
>          nbd_send_opt_abort(ioc);
>          return -1;
>      }
> -    if (namelen !=3D strlen(want)) {
> -        if (nbd_drop(ioc, len, errp) < 0) {
> -            error_prepend(errp,
> -                          "failed to skip export name with wrong lengt=
h: ");
> -            nbd_send_opt_abort(ioc);
> -            return -1;
> +    if (want) {
> +        if (namelen !=3D strlen(want)) {
> +            if (nbd_drop(ioc, len, errp) < 0) {
> +                error_prepend(errp,
> +                              "failed to skip export name with wrong l=
ength: ");
> +                nbd_send_opt_abort(ioc);
> +                return -1;
> +            }
> +            return 1;
>          }
> -        return 1;
> +        assert(namelen < sizeof(array));
> +    } else {
> +        assert(nameout);
> +        *nameout =3D name =3D g_new(char, namelen + 1);
>      }
>=20
> -    assert(namelen < sizeof(name));
>      if (nbd_read(ioc, name, namelen, errp) < 0) {
>          error_prepend(errp, "failed to read export name: ");
>          nbd_send_opt_abort(ioc);
> +        if (!want) {
> +            free(name);
> +        }
>          return -1;
>      }
>      name[namelen] =3D '\0';
>      len -=3D namelen;
> -    if (nbd_drop(ioc, len, errp) < 0) {
> +    if (!want) {
> +        assert(description);
> +        *description =3D g_new(char, len + 1);
> +        if (nbd_read(ioc, *description, len, errp) < 0) {
> +            error_prepend(errp, "failed to read export description: ")=
;
> +            nbd_send_opt_abort(ioc);
> +            free(name);
> +            free(*description);
> +            return -1;
> +        }
> +        (*description)[len] =3D '\0';
> +    } else if (nbd_drop(ioc, len, errp) < 0) {
>          error_prepend(errp, "failed to read export description: ");
>          nbd_send_opt_abort(ioc);
>          return -1;
>      }
> -    if (!strcmp(name, want)) {
> +    if (want && !strcmp(name, want)) {
>          *match =3D true;
>      }
>      return 1;
> @@ -498,7 +525,8 @@ static int nbd_receive_query_exports(QIOChannel *io=
c,
>      }
>=20
>      while (1) {
> -        int ret =3D nbd_receive_list(ioc, wantname, &foundExport, errp=
);
> +        int ret =3D nbd_receive_list(ioc, wantname, &foundExport,
> +                                   NULL, NULL, errp);
>=20
>          if (ret < 0) {
>              /* Server gave unexpected reply */

I found this patch a lot easier to review once I started to use the
=E2=80=98git show -w=E2=80=99 option.  The changes look like a reasonable=
 adaptation
of the function, and the only consumer of the function (at this point)
is unaffected, so:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
