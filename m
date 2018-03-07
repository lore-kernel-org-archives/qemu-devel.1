Received: from eggs.gnu.org ([2001:4830:134:3::10]:43706)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1etU68-0006ag-6B
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 03:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1etU63-0007ff-7f
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 03:06:52 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:47138 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1etU62-0007ez-Un
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 03:06:47 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Wed, 7 Mar 2018 09:06:41 +0100
From: Peter Lieven <pl@kamp.de>
References: <c0d7b993-b3b8-a753-21f5-e2257de27caf@kamp.de>
	<20180305114533.GI7910@stefanha-x1.localdomain>
	<0f1ec3c7-1157-e618-62f8-ffd5e08eb342@kamp.de>
	<20180305145215.GM3131@work-vm>
	<20180306160739.GN31045@stefanha-x1.localdomain>
	<824907bb-3a37-27bd-76db-be17d05bdac0@kamp.de>
	<231fe0ce-3df4-a175-2fba-403023cc65e1@kamp.de>
Message-ID: <99df10d6-6514-56ee-16ce-8b7d1823cc08@kamp.de>
Date: Wed, 7 Mar 2018 09:06:41 +0100
MIME-Version: 1.0
In-Reply-To: <231fe0ce-3df4-a175-2fba-403023cc65e1@kamp.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] block migration and dirty bitmap reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, wency@cn.fujitsu.com, qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Hi,

while looking at the code I wonder if the blk_aio_preadv and the bdrv_reset_dirty_bitmap order must
be swapped in mig_save_device_bulk:

    qemu_mutex_lock_iothread();
    aio_context_acquire(blk_get_aio_context(bmds->blk));
    blk->aiocb = blk_aio_preadv(bb, cur_sector * BDRV_SECTOR_SIZE, &blk->qiov,
                                0, blk_mig_read_cb, blk);

    bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector * BDRV_SECTOR_SIZE,
                            nr_sectors * BDRV_SECTOR_SIZE);
    aio_context_release(blk_get_aio_context(bmds->blk));
    qemu_mutex_unlock_iothread();

In mig_save_device_dirty we first reset the dirty bitmap and read then which shoulds like
a better idea. Maybe it doesn't matter while we acquire the aioctx and the iothread lock...

Peter
