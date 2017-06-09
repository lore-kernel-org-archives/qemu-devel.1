Received: from eggs.gnu.org ([2001:4830:134:3::10]:52209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dJJUy-0002YG-37
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dJJUx-0001Ff-6R
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:58:44 -0400
Date: Fri, 9 Jun 2017 14:58:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170609125831.GD4462@noname.redhat.com>
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
	<1497009003-25794-4-git-send-email-kwolf@redhat.com>
	<8514d36e-1bc6-567f-4f10-9e8584b9eed0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <8514d36e-1bc6-567f-4f10-9e8584b9eed0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test exiting qemu with
 running job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.06.2017 um 14:14 hat Eric Blake geschrieben:
> On 06/09/2017 06:50 AM, Kevin Wolf wrote:
> > When qemu is exited, all running jobs should be cancelled successfully.
> > This adds a test for this for all types of block jobs that currently
> > exist in qemu.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/185     | 189 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  tests/qemu-iotests/185.out |  59 ++++++++++++++
> >  tests/qemu-iotests/group   |   1 +
> >  3 files changed, 249 insertions(+)
> >  create mode 100755 tests/qemu-iotests/185
> >  create mode 100644 tests/qemu-iotests/185.out
> >=20
>=20
> > +
> > +_send_qemu_cmd $h \
> > +    "{ 'execute': 'human-monitor-command',
> > +       'arguments': { 'command-line':
> > +                      'qemu-io disk \"write 0 4M\"' } }" \
> > +    "return"
>=20
> My first reaction? "Why are we still dropping back to HMP?"  My second -
> "Oh yeah - qemu-io is a debugging interface, and we really don't
> need/want it in QMP".  This part is fine.
>=20
> > +_send_qemu_cmd $h \
> > +    "{ 'execute': 'drive-backup',
> > +       'arguments': { 'device': 'disk',
> > +                      'target': '$TEST_IMG.copy',
> > +                      'format': '$IMGFMT',
> > +                      'sync': 'full',
> > +                      'speed': 65536 } }" \
>=20
> Fun with slow speeds :)
>=20
> 64k is slow enough compared to your 4M chunk that you should be fairly
> immune to a heavy load allowing the job to converge.  However,
>=20
> > +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "SHUTDOWN", "data": {"guest": false}}
> > +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "o=
ffset": 524288, "speed": 65536, "type": "commit"}}
>=20
> I'm worried that if you don't sanitize at least offset, you will still
> be prone to some race conditions changing the output.  You may want to
> add in some additional filtering on the output to be safer.

I considered that at first, but then I realised that these offsets are
indeed predictable and we want to know if they change (it would likely
mean that the throttling is broken).

If you look at the individual cases, we have:

* offset=3D512k for (intermediate) commit and streaming. This is exactly
  the buffer size for a single request and will be followed by a delay
  of eight seconds before the next chunk is copied, so we will never get
  a different value here.

* offset=3D4M for active commit and mirror, because the mirror job has a
  larger buffer size by default, so one request completes it all. This
  number is already the maximum, so nothing is going to change here
  either.

* offset=3D64k for backup, which works cluster by cluster. We know that
  the cluster size is exactly 64k, and while we have only one second
  of delay here, that's still plenty of time for the 'quit' command to
  arrive.

Note that only the 'quit' command must be received in time on the QMP
socket, everything after that is synchronously, so even on a heavily
loaded host I don't see this fail. Well, maybe if it's swapping to
death, but then you have other problems.

So I think the offses actually make sense as part of the test.

Kevin

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZOpt3AAoJEH8JsnLIjy/WIxIP/i0w+qtYh742TolZS7ya/bvl
jKlAffEqu/YQvnrB/2whKzYba+tjpZ/oaJFV9JfUNxmYm8UA+PVPH2vRX4ct5EbP
aUNWztqdgFPDUmdrKLKqYsQjEF2ZSpBMYf8Sqwzju3grTu1DCJgk/R8purST+qpH
mi2tZ+BnWmJcyTBQw2Zb6iiIaymceQSzgHBqjcFLbmathkpqjnWdeLZ5TryKi6Xv
KEkSm+qpRR5OYQyVGB70Q+qBCzppv6Zy8Y4Ihb4zWL4mQXdMOqtKE4PQsjYE9k6g
+IQ1qJrN/DZGi0s5m+xnZ6cwD6k3muTiR7VNaCDvKCkazVqPtU3lG9wrQQuvKUvv
axsKQHDkj1+FS42VpemJGRu8Tnw+OdLZHnc1fO/FewUqPfLhRUA/e5EkeQe8BxFJ
Zeewlft17djaxosQki6OaXxa/nRtfgPhPcvzE2Uv3DFATPgrG9lK/YtNgT6w0Rrz
CS4U/mvv1mlxIgBQFfRasHuzXsOsl3hmdXnSLwgufMQ7EeH+yKEQ2BqONQ/Jg+47
17Htxt6PyRe/8M9iz1dOUizSQtO4Zb5kLyyQ7rriOiaiIbf2B0zek+A3MlpToD10
eZOWmXqvEN8ye+iKdVilaTDk5EB+oYiZ/RGo4KXViflkxqX3NBSrSYxli9L1IcLO
qVrxYUEx7Ri1RBoAfMrz
=YYGd
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
