Received: from eggs.gnu.org ([2001:4830:134:3::10]:50291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cU7aN-0008Mz-9w
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 02:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cU7aJ-0002UT-Eg
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 02:56:43 -0500
Received: from [45.249.212.187] (port=2529 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cU7aH-0002IA-BQ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 02:56:39 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 19 Jan 2017 07:55:56 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA19ABB7@DGGEMA505-MBX.china.huawei.com>
References: <1484051484-86503-1-git-send-email-xin.zeng@intel.com>
	<82063967A54EF84C8AFCD6BD7F6AD93310C4C74E@SHSMSX103.ccr.corp.intel.com>
	<33183CC9F5247A488A2544077AF19020DA195C57@DGGEMA505-MBX.china.huawei.com>
	<82063967A54EF84C8AFCD6BD7F6AD93310C4FD2F@SHSMSX103.ccr.corp.intel.com>
In-Reply-To: <82063967A54EF84C8AFCD6BD7F6AD93310C4FD2F@SHSMSX103.ccr.corp.intel.com>
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
Cc: "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Keating, Brian A" <brian.a.keating@intel.com>, "Griffin, John" <john.griffin@intel.com>, "Ma, Liang J" <liang.j.ma@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wubin (H)" <wu.wubin@huawei.com>

Hi,

>=20
> On Wednesday, January 18, 2017 10:04 AM, Gonglei (Arei) wrote:
> > I update the virtio crypto spec to support non-session based crypto
> > Operations and your asym service also needs change struct
> > virtio_crypto_op_data_req which maybe cause the compatibility complaint
> > with the pre-existing code.
> >
> > So I strongly suggest you rebase my v16 (will be submitted today), and =
put
> > asym service to struct virtio_crypto_op_data_req_mixed.
> >
>=20
> Yes, sure.
>=20

Besides that, you also need to use new feature bits to control=20
changes of struct virtio_crypto_config since I noticed you introduced
some new properties in struct virtio_crypto_config :

\subsection{Device ID}\label{sec:Device Types / Crypto Device / Device ID}
@@ -47,6 +47,9 @@ struct virtio_crypto_config {
     le32 mac_algo_l;
     le32 mac_algo_h;
     le32 aead_algo;
+    le32 asym_algo;
+    /*Rsa padding capabilities*/
+    le32 rsa_padding;
     /* Maximum length of cipher key */
     le32 max_cipher_key_len;
     /* Maximum length of authenticated key */

Those changes will break the pre-existing code as well.

Thanks,
-Gonglei

> > struct virtio_crypto_op_data_req_mixed {
> >     struct virtio_crypto_op_header header;
> >
> >     union {
> >         struct virtio_crypto_sym_data_req   sym_req;
> >         struct virtio_crypto_hash_data_req  hash_req;
> >         struct virtio_crypto_mac_data_req   mac_req;
> >         struct virtio_crypto_aead_data_req  aead_req;
> >         struct virtio_crypto_sym_data_req_non_sess
> sym_non_sess_req;
> >         struct virtio_crypto_hash_data_req_non_sess
> hash_non_sess_req;
> >         struct virtio_crypto_mac_data_req_non_sess
> mac_non_sess_req;
> >         struct virtio_crypto_aead_data_req_non_sess
> aead_non_sess_req;
> >
> > 		/* asymmetric crypto requests here */
> > 		...
> >     } u;
> > };
> >
> > > We also plan to add asymmetric crypto service part support in LKCF
> > > based virtio crypto frontend driver, and upstream DPDK vhost library
> > > based vhost user for cryptodev which also focuses on asymmetric crypt=
o
> > service , any comments?
> > >
> > Sounds great. It's very helpful to accelerate the progress of reviewing=
.
> > After all they are kinds of special knowledge.
> >
> > Meanwhile, I can submit the cryptodev-vhost-user/cryptodev-vhost-kernel
> > backends in QEMU if needs.
> >
>=20
> That's great. We planned to upstream vhost-user for cryptodev to DPDK in =
Q3
> this year.
> Let's have another collaboration.
>=20
> > Thanks,
> > -Gonglei
> >
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
