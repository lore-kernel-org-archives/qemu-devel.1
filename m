Received: from eggs.gnu.org ([2001:4830:134:3::10]:50431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dK1O5-0006t4-M6
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 07:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dK1O4-0004KJ-GZ
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 07:50:33 -0400
References: <20170608222617.20376-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <004dc59b-f1b0-548e-70af-3e1db1c749fa@redhat.com>
Date: Sun, 11 Jun 2017 13:50:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170608222617.20376-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mX0TdkTJdQHM56sFpJWGwHSqs98ew9b3t"
Subject: Re: [Qemu-devel] [PATCH] nbd: Fix regression on resiliency to port
 scan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mX0TdkTJdQHM56sFpJWGwHSqs98ew9b3t
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <004dc59b-f1b0-548e-70af-3e1db1c749fa@redhat.com>
Subject: Re: [PATCH] nbd: Fix regression on resiliency to port scan
References: <20170608222617.20376-1-eblake@redhat.com>
In-Reply-To: <20170608222617.20376-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-09 00:26, Eric Blake wrote:
> Back in qemu 2.5, qemu-nbd was immune to port probes (a transient
> server would not quit, regardless of how many probe connections
> came and went, until a connection actually negotiated).  But we
> broke that in commit ee7d7aa when removing the return value to
> nbd_client_new(), although that patch also introduced a bug causing
> an assertion failure on a client that fails negotiation.  We then
> made it worse during refactoring in commit 1a6245a (a segfault
> before we could even assert); the (masked) assertion was cleaned
> up in d3780c2 (still in 2.6), and just recently we finally fixed
> the segfault ("nbd: Fully intialize client in case of failed
> negotiation").  But that still means that ever since we added
> TLS support to qemu-nbd, we have been vulnerable to an ill-timed
> port-scan being able to cause a denial of service by taking down
> qemu-nbd before a real client has a chance to connect.

Maybe it would be worthy to note explicitly that this does not affect
named exports (i.e. everything done with the system emulator).

> Since negotiation is now handled asynchronously via coroutines,
> we no longer have a synchronous point of return by re-adding a
> return value to nbd_client_new().  So this patch instead wires
> things up to pass the negotiation status through the close_fn
> callback function.
>=20
> Simple test across two terminals:
> $ qemu-nbd -f raw -p 30001 file

Maybe this command line should contain a -t, because otherwise I don't
find it very CVE-worthy.

First, sure, you can kill this NBD server with the below nmap
invocation, or with an "ncat localhost 30001". But you can also do so
with a plain "qemu-io -c quit nbd://localhost:30001".

With -t you actually cannot kill it using ncat or qemu-io, but you can
with nmap. So this is what the actual issue is.

And secondly, note that even after this patch you can make the NBD
server quit with "ncat localhost 30001" (just like with qemu-io).

> $ nmap 127.0.0.1 -p 30001 && \
>   qemu-io -c 'r 0 512' -f raw nbd://localhost:30001
>=20
> Note that this patch does not change what constitutes successful
> negotiation (thus, a client must enter transmission phase before
> that client can be considered as a reason to terminate the server
> when the connection ends).

Well, the thing is that transmission phase starts immediately for the
old-style protocol:

$ ./qemu-nbd -f raw null-co:// &
[1] 24581
$ ncat --send-only localhost 10809 < /dev/null
nbd/server.c:nbd_receive_request():L706: read failed
[1]  + 24581 done       ./qemu-nbd -f raw null-co://

I'm not sure whether this is intended, but then again I'm not sure
whether we can or have to do anything about this (as I said above, you
can easily make the server quit with a qemu-io invocation if you're so
inclined.

But the thing is that this really shows there should be a -t in the
qemu-nbd invocation in this commit message. The merit of this patch is
that it fixes a *crash* in qemu-nbd if someone closes the connection
immediately after opening it, not that it allows qemu-nbd to continue to
run when someone connects who is not an NBD client -- because it really
doesn't.

(With the new style, option negotiation fails so we do not go to
transmission phase and the server stays alive:

$ ./qemu-nbd -x foo -f raw null-co:// &
[1] 24609
$ ncat --send-only localhost 10809 < /dev/null
nbd/server.c:nbd_negotiate_options():L442: read failed
nbd/server.c:nbd_negotiate():L673: option negotiation failed
$ kill %1
[1]  + 24609 done       ./qemu-nbd -x foo -f raw null-co://

)

>                             Perhaps we may want to tweak things
> in a later patch to also treat a client that uses NBD_OPT_ABORT
> as being a 'successful' negotiation (the client correctly talked
> the NBD protocol, and informed us it was not going to use our
> export after all), but that's a discussion for another day.

Well, about that...

$ ./qemu-nbd -x foo -f raw null-co:// &
[1] 24389
$ ./qemu-io -c quit nbd://localhost/bar
can't open device nbd://localhost/bar: No export with name 'bar' availabl=
e
[1]  + 24389 broken pipe  ./qemu-nbd -x foo -f raw null-co://

Even worse, the same happens with -t, both before and after this patch.

Having spent probably too much time for investigating, this happens
because the client just closes the pipe which results in a SIGPIPE sent
to qemu-nbd when it tries to sendmsg() (in qio_channel_socket_writev())
the ACK.

qemu-io and qemu-img use signal(SIGPIPE, SIG_IGN) (and os-posix.c has a
sigaction() call for the same). qemu-nbd should probably, too.
=2E..Considering you're on vacation next week, maybe I should just write
that patch.

> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1451614
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/nbd.h |  2 +-
>  blockdev-nbd.c      |  6 +++++-
>  nbd/server.c        | 24 +++++++++++++++---------
>  qemu-nbd.c          |  4 ++--
>  4 files changed, 23 insertions(+), 13 deletions(-)

With a -t in the qemu-nbd command line:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--mX0TdkTJdQHM56sFpJWGwHSqs98ew9b3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZPS58EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQNSw
CACWH17SvGLckVJX9irSjkXj7gUDVCfyYXVJyG4na0hjb1s7ChZBnd8U8gYBtQ7E
kZwNSUkRMQhvOzRzGLo9DnuPtLwzCHZ6RjF4kLQvsiQClMMsFLiwmO9Bw55wr0tN
A8/MnVRsPv7iQvHv8qPC6cAMPkN3jb0cKSQn7SoTxF3+CT92J6nK9SjRP6OygrYd
mBUudXQbVLmYn2CGyJdSbTPUw2MOz51EGO58Y7UJ02oGp6Ys9owVQztudmlBr5Ij
cSj/2R/Gh0ZC6TElV81UMvMfgidOJx2R+Inih2+2Nln6v2NJyba8isu8xfJkN2Nz
wfrG2lA2oMjl5cv6Y8IQzYl1
=7uR5
-----END PGP SIGNATURE-----

--mX0TdkTJdQHM56sFpJWGwHSqs98ew9b3t--
