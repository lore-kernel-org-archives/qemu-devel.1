Received: from eggs.gnu.org ([2001:4830:134:3::10]:45233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fqXvX-0000zb-Ol
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 02:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fqXvU-0006ut-IS
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 02:08:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39546 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fqXvU-0006uN-CK
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 02:08:00 -0400
Date: Fri, 17 Aug 2018 08:07:58 +0200
From: gerd hoffmann <kraxel@redhat.com>
Message-ID: <20180817060758.yish2qstu7hld7s6@sirius.home.kraxel.org>
References: <20180816094356.16396-1-linzhecheng@huawei.com>
	<20180816104552.ul7sxdbon4xyi2bn@sirius.home.kraxel.org>
	<D9DE8DBB19F2A24080482022C1DE758302CCD9FB@DGGEMM529-MBX.china.huawei.com>
	<20180816130131.lvg3hnv3xum55nvw@sirius.home.kraxel.org>
	<73b38635.29ad9.165434fe949.Coremail.linzc@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b38635.29ad9.165434fe949.Coremail.linzc@zju.edu.cn>
Subject: Re: [Qemu-devel] [PATCH] usb-host: insert usb device into hostdevs
 to be scaned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: CheneyLin <linzc@zju.edu.cn>
Cc: linzhecheng <linzhecheng@huawei.com>, "wangxin (u)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> > Why live-migrate to localhost?  That is rather tricky due to both source
> > and target qemu accessing host resources at the same time, and I guess
> > this is the reason you are seeing the problems here.
> Thanks for your reply, but I'm still confused about these issues:
> 1. If local live migration is not supported for host-usb device, why we have to detach it and
> rescan it in usb_host_post_load_bh? If a device's property *needs_autoscan* is false, how can we scan it(because
> we have detached it)? 

autoscan is for hotplug.  You can un-plug and re-plug a usb device on
the physical host, and the guest will see these un-plugs and re-plugs.

autoscan is turned off in case the usb device is specified using
hostbus+hostaddr attributes, because hostaddr is a moving target.
Each time the device is plugged in it gets a different address, for
hotplug to work properly you must specify the device using attributes
which don't change.  You can use hostport instead of hostaddr for
example.

> 2. Normal live migration between two remote hostes makes a vm access differnt host usb devices, how can
> we copy states and data of them? 

We don't copy any state.  It is rather pointless, even for save/resume
on the same machine we don't know what state the usb device has and
whenever it is still in the state the guest has left it.

So instead we virtually un-plug and re-plug the device, to make the
guest driver re-initialize the device.

HTH,
  Gerd
