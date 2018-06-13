Received: from eggs.gnu.org ([2001:4830:134:3::10]:52721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fTCAH-0005fL-Hm
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fTCAC-0005kT-IM
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:14:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fTCAC-0005gQ-8y
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:14:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5DK8flY028208
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 16:14:37 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jk6kd1bgp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 16:14:37 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 13 Jun 2018 16:14:36 -0400
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
	<33183CC9F5247A488A2544077AF19020DB0185BF@dggeml511-mbx.china.huawei.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 13 Jun 2018 16:14:31 -0400
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB0185BF@dggeml511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5cddcf18-b38d-f720-232b-401cf5f6562a@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC v1 1/1] virtio-crypto: Allow disabling of
 cipher algorithms for virtio-crypto device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, longpeng <longpeng2@huawei.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>

Hi Arei

On 06/12/2018 08:57 PM, Gonglei (Arei) wrote:
> 
>> -----Original Message-----
>> From: Farhan Ali [mailto:alifm@linux.ibm.com]
>> Sent: Wednesday, June 13, 2018 3:49 AM
>> To: qemu-devel@nongnu.org
>> Cc: mst@redhat.com; Gonglei (Arei) <arei.gonglei@huawei.com>; longpeng
>> <longpeng2@huawei.com>; pasic@linux.ibm.com; borntraeger@de.ibm.com;
>> frankja@linux.ibm.com; alifm@linux.ibm.com
>> Subject: [RFC v1 1/1] virtio-crypto: Allow disabling of cipher algorithms for
>> virtio-crypto device
>>
>> The virtio-crypto driver currently propagates to the guest
>> all the cipher algorithms that the backend cryptodev can
>> support. But in certain cases where the guest has more
>> performant mechanism to handle some algorithms, it would be
>> useful to propagate only a subset of the algorithms.
>>
> 
> It makes sense to me. E.g. current Intel CPU has the AES-NI instruction for accelerating
> AES algo. We don't need to propagate AES algos.
> 
>> This patch adds support for disabling the cipher
>> algorithms of the backend cryptodev.
>>
>> eg:
>>   -object cryptodev-backend-builtin,id=cryptodev0
>>   -device virtio-crypto-ccw,id=crypto0,cryptodev=cryptodev0,cipher-aes-cbc=off
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>
>> Please note this patch is not complete, and there are TODOs to handle
>> for other types of algorithms such Hash, AEAD and MAC algorithms.
>>
>> This is mainly intended to get some feedback on the design approach
>> from the community.
>>
>>
>>   hw/virtio/virtio-crypto.c         | 46
>> ++++++++++++++++++++++++++++++++++++---
>>   include/hw/virtio/virtio-crypto.h |  3 +++
>>   2 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
>> index 9a9fa49..4aed9ca 100644
>> --- a/hw/virtio/virtio-crypto.c
>> +++ b/hw/virtio/virtio-crypto.c
>> @@ -754,12 +754,22 @@ static void virtio_crypto_reset(VirtIODevice *vdev)
>>   static void virtio_crypto_init_config(VirtIODevice *vdev)
>>   {
>>       VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
>> +    uint32_t user_crypto_services = (1u <<
>> VIRTIO_CRYPTO_SERVICE_CIPHER) |
>> +                                    (1u <<
>> VIRTIO_CRYPTO_SERVICE_HASH) |
>> +                                    (1u <<
>> VIRTIO_CRYPTO_SERVICE_AEAD) |
>> +                                    (1u <<
>> VIRTIO_CRYPTO_SERVICE_MAC);
>> +
>> +    if (vcrypto->user_cipher_algo_l & (1u << VIRTIO_CRYPTO_NO_CIPHER)) {
>> +        vcrypto->user_cipher_algo_l = 1u << VIRTIO_CRYPTO_NO_CIPHER;
>> +        vcrypto->user_cipher_algo_h = 0;
>> +        user_crypto_services &= ~(1u <<
>> VIRTIO_CRYPTO_SERVICE_CIPHER);
>> +    }
>>
>> -    vcrypto->conf.crypto_services =
>> +    vcrypto->conf.crypto_services = user_crypto_services &
>>                        vcrypto->conf.cryptodev->conf.crypto_services;
>> -    vcrypto->conf.cipher_algo_l =
>> +    vcrypto->conf.cipher_algo_l = vcrypto->user_cipher_algo_l &
>>                        vcrypto->conf.cryptodev->conf.cipher_algo_l;
>> -    vcrypto->conf.cipher_algo_h =
>> +    vcrypto->conf.cipher_algo_h = vcrypto->user_cipher_algo_h &
>>                        vcrypto->conf.cryptodev->conf.cipher_algo_h;
>>       vcrypto->conf.hash_algo = vcrypto->conf.cryptodev->conf.hash_algo;
>>       vcrypto->conf.mac_algo_l = vcrypto->conf.cryptodev->conf.mac_algo_l;
>> @@ -853,6 +863,34 @@ static const VMStateDescription
>> vmstate_virtio_crypto = {
>>   static Property virtio_crypto_properties[] = {
>>       DEFINE_PROP_LINK("cryptodev", VirtIOCrypto, conf.cryptodev,
>>                        TYPE_CRYPTODEV_BACKEND, CryptoDevBackend
>> *),
>> +    DEFINE_PROP_BIT("no-cipher", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_ARC4, false),
> 
> s/ VIRTIO_CRYPTO_CIPHER_ARC4/VIRTIO_CRYPTO_NO_CIPHER/

Thanks for catching that. I will change.

> 
>> +    DEFINE_PROP_BIT("cipher-arc4", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_ARC4, false),
>> +    DEFINE_PROP_BIT("cipher-aes-ecb", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_AES_ECB, false),
>> +    DEFINE_PROP_BIT("cipher-aes-cbc", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_AES_CBC, false),
>> +    DEFINE_PROP_BIT("cipher-aes-ctr", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_AES_CTR, false),
>> +    DEFINE_PROP_BIT("cipher-des-ecb", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_DES_ECB, false),
>> +    DEFINE_PROP_BIT("cipher-3des-ecb", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_3DES_ECB, false),
>> +    DEFINE_PROP_BIT("cipher-3des-cbc", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_3DES_CBC, false),
>> +    DEFINE_PROP_BIT("cipher-3des-ctr", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_3DES_CTR, false),
>> +    DEFINE_PROP_BIT("cipher-kasumi-f8", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_KASUMI_F8, false),
>> +    DEFINE_PROP_BIT("cipher-snow3g-uea2", VirtIOCrypto,
>> user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2, false),
>> +    DEFINE_PROP_BIT("cipher-aes-f8", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_AES_F8, false),
>> +    DEFINE_PROP_BIT("cipher-aes-xts", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_AES_XTS, false),
>> +    DEFINE_PROP_BIT("cipher-zuc-eea3", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_ZUC_EEA3, false),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>
> We'd better keep all algorithms enabled by default. So pls s/false/true/g.
> 

You are right. I will change it.

> Thanks,
> -Gonglei
> 

Thanks for taking a look.

Thanks
Farhan

>> @@ -974,6 +1012,8 @@ static void virtio_crypto_instance_init(Object *obj)
>>        * Can be overriden with virtio_crypto_set_config_size.
>>        */
>>       vcrypto->config_size = sizeof(struct virtio_crypto_config);
>> +    vcrypto->user_cipher_algo_l = ~VIRTIO_CRYPTO_NO_CIPHER - 1;
>> +    vcrypto->user_cipher_algo_h = ~VIRTIO_CRYPTO_NO_CIPHER;
>>   }
>>
>>   static const TypeInfo virtio_crypto_info = {
>> diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
>> index ca3a049..c5bb684 100644
>> --- a/include/hw/virtio/virtio-crypto.h
>> +++ b/include/hw/virtio/virtio-crypto.h
>> @@ -97,6 +97,9 @@ typedef struct VirtIOCrypto {
>>       uint32_t curr_queues;
>>       size_t config_size;
>>       uint8_t vhost_started;
>> +
>> +    uint32_t user_cipher_algo_l;
>> +    uint32_t user_cipher_algo_h;
>>   } VirtIOCrypto;
>>
>>   #endif /* _QEMU_VIRTIO_CRYPTO_H */
>> --
>> 2.7.4
> 
> 
