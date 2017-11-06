Received: from eggs.gnu.org ([2001:4830:134:3::10]:51227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbPE-0000sT-6M
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbP2-00074d-Kd
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:01:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbP1-0006xm-0t
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:01:00 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:58:47 +0800
Message-ID: <1509951528-30976-2-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509951528-30976-1-git-send-email-longpeng2@huawei.com>
References: <1509951528-30976-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [v21 RESEND 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

From: Gonglei <arei.gonglei@huawei.com>

The virtio crypto device is a virtual crypto device (ie. hardware
crypto accelerator card). Currently, the virtio crypto device provides
the following crypto services: CIPHER, MAC, HASH, and AEAD.

In this patch, CIPHER, MAC, HASH, AEAD services are introduced.

VIRTIO-153

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 acknowledgements.tex |    3 +
 content.tex          |    2 +
 virtio-crypto.tex    | 1426 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1431 insertions(+)
 create mode 100644 virtio-crypto.tex

diff --git a/acknowledgements.tex b/acknowledgements.tex
index 6c86d12..c4b6844 100644
--- a/acknowledgements.tex
+++ b/acknowledgements.tex
@@ -26,6 +26,8 @@ Sasha Levin,	Oracle	\newline
 Sergey Tverdyshev,	Thales e-Security	\newline
 Stefan Hajnoczi,	Red Hat	\newline
 Tom Lyon,	Samya Systems, Inc.	\newline
+Lei Gong,	Huawei	\newline
+Peng Long,	Huawei	\newline
 \end{oasistitlesection}
 
 The following non-members have provided valuable feedback on this
@@ -43,4 +45,5 @@ Laura Novich, Red Hat	\newline
 Patrick Durusau,	Technical Advisory Board, OASIS	\newline
 Thomas Huth,	IBM	\newline
 Yan Vugenfirer, Red Hat / Daynix	\newline
+Halil Pasic,	IBM	\newline
 \end{oasistitlesection}
diff --git a/content.tex b/content.tex
index d989d98..7710f8c 100644
--- a/content.tex
+++ b/content.tex
@@ -5641,6 +5641,8 @@ descriptor for the \field{sense_len}, \field{residual},
 \field{status_qualifier}, \field{status}, \field{response} and
 \field{sense} fields.
 
+\input{virtio-crypto.tex}
+
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
 Currently there are three device-independent feature bits defined:
diff --git a/virtio-crypto.tex b/virtio-crypto.tex
new file mode 100644
index 0000000..361c9ab
--- /dev/null
+++ b/virtio-crypto.tex
@@ -0,0 +1,1426 @@
+\section{Crypto Device}\label{sec:Device Types / Crypto Device}
+
+The virtio crypto device is a virtual cryptography device as well as a
+virtual cryptographic accelerator. The virtio crypto device provides the
+following crypto services: CIPHER, MAC, HASH, and AEAD. Virtio crypto
+devices have a single control queue and at least one data queue. Crypto
+operation requests are placed into a data queue, and serviced by the
+device. Some crypto operation requests are only valid in the context of a
+session. The role of the control queue is facilitating control operation
+requests. Sessions management is realized with control operation
+requests.
+
+\subsection{Device ID}\label{sec:Device Types / Crypto Device / Device ID}
+
+20
+
+\subsection{Virtqueues}\label{sec:Device Types / Crypto Device / Virtqueues}
+
+\begin{description}
+\item[0] dataq1
+\item[\ldots]
+\item[N-1] dataqN
+\item[N] controlq
+\end{description}
+
+N is set by \field{max_dataqueues}.
+
+\subsection{Feature bits}\label{sec:Device Types / Crypto Device / Feature bits}
+
+\begin{description}
+\item VIRTIO_CRYPTO_F_MUX_MODE (0) multiplexing mode is available.
+\item VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE (1) stateless mode is available for CIPHER service.
+\item VIRTIO_CRYPTO_F_HASH_STATELESS_MODE (2) stateless mode is available for HASH service.
+\item VIRTIO_CRYPTO_F_MAC_STATELESS_MODE (3) stateless mode is available for MAC service.
+\item VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE (4) stateless mode is available for AEAD service.
+\end{description}
+
+\subsubsection{Feature bit requirements}\label{sec:Device Types / Crypto Device / Feature bits}
+
+Some crypto feature bits require other crypto feature bits
+(see \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}):
+
+\begin{description}
+\item[VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE.
+\item[VIRTIO_CRYPTO_F_HASH_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE.
+\item[VIRTIO_CRYPTO_F_MAC_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE.
+\item[VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE.
+\end{description}
+
+\subsection{Supported crypto services}\label{sec:Device Types / Crypto Device / Supported crypto services}
+
+The following crypto services are defined:
+
+\begin{lstlisting}
+/* CIPHER service */
+#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
+/* HASH service */
+#define VIRTIO_CRYPTO_SERVICE_HASH   1
+/* MAC (Message Authentication Codes) service */
+#define VIRTIO_CRYPTO_SERVICE_MAC    2
+/* AEAD (Authenticated Encryption with Associated Data) service */
+#define VIRTIO_CRYPTO_SERVICE_AEAD   3
+\end{lstlisting}
+
+The above constants designate bits used to indicate the which of crypto services are
+offered by the device as described in, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
+
+\subsubsection{CIPHER services}\label{sec:Device Types / Crypto Device / Supported crypto services / CIPHER services}
+
+The following CIPHER algorithms are defined:
+
+\begin{lstlisting}
+#define VIRTIO_CRYPTO_NO_CIPHER                 0
+#define VIRTIO_CRYPTO_CIPHER_ARC4               1
+#define VIRTIO_CRYPTO_CIPHER_AES_ECB            2
+#define VIRTIO_CRYPTO_CIPHER_AES_CBC            3
+#define VIRTIO_CRYPTO_CIPHER_AES_CTR            4
+#define VIRTIO_CRYPTO_CIPHER_DES_ECB            5
+#define VIRTIO_CRYPTO_CIPHER_DES_CBC            6
+#define VIRTIO_CRYPTO_CIPHER_3DES_ECB           7
+#define VIRTIO_CRYPTO_CIPHER_3DES_CBC           8
+#define VIRTIO_CRYPTO_CIPHER_3DES_CTR           9
+#define VIRTIO_CRYPTO_CIPHER_KASUMI_F8          10
+#define VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2        11
+#define VIRTIO_CRYPTO_CIPHER_AES_F8             12
+#define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
+#define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
+\end{lstlisting}
+
+The above constants have two usages:
+\begin{enumerate}
+\item As bit numbers, used to tell the driver which CIPHER algorithms
+are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
+\item As values, used to designate the algorithm in (CIPHER type) crypto
+operation requests, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
+\end{enumerate}
+
+\subsubsection{HASH services}\label{sec:Device Types / Crypto Device / Supported crypto services / HASH services}
+
+The following HASH algorithms are defined:
+
+\begin{lstlisting}
+#define VIRTIO_CRYPTO_NO_HASH            0
+#define VIRTIO_CRYPTO_HASH_MD5           1
+#define VIRTIO_CRYPTO_HASH_SHA1          2
+#define VIRTIO_CRYPTO_HASH_SHA_224       3
+#define VIRTIO_CRYPTO_HASH_SHA_256       4
+#define VIRTIO_CRYPTO_HASH_SHA_384       5
+#define VIRTIO_CRYPTO_HASH_SHA_512       6
+#define VIRTIO_CRYPTO_HASH_SHA3_224      7
+#define VIRTIO_CRYPTO_HASH_SHA3_256      8
+#define VIRTIO_CRYPTO_HASH_SHA3_384      9
+#define VIRTIO_CRYPTO_HASH_SHA3_512      10
+#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE128      11
+#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE256      12
+\end{lstlisting}
+
+The above constants have two usages:
+\begin{enumerate}
+\item As bit numbers, used to tell the driver which HASH algorithms
+are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
+\item As values, used to designate the algorithm in (HASH type) crypto
+operation requires, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
+\end{enumerate}
+
+\subsubsection{MAC services}\label{sec:Device Types / Crypto Device / Supported crypto services / MAC services}
+
+The following MAC algorithms are defined:
+
+\begin{lstlisting}
+#define VIRTIO_CRYPTO_NO_MAC                       0
+#define VIRTIO_CRYPTO_MAC_HMAC_MD5                 1
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA1                2
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_224             3
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_256             4
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_384             5
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_512             6
+#define VIRTIO_CRYPTO_MAC_CMAC_3DES                25
+#define VIRTIO_CRYPTO_MAC_CMAC_AES                 26
+#define VIRTIO_CRYPTO_MAC_KASUMI_F9                27
+#define VIRTIO_CRYPTO_MAC_SNOW3G_UIA2              28
+#define VIRTIO_CRYPTO_MAC_GMAC_AES                 41
+#define VIRTIO_CRYPTO_MAC_GMAC_TWOFISH             42
+#define VIRTIO_CRYPTO_MAC_CBCMAC_AES               49
+#define VIRTIO_CRYPTO_MAC_CBCMAC_KASUMI_F9         50
+#define VIRTIO_CRYPTO_MAC_XCBC_AES                 53
+#define VIRTIO_CRYPTO_MAC_ZUC_EIA3                 54
+\end{lstlisting}
+
+The above constants have two usages:
+\begin{enumerate}
+\item As bit numbers, used to tell the driver which MAC algorithms
+are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
+\item As values, used to designate the algorithm in (MAC type) crypto
+operation requests, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
+\end{enumerate}
+
+\subsubsection{AEAD services}\label{sec:Device Types / Crypto Device / Supported crypto services / AEAD services}
+
+The following AEAD algorithms are defined:
+
+\begin{lstlisting}
+#define VIRTIO_CRYPTO_NO_AEAD     0
+#define VIRTIO_CRYPTO_AEAD_GCM    1
+#define VIRTIO_CRYPTO_AEAD_CCM    2
+#define VIRTIO_CRYPTO_AEAD_CHACHA20_POLY1305  3
+\end{lstlisting}
+
+The above constants have two usages:
+\begin{enumerate}
+\item As bit numbers, used to tell the driver which AEAD algorithms
+are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
+\item As values, used to designate the algorithm in (DEAD type) crypto
+operation requests, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
+\end{enumerate}
+
+\subsection{Device configuration layout}\label{sec:Device Types / Crypto Device / Device configuration layout}
+
+\begin{lstlisting}
+struct virtio_crypto_config {
+    le32 status;
+    le32 max_dataqueues;
+    le32 crypto_services;
+    /* Detailed algorithms mask */
+    le32 cipher_algo_l;
+    le32 cipher_algo_h;
+    le32 hash_algo;
+    le32 mac_algo_l;
+    le32 mac_algo_h;
+    le32 aead_algo;
+    /* Maximum length of cipher key in bytes */
+    le32 max_cipher_key_len;
+    /* Maximum length of authenticated key in bytes */
+    le32 max_auth_key_len;
+    le32 reserved;
+    /* Maximum size of each crypto request's content in bytes */
+    le64 max_size;
+};
+\end{lstlisting}
+
+\begin{description}
+\item Currently, only one \field(status) bit is defined: VIRTIO_CRYPTO_S_HW_READY
+    set indicates that the device is ready to process requests, this bit is read-only
+    for the driver
+\begin{lstlisting}
+#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
+\end{lstlisting}
+
+\item[\field{max_dataqueues}] is the maximum number of data virtqueues that can
+    be configured by the device. The driver MAY use only one data queue, or it
+    can use more to achieve better performance.
+
+\item[\field{crypto_services}] crypto service offered, see \ref{sec:Device Types / Crypto Device / Supported crypto services}.
+
+\item[\field{cipher_algo_l}] CIPHER algorithms bits 0-31, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / CIPHER services}.
+
+\item[\field{cipher_algo_h}] CIPHER algorithms bits 32-63, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / CIPHER services}.
+
+\item[\field{hash_algo}] HASH algorithms bits, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / HASH services}.
+
+\item[\field{mac_algo_l}] MAC algorithms bits 0-31, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / MAC services}.
+
+\item[\field{mac_algo_h}] MAC algorithms bits 32-63, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / MAC services}.
+
+\item[\field{aead_algo}] AEAD algorithms bits, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / AEAD services}.
+
+\item[\field{max_cipher_key_len}] is the maximum length of cipher key supported by the device.
+
+\item[\field{max_auth_key_len}] is the maximum length of authenticated key supported by the device.
+
+\item[\field{reserved}] is reserved for future use.
+
+\item[\field{max_size}] is the maximum size of each crypto request's content supported by the device
+\end{description}
+
+\begin{note}
+Unless explicitly stated otherwise all lengths and sizes are in bytes.
+\end{note}
+
+\devicenormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
+
+\begin{itemize*}
+\item The device MUST set \field{max_dataqueues} to between 1 and 65535 inclusive.
+\item The device MUST set the \field{status} with valid flags, undefined flags MUST NOT be set.
+\item The device MUST accept and handle requests after \field{status} is set to VIRTIO_CRYPTO_S_HW_READY.
+\item The device MUST set \field{crypto_services} based on the crypto services the device offers.
+\item The device MUST set detailed algorithms masks for each service advertised by \field{crypto_services}.
+    The device MUST NOT set the not defined algorithms bits.
+\item The device MUST set \field{max_size} to show the maximum size of crypto request the device supports.
+\item The device MUST set \field{max_cipher_key_len} to show the maximum length of cipher key if the
+    device supports CIPHER service.
+\item The device MUST set \field{max_auth_key_len} to show the maximum length of authenticated key if
+    the device supports MAC service.
+\end{itemize*}
+
+\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
+
+\begin{itemize*}
+\item The driver MUST read the \field{status} from the bottom bit of status to check whether the
+    VIRTIO_CRYPTO_S_HW_READY is set, and the driver MUST reread it after device reset.
+\item The driver MUST NOT transmit any requests to the device if the VIRTIO_CRYPTO_S_HW_READY is not set.
+\item The driver MUST read \field{max_dataqueues} field to discover the number of data queues the device supports.
+\item The driver MUST read \field{crypto_services} field to discover which services the device is able to offer.
+\item The driver SHOULD ignore the not defined algorithms bits.
+\item The driver MUST read the detailed algorithms fields based on \field{crypto_services} field.
+\item The driver SHOULD read \field{max_size} to discover the maximum size of crypto request the device supports.
+\item The driver SHOULD read \field{max_cipher_key_len} to discover the maximum length of cipher key
+    the device supports.
+\item The driver SHOULD read \field{max_auth_key_len} to discover the maximum length of authenticated
+    key the device supports.
+\end{itemize*}
+
+\subsection{Device Initialization}\label{sec:Device Types / Crypto Device / Device Initialization}
+
+\drivernormative{\subsubsection}{Device Initialization}{Device Types / Crypto Device / Device Initialization}
+
+\begin{itemize*}
+\item The driver MUST configure and initialize all virtqueues.
+\item The driver MUST read the supported crypto services from bits of \field{crypto_services}.
+\item The driver MUST read the supported algorithms based on \field{crypto_services} field.
+\end{itemize*}
+
+\subsection{Device Operation}\label{sec:Device Types / Crypto Device / Device Operation}
+
+The operation of a virtio crypto device is driven by requests placed on the virtqueues.
+Requests consist of a queue-type specific header (specifying among others the operation)
+and an operation specific payload. The payload is generally composed of operation
+parameters, output data, and input data. Operation parameters are crypto-service-specific
+parameters, output data is the data that should be utilized in operations, and input
+data is equal to "operation result + result data".
+
+If VIRTIO_CRYPTO_F_MUX_MODE is negotioated the device may support both session mode
+(See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation})
+and stateless mode operation requests.
+In stateless mode all operation parameters are supplied as a part of each request,
+while in session mode, some or all operation parameters are managed within the
+session. Stateless mode is guarded by feature bits 0-4 on a service level. If
+stateless mode is negotiated for a service, the service is available both in
+session and stateless mode; otherwise it's only available in session mode.
+
+\subsubsection{Operation Status}\label{sec:Device Types / Crypto Device / Device Operation / Operation status}
+The device MUST return a status code as part of the operation (both session
+operation and service operation) result. The valid operation status as follows:
+
+\begin{lstlisting}
+enum VIRTIO_CRYPTO_STATUS {
+    VIRTIO_CRYPTO_OK = 0,
+    VIRTIO_CRYPTO_ERR = 1,
+    VIRTIO_CRYPTO_BADMSG = 2,
+    VIRTIO_CRYPTO_NOTSUPP = 3,
+    VIRTIO_CRYPTO_INVSESS = 4,
+    VIRTIO_CRYPTO_NOSPC = 5,
+    VIRTIO_CRYPTO_MAX
+};
+\end{lstlisting}
+
+\begin{itemize*}
+\item VIRTIO_CRYPTO_OK: success.
+\item VIRTIO_CRYPTO_BADMSG: authentication failed (only when AEAD decryption).
+\item VIRTIO_CRYPTO_NOTSUPP: operation or algorithm is unsupported.
+\item VIRTIO_CRYPTO_INVSESS: invalid session ID when executing crypto operations.
+\item VIRTIO_CRYPTO_NOSPC: no free session ID (only when the VIRTIO_CRYPTO_F_MUX_MODE
+    feature bit is negotiated).
+\item VIRTIO_CRYPTO_ERR: any failure not mentioned above occurs.
+\end{itemize*}
+
+\subsubsection{Control Virtqueue}\label{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue}
+
+The driver uses the control virtqueue to send control commands to the
+device, such as session operations (See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}).
+
+The header for controlq is of the following form:
+\begin{lstlisting}
+#define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
+
+struct virtio_crypto_ctrl_header {
+#define VIRTIO_CRYPTO_CIPHER_CREATE_SESSION \
+       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x02)
+#define VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION \
+       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x03)
+#define VIRTIO_CRYPTO_HASH_CREATE_SESSION \
+       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x02)
+#define VIRTIO_CRYPTO_HASH_DESTROY_SESSION \
+       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x03)
+#define VIRTIO_CRYPTO_MAC_CREATE_SESSION \
+       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x02)
+#define VIRTIO_CRYPTO_MAC_DESTROY_SESSION \
+       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x03)
+#define VIRTIO_CRYPTO_AEAD_CREATE_SESSION \
+       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
+#define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
+       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
+    le32 opcode;
+    /* algo should be service-specific algorithms */
+    le32 algo;
+    le32 flag;
+    le32 reserved;
+};
+\end{lstlisting}
+
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
+
+\paragraph{Session operation}\label{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}
+
+The session is a handle which describes the cryptographic parameters to be
+applied to a number of buffers.
+
+The following structure stores the result of session creation set by the device:
+
+\begin{lstlisting}
+struct virtio_crypto_session_input {
+    /* Device-writable part */
+    le64 session_id;
+    le32 status;
+    le32 padding;
+};
+\end{lstlisting}
+
+A request to destroy a session includes the following information:
+
+\begin{lstlisting}
+struct virtio_crypto_destroy_session_req {
+    /* Device-readable part */
+    le64  session_id;
+    /* Device-writable part */
+    le32  status;
+    le32  padding;
+};
+\end{lstlisting}
+
+\subparagraph{Session operation: HASH session}\label{sec:Device Types / Crypto Device / Device
+Operation / Control Virtqueue / Session operation / Session operation: HASH session}
+
+HASH session requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_hash_session_para {
+    /* See VIRTIO_CRYPTO_HASH_* above */
+    le32 algo;
+    /* hash result length */
+    le32 hash_result_len;
+};
+struct virtio_crypto_hash_create_session_req {
+    /* Device-readable part */
+    struct virtio_crypto_hash_session_para para;
+    /* Device-writable part */
+    struct virtio_crypto_session_input input;
+};
+\end{lstlisting}
+
+The information required by HASH session creation is stored in the
+virtio_crypto_hash_create_session_req structure, including the hash
+parameters stored in \field{para}. \field{input} stores the result of
+this operation.
+
+\subparagraph{Session operation: MAC session}\label{sec:Device Types / Crypto Device / Device
+Operation / Control Virtqueue / Session operation / Session operation: MAC session}
+
+MAC session requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_mac_session_para {
+    /* See VIRTIO_CRYPTO_MAC_* above */
+    le32 algo;
+    /* hash result length */
+    le32 hash_result_len;
+    /* length of authenticated key */
+    le32 auth_key_len;
+    le32 padding;
+};
+
+struct virtio_crypto_mac_create_session_req {
+    /* Device-readable part */
+    struct virtio_crypto_mac_session_para para;
+    /* The authenticated key */
+    u8 auth_key[auth_key_len];
+
+    /* Device-writable part */
+    struct virtio_crypto_session_input input;
+};
+\end{lstlisting}
+
+The information required by MAC session creation is stored in the
+virtio_crypto_mac_create_session_req structure, including the mac
+parameters stored in \field{para} and the authenticated key in \field{auth_key}.
+\field{input} stores the result of this operation.
+
+\subparagraph{Session operation: Symmetric algorithms session}\label{sec:Device Types / Crypto Device / Device
+Operation / Control Virtqueue / Session operation / Session operation: Symmetric algorithms session}
+
+The request of symmetric session includes two parts, CIPHER algorithms
+and chain algorithms (chaining CIPHER and HASH/MAC).
+
+CIPHER session requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_cipher_session_para {
+    /* See VIRTIO_CRYPTO_CIPHER* above */
+    le32 algo;
+    /* length of key */
+    le32 keylen;
+#define VIRTIO_CRYPTO_OP_ENCRYPT  1
+#define VIRTIO_CRYPTO_OP_DECRYPT  2
+    /* encryption or decryption */
+    le32 op;
+    le32 padding;
+};
+
+struct virtio_crypto_cipher_session_req {
+    /* Device-readable part */
+    struct virtio_crypto_cipher_session_para para;
+    /* The cipher key */
+    u8 cipher_key[keylen];
+
+    /* Device-writable part */
+    struct virtio_crypto_session_input input;
+};
+\end{lstlisting}
+
+Algorithm chaining requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_alg_chain_session_para {
+#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
+#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
+    le32 alg_chain_order;
+/* Plain hash */
+#define VIRTIO_CRYPTO_SYM_HASH_MODE_PLAIN    1
+/* Authenticated hash (mac) */
+#define VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH     2
+/* Nested hash */
+#define VIRTIO_CRYPTO_SYM_HASH_MODE_NESTED   3
+    le32 hash_mode;
+    struct virtio_crypto_cipher_session_para cipher_param;
+
+    /*
+     * The additional_para is fixed to 16 bytes in length, it
+     * contains a virtio_crypto_hash_session_para structure or
+     * a virtio_crypto_mac_session_para structure and the data
+     * of unused part (if has) will be ingored.
+     */
+#define VIRTIO_CRYPTO_ALG_CHAIN_SESS_PARA_SIZE  16
+    u8 additional_para[VIRTIO_CRYPTO_ALG_CHAIN_SESS_PARA_SIZE];
+
+    /* length of the additional authenticated data (AAD) in bytes */
+    le32 aad_len;
+    le32 padding;
+};
+
+struct virtio_crypto_alg_chain_session_req {
+    /* Device-readable part */
+    struct virtio_crypto_alg_chain_session_para para;
+    /* The cipher key */
+    u8 cipher_key[keylen];
+    /* The authenticated key */
+    u8 auth_key[auth_key_len];
+
+    /* Device-writable part */
+    struct virtio_crypto_session_input input;
+};
+\end{lstlisting}
+
+Symmetric algorithm requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_sym_create_session_req {
+    /*
+     * The additional_para is fixed to 48 bytes in length, it
+     * contains a virtio_crypto_cipher_session_req structure or
+     * a virtio_crypto_alg_chain_session_req structure and the
+     * data of unused part (if has) will be ingored.
+     */
+#define VIRTIO_CRYPTO_SYM_CREATE_SESS_PARA_SIZE  48
+    u8 additional_para[VIRTIO_CRYPTO_SYM_CREATE_SESS_PARA_SIZE];
+
+    /* Device-readable part */
+
+/* No operation */
+#define VIRTIO_CRYPTO_SYM_OP_NONE  0
+/* Cipher only operation on the data */
+#define VIRTIO_CRYPTO_SYM_OP_CIPHER  1
+/* Chain any cipher with any hash or mac operation. The order
+   depends on the value of alg_chain_order param */
+#define VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING  2
+    le32 op_type;
+    le32 padding;
+};
+\end{lstlisting}
+
+The information required by symmetric algorithms session creation is stored in the
+virtio_crypto_sym_create_session_req structure, including the symmetric operation
+type in \field{op_type} and the cipher parameters stored in \field{cipher} or the
+algorithm chaining paramenters in \field{chain}.
+
+The driver can set the \field{op_type} field in struct virtio_crypto_sym_create_session_req
+as follows: VIRTIO_CRYPTO_SYM_OP_NONE: no operation; VIRTIO_CRYPTO_SYM_OP_CIPHER: Cipher only
+operation on the data; VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING: Chain any cipher with any hash
+or mac operation.
+
+\subparagraph{Session operation: AEAD session}\label{sec:Device Types / Crypto Device / Device
+Operation / Control Virtqueue / Session operation / Session operation: AEAD session}
+
+AEAD session requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_aead_session_para {
+    /* See VIRTIO_CRYPTO_AEAD_* above */
+    le32 algo;
+    /* length of key */
+    le32 key_len;
+    /* Authentication tag length */
+    le32 tag_len;
+    /* The length of the additional authenticated data (AAD) in bytes */
+    le32 aad_len;
+    /* encryption or decryption, See above VIRTIO_CRYPTO_OP_* */
+    le32 op;
+    le32 padding;
+};
+
+struct virtio_crypto_aead_create_session_req {
+    /* Device-readable part */
+    struct virtio_crypto_aead_session_para para;
+    u8 key[key_len];
+
+    /* Device-writeable part */
+    struct virtio_crypto_session_input input;
+};
+\end{lstlisting}
+
+The information required by AEAD session creation is stored in the virtio_crypto_aead_create_session_req
+structure, including the aead parameters stored in \field{para} and the cipher key in \field{key}.
+\field{input} stores the result of this operation.
+
+\drivernormative{\subparagraph}{Session operation: create session}{Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: create session}
+
+\begin{itemize*}
+\item The driver MUST set the control general header and the corresponding crypto-service-specific
+    structure. See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue}.
+\item The driver MUST set the \field{opcode} field based on service type: CIPHER, HASH, MAC, or AEAD.
+\item The driver MUST set the \field{reversed} field to zero.
+\end{itemize*}
+
+\devicenormative{\subparagraph}{Session operation: create session}{Device Types / Crypto Device / Device
+Operation / Control Virtqueue / Session operation / Session operation: create session}
+
+\begin{itemize*}
+\item The device MUST use the corresponding crypto-service-specific structure according to the
+    \field{opcode} in the control general header.
+\item The device MUST set the \field{status} field to one of the following values of enum
+    VIRTIO_CRYPTO_STATUS after finish a session creation:
+\begin{itemize*}
+\item VIRTIO_CRYPTO_OK if a session is created successfully.
+\item VIRTIO_CRYPTO_NOTSUPP if the requested algorithm or operation is unsupported.
+\item VIRTIO_CRYPTO_NOSPC if no free session ID (only when the VIRTIO_CRYPTO_F_MUX_MODE
+    feature bit is negotiated).
+\item VIRTIO_CRYPTO_ERR if failure not mentioned above occurs.
+\end{itemize*}
+\item The device MUST set the \field{session_id} field to a unique session identifier only
+    if the status is set to VIRTIO_CRYPTO_OK.
+\end{itemize*}
+
+\drivernormative{\subparagraph}{Session operation: destroy session}{Device Types / Crypto Device / Device
+Operation / Control Virtqueue / Session operation / Session operation: destroy session}
+
+\begin{itemize*}
+\item The driver MUST set the \field{opcode} field based on service type: CIPHER, HASH, MAC, or AEAD.
+\item The driver MUST set the \field{session_id} to a valid value assigned by the device
+    when the session was created.
+\end{itemize*}
+
+\devicenormative{\subparagraph}{Session operation: destroy session}{Device Types / Crypto Device / Device
+Operation / Control Virtqueue / Session operation / Session operation: destroy session}
+
+\begin{itemize*}
+\item The device MUST set the \field{status} field to one of the following values of enum VIRTIO_CRYPTO_STATUS.
+\begin{itemize*}
+\item VIRTIO_CRYPTO_OK if a session is created successfully.
+\item VIRTIO_CRYPTO_ERR if any failure occurs.
+\end{itemize*}
+\end{itemize*}
+
+\subsubsection{Data Virtqueue}\label{sec:Device Types / Crypto Device / Device Operation / Data Virtqueue}
+
+The driver uses the data virtqueues to transmit crypto operation requests to the device,
+and completes the crypto operations.
+
+The header for dataq is as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_op_header {
+#define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
+    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
+#define VIRTIO_CRYPTO_CIPHER_DECRYPT \
+    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
+#define VIRTIO_CRYPTO_HASH \
+    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
+#define VIRTIO_CRYPTO_MAC \
+    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
+#define VIRTIO_CRYPTO_AEAD_ENCRYPT \
+    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
+#define VIRTIO_CRYPTO_AEAD_DECRYPT \
+    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
+    le32 opcode;
+    /* algo should be service-specific algorithms */
+    le32 algo;
+    le64 session_id;
+#define VIRTIO_CRYPTO_FLAG_SESSION_MODE 1
+    /* control flag to control the request */
+    le32 flag;
+    le32 padding;
+};
+\end{lstlisting}
+
+The dataq request is composed of two parts:
+\begin{lstlisting}
+struct virtio_crypto_op_data_req {
+    struct virtio_crypto_op_header header;
+
+    /* additional paramenter */
+    u8 additional_para[addl_para_len];
+};
+\end{lstlisting}
+
+The first is a general header (see above). And the second one, additional
+paramenter, contains an crypto-service-specific structure, which MUST be one
+of the following types:
+\begin{itemize*}
+\item struct virtio_crypto_sym_data_req
+\item struct virtio_crypto_hash_data_req
+\item struct virtio_crypto_mac_data_req
+\item struct virtio_crypto_aead_data_req
+\item struct virtio_crypto_sym_data_req_stateless (only for multiplexing mode)
+\item struct virtio_crypto_hash_data_req_stateless (only for multiplexing mode)
+\item struct virtio_crypto_mac_data_req_stateless (only for multiplexing mode)
+\item struct virtio_crypto_aead_data_req_stateless (only for multiplexing mode)
+\end{itemize*}
+
+The size of the additional paramenter depends on the VIRTIO_CRYPTO_F_MUX_MODE
+feature bit:
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is NOT negotiated, the
+    size of additional paramenter is fixed to 48 bytes, the data of the unused
+    part (if has) will be ingored.
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the size of
+    additional paramenter is flexible, which is the same as the crypto-service-specific
+    structure used.
+
+There is a unified input header for all crypto services, is defined as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_inhdr {
+    u8 status;
+};
+\end{lstlisting}
+
+\subsubsection{HASH Service Operation}\label{sec:Device Types / Crypto Device / Device Operation / HASH Service Operation}
+
+Session mode HASH service requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_hash_para {
+    /* length of source data */
+    le32 src_data_len;
+    /* hash result length */
+    le32 hash_result_len;
+};
+
+struct virtio_crypto_hash_data_req {
+    /* Device-readable part */
+    struct virtio_crypto_hash_para para;
+    /* Source data */
+    u8 src_data[src_data_len];
+
+    /* Device-writable part */
+    /* Hash result data */
+    u8 hash_result[hash_result_len];
+    struct virtio_crypto_inhdr inhdr;
+};
+\end{lstlisting}
+
+Each data request uses virtio_crypto_hash_data_req structure to store information
+used to run the HASH operations.
+
+The information includes the hash parameters stored in \field{para}, output data
+and input data. The output data here includes the source data and the input data
+includes the hash result data used to save the results of the HASH operations.
+\field{inhdr} stores the status of executing the HASH operations.
+
+Stateless mode HASH service requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_hash_para_statelesss {
+    struct {
+        /* See VIRTIO_CRYPTO_HASH_* above */
+        le32 algo;
+    } sess_para;
+
+    /* length of source data */
+    le32 src_data_len;
+    /* hash result length */
+    le32 hash_result_len;
+    le32 reserved;
+};
+struct virtio_crypto_hash_data_req_stateless {
+    /* Device-readable part */
+    struct virtio_crypto_hash_para_stateless para;
+    /* Source data */
+    u8 src_data[src_data_len];
+
+    /* Device-writable part */
+    /* Hash result data */
+    u8 hash_result[hash_result_len];
+    struct virtio_crypto_inhdr inhdr;
+};
+\end{lstlisting}
+
+\drivernormative{\paragraph}{HASH Service Operation}{Device Types / Crypto Device / Device Operation / HASH Service Operation}
+
+\begin{itemize*}
+\item If the driver uses the session mode, then the driver MUST set \field{session_id}
+    in struct virtio_crypto_op_header to a valid value assigned by the device when the
+	session was created.
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the driver MUST use
+    struct virtio_crypto_op_data_req_mux to wrap crypto requests. Otherwise, the driver
+	MUST use struct virtio_crypto_op_data_req.
+\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is negotiated, 1) if the
+    driver uses the stateless mode, then the driver MUST set the \field{flag} field in
+	struct virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set the
+	fields in struct virtio_crypto_hash_para_stateless.sess_para, 2) if the driver uses
+	the session mode, then the driver MUST set the \field{flag} field in struct
+	virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
+\item The driver MUST set \field{opcode} in struct virtio_crypto_op_header to VIRTIO_CRYPTO_HASH.
+\end{itemize*}
+
+\devicenormative{\paragraph}{HASH Service Operation}{Device Types / Crypto Device / Device Operation / HASH Service Operation}
+
+\begin{itemize*}
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the device MUST parse
+    the struct virtio_crypto_op_data_req_mux for crypto requests. Otherwise, the device
+	MUST parse the struct virtio_crypto_op_data_req.
+\item The device MUST use the corresponding crypto-service-specific structure according
+    to the \field{opcode} in the data general header.
+\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is negotiated, the device
+    MUST parse \field{flag} field in struct virtio_crypto_op_header in order to decide
+	which mode the driver uses.
+\item The device MUST copy the results of HASH operations in the hash_result[] if HASH
+    operations success.
+\item The device MUST set \field{status} in struct virtio_crypto_inhdr to one of the
+    following values of enum VIRTIO_CRYPTO_STATUS:
+\begin{itemize*}
+\item VIRTIO_CRYPTO_OK if the operation success.
+\item VIRTIO_CRYPTO_NOTSUPP if the requested algorithm or operation is unsupported.
+\item VIRTIO_CRYPTO_INVSESS if the session ID invalid when in session mode.
+\item VIRTIO_CRYPTO_ERR if any failure not mentioned above occurs.
+\end{itemize*}
+\end{itemize*}
+
+\subsubsection{MAC Service Operation}\label{sec:Device Types / Crypto Device / Device Operation / MAC Service Operation}
+
+Session mode MAC service requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_mac_para {
+    struct virtio_crypto_hash_para hash;
+};
+
+struct virtio_crypto_mac_data_req {
+    /* Device-readable part */
+    struct virtio_crypto_mac_para para;
+    /* Source data */
+    u8 src_data[src_data_len];
+
+    /* Device-writable part */
+    /* Hash result data */
+    u8 hash_result[hash_result_len];
+    struct virtio_crypto_inhdr inhdr;
+};
+\end{lstlisting}
+
+Each request uses the virtio_crypto_mac_data_req structure to store information
+used to run the MAC operations.
+
+The information includes the hash parameters stored in \field{para}, output data
+and input data. The output data here includes the source data and the input data
+includes the hash result data used to save the results of the MAC operations.
+\field{inhdr} stores the status of executing the MAC operations.
+
+Stateless mode MAC service requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_mac_para_stateless {
+    struct {
+        /* See VIRTIO_CRYPTO_MAC_* above */
+        le32 algo;
+        /* length of authenticated key */
+        le32 auth_key_len;
+    } sess_para;
+
+    /* length of source data */
+    le32 src_data_len;
+    /* hash result length */
+    le32 hash_result_len;
+};
+
+struct virtio_crypto_mac_data_req_stateless {
+    /* Device-readable part */
+    struct virtio_crypto_mac_para_stateless para;
+    /* The authenticated key */
+    u8 auth_key[auth_key_len];
+    /* Source data */
+    u8 src_data[src_data_len];
+
+    /* Device-writable part */
+    /* Hash result data */
+    u8 hash_result[hash_result_len];
+    struct virtio_crypto_inhdr inhdr;
+};
+\end{lstlisting}
+
+\drivernormative{\paragraph}{MAC Service Operation}{Device Types / Crypto Device / Device Operation / MAC Service Operation}
+
+\begin{itemize*}
+\item If the driver uses the session mode, then the driver MUST set \field{session_id}
+    in struct virtio_crypto_op_header to a valid value assigned by the device when the
+	session was created.
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the driver MUST use
+    struct virtio_crypto_op_data_req_mux to wrap crypto requests. Otherwise, the
+	driver MUST use struct virtio_crypto_op_data_req.
+\item If the VIRTIO_CRYPTO_F_MAC_STATELESS_MODE feature bit is negotiated, 1) if the
+    driver uses the stateless mode, then the driver MUST set the \field{flag} field
+	in struct virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST
+	set the fields in struct virtio_crypto_mac_para_stateless.sess_para, 2) if the
+	driver uses the session mode, then the driver MUST set the \field{flag} field in
+	struct virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
+\item The driver MUST set \field{opcode} in struct virtio_crypto_op_header to VIRTIO_CRYPTO_MAC.
+\end{itemize*}
+
+\devicenormative{\paragraph}{MAC Service Operation}{Device Types / Crypto Device / Device Operation / MAC Service Operation}
+
+\begin{itemize*}
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the device MUST parse
+    the struct virtio_crypto_op_data_req_mux for crypto requests. Otherwise, the device
+	MUST parse the struct virtio_crypto_op_data_req.
+\item If the VIRTIO_CRYPTO_F_MAC_STATELESS_MODE feature bit is negotiated, the device
+    MUST parse \field{flag} field in struct virtio_crypto_op_header in order to decide
+	which mode the driver uses.
+\item The device MUST copy the results of MAC operations in the hash_result[] if HASH
+    operations success.
+\item The device MUST set \field{status} in struct virtio_crypto_inhdr to one of the
+    following values of enum VIRTIO_CRYPTO_STATUS:
+\begin{itemize*}
+\item VIRTIO_CRYPTO_OK if the operation success.
+\item VIRTIO_CRYPTO_NOTSUPP if the requested algorithm or operation is unsupported.
+\item VIRTIO_CRYPTO_INVSESS if the session ID invalid when in session mode.
+\item VIRTIO_CRYPTO_ERR if any failure not mentioned above occurs.
+\end{itemize*}
+\end{itemize*}
+
+\subsubsection{Symmetric algorithms Operation}\label{sec:Device Types / Crypto Device / Device Operation / Symmetric algorithms Operation}
+
+Session mode CIPHER service requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_cipher_para {
+    /*
+     * Byte Length of valid IV/Counter data pointed to by the below iv data.
+     *
+     * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or for
+     *   SNOW3G in UEA2 mode, this is the length of the IV (which
+     *   must be the same as the block length of the cipher).
+     * For block ciphers in CTR mode, this is the length of the counter
+     *   (which must be the same as the block length of the cipher).
+     */
+    le32 iv_len;
+    /* length of source data */
+    le32 src_data_len;
+    /* length of destination data */
+    le32 dst_data_len;
+    le32 padding;
+};
+
+struct virtio_crypto_cipher_data_req {
+    /* Device-readable part */
+    struct virtio_crypto_cipher_para para;
+    /*
+     * Initialization Vector or Counter data.
+     *
+     * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or for
+     *   SNOW3G in UEA2 mode, this is the Initialization Vector (IV)
+     *   value.
+     * For block ciphers in CTR mode, this is the counter.
+     * For AES-XTS, this is the 128bit tweak, i, from IEEE Std 1619-2007.
+     *
+     * The IV/Counter will be updated after every partial cryptographic
+     * operation.
+     */
+    u8 iv[iv_len];
+    /* Source data */
+    u8 src_data[src_data_len];
+
+    /* Device-writable part */
+    /* Destination data */
+    u8 dst_data[dst_data_len];
+    struct virtio_crypto_inhdr inhdr;
+};
+\end{lstlisting}
+
+Session mode requests of algorithm chaining are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_alg_chain_data_para {
+    le32 iv_len;
+    /* Length of source data */
+    le32 src_data_len;
+    /* Length of destination data */
+    le32 dst_data_len;
+    /* Starting point for cipher processing in source data */
+    le32 cipher_start_src_offset;
+    /* Length of the source data that the cipher will be computed on */
+    le32 len_to_cipher;
+    /* Starting point for hash processing in source data */
+    le32 hash_start_src_offset;
+    /* Length of the source data that the hash will be computed on */
+    le32 len_to_hash;
+    /* Length of the additional auth data */
+    le32 aad_len;
+    /* Length of the hash result */
+    le32 hash_result_len;
+    le32 reserved;
+};
+
+struct virtio_crypto_alg_chain_data_req {
+    /* Device-readable part */
+    struct virtio_crypto_alg_chain_data_para para;
+    /* Initialization Vector or Counter data */
+    u8 iv[iv_len];
+    /* Source data */
+    u8 src_data[src_data_len];
+    /* Additional authenticated data if exists */
+    u8 aad[aad_len];
+
+    /* Device-writable part */
+    /* Destination data */
+    u8 dst_data[dst_data_len];
+    /* Hash result data */
+    u8 hash_result[hash_result_len];
+    struct virtio_crypto_inhdr inhdr;
+};
+\end{lstlisting}
+
+Session mode requests of symmetric algorithm are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_sym_data_req {
+    /*
+     * The additional_para is fixed to 40 bytes in length, it
+     * contains a virtio_crypto_cipher_data_req structure or
+     * a virtio_crypto_cipher_data_req structure and the data
+     * of unused part (if has) will be ingored.
+     */
+#define VIRTIO_CRYPTO_SYM_DATE_REQ_PARA_SIZE    40
+    u8 additional_para[VIRTIO_CRYPTO_SYM_DATE_REQ_PARA_SIZE];
+
+    /* Device-readable part */
+
+    /* See above VIRTIO_CRYPTO_SYM_OP_* */
+    le32 op_type;
+    le32 padding;
+};
+\end{lstlisting}
+
+Each request uses the virtio_crypto_sym_data_req structure to store information
+used to run the CIPHER operations.
+
+The information includes the cipher parameters stored in \field{para}, output data
+and input data. In the first virtio_crypto_cipher_para structure, \field{iv_len}
+specifies the length of the initialization vector or counter, \field{src_data_len}
+specifies the length of the source data, and \field{dst_data_len} specifies the length
+of the destination data. For plain CIPHER operations, the output data here includes
+the IV/Counter data and source data, and the input data includes the destination data
+used to save the results of the CIPHER operations.
+
+For algorithms chain, the output data here includes the IV/Counter data, source data
+and additional authenticated data if exists. The input data includes both destination
+data and hash result data used to store the results of the HASH/MAC operations.
+\field{inhdr} stores the status of executing the crypto operations.
+
+Stateless mode CIPHER service requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_cipher_para_stateless {
+    struct {
+        /* See VIRTIO_CRYPTO_CIPHER* above */
+        le32 algo;
+        /* length of key */
+        le32 keylen;
+
+        /* See VIRTIO_CRYPTO_OP_* above */
+        le32 op;
+    } sess_para;
+
+    /*
+     * Byte Length of valid IV/Counter data pointed to by the below iv data.
+     */
+    le32 iv_len;
+    /* length of source data */
+    le32 src_data_len;
+    /* length of destination data */
+    le32 dst_data_len;
+};
+
+struct virtio_crypto_cipher_data_req_stateless {
+    /* Device-readable part */
+    struct virtio_crypto_cipher_para_stateless para;
+    /* The cipher key */
+    u8 cipher_key[keylen];
+
+    /* Initialization Vector or Counter data. */
+    u8 iv[iv_len];
+    /* Source data */
+    u8 src_data[src_data_len];
+
+    /* Device-writable part */
+    /* Destination data */
+    u8 dst_data[dst_data_len];
+    struct virtio_crypto_inhdr inhdr;
+};
+\end{lstlisting}
+
+Stateless mode requests of algorithm chaining are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_alg_chain_data_para_stateless {
+    struct {
+        /* See VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_* above */
+        le32 alg_chain_order;
+        /* length of the additional authenticated data in bytes */
+        le32 aad_len;
+
+        struct {
+            /* See VIRTIO_CRYPTO_CIPHER* above */
+            le32 algo;
+            /* length of key */
+            le32 keylen;
+            /* See VIRTIO_CRYPTO_OP_* above */
+            le32 op;
+        } cipher;
+
+        struct {
+            /* See VIRTIO_CRYPTO_HASH_* or VIRTIO_CRYPTO_MAC_* above */
+            le32 algo;
+            /* length of authenticated key */
+            le32 auth_key_len;
+            /* See VIRTIO_CRYPTO_SYM_HASH_MODE_* above */
+            le32 hash_mode;
+        } hash;
+    } sess_para;
+
+    le32 iv_len;
+    /* Length of source data */
+    le32 src_data_len;
+    /* Length of destination data */
+    le32 dst_data_len;
+    /* Starting point for cipher processing in source data */
+    le32 cipher_start_src_offset;
+    /* Length of the source data that the cipher will be computed on */
+    le32 len_to_cipher;
+    /* Starting point for hash processing in source data */
+    le32 hash_start_src_offset;
+    /* Length of the source data that the hash will be computed on */
+    le32 len_to_hash;
+    /* Length of the additional auth data */
+    le32 aad_len;
+    /* Length of the hash result */
+    le32 hash_result_len;
+    le32 reserved;
+};
+
+struct virtio_crypto_alg_chain_data_req_stateless {
+    /* Device-readable part */
+    struct virtio_crypto_alg_chain_data_para_stateless para;
+    /* The cipher key */
+    u8 cipher_key[keylen];
+    /* The auth key */
+    u8 auth_key[auth_key_len];
+    /* Initialization Vector or Counter data */
+    u8 iv[iv_len];
+    /* Additional authenticated data if exists */
+    u8 aad[aad_len];
+    /* Source data */
+    u8 src_data[src_data_len];
+
+    /* Device-writable part */
+    /* Destination data */
+    u8 dst_data[dst_data_len];
+    /* Hash result data */
+    u8 hash_result[hash_result_len];
+    struct virtio_crypto_inhdr inhdr;
+};
+\end{lstlisting}
+
+Stateless mode requests of symmetric algorithm are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_sym_data_req_stateless {
+    /* additional paramenter */
+#define VIRTIO_CRYPTO_SYM_DATE_REQ_PARA_STATELESS_SIZE    72
+    u8 additional_para[VVIRTIO_CRYPTO_SYM_DATE_REQ_PARA_STATELESS_SIZE];
+
+    /* Device-readable part */
+    /* See above VIRTIO_CRYPTO_SYM_OP_* */
+    le32 op_type;
+};
+\end{lstlisting}
+
+\begin{itemize*}
+The \field{additional_para} is fixed to 72 bytes in length, it contains a
+virtio_crypto_cipher_data_req_stateless structure or a virtio_crypto_alg_chain_data_req_stateless
+structure and the data of the unused part (if has) will be ingored.
+\end{itemize*}
+
+\drivernormative{\paragraph}{Symmetric algorithms Operation}{Device Types / Crypto Device / Device Operation / Symmetric algorithms Operation}
+
+\begin{itemize*}
+\item If the driver uses the session mode, then the driver MUST set \field{session_id}
+    in struct virtio_crypto_op_header to a valid value assigned by the device when the
+	session was created.
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the driver MUST use
+    struct virtio_crypto_op_data_req_mux to wrap crypto requests. Otherwise, the driver
+	MUST use struct virtio_crypto_op_data_req.
+\item If the VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE feature bit is negotiated, 1) if the
+    driver uses the stateless mode, then the driver MUST set the \field{flag} field in
+	struct virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set the
+	fields in struct virtio_crypto_cipher_para_stateless.sess_para or struct
+	virtio_crypto_alg_chain_data_para_stateless.sess_para, 2) if the driver uses the
+	session mode, then the driver MUST set the \field{flag} field in struct
+	virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
+\item The driver MUST set the \field{opcode} field in struct virtio_crypto_op_header
+    to VIRTIO_CRYPTO_CIPHER_ENCRYPT or VIRTIO_CRYPTO_CIPHER_DECRYPT.
+\item The driver MUST specify the fields of struct virtio_crypto_cipher_data_req in
+    struct virtio_crypto_sym_data_req if the request is based on VIRTIO_CRYPTO_SYM_OP_CIPHER.
+\item The driver MUST specify the fields of both struct virtio_crypto_cipher_data_req
+    and struct virtio_crypto_mac_data_req in struct virtio_crypto_sym_data_req if the request
+	is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING type and in the VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH mode.
+\end{itemize*}
+
+\devicenormative{\paragraph}{Symmetric algorithms Operation}{Device Types / Crypto Device / Device Operation / Symmetric algorithms Operation}
+
+\begin{itemize*}
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the device MUST parse
+    the struct virtio_crypto_op_data_req_mux for crypto requests. Otherwise, the device
+	MUST parse the struct virtio_crypto_op_data_req.
+\item If the VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE feature bit is negotiated, the device
+    MUST parse \field{flag} field in struct virtio_crypto_op_header in order to decide
+	which mode the driver uses.
+\item The device MUST parse the virtio_crypto_sym_data_req based on the \field{opcode}
+    field in general header.
+\item The device SHOULD only parse fields of struct virtio_crypto_cipher_data_req in
+    struct virtio_crypto_sym_data_req if the request is VIRTIO_CRYPTO_SYM_OP_CIPHER type.
+\item The device MUST parse fields of both struct virtio_crypto_cipher_data_req and
+    struct virtio_crypto_mac_data_req in struct virtio_crypto_sym_data_req if the request
+	is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING operation type and in the
+	VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH mode.
+\item The device MUST copy the result of cryptographic operation in the dst_data[] in
+    both plain CIPHER mode and algorithms chain mode.
+\item The device MUST check the \field{para}.\field{add_len} is bigger than 0 before
+    parse the additional authenticated data in plain algorithms chain mode.
+\item The device MUST copy the result of HASH/MAC operation in the hash_result[] is
+    of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING type.
+\item The device MUST set the \field{status} field in struct virtio_crypto_inhdr to
+    one of the following values of enum VIRTIO_CRYPTO_STATUS:
+\begin{itemize*}
+\item VIRTIO_CRYPTO_OK if the operation success.
+\item VIRTIO_CRYPTO_NOTSUPP if the requested algorithm or operation is unsupported.
+\item VIRTIO_CRYPTO_INVSESS if the session ID is invalid in session mode.
+\item VIRTIO_CRYPTO_ERR if failure not mentioned above occurs.
+\end{itemize*}
+\end{itemize*}
+
+\subsubsection{AEAD Service Operation}\label{sec:Device Types / Crypto Device / Device Operation / AEAD Service Operation}
+
+Session mode requests of symmetric algorithm are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_aead_para {
+    /*
+     * Byte Length of valid IV data.
+     *
+     * For GCM mode, this is either 12 (for 96-bit IVs) or 16, in which
+     *   case iv points to J0.
+     * For CCM mode, this is the length of the nonce, which can be in the
+     *   range 7 to 13 inclusive.
+     */
+    le32 iv_len;
+    /* length of additional auth data */
+    le32 aad_len;
+    /* length of source data */
+    le32 src_data_len;
+    /* length of dst data, this should be at least src_data_len + tag_len */
+    le32 dst_data_len;
+    /* Authentication tag length */
+    le32 tag_len;
+    le32 reserved;
+};
+
+struct virtio_crypto_aead_data_req {
+    /* Device-readable part */
+    struct virtio_crypto_aead_para para;
+    /*
+     * Initialization Vector data.
+     *
+     * For GCM mode, this is either the IV (if the length is 96 bits) or J0
+     *   (for other sizes), where J0 is as defined by NIST SP800-38D.
+     *   Regardless of the IV length, a full 16 bytes needs to be allocated.
+     * For CCM mode, the first byte is reserved, and the nonce should be
+     *   written starting at &iv[1] (to allow space for the implementation
+     *   to write in the flags in the first byte).  Note that a full 16 bytes
+     *   should be allocated, even though the iv_len field will have
+     *   a value less than this.
+     *
+     * The IV will be updated after every partial cryptographic operation.
+     */
+    u8 iv[iv_len];
+    /* Source data */
+    u8 src_data[src_data_len];
+    /* Additional authenticated data if exists */
+    u8 aad[aad_len];
+
+    /* Device-writable part */
+    /* Pointer to output data */
+    u8 dst_data[dst_data_len];
+
+    struct virtio_crypto_inhdr inhdr;
+};
+\end{lstlisting}
+
+Each data request uses virtio_crypto_aead_data_req structure to store information
+used to run the AEAD operations.
+
+The information includes the hash parameters stored in \field{para}, output data
+and input data. In the first virtio_crypto_aead_para structure, \field{iv_len}
+specifies the length of the initialization vector. \field{tag_len} specifies the
+length of the authentication tag; \field{aad_len} specifies the length of additional
+authentication data, \field{src_data_len} specifies the length of the source data;
+\field{dst_data_len} specifies the length of the destination data, which is at least
+\field{src_data_len} + \field{tag_len}.
+
+The output data here includes the IV/Counter data, source data and additional
+authenticated data if exists. The input data includes both destination data used
+to save the results of the AEAD operations. \field{inhdr} stores the status of
+executing the AEAD operations.
+
+Stateless mode AEAD service requests are as follows:
+
+\begin{lstlisting}
+struct virtio_crypto_aead_para_stateless {
+    struct {
+        /* See VIRTIO_CRYPTO_AEAD_* above */
+        le32 algo;
+        /* length of key */
+        le32 key_len;
+        /* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
+        le32 op;
+    } sess_para;
+
+    /* Byte Length of valid IV data. */
+    le32 iv_len;
+    /* Authentication tag length */
+    le32 tag_len;
+    /* length of additional auth data */
+    le32 aad_len;
+    /* length of source data */
+    le32 src_data_len;
+    /* length of dst data, this should be at least src_data_len + tag_len */
+    le32 dst_data_len;
+};
+
+struct virtio_crypto_aead_data_req_stateless {
+    /* Device-readable part */
+    struct virtio_crypto_aead_para_stateless para;
+    /* The cipher key */
+    u8 key[key_len];
+    /* Initialization Vector data. */
+    u8 iv[iv_len];
+    /* Source data */
+    u8 src_data[src_data_len];
+    /* Additional authenticated data if exists */
+    u8 aad[aad_len];
+
+    /* Device-writable part */
+    /* Pointer to output data */
+    u8 dst_data[dst_data_len];
+
+    struct virtio_crypto_inhdr inhdr;
+};
+\end{lstlisting}
+
+\drivernormative{\paragraph}{AEAD Service Operation}{Device Types / Crypto Device / Device Operation / AEAD Service Operation}
+
+\begin{itemize*}
+\item If the driver uses the session mode, then the driver MUST set
+    \field{session_id} in struct virtio_crypto_op_header to a valid value assigned
+	by the device when the session was created.
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the driver MUST
+    use struct virtio_crypto_op_data_req_mux to wrap crypto requests. Otherwise,
+	the driver MUST use struct virtio_crypto_op_data_req.
+\item If the VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE feature bit is negotiated, 1) if
+    the driver uses the stateless mode, then the driver MUST set the \field{flag}
+	field in struct virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATELESS_MODE
+	and MUST set the fields in struct virtio_crypto_aead_para_stateless.sess_para,
+	2) if the driver uses the session mode, then the driver MUST set the \field{flag}
+	field in struct virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
+\item The driver MUST set the \field{opcode} field in struct virtio_crypto_op_header
+    to VIRTIO_CRYPTO_AEAD_ENCRYPT or VIRTIO_CRYPTO_AEAD_DECRYPT.
+\end{itemize*}
+
+\devicenormative{\paragraph}{AEAD Service Operation}{Device Types / Crypto Device / Device Operation / AEAD Service Operation}
+
+\begin{itemize*}
+\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is negotiated, the device MUST
+    parse the struct virtio_crypto_op_data_req_mux for crypto requests. Otherwise,
+	the device MUST parse the struct virtio_crypto_op_data_req.
+\item If the VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE feature bit is negotiated, the
+    device MUST parse the virtio_crypto_aead_data_req based on the \field{opcode}
+	field in general header.
+\item The device MUST copy the result of cryptographic operation in the dst_data[].
+\item The device MUST copy the authentication tag in the dst_data[] offset the cipher result.
+\item The device MUST set the \field{status} field in struct virtio_crypto_inhdr to
+    one of the following values of enum VIRTIO_CRYPTO_STATUS:
+\item When the \field{opcode} field is VIRTIO_CRYPTO_AEAD_DECRYPT, the device MUST
+    verify and return the verification result to the driver.
+\begin{itemize*}
+\item VIRTIO_CRYPTO_OK if the operation success.
+\item VIRTIO_CRYPTO_NOTSUPP if the requested algorithm or operation is unsupported.
+\item VIRTIO_CRYPTO_BADMSG if the verification result is incorrect.
+\item VIRTIO_CRYPTO_INVSESS if the session ID invalid when in session mode.
+\item VIRTIO_CRYPTO_ERR if any failure not mentioned above occurs.
+\end{itemize*}
+\end{itemize*}
-- 
1.8.3.1
