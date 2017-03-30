Received: from eggs.gnu.org ([2001:4830:134:3::10]:40532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctTd7-0008DW-3q
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctTd6-00016f-4y
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:32:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-3-git-send-email-armbru@redhat.com>
	<1947286013.16940443.1490806123696.JavaMail.zimbra@redhat.com>
	<1585753855.16940591.1490806170998.JavaMail.zimbra@redhat.com>
Date: Thu, 30 Mar 2017 08:32:09 +0200
In-Reply-To: <1585753855.16940591.1490806170998.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 29 Mar 2017
	12:49:31 -0400 (EDT)")
Message-ID: <87y3vnff6e.fsf@dusky.pond.sub.org>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mitake hitoshi <mitake.hitoshi@lab.ntt.co.jp>, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, namei unix <namei.unix@gmail.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> ----- Original Message -----
>>=20
>> Hi
>>=20
>> ----- Original Message -----
>> > Watch this:
>> >=20
>> >     $ qemu-system-x86_64 -nodefaults -S -display none -qmp stdio
>> >     {"QMP": {"version": {"qemu": {"micro": 91, "minor": 8, "major": 2},
>> >     "package": " (v2.8.0-1195-gf84141e-dirty)"}, "capabilities": []}}
>> >     { "execute": "qmp_capabilities" }
>> >     {"return": {}}
>> >     { "execute": "chardev-add", "arguments": { "id": "chr0", "backend"=
: {
>> >     "type": "socket", "data": { "addr": { "type": "vsock", "data": { "=
cid":
>> >     "CID", "port": "P" }}}}}}
>> >     Aborted (core dumped)
>> >=20
>> > Crashes because SocketAddress_to_str() is blissfully unaware of
>> > SOCKET_ADDRESS_KIND_VSOCK.  Fix that.  Pick the output format to match
>> > socket_parse(), just like the existing formats.
>> >=20
>> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> > Cc: Paolo Bonzini <pbonzini@redhat.com>
>> > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>=20
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!

>> > ---
>> >  chardev/char-socket.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >=20
>> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> > index 6344b07..36ab0d6 100644
>> > --- a/chardev/char-socket.c
>> > +++ b/chardev/char-socket.c
>> > @@ -357,6 +357,10 @@ static char *SocketAddress_to_str(const char *pre=
fix,
>> > SocketAddress *addr,
>> >          return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.data->=
str,
>> >                                 is_listen ? ",server" : "");
>> >          break;
>> > +    case SOCKET_ADDRESS_KIND_VSOCK:
>> > +        return g_strdup_printf("%svsock:%s:%s", prefix,
>> > +                               addr->u.vsock.data->cid,
>> > +                               addr->u.vsock.data->port);
>> >      default:
>> >          abort();
>>=20
>> ooch.. may I suggest we don't abort() here? g_return_val_if_fail() perha=
ps a
>> more judicious choice?
>
> -> g_return_if_reached()

If we reach the default label, program state is messed up, and
continuing is unsafe.

In case we decide we want to push our luck and continue anyway: as far
as I can tell, we don't use g_log() anywhere.  We can discuss whether we
have uses for it, but hard freeze is a bad time to actually introduce
it.
