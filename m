Received: from eggs.gnu.org ([2001:4830:134:3::10]:36516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fBIhi-0000sW-FD
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fBIhh-0003bL-FZ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:35:18 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <319c6e7b-c23c-09cd-4198-5b537a99c98c@redhat.com>
References: <20180421132929.21610-1-mreitz@redhat.com>
	<20180421132929.21610-2-mreitz@redhat.com>
	<w51in8g63r5.fsf@maestria.local.igalia.com>
	<319c6e7b-c23c-09cd-4198-5b537a99c98c@redhat.com>
Date: Wed, 25 Apr 2018 13:35:07 +0200
Message-ID: <w51604fsems.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/9] block: Add COR filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Wed 25 Apr 2018 01:18:03 PM CEST, Max Reitz wrote:

>>> +#define PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
>>> +                          | BLK_PERM_WRITE \
>>> +                          | BLK_PERM_RESIZE)
>>> +#define PERM_UNCHANGED (BLK_PERM_ALL & ~PERM_PASSTHROUGH)
>>> +
>>> +static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
>>> +                           const BdrvChildRole *role,
>>> +                           BlockReopenQueue *reopen_queue,
>>> +                           uint64_t perm, uint64_t shared,
>>> +                           uint64_t *nperm, uint64_t *nshared)
>>> +{
>>> +    if (c == NULL) {
>>> +        *nperm = (perm & PERM_PASSTHROUGH) | BLK_PERM_WRITE_UNCHANGED;
>>> +        *nshared = (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
>>> +        return;
>>> +    }
>>> +
>>> +    *nperm = (perm & PERM_PASSTHROUGH) |
>>> +             (c->perm & PERM_UNCHANGED);
>> 
>> I admit I'm not completely familiar with this, but don't you need to
>> add BLK_PERM_WRITE_UNCHANGED to *nperm ?
>
> As long as it's requested in when the child is attached (which it is
> in the "c == NULL" case), it should be part of c->perm then.
>
> (And since PERM_PASSTHROUGH does not contain WRITE_UNCHANGED, it is
> part of PERM_UNCHANGED.)

I see, thanks.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
