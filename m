Received: from eggs.gnu.org ([2001:4830:134:3::10]:58008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0SNN-0005NS-Je
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0SNM-0006SL-O8
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:36:57 -0400
References: <20170418103948.13965-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b51de74-0d1b-ebae-1b98-fa74d028c982@redhat.com>
Date: Tue, 18 Apr 2017 14:36:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170418103948.13965-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9-rc5 v3] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 18/04/2017 12:39, Fam Zheng wrote:
> +    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
> +        BlockDriverState *bs = child->bs;
> +        assert(bs->refcnt > 0);
> +        bdrv_ref(bs);
> +        waited |= bdrv_drain_recurse(bs);
> +        bdrv_unref(bs);
>      }

I think this accesses global state that is not protected by the
AioContext lock?

Paolo
