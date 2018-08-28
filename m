Received: from eggs.gnu.org ([2001:4830:134:3::10]:44716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fublY-0005eS-Vf
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 07:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fublV-0002TX-Nb
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 07:02:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fublT-0002Pp-I9
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 07:02:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DFCB88846
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 11:02:26 +0000 (UTC)
Date: Tue, 28 Aug 2018 12:02:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180828110218.GJ25114@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180817173104.14691-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180817173104.14691-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: call sasl_server_init() only when
 required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Aug 17, 2018 at 07:31:03PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> VNC server is calling sasl_server_init() during startup of QEMU, even
> if SASL auth has not been enabled.
>=20
> This may create undesirable warnings like "Could not find keytab file:
> /etc/qemu/krb5.tab" when the user didn't configure SASL on host and
> started VNC server.
>=20
> Instead, only initialize SASL when needed. Note that HMP/QMP "change
> vnc" calls vnc_display_open() again, which will initialize SASL if
> needed.

I could have sworn we had a way to change the VNC auth method on the
fly without restarting the whole server, but I can't find it now, so
must have been imagining it :-)

>=20
> Related to:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1609327
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/vnc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 359693238b..fc507d7f36 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -4054,7 +4054,7 @@ void vnc_display_open(const char *id, Error **err=
p)
>      trace_vnc_auth_init(vd, 1, vd->ws_auth, vd->ws_subauth);
> =20
>  #ifdef CONFIG_VNC_SASL
> -    if ((saslErr =3D sasl_server_init(NULL, "qemu")) !=3D SASL_OK) {
> +    if (sasl && ((saslErr =3D sasl_server_init(NULL, "qemu")) !=3D SAS=
L_OK)) {
>          error_setg(errp, "Failed to initialize SASL auth: %s",
>                     sasl_errstring(saslErr, NULL, NULL));
>          goto fail;

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
