Received: from eggs.gnu.org ([2001:4830:134:3::10]:35368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dejjF-0007Ws-DM
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dejj9-0003k3-Na
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:14:01 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-7-vsementsov@virtuozzo.com>
	<4dc2dde8-2177-3d1c-c168-f98d826922b5@redhat.com>
	<cf38e6aa-e934-bf75-48bf-3c3bbcb7f254@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b204c5ab-2d4c-315d-7fe7-2111559052a8@redhat.com>
Date: Mon, 7 Aug 2017 10:13:39 -0500
MIME-Version: 1.0
In-Reply-To: <cf38e6aa-e934-bf75-48bf-3c3bbcb7f254@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qQnkV5UfljO4IbgewST4rVP297hm5RQ6R"
Subject: Re: [Qemu-devel] [PATCH 06/17] block/nbd-client: fix
 nbd_read_reply_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, P J P <ppandit@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qQnkV5UfljO4IbgewST4rVP297hm5RQ6R
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org,
 P J P <ppandit@redhat.com>
Message-ID: <b204c5ab-2d4c-315d-7fe7-2111559052a8@redhat.com>
Subject: Re: [PATCH 06/17] block/nbd-client: fix nbd_read_reply_entry
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-7-vsementsov@virtuozzo.com>
 <4dc2dde8-2177-3d1c-c168-f98d826922b5@redhat.com>
 <cf38e6aa-e934-bf75-48bf-3c3bbcb7f254@virtuozzo.com>
In-Reply-To: <cf38e6aa-e934-bf75-48bf-3c3bbcb7f254@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 07:56 AM, Vladimir Sementsov-Ogievskiy wrote:
> 07.08.2017 14:52, Eric Blake wrote:
>> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Set reply.handle to 0 on error path to prevent normal path of
>>> nbd_co_receive_reply.

Side note: in general, our server must allow a handle of 0 as valid (as
the handle is something chosen by the client); but our particular client
always uses non-zero handles (and therefore using 0 as a sentinel for an
error path is okay).

>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/nbd-client.c | 1 +
>>>   1 file changed, 1 insertion(+)
>> Can you document a case where not fixing this would be an observable b=
ug
>> (even if it requires using gdb and single-stepping between client and
>> server to make what is otherwise a racy situation easy to see)?  I'm
>> trying to figure out if this is 2.10 material.
>=20
> it is simple enough:
>=20
> run qemu-nbd in gdb, set break on nbd_send_reply, and when it shoot s,
> next up to "stl_be_p(buf, NBD_REPLY_MAGIC);" and after it do "call
> stl_be_p(buf, 1000)"

Okay, so you have set up a malicious server intentionally sending bad
magic...

>=20
> run qemu-io with some read in gdb, set break on
> br block/nbd-client.c:83
>=20
> ( it is break; after failed nbd_receive_reply call)
>=20
> and on
> br block/nbd-client.c:170
>=20
> (it is in nbd_co_receive_reply after yield)
>=20
> on first break we will be sure that  nbd_receive_reply failed,
> on second we will be sure by
> (gdb) p s->reply
> $1 =3D {handle =3D 93825000680144, error =3D 0}
> (gdb) p request->handle
> $2 =3D 93825000680144
>=20
> that we are on normal receiving path.

=2E..and the client is recognizing that the server sent garbage, but then=

proceeds to handle the packet anyway.  The ideal reaction is that the
client should disconnect from the server, rather than handle the packet.
 But because it didn't do that, the client is now unable to receive any
future messages from the server.  Compare the traces of:

$  ./qemu-io -c 'r 0 1' -f raw nbd://localhost:10809/foo --trace nbd_\*

against a working server:

29103@1502118291.281180:nbd_opt_go_success Export is good to go
29103@1502118291.281397:nbd_send_request Sending request to server: {
=2Efrom =3D 0, .len =3D 1, .handle =3D 93860726319200, .flags =3D 0x0, .t=
ype =3D 0
(read) }
29103@1502118291.281705:nbd_receive_reply Got reply: { magic =3D
0x67446698, .error =3D  0, handle =3D 93860726319200 }
read 1/1 bytes at offset 0
1 bytes, 1 ops; 0.0003 sec (2.822 KiB/sec and 2890.1734 ops/sec)
29103@1502118291.281773:nbd_send_request Sending request to server: {
=2Efrom =3D 0, .len =3D 0, .handle =3D 93860726319200, .flags =3D 0x0, .t=
ype =3D 3
(flush) }
29103@1502118291.281902:nbd_receive_reply Got reply: { magic =3D
0x67446698, .error =3D  0, handle =3D 93860726319200 }
29103@1502118291.281939:nbd_send_request Sending request to server: {
=2Efrom =3D 0, .len =3D 0, .handle =3D 93860726319200, .flags =3D 0x0, .t=
ype =3D 3
(flush) }
29103@1502118291.282064:nbd_receive_reply Got reply: { magic =3D
0x67446698, .error =3D  0, handle =3D 93860726319200 }
29103@1502118291.282078:nbd_send_request Sending request to server: {
=2Efrom =3D 0, .len =3D 0, .handle =3D 0, .flags =3D 0x0, .type =3D 2 (di=
scard) }

followed by a clean disconnect; vs. the buggy server:

29148@1502118384.385133:nbd_opt_go_success Export is good to go
29148@1502118384.385321:nbd_send_request Sending request to server: {
=2Efrom =3D 0, .len =3D 1, .handle =3D 94152262559840, .flags =3D 0x0, .t=
ype =3D 0
(read) }
29148@1502118396.494643:nbd_receive_reply Got reply: { magic =3D
0x1446698, .error =3D  0, handle =3D 94152262559840 }
invalid magic (got 0x1446698)
read 1/1 bytes at offset 0
1 bytes, 1 ops; 0:00:12.10 (0.082581 bytes/sec and 0.0826 ops/sec)
29148@1502118396.494746:nbd_send_request Sending request to server: {
=2Efrom =3D 0, .len =3D 0, .handle =3D 94152262559840, .flags =3D 0x0, .t=
ype =3D 3
(flush) }

where the client is now hung.  Thankfully, the client is blocked in an
idle loop (not eating CPU), so I don't know if this counts as the
ability for a malicious server to cause a denial of service against qemu
as an NBD client (in general, being unable to read further data from the
server because client internal state is now botched is not that much
different from being unable to read further data from the server because
the client hung up on the invalid server), unless there is some way to
cause qemu to die from an assertion failure rather than just get stuck.

It also looks like the client acts on at most one bad packet from the
server before it gets stuck - but the question is whether a malicious
server could, in that one bad packet reply, cause qemu to misbehave in
some other way.

I'm adding Prasad, to analyze whether this needs a CVE.

We don't have a good protocol fuzzer to simulate a bad client and/or bad
server as the partner over the socket - if you can find any more such
interactions where a bad partner can cause a hang or crash, let's get
those fixed in 2.10.

Meanwhile, I'll probably include this patch in 2.10 (after first
figuring out if it works in isolation or needs other patches from your
series).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qQnkV5UfljO4IbgewST4rVP297hm5RQ6R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIg6MACgkQp6FrSiUn
Q2p0kQf/c2NElHHh+s4/j9xfky5f9pbYqBrNvP2GGVBtwZz9Tx3sl5vOXUO8fMka
M+TauaSiOJcbsvBbFnlh/YCCxO8PZDG0k9aJ7racuwb8CSH0mh6apwCR/VZg5fJh
IODx8VaG4dPu23QR+vrc2lprcCNg7qxUIGoKa9K54rtnV2teVPihjMLmYSKTJL/U
bce52AzqKYtnpmIqsnOVGA4HJljKiQrIGA4xv26HUmGFtROglv4Eyz0NmoC3dQP1
Z7Gk16ggPM+njBugKdeCpM1ajAEnSn0melQx4iOOIR3ndUm/myk63Ea6WgEXhMyT
QVbca2xPbMJRlWpFXGeZZzFJUo2XSw==
=luRM
-----END PGP SIGNATURE-----

--qQnkV5UfljO4IbgewST4rVP297hm5RQ6R--
