Received: from eggs.gnu.org ([2001:4830:134:3::10]:43546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eorNn-0005pT-OZ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eorNj-0004eT-0t
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:57:59 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <aed232fa-af26-5994-0bed-ec84a514b645@redhat.com>
References: <20180220222459.8461-1-eblake@redhat.com>
	<20180220222459.8461-3-eblake@redhat.com>
	<20180221165116.GB4196@localhost.localdomain>
	<aed232fa-af26-5994-0bed-ec84a514b645@redhat.com>
Date: Thu, 22 Feb 2018 14:57:51 +0100
Message-ID: <w518tbl5dpc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: Avoid memory over-allocation on
 compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On Wed 21 Feb 2018 05:59:58 PM CET, Eric Blake wrote:
> But as Berto has convinced me that an externally produced image can
> convince us to read up to 4M (even though we don't need that much to
> decompress),

A (harmless but funny) consequence of the way this works is that for any
valid compressed cluster you should be able to increase the value of the
size field as much as you want without causing any user-visible effect.

So if you're working with 2MB clusters but for a particular compressed
cluster the size field is 0x0006 (7 sectors) you can still increase it
to the maximum (0x1fff, or 8192 sectors) and it should work just the
same. QEMU will read 4MB instead of ~4KB but since decompression stops
once the original cluster has been restored there's no harm.

I think I'll write a test case for this, it can be useful to verify that
QEMU can handle this kind of scenarios.

Berto
