Received: from eggs.gnu.org ([2001:4830:134:3::10]:54970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dwqLT-00029n-Oa
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dwqLL-0001EY-RB
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:56:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dwqLK-0001Ce-F5
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:56:11 -0400
Message-ID: <59CA5C3F.7080708@huawei.com>
Date: Tue, 26 Sep 2017 21:55:11 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1505092362-10544-1-git-send-email-longpeng2@huawei.com>
	<1505092362-10544-2-git-send-email-longpeng2@huawei.com>
	<bc4406dd-dd7d-da29-5658-5d66a5909098@linux.vnet.ibm.com>
In-Reply-To: <bc4406dd-dd7d-da29-5658-5d66a5909098@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH REPOST v19 1/2] virtio-crypto: Add virtio
 crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com

Hi Halil,

On 2017/9/15 22:39, Halil Pasic wrote:

> 
> 
> On 09/11/2017 03:12 AM, Longpeng(Mike) wrote:
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
>>  acknowledgements.tex |    3 +
>>  content.tex          |    2 +
>>  virtio-crypto.tex    | 1479 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 1484 insertions(+)
>>  create mode 100644 virtio-crypto.tex
>>
>> diff --git a/acknowledgements.tex b/acknowledgements.tex
>> index 6c86d12..c4b6844 100644
>> --- a/acknowledgements.tex
>> +++ b/acknowledgements.tex
>> @@ -26,6 +26,8 @@ Sasha Levin,	Oracle	\newline
>>  Sergey Tverdyshev,	Thales e-Security	\newline
>>  Stefan Hajnoczi,	Red Hat	\newline
>>  Tom Lyon,	Samya Systems, Inc.	\newline
>> +Lei Gong,	Huawei	\newline
>> +Peng Long,	Huawei	\newline
>>  \end{oasistitlesection}
>>
>>  The following non-members have provided valuable feedback on this
>> @@ -43,4 +45,5 @@ Laura Novich, Red Hat	\newline
>>  Patrick Durusau,	Technical Advisory Board, OASIS	\newline
>>  Thomas Huth,	IBM	\newline
>>  Yan Vugenfirer, Red Hat / Daynix	\newline
>> +Halil Pasic,	IBM	\newline
>>  \end{oasistitlesection}
>> diff --git a/content.tex b/content.tex
>> index d989d98..7710f8c 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -5641,6 +5641,8 @@ descriptor for the \field{sense_len}, \field{residual},
>>  \field{status_qualifier}, \field{status}, \field{response} and
>>  \field{sense} fields.
>>
>> +\input{virtio-crypto.tex}
>> +
>>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>
>>  Currently there are three device-independent feature bits defined:
>> diff --git a/virtio-crypto.tex b/virtio-crypto.tex
>> new file mode 100644
>> index 0000000..1e75cbc
>> --- /dev/null
>> +++ b/virtio-crypto.tex
>> @@ -0,0 +1,1479 @@
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
>> +\item VIRTIO_CRYPTO_F_MUX_MODE (0) multiplexing mode is available.
>> +\item VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE (1) stateless mode is available for CIPHER service.
>> +\item VIRTIO_CRYPTO_F_HASH_STATELESS_MODE (2) stateless mode is available for HASH service.
>> +\item VIRTIO_CRYPTO_F_MAC_STATELESS_MODE (3) stateless mode is available for MAC service.
>> +\item VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE (4) stateless mode is available for AEAD service.
>> +\end{description}
>> +
>> +\subsubsection{Feature bit requirements}\label{sec:Device Types / Crypto Device / Feature bits}
>> +
>> +Some crypto feature bits require other crypto feature bits
>> +(see \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}):
>> +
>> +\begin{description}
>> +\item[VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE.
>> +\item[VIRTIO_CRYPTO_F_HASH_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE.
>> +\item[VIRTIO_CRYPTO_F_MAC_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE.
>> +\item[VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE.
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
>> +\item As values, used to tell the device which CIPHER algorithm
>> +a crypto request from the driver requires, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
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
>> +\item As values, used to tell the device which HASH algorithm
>> +a crypto request from the driver requires, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
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
>> +\item As values, used to tell the device which MAC algorithm
>> +a crypto request from the driver requires, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
> 
> Cosmetic comment: instead of 'used to tell the device which MAC algorithm
> a crypto request form the driver requires' I would prefer  'used to designate
> the algorithm in (MAC type) crypto operation requests'.
> 


OK, yours is more decent. :)

> I think, your version is good enough (won't be misunderstood)  it is just
> that request requires sound a bit weird to me. I'm not sure my version is
> better though.
> 
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
>> +\item As values, used to tell the device what AEAD algorithm
>> +a crypto request from the driver requires, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
> 
> More or less same as above (and we have some more similar occurrences below).
> 

OK.

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
>> +\item[\field{status}] is used to show whether the device is ready to work or
>> +    not, it can be either zero or have one or more flags. Only one read-only
>> +	bit (for the driver) is currently defined for the \field{status} field: VIRTIO_CRYPTO_S_HW_READY:
> 
> Cosmetic comment: maybe 'Currently, only one \field(status) bit is defined:
> IRTIO_CRYPTO_S_HW_READY set indicates that the device is ready to process
> requests, this bit is read-only for the driver
> 

OK.

> While trying to reword this, I started thinking about whether read-only
> makes sense for individual bits. I think it does not (I think we can't
> do something like compare and swap to make this work). Does read
> only even make sense for configuration space? I mean it is not random
> access AFAIK (see 4.3 Virtio Over Channel I/O)?
> 
> I'm confused abut the config space in general. I've expected that after
> a certain stage it can be only changed by the device, but I didn't
> manage to find a corresponding statement in the spec.
> 

I'm not sure whether I understand you correctly.

For the virtio-crypto device, the fields in the configure space are all fixed
after the initialization, so maybe make them read-only is acceptable.

>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
>> +\end{lstlisting}
>> +
>> +\item[\field{max_dataqueues}] is the maximum number of data virtqueues exposed by
>> +    the device. The driver MAY use only one data queue,
>> +    or it can use more to achieve better performance.
> 
> s/exposed/ that can be configured/
> 

> This is the wording virtio-net uses (if I'm not mistaken). Exposed can be
> misleading.
> 

OK.

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
>> +
>> +\item[\field{max_auth_key_len}] is the maximum length of authenticated key supported by the device.
>> +
>> +\item[\field{reserved}] is reserved for future use.
>> +
>> +\item[\field{max_size}] is the maximum size of each crypto request's content supported by the device
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
>> +\item The device MUST set the \field{status} flag based on the status of the crypto
> s/flag/flags ?
>> +    accelerator, Non-valid flags MUST NOT be set.
> What does this mean? It is a device requirement so it can't be about the driver.
> What does the device have to do if it encounters an unknown flag?


How about: The device MUST set the \field{status} with valid flags, undefined
flags MUST NOT be set ?

The existing crypto device in QEMU only sets VIRTIO_CRYPTO_S_HW_READY and other
bits are zero, it's impossible to encounters an undefined flag.

> 
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
>> +\item The driver MUST read the ready \field{status} from the bottom bit of status to check whether the
>> +    crypto accelerator is ready or not, and the driver MUST reread it after device reset.
> 
> You use 'ready' instead of VIRTIO_CRYPTO_S_HW_READY here and in the next point.
> s/ MUST read the ready \field{status}/ MUST read the \field{status}/ ?
> s/crypto accelerator is ready or not/VIRTIO_CRYPTO_S_HW_READY is set/ ?
> 

Uh, this is much better, thanks :)

>> +\item The driver MUST NOT transmit any requests to the device if the ready \field{status} is not set.
> s/if the ready \field{status}/VIRTIO_CRYPTO_S_HW_READY/ ?

OK.

>> +\item The driver MUST read \field{max_dataqueues} field to discover the number of data queues the device supports.> +\item The driver MUST read \field{crypto_services} field to discover which services the device is able to offer.
>> +\item The driver SHOULD ignore the not defined algorithms bits.
>> +\item The driver MUST read the detailed algorithms fields based on \field{crypto_services} field.
>> +\item The driver SHOULD read \field{max_size} to discover the maximum size of crypto request the device supports.
>> +\item The driver SHOULD read \field{max_cipher_key_len} to discover the maximum length of cipher key
>> +    the device supports.
>> +\item The driver SHOULD read \field{max_auth_key_len} to discover the maximum length of authenticated
>> +    key the device supports.
>> +\end{itemize*}
>> +
>> +\subsection{Device Initialization}\label{sec:Device Types / Crypto Device / Device Initialization}
>> +
>> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / Crypto Device / Device Initialization}
>> +
>> +\begin{itemize*}
>> +\item The driver MUST identify and initialize all virtqueues.
> s/initialize/configure/ ?
> 

OK.

> I wonder, do we really want to mandate configuring all virtqueues even
> if some are going to be unused? If yes why?
> 

IMHO the virtio-net does, please see:
	\Device Types\Network Device\Device Initialization

In my opinion, this can makes everything as simple as possible. We need to
consider some complex situations if the vqs are configured as required, e.g,
what should the driver to do if initialize the vq failure.

>> +\item The driver MUST read the supported crypto services from bits of \field{crypto_services}.
>> +\item The driver MUST read the supported algorithms based on \field{crypto_services} field.
>> +\end{itemize*}
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / Crypto Device / Device Operation}
>> +
>> +Requests can be transmitted by placing them in the controlq or dataq.
> 
> How about: The operation of a virtio crypto device is driven by requests
> placed on the virtqueues.
> 
> I don't like 'can be transmitted' and 'or' in your sentence. I can't put
> my finger on it.
> 

OK.

>> +Requests consist of a queue-type specific header specifying among
>> +others the operation, and an operation specific payload.
> 
> Maybe put 'specifying among others the operation' in parenthesis or
> between comas (I'm no good with grammar -- someone competent help!).
> 

OK.

>> +The payload is generally composed of operation parameters, output data, and input data.
>> +Operation parameters are algorithm-specific parameters, output data is the
> 
> Start a new sentence at the comma.

OK.

> 
>> +data that should be utilized in operations, and input data is equal to
>> +"operation result + result data".
>> +
>> +The device can support both session mode (See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}) and stateless mode.
> 
> How about if VIRTIO_CRYPTO_F_MUX_MODE is negotioated the device
> may support both session mode ... and stateless mode operation requests.
> 

Uh, yours is pretty good :)

>> +In stateless mode all operation parameters are supplied as a part
>> +of each request, while in session mode, some or all operation parameters
>> +are managed within the session. Stateless mode is guarded by
>> +feature bits 0-4 on a service level. If stateless mode is negotiated
>> +for a service, the service is available both in session and
>> +stateless mode; otherwise it's only available in session mode.
>> +
>> +The device can set the operation status as follows:
> 
> This is the first time you mention operation status. The only status
> we have defined is the config layout status. Can we introduce the
> operation status later? Alternatively before we intreudce the op status
> code we could tell something about how requests serviced, and of course
> introduce the op status field as the part of (each?) request.
> 

OK, I'll introduce them later in the next version.

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
> 
> [..]
> 
> I will continue reviewing right away but wanted to slit this up because
> the patch is huge.
> 
> My overall impression is pretty decent (up until this point) even
> with my suggestions ignored. If this weren't a standard I wouldn't probably
> bother with most of the comments (a la, it's good enough and can be improved
> upon later if deemed necessary), but since it's a standard it's more important
> to get things as good as possible already in the first version.


Yea, thank for your patience and comments, they're very useful. :)

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
