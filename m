Received: from eggs.gnu.org ([2001:4830:134:3::10]:58466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1jsH-0004vk-Mp
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1jsE-0005bu-K9
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:30:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3391
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1jsE-0005bE-0A
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:30:06 -0400
Message-ID: <58FAB1EF.1050100@huawei.com>
Date: Sat, 22 Apr 2017 09:29:19 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-13-git-send-email-longpeng2@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA238B4D@DGGEMA505-MBS.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA238B4D@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 12/18] crypto: introduce some
 common functions for af_alg backend
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



On 2017/4/21 20:36, Gonglei (Arei) wrote:

> 
>> -----Original Message-----

>> +#include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>> +#include "qemu/sockets.h"
>> +#include "qapi/error.h"
>> +#include "afalgpriv.h"
>> +
>> +static bool
>> +qcrypto_afalg_build_saddr(const char *type, const char *name,
>> +                          struct sockaddr_alg *salg, Error **errp)
>> +{
>> +    memset(salg, 0, sizeof(*salg));
> 
> Why not initialize it in its caller?
> 


Ok, will fix in v3.

>> +    salg->salg_family = AF_ALG;
>> +
>> +    if (qemu_strnlen(type, SALG_TYPE_LEN_MAX) == SALG_TYPE_LEN_MAX)
>> {

>> +
>> +QCryptoAFAlg *
>> +qcrypto_afalg_comm_alloc(const char *type, const char *name,
>> +                         Error **errp)
>> +{
>> +    QCryptoAFAlg *afalg = NULL;
> 
> A superfluous initialization.
> 


Ok.

>> +
>> +    afalg = g_new0(QCryptoAFAlg, 1);
>> +    /* initilize crypto API socket */
>> +    afalg->opfd = -1;
>> +    afalg->tfmfd = qcrypto_afalg_socket_bind(type, name, errp);
>> +    if (afalg->tfmfd == -1) {
>> +        goto error;
>> +    }
>> +
>> +    afalg->opfd = qemu_accept(afalg->tfmfd, NULL, 0);
>> +    if (afalg->opfd == -1) {
>> +        error_setg_errno(errp, errno, "Failed to accept socket");
>> +        goto error;
>> +    }
>> +
>> +    return afalg;
>> +
>> +error:
>> +    qcrypto_afalg_comm_free(afalg);
>> +    return NULL;
>> +}

>> +/**
>> + * qcrypto_afalg_comm_alloc:
>> + * @type: the type of crypto opeartion
>> + * @name: the name of crypto opeartion
> 
> s/opeartion/operation/g
> 


Ok.

Thanks.

> 
>> + *
>> + * Allocate a QCryptoAFAlg object and bind itself to
>> + * a AF_ALG socket.
>> + *
>> + * Returns:
>> + *  a new QCryptoAFAlg object, or NULL in error.
>> + */
>> +QCryptoAFAlg *
>> +qcrypto_afalg_comm_alloc(const char *type, const char *name,
>> +                         Error **errp);
>> +
>> +/**
>> + * afalg_comm_free:
>> + * @afalg: the QCryptoAFAlg object
>> + *
>> + * Free the @afalg.
>> + */
>> +void qcrypto_afalg_comm_free(QCryptoAFAlg *afalg);
>> +
>> +#endif
>> --
>> 1.8.3.1
>>
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
