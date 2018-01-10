Received: from eggs.gnu.org ([2001:4830:134:3::10]:48393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eZ9Ka-0006Sx-Gn
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eZ9KV-0005Pq-Ft
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:53:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2063 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1eZ9KT-0005OR-Sd
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:53:39 -0500
Message-ID: <5A55AA45.9090004@huawei.com>
Date: Wed, 10 Jan 2018 13:53:09 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
	<1514626559-162312-2-git-send-email-longpeng2@huawei.com>
	<fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
In-Reply-To: <fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [v23 1/2] virtio-crypto: Add virtio crypto device
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
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com

Hi Halil,

We are fixing the Intel BUG these days, so I will go through your comments after
we're done. Thanks.

-- 
Regards,
Longpeng(Mike)

On 2018/1/10 1:05, Halil Pasic wrote:

> 
> 
> On 12/30/2017 10:35 AM, Longpeng(Mike) wrote:
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
>> Signed-off-by: Zhoujian <jianjay.zhou@huawei.com>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
>>  acknowledgements.tex |    4 +
>>  content.tex          |    2 +
>>  virtio-crypto.tex    | 1525 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 1531 insertions(+)
>>  create mode 100644 virtio-crypto.tex
>>
>> diff --git a/acknowledgements.tex b/acknowledgements.tex
>> index 2d893d9..cdde247 100644
>> --- a/acknowledgements.tex
>> +++ b/acknowledgements.tex
>> @@ -16,10 +16,13 @@ Daniel Kiper,	Oracle	\newline
>>  Geoff Brown,	Machine-to-Machine Intelligence (M2MI) Corporation	\newline
>>  Gershon Janssen,	Individual Member	\newline
>>  James Bottomley,	Parallels IP Holdings GmbH	\newline
>> +Jian Zhou,	Huawei	\newline
>> +Lei Gong,	Huawei	\newline
>>  Luiz Capitulino,	Red Hat	\newline
>>  Michael S. Tsirkin,	Red Hat	\newline
>>  Paolo Bonzini,	Red Hat	\newline
>>  Pawel Moll,	ARM \newline
>> +Peng Long,	Huawei	\newline
>>  Richard Sohn,	Alcatel-Lucent \newline
>>  Rusty Russell,	IBM	\newline
>>  Sasha Levin,	Oracle	\newline
>> @@ -38,6 +41,7 @@ Brian Foley,  ARM \newline
>>  David Alan Gilbert, Red Hat \newline
>>  Fam Zheng, Red Hat	\newline
>>  Gerd Hoffmann, Red Hat	\newline
>> +Halil Pasic,	IBM	\newline
>>  Jason Wang, Red Hat \newline
>>  Laura Novich, Red Hat	\newline
>>  Patrick Durusau,	Technical Advisory Board, OASIS	\newline
>> diff --git a/content.tex b/content.tex
>> index c840588..d1d3b09 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -5819,6 +5819,8 @@ descriptor for the \field{sense_len}, \field{residual},
>>  \field{status_qualifier}, \field{status}, \field{response} and
>>  \field{sense} fields.
>>
>> +\input{virtio-crypto.tex}
>> +
>>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>
>>  Currently these device-independent feature bits defined:
>> diff --git a/virtio-crypto.tex b/virtio-crypto.tex
>> new file mode 100644
>> index 0000000..4bd5b51
>> --- /dev/null
>> +++ b/virtio-crypto.tex
>> @@ -0,0 +1,1525 @@
>> +\section{Crypto Device}\label{sec:Device Types / Crypto Device}
>> +
>> +The virtio crypto device is a virtual cryptography device as well as a
>> +virtual cryptographic accelerator. The virtio crypto device provides the
>> +following crypto services: CIPHER, MAC, HASH, and AEAD. Virtio crypto
>> +devices have a single control queue and at least one data queue. Crypto
>> +operation requests are placed into a data queue, and serviced by the
>> +device. Some crypto operation requests are only valid in the context of a
>> +session. The role of the control queue is facilitating control operation
>> +requests. Sessions management is realized with control operation
>> +requests.
>> +
>> +\subsection{Device ID}\label{sec:Device Types / Crypto Device / Device ID}
>> +
>> +20
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / Crypto Device / Virtqueues}
>> +
>> +\begin{description}
>> +\item[0] dataq1
>> +\item[\ldots]
>> +\item[N-1] dataqN
>> +\item[N] controlq
>> +\end{description}
>> +
>> +N is set by \field{max_dataqueues}.
>> +
>> +\subsection{Feature bits}\label{sec:Device Types / Crypto Device / Feature bits}
>> +
>> +\begin{description}
>> +\item VIRTIO_CRYPTO_F_REVISION_1 (0) revision 1. Revision 1 has a specific
>> +    request format and other enhancements (which result in some additional
>> +    requirements).
>> +\item VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE (1) stateless mode requests are
>> +    supported by the CIPHER service.
>> +\item VIRTIO_CRYPTO_F_HASH_STATELESS_MODE (2) stateless mode requests are
>> +    supported by the HASH service.
>> +\item VIRTIO_CRYPTO_F_MAC_STATELESS_MODE (3) stateless mode requests are
>> +    supported by the MAC service.
>> +\item VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE (4) stateless mode requests are
>> +    supported by the AEAD service.
>> +\end{description}
>> +
>> +
>> +\subsubsection{Feature bit requirements}\label{sec:Device Types / Crypto Device / Feature bits}
>> +
>> +Some crypto feature bits require other crypto feature bits
>> +(see \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}):
>> +
>> +\begin{description}
>> +\item[VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_REVISION_1.
>> +\item[VIRTIO_CRYPTO_F_HASH_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_REVISION_1.
>> +\item[VIRTIO_CRYPTO_F_MAC_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_REVISION_1.
>> +\item[VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_REVISION_1.
>> +\end{description}
>> +
>> +\subsection{Supported crypto services}\label{sec:Device Types / Crypto Device / Supported crypto services}
>> +
>> +The following crypto services are defined:
>> +
>> +\begin{lstlisting}
>> +/* CIPHER service */
>> +#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
>> +/* HASH service */
>> +#define VIRTIO_CRYPTO_SERVICE_HASH   1
>> +/* MAC (Message Authentication Codes) service */
>> +#define VIRTIO_CRYPTO_SERVICE_MAC    2
>> +/* AEAD (Authenticated Encryption with Associated Data) service */
>> +#define VIRTIO_CRYPTO_SERVICE_AEAD   3
>> +\end{lstlisting}
>> +
>> +The above constants designate bits used to indicate the which of crypto services are
>> +offered by the device as described in, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
>> +
>> +\subsubsection{CIPHER services}\label{sec:Device Types / Crypto Device / Supported crypto services / CIPHER services}
>> +
>> +The following CIPHER algorithms are defined:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_NO_CIPHER                 0
>> +#define VIRTIO_CRYPTO_CIPHER_ARC4               1
>> +#define VIRTIO_CRYPTO_CIPHER_AES_ECB            2
>> +#define VIRTIO_CRYPTO_CIPHER_AES_CBC            3
>> +#define VIRTIO_CRYPTO_CIPHER_AES_CTR            4
>> +#define VIRTIO_CRYPTO_CIPHER_DES_ECB            5
>> +#define VIRTIO_CRYPTO_CIPHER_DES_CBC            6
>> +#define VIRTIO_CRYPTO_CIPHER_3DES_ECB           7
>> +#define VIRTIO_CRYPTO_CIPHER_3DES_CBC           8
>> +#define VIRTIO_CRYPTO_CIPHER_3DES_CTR           9
>> +#define VIRTIO_CRYPTO_CIPHER_KASUMI_F8          10
>> +#define VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2        11
>> +#define VIRTIO_CRYPTO_CIPHER_AES_F8             12
>> +#define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
>> +#define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
>> +\end{lstlisting}
>> +
>> +The above constants have two usages:
>> +\begin{enumerate}
>> +\item As bit numbers, used to tell the driver which CIPHER algorithms
>> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
>> +\item As values, used to designate the algorithm in (CIPHER type) crypto
>> +operation requests, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
>> +\end{enumerate}
>> +
>> +\subsubsection{HASH services}\label{sec:Device Types / Crypto Device / Supported crypto services / HASH services}
>> +
>> +The following HASH algorithms are defined:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_NO_HASH            0
>> +#define VIRTIO_CRYPTO_HASH_MD5           1
>> +#define VIRTIO_CRYPTO_HASH_SHA1          2
>> +#define VIRTIO_CRYPTO_HASH_SHA_224       3
>> +#define VIRTIO_CRYPTO_HASH_SHA_256       4
>> +#define VIRTIO_CRYPTO_HASH_SHA_384       5
>> +#define VIRTIO_CRYPTO_HASH_SHA_512       6
>> +#define VIRTIO_CRYPTO_HASH_SHA3_224      7
>> +#define VIRTIO_CRYPTO_HASH_SHA3_256      8
>> +#define VIRTIO_CRYPTO_HASH_SHA3_384      9
>> +#define VIRTIO_CRYPTO_HASH_SHA3_512      10
>> +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE128      11
>> +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE256      12
>> +\end{lstlisting}
>> +
>> +The above constants have two usages:
>> +\begin{enumerate}
>> +\item As bit numbers, used to tell the driver which HASH algorithms
>> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
>> +\item As values, used to designate the algorithm in (HASH type) crypto
>> +operation requires, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
>> +\end{enumerate}
>> +
>> +\subsubsection{MAC services}\label{sec:Device Types / Crypto Device / Supported crypto services / MAC services}
>> +
>> +The following MAC algorithms are defined:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_NO_MAC                       0
>> +#define VIRTIO_CRYPTO_MAC_HMAC_MD5                 1
>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA1                2
>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_224             3
>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_256             4
>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_384             5
>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_512             6
>> +#define VIRTIO_CRYPTO_MAC_CMAC_3DES                25
>> +#define VIRTIO_CRYPTO_MAC_CMAC_AES                 26
>> +#define VIRTIO_CRYPTO_MAC_KASUMI_F9                27
>> +#define VIRTIO_CRYPTO_MAC_SNOW3G_UIA2              28
>> +#define VIRTIO_CRYPTO_MAC_GMAC_AES                 41
>> +#define VIRTIO_CRYPTO_MAC_GMAC_TWOFISH             42
>> +#define VIRTIO_CRYPTO_MAC_CBCMAC_AES               49
>> +#define VIRTIO_CRYPTO_MAC_CBCMAC_KASUMI_F9         50
>> +#define VIRTIO_CRYPTO_MAC_XCBC_AES                 53
>> +#define VIRTIO_CRYPTO_MAC_ZUC_EIA3                 54
>> +\end{lstlisting}
>> +
>> +The above constants have two usages:
>> +\begin{enumerate}
>> +\item As bit numbers, used to tell the driver which MAC algorithms
>> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
>> +\item As values, used to designate the algorithm in (MAC type) crypto
>> +operation requests, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
>> +\end{enumerate}
>> +
>> +\subsubsection{AEAD services}\label{sec:Device Types / Crypto Device / Supported crypto services / AEAD services}
>> +
>> +The following AEAD algorithms are defined:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_NO_AEAD     0
>> +#define VIRTIO_CRYPTO_AEAD_GCM    1
>> +#define VIRTIO_CRYPTO_AEAD_CCM    2
>> +#define VIRTIO_CRYPTO_AEAD_CHACHA20_POLY1305  3
>> +\end{lstlisting}
>> +
>> +The above constants have two usages:
>> +\begin{enumerate}
>> +\item As bit numbers, used to tell the driver which AEAD algorithms
>> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
>> +\item As values, used to designate the algorithm in (DEAD type) crypto
>> +operation requests, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
>> +\end{enumerate}
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / Crypto Device / Device configuration layout}
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_config {
>> +    le32 status;
>> +    le32 max_dataqueues;
>> +    le32 crypto_services;
>> +    /* Detailed algorithms mask */
>> +    le32 cipher_algo_l;
>> +    le32 cipher_algo_h;
>> +    le32 hash_algo;
>> +    le32 mac_algo_l;
>> +    le32 mac_algo_h;
>> +    le32 aead_algo;
>> +    /* Maximum length of cipher key in bytes */
>> +    le32 max_cipher_key_len;
>> +    /* Maximum length of authenticated key in bytes */
>> +    le32 max_auth_key_len;
>> +    le32 reserved;
>> +    /* Maximum size of each crypto request's content in bytes */
>> +    le64 max_size;
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{description}
>> +\item Currently, only one \field(status) bit is defined: VIRTIO_CRYPTO_S_HW_READY
>> +    set indicates that the device is ready to process requests, this bit is read-only
>> +    for the driver
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
>> +\end{lstlisting}
>> +
>> +\item[\field{max_dataqueues}] is the maximum number of data virtqueues that can
>> +    be configured by the device. The driver MAY use only one data queue, or it
>> +    can use more to achieve better performance.
>> +
>> +\item[\field{crypto_services}] crypto service offered, see \ref{sec:Device Types / Crypto Device / Supported crypto services}.
>> +
>> +\item[\field{cipher_algo_l}] CIPHER algorithms bits 0-31, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / CIPHER services}.
>> +
>> +\item[\field{cipher_algo_h}] CIPHER algorithms bits 32-63, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / CIPHER services}.
>> +
>> +\item[\field{hash_algo}] HASH algorithms bits, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / HASH services}.
>> +
>> +\item[\field{mac_algo_l}] MAC algorithms bits 0-31, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / MAC services}.
>> +
>> +\item[\field{mac_algo_h}] MAC algorithms bits 32-63, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / MAC services}.
>> +
>> +\item[\field{aead_algo}] AEAD algorithms bits, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / AEAD services}.
>> +
>> +\item[\field{max_cipher_key_len}] is the maximum length of cipher key supported by the device.
> 
> I can't find what happens if this limit isn't honored by the driver. Moreover
> reading it is only SHOULD. Is it undefined behavior or should the device reject/fail
> such requests? I think in qemu implementation we fail the request.
> 
> This question is only about niceness. We are already good enough, IMHO:
> since the implementer of the driver can't be sure what is going to happen
> if the driver disregards max_cipher_key_len it is already an implicit
> SHOULD.
> 
>> +
>> +\item[\field{max_auth_key_len}] is the maximum length of authenticated key supported by the device.
> 
> Same here.
> 
>> +
>> +\item[\field{reserved}] is reserved for future use.
>> +
>> +\item[\field{max_size}] is the maximum size of each crypto request's content supported by the device
> 
> s/device/device.
> 
> What a content of a request and how is its size calculated? Where is this defined.
> 
> The question what happens if not honored applies similarly.
> 
>> +\end{description}
>> +
>> +\begin{note}
>> +Unless explicitly stated otherwise all lengths and sizes are in bytes.
>> +\end{note}
>> +
>> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
>> +
>> +\begin{itemize*}
>> +\item The device MUST set \field{max_dataqueues} to between 1 and 65535 inclusive.
>> +\item The device MUST set the \field{status} with valid flags, undefined flags MUST NOT be set.
>> +\item The device MUST accept and handle requests after \field{status} is set to VIRTIO_CRYPTO_S_HW_READY.
>> +\item The device MUST set \field{crypto_services} based on the crypto services the device offers.
>> +\item The device MUST set detailed algorithms masks for each service advertised by \field{crypto_services}.
>> +    The device MUST NOT set the not defined algorithms bits.
>> +\item The device MUST set \field{max_size} to show the maximum size of crypto request the device supports.
>> +\item The device MUST set \field{max_cipher_key_len} to show the maximum length of cipher key if the
>> +    device supports CIPHER service.
>> +\item The device MUST set \field{max_auth_key_len} to show the maximum length of authenticated key if
>> +    the device supports MAC service.
>> +\end{itemize*}
>> +
>> +\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
>> +
>> +\begin{itemize*}
>> +\item The driver MUST read the \field{status} from the bottom bit of status to check whether the
>> +    VIRTIO_CRYPTO_S_HW_READY is set, and the driver MUST reread it after device reset.
>> +\item The driver MUST NOT transmit any requests to the device if the VIRTIO_CRYPTO_S_HW_READY is not set.
>> +\item The driver MUST read \field{max_dataqueues} field to discover the number of data queues the device supports.
>> +\item The driver MUST read \field{crypto_services} field to discover which services the device is able to offer.
>> +\item The driver SHOULD ignore the not defined algorithms bits.
>> +\item The driver MUST read the detailed algorithms fields based on \field{crypto_services} field.
>> +\item The driver SHOULD read \field{max_size} to discover the maximum size of crypto request the device supports.
>> +\item The driver SHOULD read \field{max_cipher_key_len} to discover the maximum length of cipher key
>> +    the device supports.
>> +\item The driver SHOULD read \field{max_auth_key_len} to discover the maximum length of authenticated
>> +    key the device supports.
>> +\end{itemize*}
> 
> Seems to like a common practice in the virtio spec to say SHOULD read some
> config space parameter in a driver normative but then having no driver normative
> about the operational implications of the parameter.
> 
> While I do think that the reader is usually fully capable of inferring
> the operational requirement, I find it a bit strange: having the operational
> stuff explicit (and possibly needs to be read from the config space implicit)
> seems more straight forward to me.
> 
> Anyway, you are consistent with the rest of the spec, so prefer keeping it
> like this.
> 
>  
>> +
>> +\subsection{Device Initialization}\label{sec:Device Types / Crypto Device / Device Initialization}
>> +
>> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / Crypto Device / Device Initialization}
>> +
>> +\begin{itemize*}
>> +\item The driver MUST configure and initialize all virtqueues.
>> +\item The driver MUST read the supported crypto services from bits of \field{crypto_services}.
>> +\item The driver MUST read the supported algorithms based on \field{crypto_services} field.
>> +\end{itemize*}
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / Crypto Device / Device Operation}
>> +
>> +The operation of a virtio crypto device is driven by requests placed on the virtqueues.
>> +Requests consist of a queue-type specific header (specifying among others the operation)
>> +and an operation specific payload.
>> +
>> +If VIRTIO_CRYPTO_F_REVISION_1 is negotiated the device may support both session mode
>> +(See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation})
>> +and stateless mode operation requests.
>> +In stateless mode all operation parameters are supplied as a part of each request,
>> +while in session mode, some or all operation parameters are managed within the
>> +session. Stateless mode is guarded by feature bits 0-4 on a service level. If
>> +stateless mode is negotiated for a service, the service is available both in
>> +session and stateless mode; otherwise it's only available in session mode.
> 
> How about the following?
> 
> """
> If stateless mode is negotiated for a service, the service accepts both session  mode and stateless
> requests; otherwise stateless mode requests are rejected (via operation status).
> """
> 
> I prefer it because i think it makes clearer than session mode and stateless
> mode are concepts that apply on  request and not on service (or let's say queue)
> level.
> 
>> +
>> +\subsubsection{Operation Status}\label{sec:Device Types / Crypto Device / Device Operation / Operation status}
>> +The device MUST return a status code as part of the operation (both session
>> +operation and service operation) result. The valid operation status as follows:
>> +
>> +\begin{lstlisting}
>> +enum VIRTIO_CRYPTO_STATUS {
>> +    VIRTIO_CRYPTO_OK = 0,
>> +    VIRTIO_CRYPTO_ERR = 1,
>> +    VIRTIO_CRYPTO_BADMSG = 2,
>> +    VIRTIO_CRYPTO_NOTSUPP = 3,
>> +    VIRTIO_CRYPTO_INVSESS = 4,
>> +    VIRTIO_CRYPTO_NOSPC = 5,
>> +    VIRTIO_CRYPTO_MAX
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{itemize*}
>> +\item VIRTIO_CRYPTO_OK: success.
>> +\item VIRTIO_CRYPTO_BADMSG: authentication failed (only when AEAD decryption).
>> +\item VIRTIO_CRYPTO_NOTSUPP: operation or algorithm is unsupported.
>> +\item VIRTIO_CRYPTO_INVSESS: invalid session ID when executing crypto operations.
>> +\item VIRTIO_CRYPTO_NOSPC: no free session ID (only when the VIRTIO_CRYPTO_F_REVISION_1
>> +    feature bit is negotiated).
>> +\item VIRTIO_CRYPTO_ERR: any failure not mentioned above occurs.
>> +\end{itemize*}
>> +
> 
> Just thinking loud: We don't seem to be able to differentiate between device
> detected a driver (guest) bug, and something went wrong with the backend.
> I'm not sure differentiating between the two is useful in the first place.
> 
>> +\subsubsection{Control Virtqueue}\label{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue}
>> +
>> +The driver uses the control virtqueue to send control commands to the
>> +device, such as session operations (See \ref{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation}).
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
>> +    le32 reserved;
>> +};
>> +\end{lstlisting}
>> +
>> +The controlq request is composed of four parts:
>> +\begin{lstlisting}
>> +struct virtio_crypto_op_ctrl_req {
>> +    /* Device read only portion */
>> +
>> +    struct virtio_crypto_ctrl_header header;
>> +
>> +#define VIRTIO_CRYPTO_CTRLQ_OP_SPEC_HDR_LEGACY 56
>> +    /* fixed length fields, opcode specific */
>> +    u8 op_flf[flf_len];
>> +
>> +    /* variable length fields, opcode specific */
>> +    u8 op_vlf[vlf_len];
>> +
>> +    /* Device write only portion */
>> +
>> +    /* op result or completion status */
>> +    u8 op_outcome[outcome_len];
>> +};
>> +\end{lstlisting}
>> +
>> +\field{header} is a general header (see above).
>> +
>> +\field{op_flf} is the opcode (in \field{header}) specific fixed-length paramenters.
>> +
>> +\field{flf_len} depends on the VIRTIO_CRYPTO_F_REVISION_1 feature bit (see below).
>> +
>> +\field{op_vlf} is the opcode (in \field{header}) specific variable-length paramenters.
>> +
>> +\field{vlf_len} is the size of the specific structure used.
>> +\begin{note}
>> +The \field{vlf_len} of session-destroy operation and the hash-session-create
>> +operation is ZERO.
>> +\end{note}
>> +
>> +\begin{itemize*}
>> +\item If the opcode (in \field{header}) is VIRTIO_CRYPTO_CIPHER_CREATE_SESSION
>> +    then \field{op_flf} is struct virtio_crypto_sym_create_session_flf if
>> +    VIRTIO_CRYPTO_F_REVISION_1 is negotiated and struct virtio_crypto_sym_create_session_flf if
>> +    padded to 56 bytes if NOT negotiated, and \field{op_vlf} is struct
>> +    virtio_crypto_sym_create_session_vlf.
>> +\item If the opcode (in \field{header}) is VIRTIO_CRYPTO_HASH_CREATE_SESSION
>> +    then \field{op_flf} is struct virtio_crypto_hash_create_session_flf if
>> +    VIRTIO_CRYPTO_F_REVISION_1 is negotiated and struct virtio_crypto_hash_create_session_flf if
>> +    padded to 56 bytes if NOT negotiated.
>> +\item If the opcode (in \field{header}) is VIRTIO_CRYPTO_MAC_CREATE_SESSION
>> +    then \field{op_flf} is struct virtio_crypto_mac_create_session_flf if
>> +    VIRTIO_CRYPTO_F_REVISION_1 is negotiated and struct virtio_crypto_mac_create_session_flf if
>> +    padded to 56 bytes if NOT negotiated, and \field{op_vlf} is struct
>> +    virtio_crypto_mac_create_session_vlf.
>> +\end{itemize*}
>> +\item If the opcode (in \field{header}) is VIRTIO_CRYPTO_AEAD_CREATE_SESSION
>> +    then \field{op_flf} is struct virtio_crypto_aead_create_session_flf if
>> +    VIRTIO_CRYPTO_F_REVISION_1 is negotiated and struct virtio_crypto_aead_create_session_flf if
>> +    padded to 56 bytes if NOT negotiated, and \field{op_vlf} is struct
>> +    virtio_crypto_aead_create_session_vlf.
>> +\item If the opcode (in \field{header}) is VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION
>> +    or VIRTIO_CRYPTO_HASH_DESTROY_SESSION or VIRTIO_CRYPTO_MAC_DESTROY_SESSION or
>> +    VIRTIO_CRYPTO_AEAD_DESTROY_SESSION then \field{op_flf} is struct
>> +    virtio_crypto_destroy_session_flf if VIRTIO_CRYPTO_F_REVISION_1 is negotiated and
>> +    struct virtio_crypto_destroy_session_flf if padded to 56 bytes if NOT negotiated.
>> +\end{itemize*}
>> +
>> +\field{op_outcome} stores the result of operation and must be struct
>> +virtio_crypto_destroy_session_input for session-destroy operation or
>> +struct virtio_crypto_session_input.
>> +
>> +\field{outcome_len} is the size of the structure used.
>> +
>> +
>> +\paragraph{Session operation}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation}
>> +
>> +The session is a handle which describes the cryptographic parameters to be
>> +applied to a number of buffers.
>> +
>> +The following structure stores the result of session creation set by the device:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_session_input {
>> +    /* Device write only portion */
> 
> I think you cann drop this comment along with the following similar
> comments. We have already told whats device read only and what is
> device write only in virtio_crypto_op_ctrl_req.
> 
> Restating it at each struct is redundant and IMHO just confusing. The
> R/W is determined by where does the struct sit in the request. 
> 
>> +    le64 session_id;
>> +    le32 status;
>> +    le32 padding;
>> +};
>> +\end{lstlisting}
>> +
>> +A request to destroy a session includes the following information:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_destroy_session_flf {
>> +    /* Device read only portion */
>> +    le64  session_id;
>> +};
>> +
>> +struct virtio_crypto_destroy_session_input {
>> +    /* Device write only portion */
>> +    le32  status;
>> +    le32  padding;
>> +};
>> +\end{lstlisting}
>> +
>> +
>> +\subparagraph{Session operation: HASH session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: HASH session}
>> +
>> +The fixed-length paramenters of HASH session requests is as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_hash_create_session_flf {
>> +    /* Device read only portion */
>> +
>> +    /* See VIRTIO_CRYPTO_HASH_* above */
>> +    le32 algo;
>> +    /* hash result length */
>> +    le32 hash_result_len;
>> +};
>> +\end{lstlisting}
>> +
>> +
>> +\subparagraph{Session operation: MAC session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: MAC session}
>> +
>> +The fixed-length and the variable-length parameters of MAC session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_mac_create_session_flf {
>> +    /* Device read only portion */
>> +
>> +    /* See VIRTIO_CRYPTO_MAC_* above */
>> +    le32 algo;
>> +    /* hash result length */
>> +    le32 hash_result_len;
>> +    /* length of authenticated key */
>> +    le32 auth_key_len;
>> +    le32 padding;
>> +};
>> +
>> +struct virtio_crypto_mac_create_session_vlf {
>> +    /* Device read only portion */
>> +
>> +    /* The authenticated key */
>> +    u8 auth_key[auth_key_len];
>> +};
>> +\end{lstlisting}
>> +
>> +The length of \field{auth_key} is specified in \field{auth_key_len} in the struct
>> +virtio_crypto_mac_create_session_flf.
>> +
>> +
>> +\subparagraph{Session operation: Symmetric algorithms session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: Symmetric algorithms session}
>> +
>> +The request of symmetric session could be the CIPHER algorithms request
>> +or the chain algorithms (chaining CIPHER and HASH/MAC) request.
>> +
>> +The fixed-length and the variable-length parameters of CIPHER session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_cipher_session_flf {
>> +    /* Device read only portion */
>> +
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
>> +struct virtio_crypto_cipher_session_vlf {
>> +    /* Device read only portion */
>> +
>> +    /* The cipher key */
>> +    u8 cipher_key[keylen];
>> +};
>> +\end{lstlisting}
>> +
>> +The length of \field{cipher_key} is specified in \field{keylen} in the struct
>> +virtio_crypto_cipher_session_flf.
>> +
>> +The fixed-length and the variable-length parameters of Chain session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_alg_chain_session_flf {
>> +    /* Device read only portion */
>> +
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
>> +    struct virtio_crypto_cipher_session_flf cipher_hdr;
>> +
>> +#define VIRTIO_CRYPTO_ALG_CHAIN_SESS_OP_SPEC_HDR_SIZE  16
>> +    /* fixed length fields, algo specific */
>> +    u8 algo_flf[VIRTIO_CRYPTO_ALG_CHAIN_SESS_OP_SPEC_HDR_SIZE];
>> +
>> +    /* length of the additional authenticated data (AAD) in bytes */
>> +    le32 aad_len;
>> +    le32 padding;
>> +};
>> +
>> +struct virtio_crypto_alg_chain_session_vlf {
>> +    /* Device read only portion */
>> +
>> +    /* The cipher key */
>> +    u8 cipher_key[keylen];
>> +    /* The authenticated key */
>> +    u8 auth_key[auth_key_len];
>> +};
>> +\end{lstlisting}
>> +
>> +\field{hash_mode} decides the type used by \field{algo_flf}.
>> +
>> +\field{algo_flf} is fixed to 16 bytes and MUST contains or be one of
>> +the following types:
>> +\begin{itemize*}
>> +\item struct virtio_crypto_hash_create_session_flf
>> +\item struct virtio_crypto_mac_create_session_flf
>> +\end{itemize*}
>> +The data of unused part (if has) in \field{algo_flf} will be ignored.
>> +
>> +The length of \field{cipher_key} is specified in \field{keylen} in \field{cipher_hdr}.
>> +
>> +The length of \field{auth_key} is specified in \field{auth_key_len} in struct
>> +virtio_crypto_mac_create_session_flf.
>> +
>> +The fixed-length parameters of Symmetric session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_sym_create_session_flf {
>> +    /* Device read only portion */
>> +
>> +#define VIRTIO_CRYPTO_SYM_SESS_OP_SPEC_HDR_SIZE  48
>> +    /* fixed length fields, opcode specific */
>> +    u8 op_flf[VIRTIO_CRYPTO_SYM_SESS_OP_SPEC_HDR_SIZE];
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
>> +\field{op_flf} is fixed to 48 bytes, MUST contains or be one of
>> +the following types:
>> +\begin{itemize*}
>> +\item struct virtio_crypto_cipher_session_flf
>> +\item struct virtio_crypto_alg_chain_session_flf
>> +\end{itemize*}
>> +The data of unused part (if has) in \field{op_flf} will be ignored.
>> +
>> +\field{op_type} decides the type used by \field{op_flf}.
>> +
>> +The variable-length parameters of Symmetric session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_sym_create_session_vlf {
>> +    /* Device read only portion */
>> +    /* variable length fields, opcode specific */
>> +    u8 op_vlf[vlf_len];
>> +};
>> +\end{lstlisting}
>> +
>> +\field{op_vlf} MUST contains or be one of the following types:
>> +\begin{itemize*}
>> +\item struct virtio_crypto_cipher_session_vlf
>> +\item struct virtio_crypto_alg_chain_session_vlf
>> +\end{itemize*}
>> +
>> +\field{op_type} in struct virtio_crypto_sym_create_session_flf decides the
>> +type used by \field{op_vlf}.
>> +
>> +\field{vlf_len} is the size of the specific structure used.
>> +
>> +
>> +\subparagraph{Session operation: AEAD session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: AEAD session}
>> +
>> +The fixed-length and the variable-length parameters of AEAD session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_aead_create_session_flf {
>> +    /* Device read only portion */
>> +
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
>> +struct virtio_crypto_aead_create_session_vlf {
>> +    /* Device read only portion */
>> +    u8 key[key_len];
>> +};
>> +\end{lstlisting}
>> +
>> +The length of \field{key} is specified in \field{key_len} in struct
>> +virtio_crypto_aead_create_session_flf.
>> +
>> +
>> +\drivernormative{\subparagraph}{Session operation: create session}{Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: create session}
>> +
>> +\begin{itemize*}
>> +\item The driver MUST set the \field{opcode} field based on service type: CIPHER, HASH, MAC, or AEAD.
>> +\item The driver MUST set the control general header, the opcode specific header,
>> +    the opcode specific extra parameters and the opcode specific outcome buffer in turn.
>> +    See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue}.
>> +\item The driver MUST set the \field{reversed} field to zero.
>> +\end{itemize*}
>> +
>> +\devicenormative{\subparagraph}{Session operation: create session}{Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: create session}
>> +
>> +\begin{itemize*}
>> +\item The device MUST use the corresponding opcode specific structure according to the
>> +    \field{opcode} in the control general header.
>> +\item The device MUST extract extra parameters according to the structures used.
>> +\item The device MUST set the \field{status} field to one of the following values of enum
>> +    VIRTIO_CRYPTO_STATUS after finish a session creation:
>> +\begin{itemize*}
>> +\item VIRTIO_CRYPTO_OK if a session is created successfully.
>> +\item VIRTIO_CRYPTO_NOTSUPP if the requested algorithm or operation is unsupported.
>> +\item VIRTIO_CRYPTO_NOSPC if no free session ID (only when the VIRTIO_CRYPTO_F_REVISION_1
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
>> +
>> +\subsubsection{Data Virtqueue}\label{sec:Device Types / Crypto Device / Device Operation / Data Virtqueue}
>> +
>> +The driver uses the data virtqueues to transmit crypto operation requests to the device,
>> +and completes the crypto operations.
>> +
>> +The header for dataq is as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_op_header {
>> +#define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
>> +#define VIRTIO_CRYPTO_CIPHER_DECRYPT \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
>> +#define VIRTIO_CRYPTO_HASH \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
>> +#define VIRTIO_CRYPTO_MAC \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
>> +#define VIRTIO_CRYPTO_AEAD_ENCRYPT \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
>> +#define VIRTIO_CRYPTO_AEAD_DECRYPT \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
>> +    le32 opcode;
>> +    /* algo should be service-specific algorithms */
>> +    le32 algo;
>> +    le64 session_id;
>> +#define VIRTIO_CRYPTO_FLAG_SESSION_MODE 1
>> +    /* control flag to control the request */
>> +    le32 flag;
>> +    le32 padding;
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{note}
>> +If VIRTIO_CRYPTO_F_REVISION_1 is negotiated but VIRTIO_CRYPTO_F_<SERVICE>_STATELESS_MODE
>> +is not negotiated then <SERVICE> retuqests with the \field{flag} (in struct
> 
> 
> s/retuqests/requests
> 
>> +virtio_crypto_op_header) is ZERO need to be rejected. If VIRTIO_CRYPTO_F_REVISION_1 is
>> +not negotiated the \field{flag} is ignored.
>> +\end{note}
>> +
> 
> I think your formulation is a bit hard to understand.
> 
> I would prefer:
> +\begin{note}
> +If VIRTIO_CRYPTO_F_REVISION_1 is not negotiated the \field{flag} is ignored.
> +
> +If VIRTIO_CRYPTO_F_REVISION_1 is negotiated but VIRTIO_CRYPTO_F_<SERVICE>_STATELESS_MODE
> +is not negotiated, then the device should reject <SERVICE> requests if
> +VIRTIO_CRYPTO_FLAG_SESSION_MODE is not set (in \field{flag}). 
> +\end{note}
> +
> 
>> +The dataq request is composed of four parts:
>> +\begin{lstlisting}
>> +struct virtio_crypto_op_data_req {
>> +    /* Device read only portion */
>> +
>> +    struct virtio_crypto_op_header header;
>> +
>> +#define VIRTIO_CRYPTO_DATAQ_OP_SPEC_HDR_LEGACY 48
>> +    /* fixed length fields, opcode specific */
>> +    u8 op_flf[flf_len];
>> +
>> +    /* Device read && write portion */
>> +    /* variable length fields, opcode specific */
>> +    u8 op_vlf[vlf_len];
> 
> Descriptors are either read or write. You need read && write (whatever the
> sematic is) because you throw things together that don't belong together.
> 
> I would try to do the same as for the ctrl requests: 
> +    * Device write only portion */
> +    u8 op_outcome;
> 
> and describe the outcome on a per service basis. Also see my
> comments about the dst_data_len below.
> 
>> +
>> +    /* Device write only portion */
>> +    struct virtio_crypto_inhdr inhdr;
>> +};
>> +\end{lstlisting}
>> +
>> +\field{header} is a general header (see above).
>> +
>> +\field{op_flf} is the opcode (in \field{header}) specific header.
>> +
>> +\field{flf_len} depends on the VIRTIO_CRYPTO_F_REVISION_1 feature bit
>> +(see below).
>> +
>> +\field{op_vlf} is the opcode (in \field{header}) specific parameters.
>> +
>> +\field{vlf_len} is the size of the specific structure used.
>> +
>> +\begin{itemize*}
>> +\item If the the opcode (in \field{header}) is VIRTIO_CRYPTO_CIPHER_ENCRYPT
>> +    or VIRTIO_CRYPTO_CIPHER_DECRYPT then:
>> +    \begin{itemize*}
>> +	\item If VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE is negotiated, \field{op_flf} is
>> +        struct virtio_crypto_sym_data_flf_stateless, and \field{op_vlf} is struct
>> +        virtio_crypto_sym_data_vlf_stateless.
> 
> What does this _data_  (in the name) symbolise?
> 
>> +    \item If VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE is NOT negotiated, \field{op_flf}
>> +        is struct virtio_crypto_sym_data_flf if VIRTIO_CRYPTO_F_REVISION_1 is negotiated
>> +        and struct virtio_crypto_sym_data_flf if padded to 48 bytes if NOT negotiated,
>> +        and \field{op_vlf} is struct virtio_crypto_sym_data_vlf.
>> +    \end{itemize*}
>> +\item If the the opcode (in \field{header}) is VIRTIO_CRYPTO_HASH:
>> +    \begin{itemize*}
>> +	\item If VIRTIO_CRYPTO_F_HASH_STATELESS_MODE is negotiated, \field{op_flf} is
>> +        struct virtio_crypto_hash_data_flf_stateless, and \field{op_vlf} is struct
>> +        virtio_crypto_hash_data_vlf_stateless.
>> +    \item If VIRTIO_CRYPTO_F_HASH_STATELESS_MODE is NOT negotiated, \field{op_flf}
>> +        is struct virtio_crypto_hash_data_flf if VIRTIO_CRYPTO_F_REVISION_1 is negotiated
>> +        and struct virtio_crypto_hash_data_flf if padded to 48 bytes if NOT negotiated,
>> +        and \field{op_vlf} is struct virtio_crypto_hash_data_vlf.
>> +\item If the the opcode (in \field{header}) is VIRTIO_CRYPTO_MAC:
>> +    \begin{itemize*}
>> +	\item If VIRTIO_CRYPTO_F_MAC_STATELESS_MODE is negotiated, \field{op_flf} is
>> +        struct virtio_crypto_mac_data_flf_stateless, and \field{op_vlf} is struct
>> +        virtio_crypto_mac_data_vlf_stateless.
>> +    \item If VIRTIO_CRYPTO_F_MAC_STATELESS_MODE is NOT negotiated, \field{op_flf}
>> +        is struct virtio_crypto_mac_data_flf if VIRTIO_CRYPTO_F_REVISION_1 is negotiated
>> +        and struct virtio_crypto_mac_data_flf if padded to 48 bytes if NOT negotiated,
>> +        and \field{op_vlf} is struct virtio_crypto_mac_data_vlf.
>> +\item If the the opcode (in \field{header}) is VIRTIO_CRYPTO_AEAD_ENCRYPT
>> +    or VIRTIO_CRYPTO_AEAD_DECRYPT then:
>> +    \begin{itemize*}
>> +	\item If VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE is negotiated, \field{op_flf} is
>> +        struct virtio_crypto_aead_data_flf_stateless, and \field{op_vlf} is struct
>> +        virtio_crypto_aead_data_vlf_stateless.
>> +    \item If VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE is NOT negotiated, \field{op_flf}
>> +        is struct virtio_crypto_aead_data_flf if VIRTIO_CRYPTO_F_REVISION_1 is negotiated
>> +        and struct virtio_crypto_aead_data_flf if padded to 48 bytes if NOT negotiated,
>> +        and \field{op_vlf} is struct virtio_crypto_aead_data_vlf.
>> +\end{itemize*}
>> +
>> +\field{inhdr} is a unified input header that used to return the status of
>> +the operations, is defined as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_inhdr {
>> +    u8 status;
>> +};
>> +\end{lstlisting}
>> +
>> +\subsubsection{HASH Service Operation}\label{sec:Device Types / Crypto Device / Device Operation / HASH Service Operation}
>> +
>> +Session mode HASH service requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_hash_data_flf {
>> +    /* length of source data */
>> +    le32 src_data_len;
>> +    /* hash result length */
>> +    le32 hash_result_len;
>> +};
>> +
>> +struct virtio_crypto_hash_data_vlf {
>> +    /* Device read only portion */
>> +    /* Source data */
>> +    u8 src_data[src_data_len];
>> +
>> +    /* Device write only portion */
>> +    /* Hash result data */
>> +    u8 hash_result[hash_result_len];
>> +};
>> +\end{lstlisting}
>> +
>> +Each data request uses the virtio_crypto_hash_data_flf structure and the
>> +virtio_crypto_hash_data_vlfto structure to store information used to run the
>> +HASH operations.
>> +
>> +\field{src_data} is the source data that will be processed.
>> +\field{src_data_len} is the length of source data.
>> +\field{hash_result} is the result data and \field{hash_result_len} is the length
>> +of it.
>> +
>> +Stateless mode HASH service requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_hash_data_flf_stateless {
>> +    struct {
>> +        /* See VIRTIO_CRYPTO_HASH_* above */
>> +        le32 algo;
>> +    } sess_para;
>> +
>> +    /* length of source data */
>> +    le32 src_data_len;
>> +    /* hash result length */
>> +    le32 hash_result_len;
>> +    le32 reserved;
>> +};
>> +struct virtio_crypto_hash_data_vlf_stateless {
>> +    /* Device read only portion */
>> +    /* Source data */
>> +    u8 src_data[src_data_len];
>> +
>> +    /* Device write only portion */
>> +    /* Hash result data */
>> +    u8 hash_result[hash_result_len];
>> +};
>> +\end{lstlisting}
>> +
>> +\drivernormative{\paragraph}{HASH Service Operation}{Device Types / Crypto Device / Device Operation / HASH Service Operation}
>> +
>> +\begin{itemize*}
>> +\item If the driver uses the session mode, then the driver MUST set \field{session_id}
>> +    in struct virtio_crypto_op_header to a valid value assigned by the device when the
>> +    session was created.
>> +\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is negotiated, 1) if the
>> +    driver uses the stateless mode, then the driver MUST set the \field{flag} field in
>> +    struct virtio_crypto_op_header to ZERO and MUST set the fields in struct
>> +    virtio_crypto_hash_data_flf_stateless.sess_para, 2) if the driver uses the session
>> +    mode, then the driver MUST set the \field{flag} field in struct virtio_crypto_op_header
>> +    to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
>> +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_header to VIRTIO_CRYPTO_HASH.
>> +\end{itemize*}
>> +
>> +\devicenormative{\paragraph}{HASH Service Operation}{Device Types / Crypto Device / Device Operation / HASH Service Operation}
>> +
>> +\begin{itemize*}
>> +\item The device MUST use the corresponding structure according to the \field{opcode}
>> +    in the data general header.
>> +\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is negotiated, the device
>> +    MUST parse \field{flag} field in struct virtio_crypto_op_header in order to decide
>> +    which mode the driver uses.
>> +\item The device MUST copy the results of HASH operations in the hash_result[] if HASH
>> +    operations success.
>> +\item The device MUST set \field{status} in struct virtio_crypto_inhdr to one of the
>> +    following values of enum VIRTIO_CRYPTO_STATUS:
>> +\begin{itemize*}
>> +\item VIRTIO_CRYPTO_OK if the operation success.
>> +\item VIRTIO_CRYPTO_NOTSUPP if the requested algorithm or operation is unsupported.
>> +\item VIRTIO_CRYPTO_INVSESS if the session ID invalid when in session mode.
>> +\item VIRTIO_CRYPTO_ERR if any failure not mentioned above occurs.
>> +\end{itemize*}
>> +\end{itemize*}
>> +
>> +
>> +\subsubsection{MAC Service Operation}\label{sec:Device Types / Crypto Device / Device Operation / MAC Service Operation}
>> +
>> +Session mode MAC service requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_mac_data_flf {
>> +    struct virtio_crypto_hash_data_flf hdr;
>> +};
>> +
>> +struct virtio_crypto_mac_data_vlf {
>> +    /* Device read only portion */
>> +    /* Source data */
>> +    u8 src_data[src_data_len];
>> +
>> +    /* Device write only portion */
>> +    /* Hash result data */
>> +    u8 hash_result[hash_result_len];
>> +};
>> +\end{lstlisting}
>> +
>> +Each request uses the virtio_crypto_mac_data_flf structure and the
>> +virtio_crypto_mac_data_vlf structure to store information used to run the
>> +MAC operations.
>> +
>> +\field{src_data} is the source data that will be processed.
>> +\field{src_data_len} is the length of source data.
>> +\field{hash_result} is the result data and \field{hash_result_len} is the length
>> +of it.
>> +
>> +Stateless mode MAC service requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_mac_data_flf_stateless {
>> +    struct {
>> +        /* See VIRTIO_CRYPTO_MAC_* above */
>> +        le32 algo;
>> +        /* length of authenticated key */
>> +        le32 auth_key_len;
>> +    } sess_para;
>> +
>> +    /* length of source data */
>> +    le32 src_data_len;
>> +    /* hash result length */
>> +    le32 hash_result_len;
>> +};
>> +
>> +struct virtio_crypto_mac_data_vlf_stateless {
>> +    /* Device read only portion */
>> +    /* The authenticated key */
>> +    u8 auth_key[auth_key_len];
>> +    /* Source data */
>> +    u8 src_data[src_data_len];
>> +
>> +    /* Device write only portion */
>> +    /* Hash result data */
>> +    u8 hash_result[hash_result_len];
>> +};
>> +\end{lstlisting}
>> +
>> +\field{auth_key} is the authenticated key that will be used during the process.
>> +\field{auth_key_len} is the length of the key.
>> +
>> +\drivernormative{\paragraph}{MAC Service Operation}{Device Types / Crypto Device / Device Operation / MAC Service Operation}
>> +
>> +\begin{itemize*}
>> +\item If the driver uses the session mode, then the driver MUST set \field{session_id}
>> +    in struct virtio_crypto_op_header to a valid value assigned by the device when the
>> +    session was created.
>> +\item If the VIRTIO_CRYPTO_F_MAC_STATELESS_MODE feature bit is negotiated, 1) if the
>> +    driver uses the stateless mode, then the driver MUST set the \field{flag} field
>> +    in struct virtio_crypto_op_header to ZERO and MUST set the fields in struct
>> +    virtio_crypto_mac_data_flf_stateless.sess_para, 2) if the driver uses the session
>> +    mode, then the driver MUST set the \field{flag} field in struct virtio_crypto_op_header
>> +    to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
>> +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_header to VIRTIO_CRYPTO_MAC.
>> +\end{itemize*}
>> +
>> +\devicenormative{\paragraph}{MAC Service Operation}{Device Types / Crypto Device / Device Operation / MAC Service Operation}
>> +
>> +\begin{itemize*}
>> +\item If the VIRTIO_CRYPTO_F_MAC_STATELESS_MODE feature bit is negotiated, the device
>> +    MUST parse \field{flag} field in struct virtio_crypto_op_header in order to decide
>> +	which mode the driver uses.
>> +\item The device MUST copy the results of MAC operations in the hash_result[] if HASH
>> +    operations success.
>> +\item The device MUST set \field{status} in struct virtio_crypto_inhdr to one of the
>> +    following values of enum VIRTIO_CRYPTO_STATUS:
>> +\begin{itemize*}
>> +\item VIRTIO_CRYPTO_OK if the operation success.
>> +\item VIRTIO_CRYPTO_NOTSUPP if the requested algorithm or operation is unsupported.
>> +\item VIRTIO_CRYPTO_INVSESS if the session ID invalid when in session mode.
>> +\item VIRTIO_CRYPTO_ERR if any failure not mentioned above occurs.
>> +\end{itemize*}
>> +\end{itemize*}
>> +
>> +\subsubsection{Symmetric algorithms Operation}\label{sec:Device Types / Crypto Device / Device Operation / Symmetric algorithms Operation}
>> +
>> +Session mode CIPHER service requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_cipher_data_flf {
>> +    /*
>> +     * Byte Length of valid IV/Counter data pointed to by the below iv data.
>> +     *
>> +     * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or for
>> +     *   SNOW3G in UEA2 mode, this is the length of the IV (which
>> +     *   must be the same as the block length of the cipher).
>> +     * For block ciphers in CTR mode, this is the length of the counter
>> +     *   (which must be the same as the block length of the cipher).
>> +     */
>> +    le32 iv_len;
>> +    /* length of source data */
>> +    le32 src_data_len;
>> +    /* length of destination data */
>> +    le32 dst_data_len;
>> +    le32 padding;
>> +};
>> +
>> +struct virtio_crypto_cipher_data_vlf {
>> +    /* Device read only portion */
>> +
>> +    /*
>> +     * Initialization Vector or Counter data.
>> +     *
>> +     * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or for
>> +     *   SNOW3G in UEA2 mode, this is the Initialization Vector (IV)
>> +     *   value.
>> +     * For block ciphers in CTR mode, this is the counter.
>> +     * For AES-XTS, this is the 128bit tweak, i, from IEEE Std 1619-2007.
>> +     *
>> +     * The IV/Counter will be updated after every partial cryptographic
>> +     * operation.
>> +     */
>> +    u8 iv[iv_len];
>> +    /* Source data */
>> +    u8 src_data[src_data_len];
>> +
>> +    /* Device write only portion */
>> +    /* Destination data */
>> +    u8 dst_data[dst_data_len];
> 
> 
> I'm a bit puzzled about dst_data_len. I'm by no means a crypto expert,
> and that is probably the very reason of my discomfort.
> 
> I've tried to figure out how dst_data_len is used and expected to find
> a place that checks, that at least a sufficiently large buffer was provided.
> 
> I've also assumed that the src_data_len is likely to imply the dst_data_len
> for any given algorithm. Furthermore, I even hypothesised that the both
> lengths are the same. All based on what I remember about block ciphers.
> 
> If that hypothesis is right, then I don't understand why do we need 
> both src_data_len and dst_data_len.
> 
> Since dst_data_len is device read only, the driver I figure the driver
> needs to know the exact length (since I cant figure out, based on this
> spec, how is it supposed to be told by the device which part of the
> buffer is the result and which part garbage). So the only sane usage
> I was able to come up with is to avoid the device overwritting other
> parts of the requests device writtable part because of a driver
> bug (wrong dst_data_len). But as I've said I could not find the corresponding
> code in qemu.
> 
> Anyway providing some more background for the guys only superficially 
> involved with crypto (like me) would be appreciated.
> 
> I will stop here for now. I read the rest real quick and I did not
> see anything major. I think we are slowly getting there.
> 
> Regards,
> Halil
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
