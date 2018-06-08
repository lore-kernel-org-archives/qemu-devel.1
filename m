Received: from eggs.gnu.org ([2001:4830:134:3::10]:36956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fRMks-0003Ah-Pc
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fRMkp-0000lp-JG
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:08:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fRMkp-0000lY-9z
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:08:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w58J4wwC037906
	for <qemu-devel@nongnu.org>; Fri, 8 Jun 2018 15:08:54 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jfuf936yh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 15:08:53 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Fri, 8 Jun 2018 15:08:52 -0400
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri,  8 Jun 2018 15:08:46 -0400
In-Reply-To: <cover.1528462918.git.alifm@linux.ibm.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1528462918.git.alifm@linux.ibm.com>
References: <cover.1528462918.git.alifm@linux.ibm.com>
Message-Id: <e0fe84d1df4e0c2c88d7d29f94d621c988c22194.1528462918.git.alifm@linux.ibm.com>
Subject: [Qemu-devel] [RFC v1 1/2] crypto/virtio-crypto: Read crypto
 services and algorithm masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: mst@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com, longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com, borntraeger@de.ibm.com, alifm@linux.ibm.com

Read the crypto services and algorithm masks which provides
information about the services and algorithms supported by
virtio-crypto backend.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/crypto/virtio/virtio_crypto_common.h | 14 ++++++++++++++
 drivers/crypto/virtio/virtio_crypto_core.c   | 29 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 66501a5..05eca12e 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -55,6 +55,20 @@ struct virtio_crypto {
 	/* Number of queue currently used by the driver */
 	u32 curr_queue;
 
+	/*
+	 * Specifies the services mask which the device support,
+	 * see VIRTIO_CRYPTO_SERVICE_* above
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
