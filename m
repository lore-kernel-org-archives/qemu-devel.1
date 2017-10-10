Received: from eggs.gnu.org ([2001:4830:134:3::10]:46536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1e1sYr-0007mU-3u
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1e1sYm-0006Ws-9z
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:18:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1e1sYl-0006VX-6c
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:18:52 -0400
Message-ID: <59DCAB16.1000006@huawei.com>
Date: Tue, 10 Oct 2017 19:12:22 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1506662648-55692-1-git-send-email-longpeng2@huawei.com>
	<1506662648-55692-2-git-send-email-longpeng2@huawei.com>
	<23e444c8-7f23-1021-552e-534153c149dd@linux.vnet.ibm.com>
In-Reply-To: <23e444c8-7f23-1021-552e-534153c149dd@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [v20 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, mst@redhat.com, xin.zeng@intel.com, jasowang@redhat.com, luonengjun@huawei.com, agraf@suse.de, john.griffin@intel.com, mike.caraman@nxp.com, arei.gonglei@huawei.com, liang.j.ma@intel.com, stefanha@redhat.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com, arei.gonglei@hotmail.com



On 2017/10/9 23:43, Halil Pasic wrote:

> 
> 
> On 09/29/2017 07:24 AM, Longpeng(Mike) wrote:
>> From: Gonglei <arei.gonglei@huawei.com>
>>
>> The virtio crypto device is a virtual crypto device (ie. hardware
>> crypto accelerator card). Currently, the virtio crypto device provides
>> the following crypto services: CIPHER, MAC, HASH, and AEAD.
>>
>> In this patch, CIPHER, MAC, HASH, AEAD services are introduced.
>>
>> VIRTIO-153
>>
>> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
> [..]
> 
> Continuing basically form where I left of last time to avoid the
> beginning getting lots of review and the end hardly any.
> 
>> +\subsubsection{Control Virtqueue}\label{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue}
>> +
>> +The driver uses the control virtqueue to send control commands to the
>> +device, such as session operations (See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}).
>> +
>> +The header for controlq is of the following form:
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
>> +
>> +struct virtio_crypto_ctrl_header {
>> +#define VIRTIO_CRYPTO_CIPHER_CREATE_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x02)
>> +#define VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x03)
>> +#define VIRTIO_CRYPTO_HASH_CREATE_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x02)
>> +#define VIRTIO_CRYPTO_HASH_DESTROY_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x03)
>> +#define VIRTIO_CRYPTO_MAC_CREATE_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x02)
>> +#define VIRTIO_CRYPTO_MAC_DESTROY_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x03)
>> +#define VIRTIO_CRYPTO_AEAD_CREATE_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
>> +#define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
>> +    le32 opcode;
>> +    /* algo should be service-specific algorithms */
>> +    le32 algo;
>> +    le32 flag;
>> +    /* reserved */
>> +    le32 queue_id;
> 
> AFAIR we agreed to drop queue_id. Call the variable something a reserved0,
> or whatever but not queue_id.
> 

Oh, yes. 'reserved0' is good enough.

>> +};
>> +\end{lstlisting}
>> +
>> +The format of the controlq request depends on the VIRTIO_CRYPTO_F_MUX_MODE feature bit:
>> +
>> +\begin{itemize*}
>> +\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is NOT negotiated the controlq request is
>> +    a fixed-size structure of form:
>> +\begin{lstlisting}
>> +struct virtio_crypto_op_ctrl_req {
>> +    struct virtio_crypto_ctrl_header header;
>> +
>> +    union {
>> +        struct virtio_crypto_sym_create_session_req   sym_create_session;
>> +        struct virtio_crypto_hash_create_session_req  hash_create_session;
>> +        struct virtio_crypto_mac_create_session_req   mac_create_session;
>> +        struct virtio_crypto_aead_create_session_req  aead_create_session;
>> +        struct virtio_crypto_destroy_session_req      destroy_session;
>> +    } u;
>> +};
> 
> 
> See my comment on your implementation RFC. I don't think we need to
> introduce these structs.
> 

Sorry, just virtio_crypto_op_ctrl_req only or all the structs above?

I agree with you that virtio_crypto_op_ctrl_req is unnecessary in the
implementation, however maybe it's needed in the spec because we just want to
use it to illustrate the control request format (please see my following reply).

> The only difference is that a certain portion needs to be padded to 56
> bytes in case of no-mux and that it does not in case of mux.
> 

Yes.

> Furthermore is (struct virtio_crypto_op_ctrl_req) this even correct?
> Please explain to me, how is an implementer of this specification
> supposed to know on which offset does the stuff corresponding to struct
> virtio_crypto_session_input start! Another such question is, what is the
> size of struct virtio_crypto_op_ctrl_req? (I think I've asked the later
> one several times, and I'm quite frustrated to do it again -- sorry
> if I'm wrong, I did not have time to dig trough my emails and verify my
> hypothesis).
> 
> IMHO whithout this information it's impossible to come up with an
> interoperable implementation -- and facilitating that is supposed to be
> the the main objective of this specification AFAIU.
> 
> The stuff in the linux header is unambiguous because it has a lot of
> padding specified which isn't specified here. On the other hand here we
> have the variable length arrays notation which very ambiguous, and simply
> does not do the job. Please feel encouraged to point out my mistake
> if I'm wrong in my assessments (happens quite often -- sadly)!
> 

Maybe I get your point now, thanks for your patient explanation. :)

