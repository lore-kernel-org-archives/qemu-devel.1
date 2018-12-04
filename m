Received: from eggs.gnu.org ([2001:4830:134:3::10]:53039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUFpP-0003Pq-QQ
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUFpP-0005TS-4D
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:53:51 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUFpO-0005Rq-Ru
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:53:50 -0500
Received: by mail-ot1-x343.google.com with SMTP id f18so16163852otl.11
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20181204184657.78028-1-vsementsov@virtuozzo.com>
	<20181204184657.78028-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181204184657.78028-2-vsementsov@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 18:53:38 +0000
Message-ID: <CAFEAcA_kia8BY3+DmrPD+zOhrHpgOnR8WUd+4t=jp1a2cu+xBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1? 1/5] crypto/block-luks: fix memory
 leak in qcrypto_block_luks_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>

On Tue, 4 Dec 2018 at 18:50, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Free block->cipher and block->ivgen on error path.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  crypto/block-luks.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 5738124773..51e24d23ca 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -1341,6 +1341,9 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>      qcrypto_ivgen_free(ivgen);
>      qcrypto_cipher_free(cipher);
>
> +    qcrypto_cipher_free(block->cipher);
> +    qcrypto_ivgen_free(block->ivgen);
> +
>      g_free(luks);
>      return -1;
>  }
> --

Too late for 3.1, I'm afraid. You should probably add the
cc tag for stable.

thanks
-- PMM
