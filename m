Received: from eggs.gnu.org ([2001:4830:134:3::10]:59610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPtx5-0003bW-Tv
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPtx4-0006et-C5
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:06:59 -0400
References: <20170608222617.20376-1-eblake@redhat.com>
	<004dc59b-f1b0-548e-70af-3e1db1c749fa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <37a05656-453b-1e2f-7fd2-18941aeedbf7@redhat.com>
Date: Tue, 27 Jun 2017 12:06:47 -0500
MIME-Version: 1.0
In-Reply-To: <004dc59b-f1b0-548e-70af-3e1db1c749fa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q4mor5nF2LCC6eI686ibkAMjFe4ebmWK5"
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
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, P J P <ppandit@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q4mor5nF2LCC6eI686ibkAMjFe4ebmWK5
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 P J P <ppandit@redhat.com>
Message-ID: <37a05656-453b-1e2f-7fd2-18941aeedbf7@redhat.com>
Subject: Re: [PATCH] nbd: Fix regression on resiliency to port scan
References: <20170608222617.20376-1-eblake@redhat.com>
 <004dc59b-f1b0-548e-70af-3e1db1c749fa@redhat.com>
In-Reply-To: <004dc59b-f1b0-548e-70af-3e1db1c749fa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/11/2017 06:50 AM, Max Reitz wrote:
> On 2017-06-09 00:26, Eric Blake wrote:
>> Back in qemu 2.5, qemu-nbd was immune to port probes (a transient
>> server would not quit, regardless of how many probe connections
>> came and went, until a connection actually negotiated).  But we
>> broke that in commit ee7d7aa

>> Simple test across two terminals:
>> $ qemu-nbd -f raw -p 30001 file
>=20
> Maybe this command line should contain a -t, because otherwise I don't
> find it very CVE-worthy.

I was on vacation when this patch got merged, so it's too late to modify
the commit message now.  However, I'm following up now; first to point
out that we now have the actual CVE number (it was not yet assigned when
I originally posted - and if we hadn't merged yet, I would also have
tweaked the commit message to call the id out): CVE-2017-9524

>=20
> First, sure, you can kill this NBD server with the below nmap
> invocation, or with an "ncat localhost 30001". But you can also do so
> with a plain "qemu-io -c quit nbd://localhost:30001".

But in that case, without -t, you specifically wanted the server to go
away after the first successful client, and that was indeed a successful
client.

>=20
> With -t you actually cannot kill it using ncat or qemu-io, but you can
> with nmap. So this is what the actual issue is.

You do make a point, though.  The command line example I gave is the
old-style NBD, where there is no named export, and where any client is
first in line for the given export - which is rather weak, and why
upstream NBD discourages the old protocol in favor of the new where the
client has to specify WHICH named export it wants.  And in the new
protocol, if you are not using -t, then you want the server to ignore
clients that aren't requesting the export that the server is willing to
serve, rather than hanging up on the first random client that requests
the wrong name.  And you properly investigated that scenario below...

>=20
> And secondly, note that even after this patch you can make the NBD
> server quit with "ncat localhost 30001" (just like with qemu-io).
>=20
>> $ nmap 127.0.0.1 -p 30001 && \
>>   qemu-io -c 'r 0 512' -f raw nbd://localhost:30001
>>
>> Note that this patch does not change what constitutes successful
>> negotiation (thus, a client must enter transmission phase before
>> that client can be considered as a reason to terminate the server
>> when the connection ends).
>=20
> Well, the thing is that transmission phase starts immediately for the
> old-style protocol:
>=20
> $ ./qemu-nbd -f raw null-co:// &
> [1] 24581
> $ ncat --send-only localhost 10809 < /dev/null
> nbd/server.c:nbd_receive_request():L706: read failed
> [1]  + 24581 done       ./qemu-nbd -f raw null-co://
>=20
> I'm not sure whether this is intended, but then again I'm not sure
> whether we can or have to do anything about this (as I said above, you
> can easily make the server quit with a qemu-io invocation if you're so
> inclined.

Old-style negotiation is not as important these days as new-style where
a handshake occurs (in fact, upstream NBD documents but no longer
implements old-style negotiation, so it has definitely moved into
deprecated usage).

>=20
> But the thing is that this really shows there should be a -t in the
> qemu-nbd invocation in this commit message. The merit of this patch is
> that it fixes a *crash* in qemu-nbd if someone closes the connection
> immediately after opening it, not that it allows qemu-nbd to continue t=
o
> run when someone connects who is not an NBD client -- because it really=

> doesn't.

So yes, your arguments are good that the REAL denial-of-service is not
against a server that expects only one client (or, with new-style, one
client that knows about the specific export), but against a server
running with -t that is supposed to be persistent regardless of how many
clients consecutively connect to it.

>=20
> (With the new style, option negotiation fails so we do not go to
> transmission phase and the server stays alive:
>=20
> $ ./qemu-nbd -x foo -f raw null-co:// &
> [1] 24609
> $ ncat --send-only localhost 10809 < /dev/null
> nbd/server.c:nbd_negotiate_options():L442: read failed
> nbd/server.c:nbd_negotiate():L673: option negotiation failed
> $ kill %1
> [1]  + 24609 done       ./qemu-nbd -x foo -f raw null-co://
>=20
> )
>=20
>>                             Perhaps we may want to tweak things
>> in a later patch to also treat a client that uses NBD_OPT_ABORT
>> as being a 'successful' negotiation (the client correctly talked
>> the NBD protocol, and informed us it was not going to use our
>> export after all), but that's a discussion for another day.
>=20
> Well, about that...
>=20
> $ ./qemu-nbd -x foo -f raw null-co:// &
> [1] 24389
> $ ./qemu-io -c quit nbd://localhost/bar
> can't open device nbd://localhost/bar: No export with name 'bar' availa=
ble
> [1]  + 24389 broken pipe  ./qemu-nbd -x foo -f raw null-co://
>=20
> Even worse, the same happens with -t, both before and after this patch.=


You later submitted the fix for this (ignoring SIGPIPE); what I'm now
trying to figure out is whether your later patch is part of the same
CVE-2017-9524 fix, or whether we need a second CVE assigned for this
second denial-of-service scenario.

>=20
> Having spent probably too much time for investigating, this happens
> because the client just closes the pipe which results in a SIGPIPE sent=

> to qemu-nbd when it tries to sendmsg() (in qio_channel_socket_writev())=

> the ACK.
>=20
> qemu-io and qemu-img use signal(SIGPIPE, SIG_IGN) (and os-posix.c has a=

> sigaction() call for the same). qemu-nbd should probably, too.
> ...Considering you're on vacation next week, maybe I should just write
> that patch.

Thanks for your investigations and followup patch.  Now, the task at
hand is to figure out how important your followup patch is to the CVE
question.

>=20
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1451614
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  include/block/nbd.h |  2 +-
>>  blockdev-nbd.c      |  6 +++++-
>>  nbd/server.c        | 24 +++++++++++++++---------
>>  qemu-nbd.c          |  4 ++--
>>  4 files changed, 23 insertions(+), 13 deletions(-)
>=20
> With a -t in the qemu-nbd command line:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Q4mor5nF2LCC6eI686ibkAMjFe4ebmWK5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUpCnAAoJEKeha0olJ0NqmNcIAJvfFjh7838+l44LTdHO0S3U
KNDtFSEVtS4jkY6BQ9XMcU8r+mcO/sAipXS9myY1dIzQxBpkUrwvVL5oxoLHF2Pr
qrmu2dR6obe1KuKMEIYcY19UllCYb8Swpzh8bXjvSiy4HN72nF9dd3YzQyX4X7C0
XnYR/LFZOq9HyumecRDk8OiLgyoSkwUAPBHw2n7RQ8T8nH+cicHKyi5rc7YpSCD+
qvGzcWXuFwOwxXPq50vPNQgUwM5f+41XclFDTLoW7iyG4qden4nGGE+wku9tqg02
Sp1KsNJXKAoEDSN3qSy9XyZVr5XDxPkIyq5H99YlE14aX/DemnYWd+Sn5knCnro=
=RACw
-----END PGP SIGNATURE-----

--Q4mor5nF2LCC6eI686ibkAMjFe4ebmWK5--
