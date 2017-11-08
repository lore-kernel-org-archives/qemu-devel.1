Received: from eggs.gnu.org ([2001:4830:134:3::10]:59875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eCVCw-00022O-AT
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eCVCt-000708-47
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:36:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eCVCs-0006zk-M4
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:36:10 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8IZeTE005615
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 13:36:05 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e462cm6cb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 13:36:04 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 18:36:00 -0000
References: <1509951193-25256-1-git-send-email-longpeng2@huawei.com>
	<1509951193-25256-2-git-send-email-longpeng2@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 8 Nov 2017 19:35:53 +0100
MIME-Version: 1.0
In-Reply-To: <1509951193-25256-2-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9d566eaa-5ace-b136-904e-07f964a6a5e9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [v21 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, Gonglei <arei.gonglei@huawei.com>

[..]

On 11/06/2017 07:53 AM, Longpeng(Mike) wrote:
> +\subsection{Device Operation}\label{sec:Device Types / Crypto Device / Device Operation}
> +
> +The operation of a virtio crypto device is driven by requests placed on the virtqueues.
> +Requests consist of a queue-type specific header (specifying among others the operation)
> +and an operation specific payload. The payload is generally composed of operation
> +parameters, output data, and input data. Operation parameters are crypto-service-specific
> +parameters, output data is the data that should be utilized in operations, and input
> +data is equal to "operation result + result data".
> +
> +If VIRTIO_CRYPTO_F_MUX_MODE is negotioated the device may support both session mode

s/negotioated/negotiated/

> +(See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation})
> +and stateless mode operation requests.
> +In stateless mode all operation parameters are supplied as a part of each request,
> +while in session mode, some or all operation parameters are managed within the
> +session. Stateless mode is guarded by feature bits 0-4 on a service level. If
> +stateless mode is negotiated for a service, the service is available both in
> +session and stateless mode; otherwise it's only available in session mode.
> +
> +\subsubsection{Operation Status}\label{sec:Device Types / Crypto Device / Device Operation / Operation status}
> +The device MUST return a status code as part of the operation (both session
> +operation and service operation) result. The valid operation status as follows:
> +
> +\begin{lstlisting}
> +enum VIRTIO_CRYPTO_STATUS {
> +    VIRTIO_CRYPTO_OK = 0,
> +    VIRTIO_CRYPTO_ERR = 1,
> +    VIRTIO_CRYPTO_BADMSG = 2,
> +    VIRTIO_CRYPTO_NOTSUPP = 3,
> +    VIRTIO_CRYPTO_INVSESS = 4,
> +    VIRTIO_CRYPTO_NOSPC = 5,
> +    VIRTIO_CRYPTO_MAX
> +};
> +\end{lstlisting}
> +
> +\begin{itemize*}
> +\item VIRTIO_CRYPTO_OK: success.
> +\item VIRTIO_CRYPTO_BADMSG: authentication failed (only when AEAD decryption).
> +\item VIRTIO_CRYPTO_NOTSUPP: operation or algorithm is unsupported.
> +\item VIRTIO_CRYPTO_INVSESS: invalid session ID when executing crypto operations.
> +\item VIRTIO_CRYPTO_NOSPC: no free session ID (only when the VIRTIO_CRYPTO_F_MUX_MODE
> +    feature bit is negotiated).
> +\item VIRTIO_CRYPTO_ERR: any failure not mentioned above occurs.
> +\end{itemize*}
> +
> +\subsubsection{Control Virtqueue}\label{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue}
> +
> +The driver uses the control virtqueue to send control commands to the
> +device, such as session operations (See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}).
> +
> +The header for controlq is of the following form:
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
> +
> +struct virtio_crypto_ctrl_header {
> +#define VIRTIO_CRYPTO_CIPHER_CREATE_SESSION \
> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x02)
> +#define VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION \
> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x03)
> +#define VIRTIO_CRYPTO_HASH_CREATE_SESSION \
> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x02)
> +#define VIRTIO_CRYPTO_HASH_DESTROY_SESSION \
> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x03)
> +#define VIRTIO_CRYPTO_MAC_CREATE_SESSION \
> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x02)
> +#define VIRTIO_CRYPTO_MAC_DESTROY_SESSION \
> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x03)
> +#define VIRTIO_CRYPTO_AEAD_CREATE_SESSION \
> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
> +#define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
> +    le32 opcode;
> +    /* algo should be service-specific algorithms */
> +    le32 algo;
> +    le32 flag;
> +    le32 reserved;
> +};
> +\end{lstlisting}
> +
> +The controlq request is composed of two parts:
> +\begin{lstlisting}
> +struct virtio_crypto_op_ctrl_req {
> +    struct virtio_crypto_ctrl_header header;
> +
> +    /* additional paramenter */
> +    u8 additional_para[addl_para_len];

What does additional paramenter mean? Even if I s/paramenter/parameter
id doesn't sit well. To me and in this context additional is kind
of like optional: because each member of a struct is trivially additional
in respect to the previous members, and there is no point in pointing
out additional. I would much rather go with something like:
u8 op_specific[]

I also don't find the addl_para_len used anywhere. Then IMHO we don't
need to introduce a name.

> +};
> +\end{lstlisting}
> +
> +The first is a general header (see above). And the second one, additional
> +paramenter, contains an crypto-service-specific structure, which could be one

