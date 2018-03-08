Received: from eggs.gnu.org ([2001:4830:134:3::10]:44006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1etrRj-0006Kb-6x
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1etrRe-0003op-E3
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:02:43 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1etrRe-0003n3-22
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:02:38 -0500
Received: by mail-vk0-f66.google.com with SMTP id p189so3154435vkd.10
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 01:02:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0EDE7998-76A9-41F5-AE83-89BA0E9C3A6E@kamp.de>
References: <c0d7b993-b3b8-a753-21f5-e2257de27caf@kamp.de>
	<20180305114533.GI7910@stefanha-x1.localdomain>
	<0f1ec3c7-1157-e618-62f8-ffd5e08eb342@kamp.de>
	<20180305145215.GM3131@work-vm>
	<20180306160739.GN31045@stefanha-x1.localdomain>
	<824907bb-3a37-27bd-76db-be17d05bdac0@kamp.de>
	<231fe0ce-3df4-a175-2fba-403023cc65e1@kamp.de>
	<99df10d6-6514-56ee-16ce-8b7d1823cc08@kamp.de>
	<20180308012842.GJ13844@lemon.usersys.redhat.com>
	<0EDE7998-76A9-41F5-AE83-89BA0E9C3A6E@kamp.de>
From: Fam Zheng <famz@redhat.com>
Date: Thu, 8 Mar 2018 17:01:56 +0800
Message-ID: <CAK1Eb9=cZVH6v4hmLmTrTLH81DL-nP1Z-v+7EswQHd4fqaYBvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] block migration and dirty bitmap reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, wency@cn.fujitsu.com, qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Mar 8, 2018 at 4:57 PM, Peter Lieven <pl@kamp.de> wrote:
>
>
>> Am 08.03.2018 um 02:28 schrieb Fam Zheng <famz@redhat.com>:
>>
>>> On Wed, 03/07 09:06, Peter Lieven wrote:
>>> Hi,
>>>
>>> while looking at the code I wonder if the blk_aio_preadv and the bdrv_reset_dirty_bitmap order must
>>> be swapped in mig_save_device_bulk:
>>>
>>>    qemu_mutex_lock_iothread();
>>>    aio_context_acquire(blk_get_aio_context(bmds->blk));
>>>    blk->aiocb = blk_aio_preadv(bb, cur_sector * BDRV_SECTOR_SIZE, &blk->qiov,
>>>                                0, blk_mig_read_cb, blk);
>>>
>>>    bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector * BDRV_SECTOR_SIZE,
>>>                            nr_sectors * BDRV_SECTOR_SIZE);
>>>    aio_context_release(blk_get_aio_context(bmds->blk));
>>>    qemu_mutex_unlock_iothread();
>>>
>>> In mig_save_device_dirty we first reset the dirty bitmap and read then which shoulds like
>>> a better idea.
>>
>> Yes, that sounds right to me.
>>
>> Fam
>
> You mean the order should be swapped in mig_save_device_bulk as well?

Yeah, resetting the dirty bitmap before reading makes sure we don't
miss any new data.

Fam

>
> Peter
>
