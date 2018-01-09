Received: from eggs.gnu.org ([2001:4830:134:3::10]:57039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYuE6-0007MJ-RV
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYuE2-0004YF-RE
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:46:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYuDn-0004Nm-2f
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:45:58 -0500
Date: Tue, 9 Jan 2018 13:45:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180109134528.GE31400@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-21-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-21-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 20/27] qmp: export qmp_dispatch_check_obj
 and allow "id"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:50PM +0800, Peter Xu wrote:
> We need this for earlier check for OOB, before reaching
> do_qmp_dispatch().  Meanwhile, a small touch-up to allow "id" field,
> after all we allow that for sure in the spec (in any form).

This change would be better as part of the patch that needs it.  I don't
understand the commit description and there is no context in this patch
showing how this change is used.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h | 1 +
>  qapi/qmp-dispatch.c         | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> index b76798800c..cf2657b5c9 100644
> --- a/include/qapi/qmp/dispatch.h
> +++ b/include/qapi/qmp/dispatch.h
> @@ -49,6 +49,7 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
>  const char *qmp_command_name(const QmpCommand *cmd);
>  bool qmp_has_success_response(const QmpCommand *cmd);
>  QObject *qmp_build_error_object(Error *err);
> +QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp);
> =20
>  typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
> =20
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index b41fa174fe..b16f2f1d3f 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -20,7 +20,7 @@
>  #include "qapi-types.h"
>  #include "qapi/qmp/qerror.h"
> =20
> -static QDict *qmp_dispatch_check_obj(const QObject *request, Error **err=
p)
> +QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>  {
>      const QDictEntry *ent;
>      const char *arg_name;
> @@ -52,6 +52,8 @@ static QDict *qmp_dispatch_check_obj(const QObject *req=
uest, Error **errp)
>                             "QMP input member 'arguments' must be an obje=
ct");
>                  return NULL;
>              }
> +        } else if (!strcmp(arg_name, "id")) {
> +            continue;
>          } else {
>              error_setg(errp, "QMP input member '%s' is unexpected",
>                         arg_name);
> --=20
> 2.14.3
>=20

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVMd4AAoJEJykq7OBq3PIi9IIAMjCt5XTNEzsOr4erRTBaps2
ZxmTYgicmhZqa7ipfrkKZX2+8vcmBRsnaRK0bwCfkxEMoO97/4UiYQT/Y80fswqS
VpOaZ1fc8NJu7fFevTfVziyxCirTfHVoJ4wd+24LFzJi9znfxPKNv1pJ3kPvJB5X
Wxl7EGju9HKw+A7RZ7ZFiLo8WjkD0VgKwyJnQ94wQQR4Kjx6acw/9/QQJhYezpUv
qW+zmYoahHHqzAP0GwnU9NSMKpgBCUDL+UQs+XBg1v8J6CN/pXxBblaA8K9RCrd9
ajrLfPvscwsnPDpbZ47jx4AAV1iJWEPvkzBJVSiKc603zhQXE3Zq7AMuNhFCQ/Y=
=ND8B
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
