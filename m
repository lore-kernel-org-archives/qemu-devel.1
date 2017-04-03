Received: from eggs.gnu.org ([2001:4830:134:3::10]:51349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cv1JZ-0007dQ-5K
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cv1JU-0006kQ-8I
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:42:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cv1JU-0006kE-1q
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:42:28 -0400
Message-ID: <1491223335.17505.48.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 03 Apr 2017 14:42:15 +0200
In-Reply-To: <b8daec8e-86ed-56e6-d42d-d948508e5b6f@ilande.co.uk>
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
	<e0df6143-81f2-a0e7-2c23-90dd01724e9f@redhat.com>
	<1491221026.17505.39.camel@redhat.com>
	<b8daec8e-86ed-56e6-d42d-d948508e5b6f@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Mo, 2017-04-03 at 13:24 +0100, Mark Cave-Ayland wrote:
> On 03/04/17 13:03, Gerd Hoffmann wrote:
>=20
> >   Hi,
> >=20
> >> I checked the branch, is bitmap_copy_and_clear_atomic correct when you
> >> have partial updates?  Maybe you need to handle partial updates of the
> >> first and last word?
> >=20
> > Should not be a problem.  We might clear some more bits, but these are
> > outsize the visible area so they should cause visible corruption (and i=
f
> > the visible area changes the display code needs to do a full refresh
> > anyway).
>=20
> Right. Also is there a reason that
> cpu_physical_memory_snapshot_and_clear_dirty() uses BITS_PER_LEVEL when
> calculating the alignment used for the first/last addresses?

The code copy doesn't operate on bits but on bitmap longs, so I can just
copy the whole long instead of fiddeling with bits.  So I round down to
a bitmap long start.  On 64bit hosts that are units of 64 pages.

Actually querying the copied bitmap operates on page granularity of
course.

> Otherwise you end up expanding the range of your last address
> considerably beyond the next page alignment.

Yes, it's larger, but as it expands to the start of the long word I
expect the penalty is almost zero (same cache line) and being able to
just copy the whole long instead of dealing with individual bits should
be a win.

> And also in the main page
> loop why is BITS_PER_LEVEL used? I see that several of the internal
> bitmap routines appear to use BITS_PER_LONG for compressing into the
> bitmap which might be more appropriate?

shift by BITS_PER_LEVEL is the same as division by BITS_PER_LONG

cheers,
  Gerd