So...how about (if we introduce struct virtio_crypto_op_ctrl_req in the spec)

struct virtio_crypto_op_ctrl_req {
    struct virtio_crypto_ctrl_header header;

#define VIRTIO_CRYPTO_CTRL_REQ_PARAM_SIZE_NONMUX 56
    /* additional paramenter */
    u8 additional_para[VIRTIO_CRYPTO_CTRL_REQ_PARAM_SIZE_NONMUX];
};

For mux mode, the request format is:
struct virtio_crypto_op_ctrl_req_mux {
    struct virtio_crypto_ctrl_header header;

    /* additional paramenter */
    u8 additional_para[addl_para_len];
};


If you have some better approaches, please let us know, thanks :)

> 
>> +\end{lstlisting}
>> +The header is the general header, and the union is of the algorithm-specific type or the
>> +virtio_crypto_destroy_session_req structure, which is set by the driver. All the properties
>> +in the union are shown as follows.
>> +
>> +\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated the controlq request is composed
>> +    of two parts, the additional paramenters are preceded by the general header.
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_op_ctrl_req_mux {
>> +    struct virtio_crypto_ctrl_header header;
>> +
>> +    /* additional paramenter */
>> +    u8 additional_para[addl_para_len];
>> +};
>> +\end{lstlisting}
>> +
>> +The additional paramenters are stored in a virtio_crypto_destroy_session_req structure or
>> +in a algorithm-specific structure:
>> +\begin{itemize*}
>> +\item struct virtio_crypto_sym_create_session_req
>> +\item struct virtio_crypto_hash_create_session_req
>> +\item struct virtio_crypto_mac_create_session_req
>> +\item struct virtio_crypto_aead_create_session_req
>> +\item struct virtio_crypto_destroy_session_req
>> +\end{itemize*}
>> +All of the structures above are shown as follows.
>> +\end{itemize*}
>> +
>> +\paragraph{Session operation}\label{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}
>> +
>> +The session is a
>> +handle which describes the cryptographic parameters to be applied to
>> +a number of buffers.
>> +
>> +The following structure stores the result of session creation set by the device:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_session_input {
>> +    /* Device-writable part */
>> +    le64 session_id;
>> +    le32 status;
>> +    le32 padding;
>> +};
>> +\end{lstlisting}
>> +
>> +A request to destroy a session includes the following information:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_destroy_session_req {
>> +    /* Device-readable part */
>> +    le64  session_id;
>> +    /* Device-writable part */
>> +    le32  status;
>> +    le32  padding;
>> +};
>> +\end{lstlisting}
>> +
>> +\subparagraph{Session operation: HASH session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: HASH session}
>> +
>> +HASH session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_hash_session_para {
>> +    /* See VIRTIO_CRYPTO_HASH_* above */
>> +    le32 algo;
>> +    /* hash result length */
>> +    le32 hash_result_len;
>> +};
>> +struct virtio_crypto_hash_create_session_req {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_hash_session_para para;
>> +    /* Device-writable part */
>> +    struct virtio_crypto_session_input input;
>> +};
>> +\end{lstlisting}
>> +
>> +The information required by HASH session creation is stored in the virtio_crypto_hash_create_session_req
>> +structure, including the hash parameters stored in \field{para}. \field{input} stores the result of this operation.
>> +
>> +\subparagraph{Session operation: MAC session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: MAC session}
>> +
>> +MAC session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_mac_session_para {
>> +    /* See VIRTIO_CRYPTO_MAC_* above */
>> +    le32 algo;
>> +    /* hash result length */
>> +    le32 hash_result_len;
>> +    /* length of authenticated key */
>> +    le32 auth_key_len;
>> +    le32 padding;
>> +};
>> +
>> +struct virtio_crypto_mac_create_session_req {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_mac_session_para para;
>> +    /* The authenticated key */
>> +    u8 auth_key[auth_key_len];
>> +
>> +    /* Device-writable part */
>> +    struct virtio_crypto_session_input input;
>> +};
>> +\end{lstlisting}
>> +
>> +The information required by MAC session creation is stored in the virtio_crypto_mac_create_session_req
>> +structure, including the mac parameters stored in \field{para} and the authenticated key in \field{auth_key}.
>> +\field{input} stores the result of this operation.
>> +
>> +\subparagraph{Session operation: Symmetric algorithms session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: Symmetric algorithms session}
>> +
>> +The request of symmetric session includes two parts, CIPHER algorithms and chain
>> +algorithms (chaining CIPHER and HASH/MAC).
>> +
>> +CIPHER session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_cipher_session_para {
>> +    /* See VIRTIO_CRYPTO_CIPHER* above */
>> +    le32 algo;
>> +    /* length of key */
>> +    le32 keylen;
>> +#define VIRTIO_CRYPTO_OP_ENCRYPT  1
>> +#define VIRTIO_CRYPTO_OP_DECRYPT  2
>> +    /* encryption or decryption */
>> +    le32 op;
>> +    le32 padding;
>> +};
>> +
>> +struct virtio_crypto_cipher_session_req {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_cipher_session_para para;
>> +    /* The cipher key */
>> +    u8 cipher_key[keylen];
>> +
>> +    /* Device-writable part */
>> +    struct virtio_crypto_session_input input;
>> +};
>> +\end{lstlisting}
>> +
>> +Algorithm chaining requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_alg_chain_session_para {
>> +#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
>> +#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
>> +    le32 alg_chain_order;
>> +/* Plain hash */
>> +#define VIRTIO_CRYPTO_SYM_HASH_MODE_PLAIN    1
>> +/* Authenticated hash (mac) */
>> +#define VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH     2
>> +/* Nested hash */
>> +#define VIRTIO_CRYPTO_SYM_HASH_MODE_NESTED   3
>> +    le32 hash_mode;
>> +    struct virtio_crypto_cipher_session_para cipher_param;
>> +    union {
>> +        struct virtio_crypto_hash_session_para hash_param;
>> +        struct virtio_crypto_mac_session_para mac_param;
>> +    } u;
>> +    /* length of the additional authenticated data (AAD) in bytes */
>> +    le32 aad_len;
>> +    le32 padding;
>> +};
>> +
>> +struct virtio_crypto_alg_chain_session_req {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_alg_chain_session_para para;
>> +    /* The cipher key */
>> +    u8 cipher_key[keylen];
>> +    /* The authenticated key */
>> +    u8 auth_key[auth_key_len];
>> +
>> +    /* Device-writable part */
>> +    struct virtio_crypto_session_input input;
>> +};
>> +\end{lstlisting}
>> +
>> +Symmetric algorithm requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_sym_create_session_req {
>> +    union {
>> +        struct virtio_crypto_cipher_session_req cipher;
>> +        struct virtio_crypto_alg_chain_session_req chain;
>> +    } u;
>> +
>> +    /* Device-readable part */
>> +
>> +/* No operation */
>> +#define VIRTIO_CRYPTO_SYM_OP_NONE  0
>> +/* Cipher only operation on the data */
>> +#define VIRTIO_CRYPTO_SYM_OP_CIPHER  1
>> +/* Chain any cipher with any hash or mac operation. The order
>> +   depends on the value of alg_chain_order param */
>> +#define VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING  2
>> +    le32 op_type;
>> +    le32 padding;
>> +};
>> +\end{lstlisting}
>> +
>> +The information required by symmetric algorithms session creation is stored in the
>> +virtio_crypto_sym_create_session_req structure, including the symmetric operation
>> +type in \field{op_type} and the cipher parameters stored in \field{cipher} or the
>> +algorithm chaining paramenters in \field{chain}.
>> +
>> +The driver can set the \field{op_type} field in struct virtio_crypto_sym_create_session_req
>> +as follows: VIRTIO_CRYPTO_SYM_OP_NONE: no operation; VIRTIO_CRYPTO_SYM_OP_CIPHER: Cipher only
>> +operation on the data; VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING: Chain any cipher with any hash
>> +or mac operation.
>> +
>> +\subparagraph{Session operation: AEAD session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: AEAD session}
>> +
>> +AEAD session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_aead_session_para {
>> +    /* See VIRTIO_CRYPTO_AEAD_* above */
>> +    le32 algo;
>> +    /* length of key */
>> +    le32 key_len;
>> +    /* Authentication tag length */
>> +    le32 tag_len;
>> +    /* The length of the additional authenticated data (AAD) in bytes */
>> +    le32 aad_len;
>> +    /* encryption or decryption, See above VIRTIO_CRYPTO_OP_* */
>> +    le32 op;
>> +    le32 padding;
>> +};
>> +
>> +struct virtio_crypto_aead_create_session_req {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_aead_session_para para;
>> +    u8 key[key_len];
>> +
>> +    /* Device-writeable part */
>> +    struct virtio_crypto_session_input input;
>> +};
>> +\end{lstlisting}
>> +
>> +The information required by AEAD session creation is stored in the virtio_crypto_aead_create_session_req
>> +structure, including the aead parameters stored in \field{para} and the cipher key in \field{key}.
>> +\field{input} stores the result of this operation.
>> +
>> +\drivernormative{\subparagraph}{Session operation: create session}{Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: create session}
>> +
>> +\begin{itemize*}
>> +\item The driver MUST set the control general header and the corresponding algorithm-specific structure.
>> +    See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue}.
>> +\item The driver MUST set the \field{opcode} field based on service type: CIPHER, HASH, MAC, or AEAD.
>> +\item The driver MUST set the \field{queue_id} field to zero.
>> +\end{itemize*}
>> +
>> +\devicenormative{\subparagraph}{Session operation: create session}{Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: create session}
>> +
>> +\begin{itemize*}
>> +\item The device MUST use the corresponding algorithm-specific structure according to the
>> +    \field{opcode} in the control general header.
>> +\item The device MUST set the \field{status} field to one of the following values of enum
>> +    VIRTIO_CRYPTO_STATUS after finish a session creation:
>> +\begin{itemize*}
>> +\item VIRTIO_CRYPTO_OK if a session is created successfully.
>> +\item VIRTIO_CRYPTO_NOTSUPP if the requested algorithm or operation is unsupported.
>> +\item VIRTIO_CRYPTO_NOSPC if no free session ID (only when the VIRTIO_CRYPTO_F_MUX_MODE
>> +    feature bit is negotiated).
>> +\item VIRTIO_CRYPTO_ERR if failure not mentioned above occurs.
>> +\end{itemize*}
>> +\item The device MUST set the \field{session_id} field to a unique session identifier only
>> +    if the status is set to VIRTIO_CRYPTO_OK.
>> +\end{itemize*}
>> +
>> +\drivernormative{\subparagraph}{Session operation: destroy session}{Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: destroy session}
>> +
>> +\begin{itemize*}
>> +\item The driver MUST set the \field{opcode} field based on service type: CIPHER, HASH, MAC, or AEAD.
>> +\item The driver MUST set the \field{session_id} to a valid value assigned by the device
>> +    when the session was created.
>> +\end{itemize*}
>> +
>> +\devicenormative{\subparagraph}{Session operation: destroy session}{Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: destroy session}
>> +
>> +\begin{itemize*}
>> +\item The device MUST set the \field{status} field to one of the following values of enum VIRTIO_CRYPTO_STATUS.
>> +\begin{itemize*}
>> +\item VIRTIO_CRYPTO_OK if a session is created successfully.
>> +\item VIRTIO_CRYPTO_ERR if any failure occurs.
>> +\end{itemize*}
>> +\end{itemize*}
>> +
> 
> I don't think further discussion makes any sense until the questions I've
> asked are clarified. Looking forward to your reply!
> 
> 
> Halil
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
