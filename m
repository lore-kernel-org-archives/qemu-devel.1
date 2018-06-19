Received: from eggs.gnu.org ([2001:4830:134:3::10]:34217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fVIlP-0004HC-0Z
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fVIlL-0005Bx-SR
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:41:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fVIlL-0005BN-JC
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:41:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5JFeuJw124844
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 11:41:42 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jq2xbwq11-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 11:41:41 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 19 Jun 2018 11:41:40 -0400
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 19 Jun 2018 11:41:33 -0400
In-Reply-To: <cover.1529422492.git.alifm@linux.ibm.com>
References: <cover.1529422492.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1529422492.git.alifm@linux.ibm.com>
References: <cover.1529422492.git.alifm@linux.ibm.com>
Message-Id: <7f5841568b1fabb60d9c11a8bbbc041d34c1c86f.1529422492.git.alifm@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/2] crypto/virtio-crypto: Read crypto
 services and algorithm masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, herbert@gondor.apana.org.au, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com, mst@redhat.com

Read the crypto services and algorithm masks which provides
information about the services and algorithms supported by
virtio-crypto backend.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Acked-by: Gonglei <arei.gonglei@huawei.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/crypto/virtio/virtio_crypto_common.h | 14 ++++++++++++++
 drivers/crypto/virtio/virtio_crypto_core.c   | 29 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 66501a5..931a3bd 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -55,6 +55,20 @@ struct virtio_crypto {
 	/* Number of queue currently used by the driver */
 	u32 curr_queue;
 
+	/*
+	 * Specifies the services mask which the device support,
+	 * see VIRTIO_CRYPTO_SERVICE_*
+	 */
+	u32 crypto_services;
+
+	/* Detailed algorithms mask */
+	u32 cipher_algo_l;
+	u32 cipher_algo_h;
+	u32 hash_algo;
+	u32 mac_algo_l;
+	u32 mac_algo_h;
+	u32 aead_algo;
+
 	/* Maximum length of cipher key */
 	u32 max_cipher_key_len;
 	/* Maximum length of authenticated key */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 8332698..8f745f2 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -303,6 +303,13 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	u32 max_data_queues = 0, max_cipher_key_len = 0;
 	u32 max_auth_key_len = 0;
 	u64 max_size = 0;
+	u32 cipher_algo_l = 0;
+	u32 cipher_algo_h = 0;
+	u32 hash_algo = 0;
+	u32 mac_algo_l = 0;
+	u32 mac_algo_h = 0;
+	u32 aead_algo = 0;
+	u32 crypto_services = 0;
 
 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		return -ENODEV;
@@ -339,6 +346,20 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 		max_auth_key_len, &max_auth_key_len);
 	virtio_cread(vdev, struct virtio_crypto_config,
 		max_size, &max_size);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		crypto_services, &crypto_services);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		cipher_algo_l, &cipher_algo_l);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		cipher_algo_h, &cipher_algo_h);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		hash_algo, &hash_algo);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		mac_algo_l, &mac_algo_l);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		mac_algo_h, &mac_algo_h);
+	virtio_cread(vdev, struct virtio_crypto_config,
+		aead_algo, &aead_algo);
 
 	/* Add virtio crypto device to global table */
 	err = virtcrypto_devmgr_add_dev(vcrypto);
@@ -358,6 +379,14 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	vcrypto->max_cipher_key_len = max_cipher_key_len;
 	vcrypto->max_auth_key_len = max_auth_key_len;
 	vcrypto->max_size = max_size;
+	vcrypto->crypto_services = crypto_services;
+	vcrypto->cipher_algo_l = cipher_algo_l;
+	vcrypto->cipher_algo_h = cipher_algo_h;
+	vcrypto->mac_algo_l = mac_algo_l;
+	vcrypto->mac_algo_h = mac_algo_h;
+	vcrypto->hash_algo = hash_algo;
+	vcrypto->aead_algo = aead_algo;
+
 
 	dev_info(&vdev->dev,
 		"max_queues: %u, max_cipher_key_len: %u, max_auth_key_len: %u, max_size 0x%llx\n",
-- 
2.7.4
