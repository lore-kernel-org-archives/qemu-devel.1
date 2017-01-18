Received: from eggs.gnu.org ([2001:4830:134:3::10]:43960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cTfcZ-0005jy-1w
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cTfcT-0004ug-Ur
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:05:06 -0500
Received: from [45.249.212.187] (port=2528 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cTfcN-0004aL-6x
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:05:01 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 18 Jan 2017 02:04:07 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA195C57@DGGEMA505-MBX.china.huawei.com>
References: <1484051484-86503-1-git-send-email-xin.zeng@intel.com>
	<82063967A54EF84C8AFCD6BD7F6AD93310C4C74E@SHSMSX103.ccr.corp.intel.com>
In-Reply-To: <82063967A54EF84C8AFCD6BD7F6AD93310C4C74E@SHSMSX103.ccr.corp.intel.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH v3 1/1] virtio crypto device
 specification: asymmetric crypto service
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zeng, Xin" <xin.zeng@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Keating, Brian A" <brian.a.keating@intel.com>, "Griffin, John" <john.griffin@intel.com>, "Ma, Liang J" <liang.j.ma@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

Hi Xin,

>
> Subject: RE: [RFC PATCH v3 1/1] virtio crypto device specification: asymm=
etric
> crypto service
>=20
> Ping...
> Any comments on this part of virtio crypto spec?
>=20
I update the virtio crypto spec to support non-session based crypto
Operations and your asym service also needs change struct virtio_crypto_op_=
data_req
which maybe cause the compatibility complaint with the pre-existing code.

So I strongly suggest you rebase my v16 (will be submitted today), and put
asym service to struct virtio_crypto_op_data_req_mixed.

struct virtio_crypto_op_data_req_mixed {
    struct virtio_crypto_op_header header;

    union {
        struct virtio_crypto_sym_data_req   sym_req;
        struct virtio_crypto_hash_data_req  hash_req;
        struct virtio_crypto_mac_data_req   mac_req;
        struct virtio_crypto_aead_data_req  aead_req;
        struct virtio_crypto_sym_data_req_non_sess   sym_non_sess_req;
        struct virtio_crypto_hash_data_req_non_sess  hash_non_sess_req;
        struct virtio_crypto_mac_data_req_non_sess   mac_non_sess_req;
        struct virtio_crypto_aead_data_req_non_sess  aead_non_sess_req;

		/* asymmetric crypto requests here */
		...
    } u;
};

> We also plan to add asymmetric crypto service part support in LKCF based =
virtio
> crypto frontend driver, and upstream DPDK vhost library based vhost user =
for
> cryptodev which also focuses on asymmetric crypto service , any comments?
>=20
Sounds great. It's very helpful to accelerate the progress of reviewing.
After all they are kinds of special knowledge.

Meanwhile, I can submit the cryptodev-vhost-user/cryptodev-vhost-kernel
backends in QEMU if needs.

Thanks,
-Gonglei
