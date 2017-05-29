Received: from eggs.gnu.org ([2001:4830:134:3::10]:36006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dFLKf-0006H5-MW
	for qemu-devel@nongnu.org; Mon, 29 May 2017 10:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dFLKc-0008Lu-9T
	for qemu-devel@nongnu.org; Mon, 29 May 2017 10:07:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51212
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dFLKc-0008Lq-2f
	for qemu-devel@nongnu.org; Mon, 29 May 2017 10:07:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4TE46Vw058814
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 10:07:37 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aqf9k0hk3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 10:07:36 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 29 May 2017 15:07:34 +0100
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-7-git-send-email-arei.gonglei@huawei.com>
	<520f45d4-33d7-8836-3140-a92ee5d15421@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA278AA0@DGGEMA505-MBS.china.huawei.com>
	<1963bfa1-c0ea-156a-59f7-aed744ca49a3@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA29A0B5@DGGEMA505-MBS.china.huawei.com>
	<b7c20d5f-026e-edf1-6703-6b64ceed375f@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA29B209@DGGEMA505-MBS.china.huawei.com>
	<a47f867a-0953-d1fb-382f-8fe886c50436@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA29D00E@DGGEMA505-MBS.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 29 May 2017 16:07:30 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA29D00E@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <8073a3a2-4703-8fcf-7a36-7b2c85820f5d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC v1 6/9] virtio-crypto: rework
 virtio_crypto_handle_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Luonengjun <luonengjun@huawei.com>, Linqiangmin <linqiangmin@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Wubin (H)" <wu.wubin@huawei.com>



On 05/18/2017 03:21 PM, Gonglei (Arei) wrote:
>>>> Besides if you look at
>>>>
>>>> +Stateless mode HASH service requests are as follows:
>>>> +
>>>> +\begin{lstlisting}
>>>> +struct virtio_crypto_hash_para_statelesss {
>>>> +    struct {
>>>> +        /* See VIRTIO_CRYPTO_HASH_* above */
>>>> +        le32 algo;
>>>> +    } sess_para;
>>>> +
>>>> +    /* length of source data */
>>>> +    le32 src_data_len;
>>>> +    /* hash result length */
>>>> +    le32 hash_result_len;
>>>> +    le32 reserved;
>>>> +};
>>>> +struct virtio_crypto_hash_data_req_stateless {
>>>> +    /* Device-readable part */
>>>> +    struct virtio_crypto_hash_para_stateless para;
>>>> +    /* Source data */
>>>> +    u8 src_data[src_data_len];
>>>> +
>>>> +    /* Device-writable part */
>>>> +    /* Hash result data */
>>>> +    u8 hash_result[hash_result_len];
>>>> +    struct virtio_crypto_inhdr inhdr;
>>>> +};
>>>> +\end{lstlisting}
>>>> +
>>>>
>>>> from the "[PATCH v18 1/2] virtio-crypto: Add virtio crypto device
>>>> specification". You need the padding to 128 bytes after
>>>> virtio_crypto_hash_para_stateless para, but before src_data. But there is
>>>> no indication in the definition of virtio_crypto_hash_data_req_stateless
>>>> nor somewhere in the spec about that. On the contrary based on this
>>>> one would expect para.reserved and src_data being pretty adjecent.
>>>>
>>>> Thus the normative statement you quoted is (IMHO) ill suited and
>>>> insufficient to express what you have been trying to express.
>>>>
>>> That's indeed a problem. I can't find a good way to express my thoughts
>>> in the spec. Make me sad.~
>>>
>> Can't really tell if we are in an agreement based on your reply above.
>> If we are not, please tell.
>>
>> If we are we have two paths:
>> 1) Give up on the concept of same 'header' length. You could easily
>> branch on the common header and do everything else algorithm specific.
>> 2) Find a way to clean up the mess:
>>    * Bring to expression that the  struct virtio_crypto_op_data_req
>>      from the code ain't the full request (e.g. by postfix-ing _header).
>>      Same for mux.
>>    * Update the description in the spec so that it's compatible with
>>      what your implementations are doing.
>>
> Could you pls explain more about those two ways? Oh give me an example
> for each other. Which way do you like better?

Sorry, I'm quite busy at the time and it does not look like I will be
able to find the time for providing a more detailed explanation. Regarding
my preferences I think 1) is the more straight-forward approach at least
conceptually. OTOH I would need to implement 1) to verify that...

Regards,
Halil
