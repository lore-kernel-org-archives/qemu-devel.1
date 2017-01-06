Received: from eggs.gnu.org ([2001:4830:134:3::10]:45914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPSgw-0000UO-NH
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 06:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPSgt-0003Ly-IX
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 06:28:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPSgt-0003LW-Cy
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 06:28:11 -0500
Date: Fri, 6 Jan 2017 11:28:04 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106112803.GG31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1483577381-38088-1-git-send-email-longpeng2@huawei.com>
	<1483577381-38088-3-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1483577381-38088-3-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RESEND 2/6] crypto: add AEAD algorithms
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Thu, Jan 05, 2017 at 08:49:37AM +0800, Longpeng(Mike) wrote:
> This patch introduce AEAD algorithms framework.

So AEAD is essentially just encryption with extra metadata on
input and output stages. As such I don't think this should be
implemented via new objects in QEMU.

Instead, we should add the extra APIs to the existing
cipher.{c,h} file.

You've only implemented AES support here, so the code duplication
is not obvious, but if we were to extend AEAD to other algorithms
we'd see alot of duplication with the way you've done things.

So....

> +int qcrypto_aead_set_nonce(QCryptoAead *aead,
> +                           const uint8_t *nonce, size_t nonce_len,
> +                           size_t aad_len, size_t in_len,
> +                           size_t tag_len,
> +                           Error **errp);

> +int qcrypto_aead_authenticate(QCryptoAead *aead,
> +                              const uint8_t *aad, size_t aad_len,
> +                              Error **errp);
> +

> +int qcrypto_aead_get_tag(QCryptoAead *aead,
> +                         uint8_t *tag, size_t tag_len,
> +                         Error **errp);
> +

Just add these three methods to cipher.h instead


> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index f4fd93b..edb2962 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -87,6 +87,8 @@
>  #
>  # The supported modes for content encryption ciphers
>  #
> +# @ccm: Counter with CBC-MAC Mode (Since 2.9)
> +# @gcm: Galois Counter Mode (Since 2.9)
>  # @ecb: Electronic Code Book
>  # @cbc: Cipher Block Chaining
>  # @xts: XEX with tweaked code book and ciphertext stealing
> @@ -95,7 +97,7 @@
>  ##
>  { 'enum': 'QCryptoCipherMode',
>    'prefix': 'QCRYPTO_CIPHER_MODE',
> -  'data': ['ecb', 'cbc', 'xts', 'ctr']}
> +  'data': ['ccm', 'gcm', 'ecb', 'cbc', 'xts', 'ctr']}

This is fine.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
