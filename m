Received: from eggs.gnu.org ([2001:4830:134:3::10]:57125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqLbG-0005v8-VU
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqLbC-0006rY-6V
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:26:02 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180222155922.9833-3-eblake@redhat.com>
References: <20180222155922.9833-1-eblake@redhat.com>
	<20180222155922.9833-3-eblake@redhat.com>
Date: Mon, 26 Feb 2018 17:25:54 +0100
Message-ID: <w51bmgbd8fh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qcow2: Document some maximum size
 constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 22 Feb 2018 04:59:20 PM CET, Eric Blake wrote:
> While at it, notice that since we cannot map any virtual cluster to
> any address higher than 64 PB (56 bits) (due to the L1/L2 field
> encoding), it makes little sense to require the refcount table to
> access host offsets beyond that point.

But refcount blocks are not addressed by L2 tables, so in principle it
should be possible to have refcount blocks after the first 64PB.

But I agree that it's a good idea to set that as a maximum possible
physical size of the qcow2 image.

> @@ -341,7 +355,7 @@ Refcount table entry:
>
>      Bit  0 -  8:    Reserved (set to 0)
>
> -         9 - 63:    Bits 9-63 of the offset into the image file at which the
> +         9 - 55:    Bits 9-55 of the offset into the image file at which the
>                      refcount block starts. Must be aligned to a cluster
>                      boundary.
>
> @@ -349,6 +363,8 @@ Refcount table entry:
>                      been allocated. All refcounts managed by this refcount block
>                      are 0.
>
> +        56 - 63:    Reserved (set to 0)

Are we not updating REFT_OFFSET_MASK as well?

Berto
