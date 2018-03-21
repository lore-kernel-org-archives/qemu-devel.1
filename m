Received: from eggs.gnu.org ([2001:4830:134:3::10]:45132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roy.fan.zhang@intel.com>) id 1eyUc1-0003nN-S8
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roy.fan.zhang@intel.com>) id 1eyUbw-0000CH-Qk
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:40:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:26321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <roy.fan.zhang@intel.com>)
	id 1eyUbw-0000Au-II
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:40:24 -0400
From: "Zhang, Roy Fan" <roy.fan.zhang@intel.com>
Date: Wed, 21 Mar 2018 03:40:15 +0000
Message-ID: <9F7182E3F746AB4EA17801C148F3C60433102472@IRSMSX101.ger.corp.intel.com>
References: <1516111613-18988-1-git-send-email-jianjay.zhou@huawei.com>
	<1516111613-18988-4-git-send-email-jianjay.zhou@huawei.com>
In-Reply-To: <1516111613-18988-4-git-send-email-jianjay.zhou@huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 3/4] cryptodev-vhost-user: add crypto
 session handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "weidong.huang@huawei.com" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "longpeng2@huawei.com" <longpeng2@huawei.com>, "Zeng, Xin" <xin.zeng@intel.com>, "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>

Hi Jay,

Excellent work! The patch, although need some minor rework, has improved th=
e performance.
Some comments:

1. you need to set up capabilities for virtio_crypto PMD. As in Qemu vhost =
crypto proxy backend only AESCBC and SHA1 are supported (in cryptodev_vhost=
_user_init() definition), I believe in this version these two algorithms sh=
all be enough.  Actually for the same reason I suggest you to remove all AE=
S_CTR test cases in the virtio_crypto PMD functional test, as they will fai=
l when vhost_user crypto backend is used.

You may use driver/crypto/qat/qat_crypto_capabilities.h as example. The con=
st capabilities array shall be returned to the application when virtio_cryp=
to_dev_info_get() is called.
2. there is a bug in virtio_crypto_queue_setup(), you declared " uint32_t i=
, j;" while i may be used uninitialized later.

Regards,
Fan


> -----Original Message-----
> From: Jay Zhou [mailto:jianjay.zhou@huawei.com]
> Sent: Tuesday, January 16, 2018 2:07 PM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; pbonzini@redhat.com; weidong.huang@huawei.com;
> stefanha@redhat.com; jianjay.zhou@huawei.com;
> pasic@linux.vnet.ibm.com; longpeng2@huawei.com; Zeng, Xin
> <xin.zeng@intel.com>; Zhang, Roy Fan <roy.fan.zhang@intel.com>;
> arei.gonglei@huawei.com
> Subject: [PATCH v3 3/4] cryptodev-vhost-user: add crypto session handler
>=20
