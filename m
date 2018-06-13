Received: from eggs.gnu.org ([2001:4830:134:3::10]:37897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT2DH-0001kV-7U
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT2DD-0002rW-8H
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:37:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fT2DD-0002qu-1D
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:37:07 -0400
Date: Wed, 13 Jun 2018 10:37:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180613093700.GG27901@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
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
To: Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, frankja@linux.ibm.com, mst@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com

On Tue, Jun 12, 2018 at 03:48:34PM -0400, Farhan Ali wrote:
> The virtio-crypto driver currently propagates to the guest
> all the cipher algorithms that the backend cryptodev can
> support. But in certain cases where the guest has more
> performant mechanism to handle some algorithms, it would be
> useful to propagate only a subset of the algorithms.

I'm not really convinced by this.

The performance of crypto algorithms has many influencing
factors, making it pretty hard to decide which is best
without actively testing specific impls and comparing
them in a manner which matches the application usage
pattern. eg in theory the kernel crypto impl of an alg
is faster than a userspace impl, if the kernel uses
hardware accel and userspace does not. This, however,
ignores the overhead of the kernel/userspace switch.
The real world performance winner, thus depends on the
amount of data being processed in each operation. Some
times userspace can win & sometimes kernel space can
win. This is even more relevant to virtio-crypto as
it has more expensive context switches.

IOW, when we expose a virtio-crypto dev to a guest,
it is never reasonable for the guest to blindly assume
that anything it does is faster than a pure software
impl running in the guest. It will depend on the usage
pattern. This is no different to bare metal where you
should not assume kernel crypto is faster.

IMHO this is not a compelling reason to be able to turn
off algorithms in virtio-crypto, as any decision will
always be at best incomplete & inaccurate.

> @@ -853,6 +863,34 @@ static const VMStateDescription vmstate_virtio_crypto = {
>  static Property virtio_crypto_properties[] = {
>      DEFINE_PROP_LINK("cryptodev", VirtIOCrypto, conf.cryptodev,
>                       TYPE_CRYPTODEV_BACKEND, CryptoDevBackend *),
> +    DEFINE_PROP_BIT("no-cipher", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_ARC4, false),
> +    DEFINE_PROP_BIT("cipher-arc4", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_ARC4, false),
> +    DEFINE_PROP_BIT("cipher-aes-ecb", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_AES_ECB, false),
> +    DEFINE_PROP_BIT("cipher-aes-cbc", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_AES_CBC, false),
> +    DEFINE_PROP_BIT("cipher-aes-ctr", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_AES_CTR, false),
> +    DEFINE_PROP_BIT("cipher-des-ecb", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_DES_ECB, false),
> +    DEFINE_PROP_BIT("cipher-3des-ecb", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_3DES_ECB, false),
> +    DEFINE_PROP_BIT("cipher-3des-cbc", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_3DES_CBC, false),
> +    DEFINE_PROP_BIT("cipher-3des-ctr", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_3DES_CTR, false),
> +    DEFINE_PROP_BIT("cipher-kasumi-f8", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_KASUMI_F8, false),
> +    DEFINE_PROP_BIT("cipher-snow3g-uea2", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2, false),
> +    DEFINE_PROP_BIT("cipher-aes-f8", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_AES_F8, false),
> +    DEFINE_PROP_BIT("cipher-aes-xts", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_AES_XTS, false),
> +    DEFINE_PROP_BIT("cipher-zuc-eea3", VirtIOCrypto, user_cipher_algo_l,
> +                    VIRTIO_CRYPTO_CIPHER_ZUC_EEA3, false),

This does not scale as an approach IMHO which just reinforces to me
that we shouldn't do this.

>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -974,6 +1012,8 @@ static void virtio_crypto_instance_init(Object *obj)
>       * Can be overriden with virtio_crypto_set_config_size.
>       */
>      vcrypto->config_size = sizeof(struct virtio_crypto_config);
> +    vcrypto->user_cipher_algo_l = ~VIRTIO_CRYPTO_NO_CIPHER - 1;
> +    vcrypto->user_cipher_algo_h = ~VIRTIO_CRYPTO_NO_CIPHER;
>  }
>  
>  static const TypeInfo virtio_crypto_info = {
> diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
> index ca3a049..c5bb684 100644
> --- a/include/hw/virtio/virtio-crypto.h
> +++ b/include/hw/virtio/virtio-crypto.h
> @@ -97,6 +97,9 @@ typedef struct VirtIOCrypto {
>      uint32_t curr_queues;
>      size_t config_size;
>      uint8_t vhost_started;
> +
> +    uint32_t user_cipher_algo_l;
> +    uint32_t user_cipher_algo_h;
>  } VirtIOCrypto;
>  
>  #endif /* _QEMU_VIRTIO_CRYPTO_H */
> -- 
> 2.7.4
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
