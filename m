Received: from eggs.gnu.org ([2001:4830:134:3::10]:45472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f5oOA-0003xU-EZ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f5oO9-00046L-EE
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:12:26 -0400
Date: Tue, 10 Apr 2018 16:11:58 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180410081158.GA20090@stefanha-x1.localdomain>
References: <20180404150146.23281-1-stefanha@redhat.com>
	<5c93e912-9d6a-214c-e4fb-8a4e6fc6e7f9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <5c93e912-9d6a-214c-e4fb-8a4e6fc6e7f9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] qemu-iotests: update 185 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 06:16:12PM +0200, Max Reitz wrote:
> On 2018-04-04 17:01, Stefan Hajnoczi wrote:
>  =3D=3D=3D Start mirror job and exit qemu =3D=3D=3D
>=20
> This seems to be independent of whether there is actually data on
> TEST_IMG (the commit source), so something doesn't seem quite right with
> the block job throttling here...?

I've been playing around with this test failure.  Let's leave it broken
(!) in QEMU 2.12 because this test has uncovered a block job ratelimit
issue that's not a regression.  The fix shouldn't be rushed.

block/mirror.c calculates delay_ns but then discards it:

  static void coroutine_fn mirror_run(void *opaque)
  {
      ...

      for (;;) {
          ...delay_ns is calculated based on job speed...

          ret =3D 0;
          trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
          if (block_job_is_cancelled(&s->common) && s->common.force) {
              break;
          } else if (!should_complete) {
              delay_ns =3D (s->in_flight =3D=3D 0 && cnt =3D=3D 0 ? SLICE_T=
IME : 0);
	        ^--- we discard it!
              block_job_sleep_ns(&s->common, delay_ns);
          }
          s->last_pause_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
      }

      ...
  }

This is why the mirror-based tests are completing even though we'd
expect them to only reach the "next" iteration due to the job speed.

Increasing the 4 MB write operation in the test to >16 MB (the mirror
buffer size) doesn't solve the problem because the next QMP command will
race with the job's 0 ns sleep.  It would just make the test unreliable.

I'll work on the following for QEMU 2.13:

1. Avoid spurious block_job_enter() from block_job_drain().  This
   eliminates the extra block job iteration that changed the output in
   the first place.

2. Honor the job speed in block/mirror.c.

The end result will be that the test output will not require changes.

Stefan

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazHHOAAoJEJykq7OBq3PIrkQH/iDIJCIJEaC5Zqd+ztuXVmDV
sdtd7y1CTrPi2riZIOeB+w+20je+YJ12cc0Qz5JP6/zYaC14u3DHQfkIYRyL47Wq
HxNdR5lbUL48wrB3pByacOTrJRavnzSowEMyP1rhm5FLCVlnNL+f4bnefrfbhTvG
HulYvNO5dXAhxjCc+dH9yWjW2PmHx4NppK05qiM2WasEDzN7N2186fUZEVVuC0k/
+PTLAjDIQgbU9Nv6Wz/Z4cwkf+bHMMkON7KkuwidBXJPOnGXzW921FK+djjG3pTT
w0HvRPafDaFSJE3SBtthFEvMpRoi0J/HxmlPahJY56OaTkinChln75SdtGYvW/Q=
=gtd9
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
