Received: from eggs.gnu.org ([2001:4830:134:3::10]:43291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1frZcm-0003ck-LT
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1frZcj-0007lj-HR
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:08:56 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2281 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1frZcj-0007hz-34
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:08:53 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Mon, 20 Aug 2018 02:08:35 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302CDB549@dggemm509-mbx.china.huawei.com>
References: <20180816094356.16396-1-linzhecheng@huawei.com>
	<20180816104552.ul7sxdbon4xyi2bn@sirius.home.kraxel.org>
	<D9DE8DBB19F2A24080482022C1DE758302CCD9FB@DGGEMM529-MBX.china.huawei.com>
	<20180816130131.lvg3hnv3xum55nvw@sirius.home.kraxel.org>
	<73b38635.29ad9.165434fe949.Coremail.linzc@zju.edu.cn>
	<20180817060758.yish2qstu7hld7s6@sirius.home.kraxel.org>
In-Reply-To: <20180817060758.yish2qstu7hld7s6@sirius.home.kraxel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: gerd hoffmann <kraxel@redhat.com>, CheneyLin <linzc@zju.edu.cn>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> -----Original Message-----
> From: gerd hoffmann [mailto:kraxel@redhat.com]
> Sent: Friday, August 17, 2018 2:08 PM
> To: CheneyLin <linzc@zju.edu.cn>
> Cc: linzhecheng <linzhecheng@huawei.com>; wangxin (U)
> <wangxinxin.wang@huawei.com>; qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH] usb-host: insert usb device into hostde=
vs to
> be scaned
>=20
> > > Why live-migrate to localhost?  That is rather tricky due to both
> > > source and target qemu accessing host resources at the same time,
> > > and I guess this is the reason you are seeing the problems here.
> > Thanks for your reply, but I'm still confused about these issues:
> > 1. If local live migration is not supported for host-usb device, why
> > we have to detach it and rescan it in usb_host_post_load_bh? If a
> > device's property *needs_autoscan* is false, how can we scan it(because=
 we
> have detached it)?
>=20
> autoscan is for hotplug.  You can un-plug and re-plug a usb device on the
> physical host, and the guest will see these un-plugs and re-plugs.
>=20
> autoscan is turned off in case the usb device is specified using
> hostbus+hostaddr attributes, because hostaddr is a moving target.
> Each time the device is plugged in it gets a different address, for hotpl=
ug to
> work properly you must specify the device using attributes which don't ch=
ange.
> You can use hostport instead of hostaddr for example.
>=20
> > 2. Normal live migration between two remote hostes makes a vm access
> > differnt host usb devices, how can we copy states and data of them?
>=20
> We don't copy any state.  It is rather pointless, even for save/resume on=
 the
> same machine we don't know what state the usb device has and whenever it =
is
> still in the state the guest has left it.
I have tried stop/cont a vm with host-usb device during coping large files(=
makes usb device busy woking),=20
but usb device was not detached/attached and coping task was completed prop=
erly.
 It seems that we can restart it where we left it off.

>=20
> So instead we virtually un-plug and re-plug the device, to make the guest=
 driver
> re-initialize the device.
>=20
> HTH,
>   Gerd
