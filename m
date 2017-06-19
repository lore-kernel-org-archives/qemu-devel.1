Received: from eggs.gnu.org ([2001:4830:134:3::10]:60401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dMtba-0006KU-Fi
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dMtbW-00014S-C5
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:08:22 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dMtbW-00012o-4n
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:08:18 -0400
Received: by mail-wm0-x229.google.com with SMTP id u195so56979675wmd.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:08:18 -0700 (PDT)
Date: Mon, 19 Jun 2017 11:08:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170619100813.GB17304@stefanha-x1.localdomain>
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
Subject: Re: [Qemu-devel] [RFC] virtio-mem: paravirtualized memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 16, 2017 at 04:20:02PM +0200, David Hildenbrand wrote:
> Important restrictions of this concept:
> - Guests without a virtio-mem guest driver can't see that memory.
> - We will always require some boot memory that cannot get unplugged.
>   Also, virtio-mem memory (as all other hotplugged memory) cannot become
>   DMA memory under Linux. So the boot memory also defines the amount of
>   DMA memory.

I didn't know that hotplug memory cannot become DMA memory.

Ouch.  Zero-copy disk I/O with O_DIRECT and network I/O with virtio-net
won't be possible.

When running an application that uses O_DIRECT file I/O this probably
means we now have 2 copies of pages in memory: 1. in the application and
2. in the kernel page cache.

So this increases pressure on the page cache and reduces performance :(.

Stefan

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZR6KNAAoJEJykq7OBq3PIQqMH/0S2AZbkzrqnJOKdCz8yKg9X
qBbZG8McVs38XBZtkkzU4J4JKQMsS7b+boDjJ8N5LmjuHrNFfnJrwScVVc8aQ++E
muHRRed4s556aSBAcSvk/OT7CtxYdwrraFuvzp2O1Rt84m9RPrMv719xZxeWsbzo
69e7xRq3NIAgv2zLbPIWV/RiqXJIYWJatGP95n0PvKIeRwxl8jK68BUdEchWGjAQ
mcjgcM8gch/facSMSd0OcRR4IgCLKuEV3RqKXJ2WKy//xWIjQc95m0sQEFWdwBtB
Eri7GCsR0SDsOfGtoMmBvuQOePISkS1YiqNNLcSVKY2WJ5agzszR/rnFl6vvAF0=
=zROB
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
