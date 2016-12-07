Received: from eggs.gnu.org ([2001:4830:134:3::10]:50187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEYOf-0002bZ-2m
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEYOV-0005JX-OY
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:20:13 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:44029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEYOV-0005GH-4s
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:20:07 -0500
Message-ID: <5847D42A.6090400@huawei.com>
Date: Wed, 7 Dec 2016 17:19:38 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1481099622-188132-1-git-send-email-longpeng2@huawei.com>
	<1481099622-188132-2-git-send-email-longpeng2@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA155BFA@DGGEMA505-MBX.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA155BFA@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] crypto: add 3des-ede support
 when using libgcrypt/nettle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "berrange@redhat.com" <berrange@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>



On 2016/12/7 16:52, Gonglei (Arei) wrote:

>> -----Original Message-----
>> From: longpeng
>> Sent: Wednesday, December 07, 2016 4:34 PM
>> To: berrange@redhat.com; eblake@redhat.com; armbru@redhat.com;
>> Gonglei (Arei)
>> Cc: qemu-devel@nongnu.org; Wubin (H); Zhoujian (jay, Euler); longpeng
>> Subject: [PATCH for-2.9 1/2] crypto: add 3des-ede support when using
>> libgcrypt/nettle
>>
>> Libgcrypt and nettle support 3des-ede, so this patch add 3des-ede
>> support when using libgcrypt or nettle.
>>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
......
>> --- a/qapi/crypto.json
>> +++ b/qapi/crypto.json
>> @@ -63,6 +63,7 @@
>>  # @aes-192: AES with 192 bit / 24 byte keys
>>  # @aes-256: AES with 256 bit / 32 byte keys
>>  # @des-rfb: RFB specific variant of single DES. Do not use except in VNC.
>> +# @3des-ede: 3DES-EDE with 192 bit / 24 byte keys
> 
> Missing since 2.9 here.
> 

Okay, I will add it in V2.

>>  # @cast5-128: Cast5 with 128 bit / 16 byte keys
>>  # @serpent-128: Serpent with 128 bit / 16 byte keys
>>  # @serpent-192: Serpent with 192 bit / 24 byte keys
......
>> +    {
>> +        /* Borrowed from linux-kernel crypto/testmgr.h */
>> +        .path = "/crypto/cipher/3des-ede-ecb",
>> +        .alg = QCRYPTO_CIPHER_ALG_3DES_EDE,
>> +        .mode = QCRYPTO_CIPHER_MODE_ECB,
>> +        .key =
>> +            "0123456789abcdef5555555555555555"
>> +            "fedcba9876543210",
>> +        .plaintext =
>> +            "736f6d6564617461",
>> +        .ciphertext =
>> +            "18d748e563620572",
>> +    },
>> +#endif
> 
> Pls adds the CTR mode test case as well.
> 

Okay!

But I confuse with the 3DES's iv length now. I saw that cbc(3des-ede)'s iv-len
can be 8 or 16 bytes, and ctr(3des-ede)'s iv-len is 24 bytes(according to
linux-kernel crypto/testmgr.h).

However, I think qcrypto_cipher_get_iv_len() cannot distinguish a cipher alg
with more than one iv-len.

Daniel, do you have any idea ?

> You'd better split the patch set into two patches so that Denial can take this one.
> and I can take the patch 2.
> 

Okay, thanks.

> Thanks for your work.
> 
> -Gonglei
> 
>>      {
>>          /* RFC 2144, Appendix B.1 */
>>          .path = "/crypto/cipher/cast5-128",
>> --
>> 1.8.3.1
>>
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
