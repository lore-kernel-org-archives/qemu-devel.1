Received: from eggs.gnu.org ([2001:4830:134:3::10]:54856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eEEUF-0002KD-LK
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eEEU9-0008Ob-As
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:09:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eEEU9-0008M8-28
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:09:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vADD878p066448
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 08:09:01 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e763s0q3s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 08:09:01 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 13:08:58 -0000
References: <1509951193-25256-1-git-send-email-longpeng2@huawei.com>
	<1509951193-25256-2-git-send-email-longpeng2@huawei.com>
	<9d566eaa-5ace-b136-904e-07f964a6a5e9@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA46A708@DGGEMA505-MBS.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 14:08:49 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA46A708@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <e3613f11-7d95-17d4-610f-b3f44a14c723@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [v21 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng <longpeng2@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>



On 11/13/2017 08:17 AM, Gonglei (Arei) wrote:
>>> +struct virtio_crypto_cipher_session_req {
>>> +    /* Device-readable part */
>>> +    struct virtio_crypto_cipher_session_para para;
>>> +    /* The cipher key */
>>> +    u8 cipher_key[keylen];
>>> +
>> Is there a limit to the size of chiper_key. I don't see one in your
>> kernel code. OTOH given that virtio_crypto_sym_create_session_req
>> is one flavor of virtio_crypto_op_ctrl_req.additional_para and that
>> the later is 56 bytes in case no mux mode is supported, I think
>> there must be a limit to the size of cipher_key!
>>
> Of course the size of cipher_key is limited, firstly the max length is defined
> in virtio crypto's configuration, see
> 
> struct virtio_crypto_config {
>   ... ...
>     /* Maximum length of cipher key */
>     uint32_t max_cipher_key_len;
>   ... ...
> };
> 

So for the current qemu implementation it's 64 bytes.

> Secondly the real cipher_key size for a specific request, is in struct virtio_crypto_cipher_session_para,
> 
> struct virtio_crypto_cipher_session_para {
>    ... ...
>     /* length of key */
>     le32 keylen;
>    ... ...
> };
> 
> That means a size of cipher_key is variable, which is assigned in each request.

Of course I understood that. There are two problems I was trying
to point out, and you ignored both.

1. The more important one I was explicit about. Sadly you ignored
that part of my mail. I will mark it as *Problem 1* down below.

2. If there is a limit to the size, then there should be a driver
normative statement ("Driver Requirements") that states this limit
MUST be respected. I didn't find this statement.
> 
>> Please explain!
>>
>> Looking at the kernel code again, it seems to me that chiper_key
>> starts at offset 72 == sizeof(struct virtio_crypto_op_ctrl_req)
>> where struct virtio_crypto_op_ctrl_req is defined in
>> include/uapi/linux/virtio_crypto.h. That would mean that this
>> guy is *not a part of* virtio_crypto_op_ctrl_req but comes
>> after it and is of variable size.

*Problem 1*

Now consider the part where the whole request is described

"""
+The controlq request is composed of two parts:
+\begin{lstlisting}
+struct virtio_crypto_op_ctrl_req {
+    struct virtio_crypto_ctrl_header header;
+
+    /* additional paramenter */
+    u8 additional_para[addl_para_len];
+};
+\end{lstlisting}
+
+The first is a general header (see above). And the second one, additional
+paramenter, contains an crypto-service-specific structure, which could be one
+of the following types:
+\begin{itemize*}
+\item struct virtio_crypto_sym_create_session_req
+\item struct virtio_crypto_hash_create_session_req
+\item struct virtio_crypto_mac_create_session_req
+\item struct virtio_crypto_aead_create_session_req
+\item virtio_crypto_destroy_session_req
+\end{itemize*}
+
+The size of the additional paramenter depends on the VIRTIO_CRYPTO_F_MUX_MODE
+feature bit:
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is NOT negotiated, the
+    size of additional paramenter is fixed to 56 bytes, the data of the unused
+    part (if has) will be ingored.
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the size of
+    additional paramenter is flexible, which is the same as the crypto-service-specific
+    structure used.
"""

There it's said that the whole request is header + additional_para and that
if VIRTIO_CRYPTO_F_MUX_MODE feature bit is NOT negotiated additional para
is 56 bytes. Let's assume the key is part of the additional parameter.
But you can't put 64 bytes into 56 bytes. So as I say above
*the key is not part of virtio_crypto_op_ctrl_req* neiter as described
in this spec nor as defined in uapi/linux/virtio_crypto.h. That means
the communication protocol description (more precisely the message format
description) in the spec is broken. QED

In my opinion this is a big issue.


>>
>>> +    /* Device-writable part */
>>
>> Now I'm interested on what 'offset' does the device writable
>> part start.
>>
>> Of course technically we don't need to know this, because we
>> have a device-read-only or device-write-only indication on each
>> descriptor. So virtio_crypto_session_input starts with the first
>> device write only descriptor.
>>
> You are right. We definitely don't need to know this. Pls see Qemu code:
> virtio_crypto_handle_request():
> 
>     /* We always touch the last byte, so just see how big in_iov is. */
>     request->in_len = iov_size(in_iov, in_num);
>     request->in = (void *)in_iov[in_num - 1].iov_base
>               + in_iov[in_num - 1].iov_len
>               - sizeof(struct virtio_crypto_inhdr);
>     iov_discard_back(in_iov, &in_num, sizeof(struct virtio_crypto_inhdr));
> 
> The above in_iov means device-writable iov.
> 

I've seen that code. Thanks.

>>> +    struct virtio_crypto_session_input input;
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +Algorithm chaining requests are as follows:
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_crypto_alg_chain_session_para {
>>> +#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER
>> 1
>>> +#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH
>> 2
> [skip]
> 
>>> +The driver can set the \field{op_type} field in struct
>> virtio_crypto_sym_create_session_req
>>> +as follows: VIRTIO_CRYPTO_SYM_OP_NONE: no operation;
>> VIRTIO_CRYPTO_SYM_OP_CIPHER: Cipher only
>>> +operation on the data; VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING:
>> Chain any cipher with any hash
>>> +or mac operation.
>>> +
>> Based on the stuff written here, it ain't obvious to me at which offset does
>> the device writable part (that is virtio_crypto_session_input) start.
>>
> Why do we need to know the offset? IMO we only need to follow the spec arrangement to 
> fill the specific request packet will not be a problem, such as general header + out_data + in_data. 
> Driver first complete read-only part, then the writable part. The device then parses the 
> request packet this way. Why do we need to write this offset in the spec?
> 

We actually don't. That is just what I've said a couple of lines before.
But we do need to know at which offset the key is (or any other piece of
information within the device readable and the device writable part).

Maybe it was not smart from me to ask this question.

I understood this specification as if it were trying to describe a message
format as structs, which are basically supposed to define the offset of the
individual fields. So for a guy trying to figure out the spec (because he
wants to implement it) asking himself at what offset a certain piece
of info is, is natural IMHO.

I don't think the placement of virtio_crypto_session_input is adequately
described. Please point me to the fragment if I've missed it. IMHO a
straightforward way to describe it would be that virtio_crypto_session_input
starts at the data address designated by the first device writable descriptor.

Regards,
Halil

>> From your kernel code, it seems to me that it starts at offset 72 + keylen.
>>
>>
>> To sum it up I'm awfully dissatisfied. Maybe I made some mistake somewhere,
>> and that's why things don't make sense.
>>
>> I would really appreciate somebody else having a look, and telling:
>> is it possible to figure out the message formats and create an inter-operable
>> implementation based on this text (and without looking at the Linux/QEMU
>> code)?
>>
> Yes, we need some other comments about this.
> > Thanks,
> -Gonglei
