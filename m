Received: from eggs.gnu.org ([2001:4830:134:3::10]:37381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fSmlt-0007gO-Nu
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fSmlq-0002qy-H4
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:07:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fSmlq-0002qQ-7l
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:07:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5CH4c54047002
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:07:49 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jjh7xb46u-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:07:48 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 12 Jun 2018 13:07:47 -0400
References: <cover.1528462918.git.alifm@linux.ibm.com>
	<a9a06d82df69387bf1e66975b520d9049e9976e8.1528462918.git.alifm@linux.ibm.com>
	<33183CC9F5247A488A2544077AF19020DB015ABF@dggeml511-mbx.china.huawei.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 12 Jun 2018 13:07:41 -0400
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB015ABF@dggeml511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7957a36b-6881-1967-fa60-eaeaa38256c0@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC v1 2/2] crypto/virtio-crypto: Register an
 algo only if it's supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, longpeng <longpeng2@huawei.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>



On 06/11/2018 04:48 AM, Gonglei (Arei) wrote:
> 
> 
>> -----Original Message-----
>> From: Farhan Ali [mailto:alifm@linux.ibm.com]
>> Sent: Saturday, June 09, 2018 3:09 AM
>> To: linux-kernel@vger.kernel.org; kvm@vger.kernel.org
>> Cc: mst@redhat.com; qemu-devel@nongnu.org; Gonglei (Arei)
>> <arei.gonglei@huawei.com>; longpeng <longpeng2@huawei.com>;
>> pasic@linux.ibm.com; frankja@linux.ibm.com; borntraeger@de.ibm.com;
>> alifm@linux.ibm.com
>> Subject: [RFC v1 2/2] crypto/virtio-crypto: Register an algo only if it's supported
>>
>> From: Farhan Ali <alifm@linux.vnet.ibm.com>
>>
>> Register a crypto algo with the Linux crypto layer only if
>> the algorithm is supported by the backend virtio-crypto
>> device.
>>
>> Also route crypto requests to a virtio-crypto
>> device, only if it can support the requested service and
>> algorithm.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/crypto/virtio/virtio_crypto_algs.c   | 110
>> ++++++++++++++++++---------
>>   drivers/crypto/virtio/virtio_crypto_common.h |  11 ++-
>>   drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 ++++++++++++++++++--
>>   3 files changed, 158 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c
>> b/drivers/crypto/virtio/virtio_crypto_algs.c
>> index ba190cf..fef112a 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_algs.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_algs.c
>> @@ -49,12 +49,18 @@ struct virtio_crypto_sym_request {
>>   	bool encrypt;
>>   };
>>
>> +struct virtio_crypto_algo {
>> +	uint32_t algonum;
>> +	uint32_t service;
>> +	unsigned int active_devs;
>> +	struct crypto_alg algo;
>> +};
>> +
>>   /*
>>    * The algs_lock protects the below global virtio_crypto_active_devs
>>    * and crypto algorithms registion.
>>    */
>>   static DEFINE_MUTEX(algs_lock);
>> -static unsigned int virtio_crypto_active_devs;
>>   static void virtio_crypto_ablkcipher_finalize_req(
>>   	struct virtio_crypto_sym_request *vc_sym_req,
>>   	struct ablkcipher_request *req,
>> @@ -312,13 +318,19 @@ static int virtio_crypto_ablkcipher_setkey(struct
>> crypto_ablkcipher *tfm,
>>   					 unsigned int keylen)
>>   {
>>   	struct virtio_crypto_ablkcipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
>> +	uint32_t alg;
>>   	int ret;
>>
>> +	ret = virtio_crypto_alg_validate_key(keylen, &alg);
>> +	if (ret)
>> +		return ret;
>> +
>>   	if (!ctx->vcrypto) {
>>   		/* New key */
>>   		int node = virtio_crypto_get_current_node();
>>   		struct virtio_crypto *vcrypto =
>> -				      virtcrypto_get_dev_node(node);
>> +				      virtcrypto_get_dev_node(node,
>> +				      VIRTIO_CRYPTO_SERVICE_CIPHER, alg);
>>   		if (!vcrypto) {
>>   			pr_err("virtio_crypto: Could not find a virtio device in the
>> system\n");
> 
> We'd better change the above error message now. What about:
>   " virtio_crypto: Could not find a virtio device in the system or unsupported algo" ?
> 
> Regards,
> -Gonglei


Sure, I will update the error message. But other than that does the rest 
of the code looks good to you?

Thanks
Farhan

> 
> 
> 
> 
