Received: from eggs.gnu.org ([2001:4830:134:3::10]:58238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1jq3-00047z-HK
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1jq0-0005N8-EH
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:27:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3455
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1jpz-0005Ma-RI
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:27:48 -0400
Message-ID: <58FAB162.2020202@huawei.com>
Date: Sat, 22 Apr 2017 09:26:58 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-12-git-send-email-longpeng2@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA238AEC@DGGEMA505-MBS.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA238AEC@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 11/18] crypto: hmac: add hmac
 driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "berrange@redhat.com" <berrange@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 2017/4/21 20:25, Gonglei (Arei) wrote:

> 
> 
>> -----Original Message-----
>> From: longpeng
>> Sent: Monday, April 17, 2017 9:33 AM
>> To: berrange@redhat.com
>> Cc: Gonglei (Arei); Huangweidong (C); armbru@redhat.com;
>> eblake@redhat.com; mst@redhat.com; qemu-devel@nongnu.org; longpeng
>> Subject: [PATCH v2 for-2.10 11/18] crypto: hmac: add hmac driver framework
>>
>> 1) makes the public APIs in hmac-nettle/gcrypt/glib static,
>>    and rename them with "nettle/gcrypt/glib" prefix.
>>
>> 2) introduces hmac framework, including QCryptoHmacDriver
>>    and new public APIs.
>>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
>>  crypto/hmac-gcrypt.c  | 51 ++++++++++++-----------------------
>>  crypto/hmac-glib.c    | 75 +++++++++++++++++++++------------------------------
>>  crypto/hmac-nettle.c  | 52 ++++++++++++-----------------------
>>  crypto/hmac.c         | 44 ++++++++++++++++++++++++++++++
>>  crypto/hmacpriv.h     | 36 +++++++++++++++++++++++++
>>  include/crypto/hmac.h |  1 +
>>  6 files changed, 145 insertions(+), 114 deletions(-)
>>  create mode 100644 crypto/hmacpriv.h
>>
>> diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
>> index 42489f3..76ca61b 100644
>> --- a/crypto/hmac-gcrypt.c
>> +++ b/crypto/hmac-gcrypt.c
>> @@ -15,6 +15,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>>  #include "crypto/hmac.h"
>> +#include "hmacpriv.h"
>>  #include <gcrypt.h>
>>
>>  static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__MAX] = {
>> @@ -42,10 +43,9 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm
>> alg)
>>      return false;
>>  }
>>
>> -static QCryptoHmacGcrypt *
>> -qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
>> -                     const uint8_t *key, size_t nkey,
>> -                     Error **errp)
>> +void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
>> +                           const uint8_t *key, size_t nkey,
>> +                           Error **errp)
> 
> Why do this change?
> 


pls see below :)

>>  {
>>      QCryptoHmacGcrypt *ctx;

>> +
>> +struct QCryptoHmacDriver {
>> +    int (*hmac_bytesv)(QCryptoHmac *hmac,
>> +                       const struct iovec *iov,
>> +                       size_t niov,
>> +                       uint8_t **result,
>> +                       size_t *resultlen,
>> +                       Error **errp);
>> +
>> +    void (*hmac_free)(QCryptoHmac *hmac);
>> +};
>> +
>> +extern void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
>> +                                  const uint8_t *key, size_t nkey,
>> +                                  Error **errp);
> 
> I think the method of cipher is fine.
> 


In cipher.c, we can see this:

#ifdef CONFIG_GCRYPT
#include "crypto/cipher-gcrypt.c"
#elif defined CONFIG_NETTLE
#include "crypto/cipher-nettle.c"
#else
#include "crypto/cipher-builtin.c"
#endif

it included cipher-*.c, so cipher.c can access the static methods in cipher-*.c
directly.

But in hmac.c, it just included hmac.h, it cannot access the static methods in
hmac-*.c, so we must change qcrypto_hmac_ctx_new from 'static
qcrypto_hmac_ctx_new *' to 'void *', and declare it in hmac.h.


> 
>> +extern QCryptoHmacDriver qcrypto_hmac_lib_driver;
>> +
>> +#endif
>> diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
>> index 0d3acd7..5e88905 100644
>> --- a/include/crypto/hmac.h
>> +++ b/include/crypto/hmac.h
>> @@ -18,6 +18,7 @@ typedef struct QCryptoHmac QCryptoHmac;
>>  struct QCryptoHmac {
>>      QCryptoHashAlgorithm alg;
>>      void *opaque;
>> +    void *driver;
>>  };
>>
>>  /**
>> --
>> 1.8.3.1
>>
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
