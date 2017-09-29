Received: from eggs.gnu.org ([2001:4830:134:3::10]:49311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dxqu2-0003yc-7h
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dxqtz-0000Qt-5D
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dxqty-0000Qd-Vl
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:44:07 -0400
Date: Fri, 29 Sep 2017 10:43:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170929084359.GB3812@localhost.localdomain>
References: <9AA25E8890139848BAC96ED2495626F439A2FFAA@DGGEML501-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9AA25E8890139848BAC96ED2495626F439A2FFAA@DGGEML501-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] I have two issues about it to discuss with you RE:
 ping RE: question: I found a qemu crash about migration
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "wangjie (P)" <wangjie88@huawei.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "fuweiwei (C)" <fuweiwei2@huawei.com>, "eblake@redhat.com" <eblake@redhat.com>, "berrange@redhat.com kchamart@redhat.com" <kchamart@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "Wubin (H)" <wu.wubin@huawei.com>, "Fangyi (C)" <eric.fangyi@huawei.com>
List-ID: <qemu-devel.nongnu.org>

Am 29.09.2017 um 05:20 hat wangjie (P) geschrieben:
> Excuse me, I have two issues to discuss with you :>

Please don't break the email threading. Make sure that your replies
appear in the same thread as the message you're replying to.

> //Question 1:
> 
> Can we fix it by the demo patch as attachment? (the patch is base on
> qemu-2.8.1, just a demo for discuss)
> 
> Because I think we should not set  INACTIVE label for drive-mirror
> BlockDriverState, mirror IO will not affect the memory migration. So
> we can filter the drive-mirror bs in bdrv_inactivate_all, and I
> tested, my demo patch can fix it.

No, this is wrong.

Images must be inactivated before the destination can continue, so just
not inactivating them at all is not the solution. Your patch probably
breaks migration with shared storage.

It is also wrong from a design perspective because you're fixing a
special case of a special case of the bug by introducing a layering
violation. So even if not inactivating the images were right, this patch
would still be bad.

> //Question 2:
> 
> I used git-bisect and found the qemu-2.6.0 is OK,  because I cann't
> trigger the bug on qemu-2.6.0 even though I tried many times.     But
> I can trigger the bug and reproduce it very easy  since
> qemu-2.7.0-rc0.   so I git-biset it go on, and found the bug begin to
> occur since the patchs committed as following:
> 
> commit cbd614870fce00f46088be7054a7bf5eadcc77ac
> Merge: 500acc9 0bc7a6f
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Thu Jun 2 13:42:52 2016 +0100
> 
>     Merge remote-tracking branch 'remotes/famz/tags/pull-docker-20160601' into staging

This looks rather unlikely to be the real culprit, especially because
it's only a merge commit.

Kevin