s/paramenter/parameter

It's actually opcode specific, or? Or is there a destroy service?

> +of the following types:
> +\begin{itemize*}
> +\item struct virtio_crypto_sym_create_session_req
> +\item struct virtio_crypto_hash_create_session_req
> +\item struct virtio_crypto_mac_create_session_req
> +\item struct virtio_crypto_aead_create_session_req
> +\item virtio_crypto_destroy_session_req
> +\end{itemize*}
> +
> +The size of the additional paramenter depends on the VIRTIO_CRYPTO_F_MUX_MODE

s/paramenter/parameter

> +feature bit:
> +\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is NOT negotiated, the
> +    size of additional paramenter is fixed to 56 bytes, the data of the unused

s/paramenter/parameter

> +    part (if has) will be ingored.

s/ingored/ignored


> +\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the size of
> +    additional paramenter is flexible, which is the same as the crypto-service-specific

s/paramenter/parameter

> +    structure used.
> +
> +\paragraph{Session operation}\label{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}
> +
> +The session is a handle which describes the cryptographic parameters to be
> +applied to a number of buffers.
> +
> +The following structure stores the result of session creation set by the device:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_session_input {
> +    /* Device-writable part */
> +    le64 session_id;
> +    le32 status;
> +    le32 padding;
> +};
> +\end{lstlisting}
> +
> +A request to destroy a session includes the following information:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_destroy_session_req {
> +    /* Device-readable part */
> +    le64  session_id;
> +    /* Device-writable part */
> +    le32  status;
> +    le32  padding;
> +};
> +\end{lstlisting}
> +
> +\subparagraph{Session operation: HASH session}\label{sec:Device Types / Crypto Device / Device
> +Operation / Control Virtqueue / Session operation / Session operation: HASH session}
> +

Let me skip to the one actually implemented.

> +HASH session requests are as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_hash_session_para {
> +    /* See VIRTIO_CRYPTO_HASH_* above */
> +    le32 algo;
> +    /* hash result length */
> +    le32 hash_result_len;
> +};
> +struct virtio_crypto_hash_create_session_req {
> +    /* Device-readable part */
> +    struct virtio_crypto_hash_session_para para;
> +    /* Device-writable part */
> +    struct virtio_crypto_session_input input;
> +};
> +\end{lstlisting}
> +
> +The information required by HASH session creation is stored in the
> +virtio_crypto_hash_create_session_req structure, including the hash
> +parameters stored in \field{para}. \field{input} stores the result of
> +this operation.
> +
> +\subparagraph{Session operation: MAC session}\label{sec:Device Types / Crypto Device / Device
> +Operation / Control Virtqueue / Session operation / Session operation: MAC session}
> +
> +MAC session requests are as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_mac_session_para {
> +    /* See VIRTIO_CRYPTO_MAC_* above */
> +    le32 algo;
> +    /* hash result length */
> +    le32 hash_result_len;
> +    /* length of authenticated key */
> +    le32 auth_key_len;
> +    le32 padding;
> +};
> +
> +struct virtio_crypto_mac_create_session_req {
> +    /* Device-readable part */
> +    struct virtio_crypto_mac_session_para para;
> +    /* The authenticated key */
> +    u8 auth_key[auth_key_len];
> +
> +    /* Device-writable part */
> +    struct virtio_crypto_session_input input;
> +};
> +\end{lstlisting}
> +
> +The information required by MAC session creation is stored in the
> +virtio_crypto_mac_create_session_req structure, including the mac
> +parameters stored in \field{para} and the authenticated key in \field{auth_key}.
> +\field{input} stores the result of this operation.
> +
> +\subparagraph{Session operation: Symmetric algorithms session}\label{sec:Device Types / Crypto Device / Device
> +Operation / Control Virtqueue / Session operation / Session operation: Symmetric algorithms session}

Here we are!

> +
> +The request of symmetric session includes two parts, CIPHER algorithms
> +and chain algorithms (chaining CIPHER and HASH/MAC).

