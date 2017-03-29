Received: from eggs.gnu.org ([2001:4830:134:3::10]:48968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ctGmJ-00075r-WF
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ctGmI-0007Iu-Ta
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:49:00 -0400
Date: Wed, 29 Mar 2017 12:48:43 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1947286013.16940443.1490806123696.JavaMail.zimbra@redhat.com>
In-Reply-To: <1490805920-17029-3-git-send-email-armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-3-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [for-2.9 2/8] char: Fix socket with "type":
 "vsock" address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mitake hitoshi <mitake.hitoshi@lab.ntt.co.jp>, namei unix <namei.unix@gmail.com>, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>


Hi

----- Original Message -----
> Watch this:
>=20
>     $ qemu-system-x86_64 -nodefaults -S -display none -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 91, "minor": 8, "major": 2},
>     "package": " (v2.8.0-1195-gf84141e-dirty)"}, "capabilities": []}}
>     { "execute": "qmp_capabilities" }
>     {"return": {}}
>     { "execute": "chardev-add", "arguments": { "id": "chr0", "backend": {
>     "type": "socket", "data": { "addr": { "type": "vsock", "data": { "cid=
":
>     "CID", "port": "P" }}}}}}
>     Aborted (core dumped)
>=20
> Crashes because SocketAddress_to_str() is blissfully unaware of
> SOCKET_ADDRESS_KIND_VSOCK.  Fix that.  Pick the output format to match
> socket_parse(), just like the existing formats.
>=20
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-socket.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 6344b07..36ab0d6 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -357,6 +357,10 @@ static char *SocketAddress_to_str(const char *prefix=
,
> SocketAddress *addr,
>          return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.data->str=
,
>                                 is_listen ? ",server" : "");
>          break;
> +    case SOCKET_ADDRESS_KIND_VSOCK:
> +        return g_strdup_printf("%svsock:%s:%s", prefix,
> +                               addr->u.vsock.data->cid,
> +                               addr->u.vsock.data->port);
>      default:
>          abort();

ooch.. may I suggest we don't abort() here? g_return_val_if_fail() perhaps =
a more judicious choice?
