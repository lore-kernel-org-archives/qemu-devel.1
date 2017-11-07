Received: from eggs.gnu.org ([2001:4830:134:3::10]:52504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBtbv-0008Pa-PK
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBtbs-0005xo-H4
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:27:31 -0500
Received: from [45.249.212.32] (port=42057 helo=huawei.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBtbs-0005xC-5G
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:27:28 -0500
Message-ID: <5A0119FE.6060709@huawei.com>
Date: Tue, 7 Nov 2017 10:27:10 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
	<d465b265-2f07-34df-4474-d5dd57ec7443@redhat.com>
In-Reply-To: <d465b265-2f07-34df-4474-d5dd57ec7443@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] crypto: afalg: fix a NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: berrange@redhat.com, pbonzini@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan
	Hajnoczi <stefanha@gmail.com>



On 2017/11/7 1:00, Eric Blake wrote:

> On 11/06/2017 12:21 AM, Longpeng(Mike) wrote:
>> Test-crypto-hash calls qcrypto_hash_bytesv/digest/base64 with
>> errp=NULL, this will cause a NULL poniter deference if afalg_driver
> 
> s/poniter deference/pointer dereference/
> 

OK.

>> doesn't support requested algos:
>>     ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
>>                                                 result, resultlen,
>>                                                 errp);
>>     if (ret == 0) {
>>         return ret;
>>     }
>>
>>     error_free(*errp);  // <--- here
>>
>> So we must check 'errp & *errp' before dereference.
> 
> No, if we are going to blindly ignore the error from the hash_bytesv()
> call, then we should pass NULL rather than errp.
> 

The 'errp' in this palce is convenient for debug, it can tell us the reason for
failure without stepping into afalg_driver's hash_bytesv().

>>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
>>  crypto/hash.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/crypto/hash.c b/crypto/hash.c
>> index ac59c63..c464c78 100644
>> --- a/crypto/hash.c
>> +++ b/crypto/hash.c
>> @@ -60,7 +60,9 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
>>       * TODO:
>>       * Maybe we should treat some afalg errors as fatal
>>       */
>> -    error_free(*errp);
>> +    if (errp && *errp) {
>> +        error_free(*errp);
>> +    }
> 
> Any code that uses 'if (errp && *errp)' is suspicious; I think you need

I see, thanks a lot.

> a v2 that doesn't try to set errp in the first place, rather than
> cleaning it up to ignore it after the fact.
> 

I answered above.

How about the following approach?

int qcrypto_hash_bytesv(...Error **errp)
{
#ifdef CONFIG_AF_ALG
    int ret;
    Error *err2 = NULL;

    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
                                                result, resultlen,
                                                &err2);
    if (ret == 0) {
        return ret;
    }

    error_free(*err2);
#endif

    return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
                                               result, resultlen,
                                               errp);
}

I'll send a V2 if there's no objection, otherwise I'll pick your suggested
approach. :)

-- 
Regards,
Longpeng(Mike)
