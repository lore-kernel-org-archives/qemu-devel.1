Received: from eggs.gnu.org ([2001:4830:134:3::10]:43329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fakfc-0007V2-Cm
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fakfY-0005Xc-U7
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:30:20 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:42507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fakfY-0005WT-B4
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:30:16 -0400
Received: by mail-qk0-x234.google.com with SMTP id u62-v6so3118659qkf.9
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 09:30:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180704153919.12432-1-f4bug@amsat.org>
	<20180704153919.12432-4-f4bug@amsat.org>
	<20180704155104.GN32267@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6d18c7bb-3eed-03bc-b8fd-def49e02812c@amsat.org>
Date: Wed, 4 Jul 2018 13:30:11 -0300
MIME-Version: 1.0
In-Reply-To: <20180704155104.GN32267@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/8] crypto: Remove useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 07/04/2018 12:51 PM, Daniel P. Berrangé wrote:
> On Wed, Jul 04, 2018 at 12:39:14PM -0300, Philippe Mathieu-Daudé wrote:
>> Patch created mechanically by rerunning:
>>
>>   $  spatch --sp-file scripts/coccinelle/typecast.cocci \
>>             --macro-file scripts/cocci-macro-file.h \
>>             --dir . --in-place
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  crypto/cipher-builtin.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
>> index d8c811fd33..7eff760f0a 100644
>> --- a/crypto/cipher-builtin.c
>> +++ b/crypto/cipher-builtin.c
>> @@ -133,7 +133,7 @@ static void qcrypto_cipher_aes_xts_encrypt(const void *ctx,
>>  {
>>      const QCryptoCipherBuiltinAESContext *aesctx = ctx;
>>  
>> -    qcrypto_cipher_aes_ecb_encrypt((AES_KEY *)&aesctx->enc,
>> +    qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc,
>>                                     src, dst, length);
> 
> qcrypto_cipher_aes_ecb_encrypt expects a 'AES_KEY *' parameter, but
> '&aesctx->enc, is a 'const AES_KEY *'. The cast is needed to discard
> the const-ness.

Oh I didn't notice. I'll see if I can patch typecast.cocci to avoid this
noise.

Thanks!

> 
>> @@ -145,7 +145,7 @@ static void qcrypto_cipher_aes_xts_decrypt(const void *ctx,
>>  {
>>      const QCryptoCipherBuiltinAESContext *aesctx = ctx;
>>  
>> -    qcrypto_cipher_aes_ecb_decrypt((AES_KEY *)&aesctx->dec,
>> +    qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec,
>>                                     src, dst, length);
> 
> Same here.
> 
> 
> Regards,
> Daniel
> 
