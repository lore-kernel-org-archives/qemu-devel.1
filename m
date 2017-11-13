Received: from eggs.gnu.org ([2001:4830:134:3::10]:45024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEFLN-0001CK-9F
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEFLH-0004aV-Gr
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:04:09 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171108143354.GF30890@localhost.localdomain>
References: <20171106145345.12038-1-berto@igalia.com>
	<20171108143354.GF30890@localhost.localdomain>
Date: Mon, 13 Nov 2017 15:03:59 +0100
Message-ID: <w51inee9sxc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block: Close a BlockDriverState completely
 even when bs->drv is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed 08 Nov 2017 03:33:54 PM CET, Kevin Wolf wrote:
>> This patch makes bdrv_close() do the full uninitialization process in
>> all cases. This fixes the problem with corrupted images and still
>> works fine with freshly created BDSs.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>
> This doesn't apply cleanly in the test case. Does it depend on your
> qcow2 fixes?

Ah, yes. It doesn't have any semantic dependency though, so as long as
you add the new tests to qemu-iotests/060 it will work.

I can resend it properly rebased.

> Also, while I think the change makes sense, it's also clear that we're
> trying to fix up an inconsistent state here. Maybe we could also
> improve the state that block drivers leave behind when marking an
> image as corrupt. Just setting bs->drv = NULL means that at least any
> internal data structures will not get cleaned up.
>
> On the other hand, we can't just call bdrv_close() from a failing
> request because closing requires that we drain the request
> first. Maybe it would be possible to call drv->bdrv_close() with a BH
> or something.

I'm not sure if I'm following you here, where would you add the
bottom-half and what kind of problem it would solve?

Berto
