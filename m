Received: from eggs.gnu.org ([2001:4830:134:3::10]:43210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fubhJ-0002c3-Su
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fubhJ-0008JB-5Z
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:58:09 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fubhI-0008Ir-U2
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:58:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id w11-v6so1149932wrc.5
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 03:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180817173104.14691-1-marcandre.lureau@redhat.com>
In-Reply-To: <20180817173104.14691-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Aug 2018 12:57:56 +0200
Message-ID: <CAJ+F1C+o2UPHZFMgEPUh8-DBVMCGc7zYhSfmn=wOYM5KT0RAgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: QEMU <qemu-devel@nongnu.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

ping
On Fri, Aug 17, 2018 at 7:32 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> VNC server is calling sasl_server_init() during startup of QEMU, even
> if SASL auth has not been enabled.
>
> This may create undesirable warnings like "Could not find keytab file:
> /etc/qemu/krb5.tab" when the user didn't configure SASL on host and
> started VNC server.
>
> Instead, only initialize SASL when needed. Note that HMP/QMP "change
> vnc" calls vnc_display_open() again, which will initialize SASL if
> needed.
>
> Related to:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1609327
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/vnc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 359693238b..fc507d7f36 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -4054,7 +4054,7 @@ void vnc_display_open(const char *id, Error **errp)
>      trace_vnc_auth_init(vd, 1, vd->ws_auth, vd->ws_subauth);
>
>  #ifdef CONFIG_VNC_SASL
> -    if ((saslErr =3D sasl_server_init(NULL, "qemu")) !=3D SASL_OK) {
> +    if (sasl && ((saslErr =3D sasl_server_init(NULL, "qemu")) !=3D SASL_=
OK)) {
>          error_setg(errp, "Failed to initialize SASL auth: %s",
>                     sasl_errstring(saslErr, NULL, NULL));
>          goto fail;
> --
> 2.18.0.547.g1d89318c48
>
>


--=20
Marc-Andr=C3=A9 Lureau
