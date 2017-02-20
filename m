Received: from eggs.gnu.org ([2001:4830:134:3::10]:36064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfmKa-000842-VP
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfmKZ-00052K-K3
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:40:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cfmKZ-000520-DN
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:40:35 -0500
Date: Mon, 20 Feb 2017 11:40:29 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220114029.GI15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170220112307.31695-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170220112307.31695-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] crypto: assert cipher algorithm is always
 valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Mon, Feb 20, 2017 at 04:53:07PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Crypto routines 'qcrypto_cipher_get_block_len' and
> 'qcrypto_cipher_get_key_len' return non-zero cipher block and key
> lengths from static arrays 'alg_block_len[]' and 'alg_key_len[]'
> respectively. Returning 'zero(0)' value from either of them would
> likely lead to an error condition.

Well callers are supposed to check for 0 condition and report an
error really. In practice none of them do, and the alg parameters
they pass in all come from constants. So we're not validating user
input here - we're catching programming bugs and thus assert makes
sense.

> 
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  crypto/cipher.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

> 
> diff --git a/crypto/cipher.c b/crypto/cipher.c
> index 9ecaff7..5a96489 100644
> --- a/crypto/cipher.c
> +++ b/crypto/cipher.c
> @@ -63,18 +63,14 @@ static bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] = {
>  
>  size_t qcrypto_cipher_get_block_len(QCryptoCipherAlgorithm alg)
>  {
> -    if (alg >= G_N_ELEMENTS(alg_key_len)) {
> -        return 0;
> -    }
> +    assert(alg < G_N_ELEMENTS(alg_key_len));
>      return alg_block_len[alg];
>  }
>  
>  
>  size_t qcrypto_cipher_get_key_len(QCryptoCipherAlgorithm alg)
>  {
> -    if (alg >= G_N_ELEMENTS(alg_key_len)) {
> -        return 0;
> -    }
> +    assert(alg < G_N_ELEMENTS(alg_key_len));
>      return alg_key_len[alg];
>  }

Adding to the crypto/ queue

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
