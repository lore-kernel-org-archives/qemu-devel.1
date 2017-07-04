Received: from eggs.gnu.org ([2001:4830:134:3::10]:45140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJaB-0001sx-EA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJa8-0003gx-9i
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:53:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJa7-0003cT-Ms
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:53:16 -0400
Message-ID: <595B575C.6020908@huawei.com>
Date: Tue, 4 Jul 2017 16:52:44 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
	<1492845627-4384-16-git-send-email-longpeng2@huawei.com>
	<20170426122308.GU18933@redhat.com>
In-Reply-To: <20170426122308.GU18933@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/18] crypto: hmac: add af_alg hmac
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: arei.gonglei@huawei.com, longpeng.mike@gmail.com, qemu-devel@nongnu.org, weidong.huang@huawei.com

Hi Daniel，

First, sorry for the long delay...

I have modified the code as your suggestion, and I'll send V4 soon.

On 2017/4/26 20:23, Daniel P. Berrange wrote:

> On Sat, Apr 22, 2017 at 03:20:24PM +0800, Longpeng(Mike) wrote:
>> Adds afalg-backend hmac support: introduces some private APIs
>> firstly, and then intergrates them into qcrypto_hmac_afalg_driver.
>>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
>>  crypto/hash-afalg.c   | 108 +++++++++++++++++++++++++++++++++++++++++++-------
>>  crypto/hmac.c         |  27 ++++++++++++-
>>  crypto/hmacpriv.h     |   9 +++++
>>  include/crypto/hmac.h |   8 ++++
>>  4 files changed, 136 insertions(+), 16 deletions(-)
>>
>> diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
>> index f577c83..0670481 100644
>> --- a/crypto/hash-afalg.c
>> +++ b/crypto/hash-afalg.c
>> @@ -1,5 +1,5 @@
>>  /*
>> - * QEMU Crypto af_alg-backend hash support
>> + * QEMU Crypto af_alg-backend hash/hmac support
>>   *
>>   * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
>>   *
>> @@ -16,10 +16,13 @@
>>  #include "qemu-common.h"
>>  #include "qapi/error.h"
>>  #include "crypto/hash.h"
>> +#include "crypto/hmac.h"
>>  #include "hashpriv.h"
>> +#include "hmacpriv.h"
>>  
>>  static char *
>>  qcrypto_afalg_hash_format_name(QCryptoHashAlgorithm alg,
>> +                               bool is_hmac,
>>                                 Error **errp)
>>  {
>>      char *name;
>> @@ -55,10 +58,14 @@ qcrypto_afalg_hash_format_name(QCryptoHashAlgorithm alg,
>>      }
>>  
>>      name = g_new0(char, SALG_NAME_LEN_MAX);
>> -    ret = snprintf(name, SALG_NAME_LEN_MAX, "%s", alg_name);
>> +    if (is_hmac) {
>> +        ret = snprintf(name, SALG_NAME_LEN_MAX, "hmac(%s)", alg_name);
>> +    } else { /* hash */
>> +        ret = snprintf(name, SALG_NAME_LEN_MAX, "%s", alg_name);
>> +    }
>>      if (ret < 0 || ret >= SALG_NAME_LEN_MAX) {
>> -        error_setg(errp, "Build hash name(name='%s') failed",
>> -                   alg_name);
>> +        error_setg(errp, "Build %s name(name='%s') failed",
>> +                   is_hmac ? "hmac" : "hash", alg_name);
>>          g_free(name);
>>          return NULL;
>>      }
> 
> Same comments as before about using g_strdup_printf
> 
>> diff --git a/crypto/hmac.c b/crypto/hmac.c
>> index d040fbb..0a1a6e7 100644
>> --- a/crypto/hmac.c
>> +++ b/crypto/hmac.c
>> @@ -90,16 +90,32 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
>>  {
>>      QCryptoHmac *hmac;
>>      void *ctx;
> 
> Initialize to NULL
> 
>> +    Error *err2 = NULL;
>> +    QCryptoHmacDriver *drv;
>> +
>> +#ifdef CONFIG_AF_ALG
>> +    ctx = qcrypto_afalg_hmac_ctx_new(alg, key, nkey, &err2);
>> +    if (ctx) {
>> +        drv = &qcrypto_hmac_afalg_driver;
>> +        goto set_hmac;
> 
> Drop the goto
> 
>> +    }
>> +#endif
>>
> 
> And we can just add 'if (!ctx)' here
> 
>>      ctx = qcrypto_hmac_ctx_new(alg, key, nkey, errp);
>>      if (ctx == NULL) {
>>          return NULL;
>>      }
>>  
>> +    drv = &qcrypto_hmac_lib_driver;
>> +    error_free(err2);
>> +
>> +#ifdef CONFIG_AF_ALG
>> +set_hmac:
>> +#endif
>>      hmac = g_new0(QCryptoHmac, 1);
>>      hmac->alg = alg;
>>      hmac->opaque = ctx;
>> -    hmac->driver = (void *)&qcrypto_hmac_lib_driver;
>> +    hmac->driver = (void *)drv;
>>  
>>      return hmac;
>>  }
> 
> Regards,
> Daniel


-- 
Regards,
Longpeng(Mike)
