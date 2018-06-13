Received: from eggs.gnu.org ([2001:4830:134:3::10]:55368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fT7HE-0002AY-Bl
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fT7H3-0006nH-Li
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:01:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fT7H3-0006k0-DD
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:01:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5DExEsq020051
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 11:01:23 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jk353qtrx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 11:01:20 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 13 Jun 2018 11:01:08 -0400
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
	<20180613093700.GG27901@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 13 Jun 2018 11:01:05 -0400
MIME-Version: 1.0
In-Reply-To: <20180613093700.GG27901@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <7b51465a-b7c1-58ec-1ef6-9fe791e96bbf@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, frankja@linux.ibm.com, mst@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, mjrosato@linux.vnet.ibm.com

Hi Daniel

On 06/13/2018 05:37 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jun 12, 2018 at 03:48:34PM -0400, Farhan Ali wrote:
>> The virtio-crypto driver currently propagates to the guest
>> all the cipher algorithms that the backend cryptodev can
>> support. But in certain cases where the guest has more
>> performant mechanism to handle some algorithms, it would be
>> useful to propagate only a subset of the algorithms.
>=20
> I'm not really convinced by this.
>=20
> The performance of crypto algorithms has many influencing
> factors, making it pretty hard to decide which is best
> without actively testing specific impls and comparing
> them in a manner which matches the application usage
> pattern. eg in theory the kernel crypto impl of an alg
> is faster than a userspace impl, if the kernel uses
> hardware accel and userspace does not. This, however,
> ignores the overhead of the kernel/userspace switch.
> The real world performance winner, thus depends on the
> amount of data being processed in each operation. Some
> times userspace can win & sometimes kernel space can
> win. This is even more relevant to virtio-crypto as
> it has more expensive context switches.

True. But what if the guest can perform some crypto algorithms without a=20
incurring a VM exit? For example in s390 we have the cpacf instructions=20
to perform crypto and this instruction is implemented for us by our=20
hardware virtualization technology. In such a case it would be better=20
not to use virtio-crypto's implementation of such a crypto algorithm.

At the same time we would like to take advantage of virtio-crypto's=20
acceleration capabilities for certain crypto algorithms for which there=20
is no hardware assistance.


>=20
> IOW, when we expose a virtio-crypto dev to a guest,
> it is never reasonable for the guest to blindly assume
> that anything it does is faster than a pure software
> impl running in the guest. It will depend on the usage
> pattern. This is no different to bare metal where you
> should not assume kernel crypto is faster.
>=20
> IMHO this is not a compelling reason to be able to turn
> off algorithms in virtio-crypto, as any decision will
> always be at best incomplete & inaccurate.

But shouldn't the user have the option to try and test by turning off=20
certain algorithms? You are right the performance will depend on usage=20
patterns, but I believe at least the user should have the option to test=20
and see what works and does not work. It would be far easier to do so=20
with the virtio-crypto dev than changing code in the kernel or userspace=20
IMHO.


>=20
>> @@ -853,6 +863,34 @@ static const VMStateDescription vmstate_virtio_cr=
ypto =3D {
>>   static Property virtio_crypto_properties[] =3D {
>>       DEFINE_PROP_LINK("cryptodev", VirtIOCrypto, conf.cryptodev,
>>                        TYPE_CRYPTODEV_BACKEND, CryptoDevBackend *),
>> +    DEFINE_PROP_BIT("no-cipher", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_ARC4, false),
>> +    DEFINE_PROP_BIT("cipher-arc4", VirtIOCrypto, user_cipher_algo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_ARC4, false),
>> +    DEFINE_PROP_BIT("cipher-aes-ecb", VirtIOCrypto, user_cipher_algo_=
l,
>> +                    VIRTIO_CRYPTO_CIPHER_AES_ECB, false),
>> +    DEFINE_PROP_BIT("cipher-aes-cbc", VirtIOCrypto, user_cipher_algo_=
l,
>> +                    VIRTIO_CRYPTO_CIPHER_AES_CBC, false),
>> +    DEFINE_PROP_BIT("cipher-aes-ctr", VirtIOCrypto, user_cipher_algo_=
l,
>> +                    VIRTIO_CRYPTO_CIPHER_AES_CTR, false),
>> +    DEFINE_PROP_BIT("cipher-des-ecb", VirtIOCrypto, user_cipher_algo_=
l,
>> +                    VIRTIO_CRYPTO_CIPHER_DES_ECB, false),
>> +    DEFINE_PROP_BIT("cipher-3des-ecb", VirtIOCrypto, user_cipher_algo=
_l,
>> +                    VIRTIO_CRYPTO_CIPHER_3DES_ECB, false),
>> +    DEFINE_PROP_BIT("cipher-3des-cbc", VirtIOCrypto, user_cipher_algo=
_l,
>> +                    VIRTIO_CRYPTO_CIPHER_3DES_CBC, false),
>> +    DEFINE_PROP_BIT("cipher-3des-ctr", VirtIOCrypto, user_cipher_algo=
_l,
>> +                    VIRTIO_CRYPTO_CIPHER_3DES_CTR, false),
>> +    DEFINE_PROP_BIT("cipher-kasumi-f8", VirtIOCrypto, user_cipher_alg=
o_l,
>> +                    VIRTIO_CRYPTO_CIPHER_KASUMI_F8, false),
>> +    DEFINE_PROP_BIT("cipher-snow3g-uea2", VirtIOCrypto, user_cipher_a=
lgo_l,
>> +                    VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2, false),
>> +    DEFINE_PROP_BIT("cipher-aes-f8", VirtIOCrypto, user_cipher_algo_l=
,
>> +                    VIRTIO_CRYPTO_CIPHER_AES_F8, false),
>> +    DEFINE_PROP_BIT("cipher-aes-xts", VirtIOCrypto, user_cipher_algo_=
l,
>> +                    VIRTIO_CRYPTO_CIPHER_AES_XTS, false),
>> +    DEFINE_PROP_BIT("cipher-zuc-eea3", VirtIOCrypto, user_cipher_algo=
_l,
>> +                    VIRTIO_CRYPTO_CIPHER_ZUC_EEA3, false),
>=20
> This does not scale as an approach IMHO which just reinforces to me
> that we shouldn't do this.

I am open suggestions on better implementation. I thought defining a=20
property bit for the virtio-crypto dev would work, similar to cpu model=20
approach.

Thanks for taking a look at the patch :)

Thanks
Farhan

>=20
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>  =20
>> @@ -974,6 +1012,8 @@ static void virtio_crypto_instance_init(Object *o=
bj)
>>        * Can be overriden with virtio_crypto_set_config_size.
>>        */
>>       vcrypto->config_size =3D sizeof(struct virtio_crypto_config);
>> +    vcrypto->user_cipher_algo_l =3D ~VIRTIO_CRYPTO_NO_CIPHER - 1;
>> +    vcrypto->user_cipher_algo_h =3D ~VIRTIO_CRYPTO_NO_CIPHER;
>>   }
>>  =20
>>   static const TypeInfo virtio_crypto_info =3D {
>> diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/vir=
tio-crypto.h
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
>>  =20
>>   #endif /* _QEMU_VIRTIO_CRYPTO_H */
>> --=20
>> 2.7.4
>>
>>
>=20
> Regards,
> Daniel
>=20