This sounds like concatenation and not either-or.
> +
> +CIPHER session requests are as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_cipher_session_para {
> +    /* See VIRTIO_CRYPTO_CIPHER* above */
> +    le32 algo;
> +    /* length of key */
> +    le32 keylen;
> +#define VIRTIO_CRYPTO_OP_ENCRYPT  1
> +#define VIRTIO_CRYPTO_OP_DECRYPT  2
> +    /* encryption or decryption */
> +    le32 op;
> +    le32 padding;
> +};
> +
> +struct virtio_crypto_cipher_session_req {
> +    /* Device-readable part */
> +    struct virtio_crypto_cipher_session_para para;
> +    /* The cipher key */
> +    u8 cipher_key[keylen];
> +

Is there a limit to the size of chiper_key. I don't see one in your
kernel code. OTOH given that virtio_crypto_sym_create_session_req
is one flavor of virtio_crypto_op_ctrl_req.additional_para and that
the later is 56 bytes in case no mux mode is supported, I think
there must be a limit to the size of cipher_key!

Please explain!

Looking at the kernel code again, it seems to me that chiper_key
starts at offset 72 == sizeof(struct virtio_crypto_op_ctrl_req)
where struct virtio_crypto_op_ctrl_req is defined in
include/uapi/linux/virtio_crypto.h. That would mean that this
guy is *not a part of* virtio_crypto_op_ctrl_req but comes
after it and is of variable size.

> +    /* Device-writable part */


Now I'm interested on what 'offset' does the device writable
part start. 

Of course technically we don't need to know this, because we
have a device-read-only or device-write-only indication on each
descriptor. So virtio_crypto_session_input starts with the first
device write only descriptor.

> +    struct virtio_crypto_session_input input;
> +};
> +\end{lstlisting}
> +
> +Algorithm chaining requests are as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_alg_chain_session_para {
> +#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
> +#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
> +    le32 alg_chain_order;
> +/* Plain hash */
> +#define VIRTIO_CRYPTO_SYM_HASH_MODE_PLAIN    1
> +/* Authenticated hash (mac) */
> +#define VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH     2
> +/* Nested hash */
> +#define VIRTIO_CRYPTO_SYM_HASH_MODE_NESTED   3
> +    le32 hash_mode;
> +    struct virtio_crypto_cipher_session_para cipher_param;
> +
> +    /*
> +     * The additional_para is fixed to 16 bytes in length, it
> +     * contains a virtio_crypto_hash_session_para structure or
> +     * a virtio_crypto_mac_session_para structure and the data
> +     * of unused part (if has) will be ingored.
> +     */
> +#define VIRTIO_CRYPTO_ALG_CHAIN_SESS_PARA_SIZE  16
> +    u8 additional_para[VIRTIO_CRYPTO_ALG_CHAIN_SESS_PARA_SIZE];
> +
> +    /* length of the additional authenticated data (AAD) in bytes */
> +    le32 aad_len;
> +    le32 padding;
> +};
> +
> +struct virtio_crypto_alg_chain_session_req {
> +    /* Device-readable part */
> +    struct virtio_crypto_alg_chain_session_para para;
> +    /* The cipher key */
> +    u8 cipher_key[keylen];
> +    /* The authenticated key */
> +    u8 auth_key[auth_key_len];
> +
> +    /* Device-writable part */
> +    struct virtio_crypto_session_input input;
> +};
> +\end{lstlisting}
> +
> +Symmetric algorithm requests are as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_sym_create_session_req {
> +    /*
> +     * The additional_para is fixed to 48 bytes in length, it
> +     * contains a virtio_crypto_cipher_session_req structure or
> +     * a virtio_crypto_alg_chain_session_req structure and the
> +     * data of unused part (if has) will be ingored.
> +     */
> +#define VIRTIO_CRYPTO_SYM_CREATE_SESS_PARA_SIZE  48
> +    u8 additional_para[VIRTIO_CRYPTO_SYM_CREATE_SESS_PARA_SIZE];
> +
> +    /* Device-readable part */
> +
> +/* No operation */
> +#define VIRTIO_CRYPTO_SYM_OP_NONE  0
> +/* Cipher only operation on the data */
> +#define VIRTIO_CRYPTO_SYM_OP_CIPHER  1
> +/* Chain any cipher with any hash or mac operation. The order
> +   depends on the value of alg_chain_order param */
> +#define VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING  2
> +    le32 op_type;
> +    le32 padding;
> +};
> +\end{lstlisting}
> +
> +The information required by symmetric algorithms session creation is stored in the
> +virtio_crypto_sym_create_session_req structure, including the symmetric operation
> +type in \field{op_type} and the cipher parameters stored in \field{cipher} or the
> +algorithm chaining paramenters in \field{chain}.
> +
> +The driver can set the \field{op_type} field in struct virtio_crypto_sym_create_session_req
> +as follows: VIRTIO_CRYPTO_SYM_OP_NONE: no operation; VIRTIO_CRYPTO_SYM_OP_CIPHER: Cipher only
> +operation on the data; VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING: Chain any cipher with any hash
> +or mac operation.
> +

Based on the stuff written here, it ain't obvious to me at which offset does
the device writable part (that is virtio_crypto_session_input) start.

>From your kernel code, it seems to me that it starts at offset 72 + keylen.


To sum it up I'm awfully dissatisfied. Maybe I made some mistake somewhere,
and that's why things don't make sense.

I would really appreciate somebody else having a look, and telling:
is it possible to figure out the message formats and create an inter-operable
implementation based on this text (and without looking at the Linux/QEMU code)?


> +\subparagraph{Session operation: AEAD session}\label{sec:Device Types / Crypto Device / Device
> +Operation / Control Virtqueue / Session operation / Session operation: AEAD session}

Further review does not make sense at the moment. If it's just my train of thought
that got derailed, please put it back on the rails first.

Regards,
Halil

[..]
