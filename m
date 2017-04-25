Received: from eggs.gnu.org ([2001:4830:134:3::10]:35859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2vNt-0004Vi-5l
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2vNs-0002e5-4O
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:59:41 -0400
References: <20170421204123.bdftoeuko6lwox3x@eukaryote>
	<58FB2125.7020603@huawei.com>
	<20170424075955.5s72guumt35dhmlb@eukaryote>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58FF019B.4040505@huawei.com>
Date: Tue, 25 Apr 2017 15:58:19 +0800
MIME-Version: 1.0
In-Reply-To: <20170424075955.5s72guumt35dhmlb@eukaryote>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU-2.8] Source QEMU crashes with:
 "bdrv_co_pwritev: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com

On 2017/4/24 15:59, Kashyap Chamarthy wrote:
> On Sat, Apr 22, 2017 at 05:23:49PM +0800, Hailiang Zhang wrote:
>> Hi,
> Hi Hailiang,
>
>> I think the bellow patch can fix your problme.
>> [PATCH 2/4] qmp-cont: invalidate on RUN_STATE_PRELAUNCH
>> https://patchwork.kernel.org/patch/9591885/
> Hmm, the above patch ("qmp-cont: invalidate on RUN_STATE_PRELAUNCH") is
> not merged in Git, as it's stalled on design discussion between Kevin
> Wolf and Vladimir.
>
> And the below patch, from you, seems to be not submitted upstream (2.8
> stable tree, perhaps).  Do you intend to do so?

Er, since this patch does the same thing with the above patch, I'm not sure if i should
send this patch ...

>> Actually, we encounter the same problem in our test, we fix it with the follow patch:
>>
>>       From 0e4d6d706afd9909b5fd71536b45c58af60892f8 Mon Sep 17 00:00:00 2001
>>       From: zhanghailiang<zhang.zhanghailiang@huawei.com>
>>       Date: Tue, 21 Mar 2017 09:44:36 +0800
>>       Subject: [PATCH] migration: Re-activate blocks whenever migration been
>>        cancelled
>>
>>       In commit 1d2acc3162d9c7772510c973f446353fbdd1f9a8, we try to fix the bug
>>       'bdrv_co_do_pwritev: Assertion `!(bs->open_flags & 0x0800)' failed'
>>       which occured in migration cancelling process.
>>
>>       But it seems that we didn't cover all the cases, we caught such a case which
>>       slipped from the old fixup in our test: if libvirtd cancelled the migration
>>       process for a shutting down VM, it will send 'system_reset' command first,
>>       and then 'cont' command behind, after VM resumes to run, it will trigger the above
>>       error reports, because we didn't regain the control of blocks for VM.
>>
>>       Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>
>>       Signed-off-by: Hongyang Yang<yanghongyang@huawei.com>
>>       ---
>>        block.c                       | 12 +++++++++++-
>>        include/block/block.h         |  1 +
>>        include/migration/migration.h |  3 ---
>>        migration/migration.c         |  7 +------
>>        qmp.c                         |  4 +---
>>        5 files changed, 14 insertions(+), 13 deletions(-)
> [...]
>
