Received: from eggs.gnu.org ([2001:4830:134:3::10]:45593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6a5Y-0006fB-6I
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6a5X-0008Ia-I2
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:03:52 -0400
References: <20170505090044.28754-1-hch@lst.de>
	<f282c1fb-6c8b-a16d-8ce0-5ce244ec4fb2@redhat.com>
	<20170505095105.GA6630@lst.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8a6ae1b-fc48-4c15-1b15-bd966b00c00e@redhat.com>
Date: Fri, 5 May 2017 12:03:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170505095105.GA6630@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nvme: Implement Write Zeroes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 05/05/2017 11:51, Christoph Hellwig wrote:
>> could you pass BDRV_REQ_MAY_UNMAP for the flags here if the deallocate
>> bit (dword 12 bit 25) is set?
> In fact we should do that unconditonally.  The deallocate bit is new
> in 1.3 (which we don't claim to support) and forces deallocating, but
> NVMe already allows for this behavior without the flag (we in fact
> explicitly clarified this in an ECN for 1.2.1).

While that's allowed and it makes sense indeed on SSDs, for QEMU's
typical usage it can lead to fragmentation and worse performance.  On
extent-based file systems, write zeroes without deallocate can be
implemented very efficiently with FALLOC_FL_ZERO_RANGE, and there's no
reason not to do it.

Is there anything backwards-incompatible in 1.3 that would make it hard
to just bump the supported version?

Paolo
