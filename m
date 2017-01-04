Received: from eggs.gnu.org ([2001:4830:134:3::10]:37171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cOiWy-0003Mu-V7
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cOiWs-00025E-LA
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:10:52 -0500
Received: from [45.249.212.188] (port=2434 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cOiWq-0001xg-51
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:10:46 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 4 Jan 2017 10:10:05 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA174989@DGGEMA505-MBX.china.huawei.com>
References: <1483524185-9036-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1483524185-9036-1-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v15 0/2] virtio-crypto: virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, Claudio Fontana <Claudio.Fontana@huawei.com>, "Zhoujian
	(jay, Euler)" <jianjay.zhou@huawei.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, Shiqing Fan <Shiqing.Fan@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>

Hi all,

I attach the diff files between v14 and v15 for better review.

diff --git a/virtio-crypto.tex b/virtio-crypto.tex
index 9f7faf0..884ee95 100644
--- a/virtio-crypto.tex
+++ b/virtio-crypto.tex
@@ -2,8 +2,8 @@
=20
 The virtio crypto device is a virtual cryptography device as well as a kin=
d of
 virtual hardware accelerator for virtual machines. The encryption and
-decryption requests are placed in the data queue and are ultimately handle=
d by the
-backend crypto accelerators. The second queue is the control queue used to=
 create=20
+decryption requests are placed in any of the data active queues and are ul=
timately handled by the
+backend crypto accelerators. The second kind of queue is the control queue=
 used to create=20
 or destroy sessions for symmetric algorithms and will control some advance=
d
 features in the future. The virtio crypto device provides the following cr=
ypto
 services: CIPHER, MAC, HASH, and AEAD.
@@ -26,7 +26,7 @@ N is set by \field{max_dataqueues}.
=20
 \subsection{Feature bits}\label{sec:Device Types / Crypto Device / Feature=
 bits}
=20
-Undefined currently.
+None currently defined.
=20
 \subsection{Device configuration layout}\label{sec:Device Types / Crypto D=
evice / Device configuration layout}
=20
@@ -54,13 +54,14 @@ struct virtio_crypto_config {
 };
 \end{lstlisting}
=20
-The value of the \field{status} field is VIRTIO_CRYPTO_S_HW_READY or VIRTI=
O_CRYPTO_S_STARTED.
+The value of the \field{status} field is VIRTIO_CRYPTO_S_HW_READY or ~VIRT=
IO_CRYPTO_S_HW_READY.
=20
 \begin{lstlisting}
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
-#define VIRTIO_CRYPTO_S_STARTED  (1 << 1)
 \end{lstlisting}
=20
+The VIRTIO_CRYPTO_S_HW_READY flag is used to show whether the hardware is =
ready to work or not.
+
 The following driver-read-only fields include \field{max_dataqueues}, whic=
h specifies the
 maximum number of data virtqueues (dataq1\ldots dataqN), and \field{crypto=
_services},
 which indicates the crypto services the virtio crypto supports.
@@ -172,7 +173,7 @@ Any other value is reserved for future use.
 \item The driver MUST read the ready \field{status} from the bottom bit of=
 status to check whether the hardware-backed
       implementation is ready or not, and the driver MUST reread it after =
the device reset.=20
 \item The driver MUST NOT transmit any packets to the device if the ready =
\field{status} is not set.
-\item The driver MAY read \field{max_dataqueues} field to discover the num=
ber of data queues the device supports.
+\item The driver MUST read \field{max_dataqueues} field to discover the nu=
mber of data queues the device supports.
 \item The driver MUST read \field{crypto_services} field to discover which=
 services the device is able to offer.
 \item The driver MUST read the detailed algorithms fields based on \field{=
crypto_services} field.
 \item The driver SHOULD read \field{max_size} to discover the maximum size=
 of crypto request the device supports.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DThe below diff shows the chang=
es of add non-session mode support:

diff --git a/virtio-crypto.tex b/virtio-crypto.tex
index 884ee95..44819f9 100644
--- a/virtio-crypto.tex
+++ b/virtio-crypto.tex
@@ -26,7 +26,10 @@ N is set by \field{max_dataqueues}.
=20
 \subsection{Feature bits}\label{sec:Device Types / Crypto Device / Feature=
 bits}
=20
-None currently defined.
+VIRTIO_CRYPTO_F_CIPHER_SESSION_MODE (1) Session mode is available for CIPH=
ER service.
+VIRTIO_CRYPTO_F_HASH_SESSION_MODE (2) Session mode is available for HASH s=
ervice.
+VIRTIO_CRYPTO_F_MAC_SESSION_MODE (3) Session mode is available for MAC ser=
vice.
+VIRTIO_CRYPTO_F_AEAD_SESSION_MODE (4) Session mode is available for AEAD s=
ervice.
=20
 \subsection{Device configuration layout}\label{sec:Device Types / Crypto D=
evice / Device configuration layout}
=20
@@ -208,6 +211,9 @@ Operation parameters are algorithm-specific parameters,=
 output data is the
 data that should be utilized in operations, and input data is equal to
 "operation result + result data".
=20
+The device can support both session mode (See \ref{sec:Device Types / Cryp=
to Device / Device Operation / Control Virtqueue / Session operation}) and =
non-session mode, for example,
+As VIRTIO_CRYPTO_F_CIPHER_SESSION feature bit is negotiated, the driver ca=
n use session mode for CIPHER service, otherwise it can only use non-sessio=
n mode.
+
 \begin{note}
 The basic unit of all data length the byte.
 \end{note}
@@ -263,6 +269,8 @@ struct virtio_crypto_op_header {
     le32 algo;
     /* session_id should be service-specific algorithms */
     le64 session_id;
+#define VIRTIO_CRYPTO_FLAG_SESSION_MODE 1
+#define VIRTIO_CRYPTO_FLAG_NONE_SESSION_MODE 2
     /* control flag to control the request */
     le32 flag;
     le32 padding;
@@ -501,11 +509,11 @@ struct virtio_crypto_aead_session_para {
     le32 algo;
     /* length of key */
     le32 key_len;
-    /* hash result length */
-    le32 hash_result_len;
+    /* Authentication tag length */
+    le32 tag_len;
     /* The length of the additional authenticated data (AAD) in bytes */
     le32 aad_len;
-    /* encryption or decryption, See above VIRTIO_CRYPTO_* */
+    /* encryption or decryption, See above VIRTIO_CRYPTO_OP_* */
     le32 op;
     le32 padding;
 };
@@ -588,10 +596,16 @@ struct virtio_crypto_inhdr {
=20
 \begin{lstlisting}
 struct virtio_crypto_hash_para {
+    struct {
+        /* See VIRTIO_CRYPTO_HASH_* above */
+        le32 algo;
+    } sess_para;
+
     /* length of source data */
     le32 src_data_len;
     /* hash result length */
     le32 hash_result_len;
+    le32 reserved;
 };
=20
 struct virtio_crypto_hash_data_req {
@@ -617,9 +631,11 @@ The output data here includes the source data and the =
input data includes the ha
 \drivernormative{\paragraph}{HASH Service Operation}{Device Types / Crypto=
 Device / Device Operation / HASH Service Operation}
=20
 \begin{itemize*}
-\item The driver MUST set the \field{session_id} in struct virtio_crypto_o=
p_header to a valid value which assigned by the device when a session is cr=
eated.
+\item If the VIRTIO_CRYPTO_F_HASH_SESSION_MODE feature bit is negotiated a=
nd the driver uses the session mode, then the driver MUST set the \field{se=
ssion_id} in struct virtio_crypto_op_header
+      to a valid value which assigned by the device when a session is crea=
ted and MUST set \field{flag} field to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
+\item If the VIRTIO_CRYPTO_F_HASH_SESSION_MODE feature bit is not negotiat=
ed or the driver doesn't use the session mode, then the driver MUST set \fi=
eld{flag} field in struct virtio_crypto_op_header
+      to VIRTIO_CRYPTO_FLAG_SESSION_NONE_MODE and MUST set fields in struc=
t virtio_crypto_hash_para.sess_para.
 \item The driver MUST set \field{opcode} in struct virtio_crypto_op_header=
 to VIRTIO_CRYPTO_HASH.
-\item The driver MUST set the \field{queue_id} field to show used dataq in=
 struct virtio_crypto_op_header.
 \end{itemize*}
=20
 \devicenormative{\paragraph}{HASH Service Operation}{Device Types / Crypto=
 Device / Device Operation / HASH Service Operation}
@@ -633,12 +649,24 @@ The output data here includes the source data and the=
 input data includes the ha
=20
 \begin{lstlisting}
 struct virtio_crypto_mac_para {
-    struct virtio_crypto_hash_para hash;
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
 };
=20
 struct virtio_crypto_mac_data_req {
     /* Device-readable part */
     struct virtio_crypto_mac_para para;
+    /* The authenticated key */
+    u8 auth_key[auth_key_len];
     /* Source data */
     u8 src_data[src_data_len];
=20
@@ -659,9 +687,11 @@ The output data here includes the source data and the =
input data includes the ha
 \drivernormative{\paragraph}{MAC Service Operation}{Device Types / Crypto =
Device / Device Operation / MAC Service Operation}
=20
 \begin{itemize*}
-\item The driver MUST set the \field{session_id} in struct virtio_crypto_o=
p_header to a valid value which assigned by the device when a session is cr=
eated.
+\item If the VIRTIO_CRYPTO_F_MAC_SESSION_MODE feature bit is negotiated an=
d the driver uses the session mode, then the driver MUST set the \field{ses=
sion_id} in struct virtio_crypto_op_header
+      to a valid value which assigned by the device when a session is crea=
ted and MUST set \field{flag} field to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
+\item If the VIRTIO_CRYPTO_F_MAC_SESSION_MODE feature bit is not negotiate=
d or the driver doesn't use the session mode, then the driver MUST set \fie=
ld{flag} field in struct virtio_crypto_op_header
+      to VIRTIO_CRYPTO_FLAG_SESSION_NONE_MODE and MUST set fields in struc=
t virtio_crypto_mac_para.sess_para.
 \item The driver MUST set \field{opcode} in struct virtio_crypto_op_header=
 to VIRTIO_CRYPTO_MAC.
-\item The driver MUST set the \field{queue_id} field to show used dataq in=
 struct virtio_crypto_op_header.
 \end{itemize*}
=20
 \devicenormative{\paragraph}{MAC Service Operation}{Device Types / Crypto =
Device / Device Operation / MAC Service Operation}
@@ -677,6 +707,16 @@ The packet of plain CIPHER service is as follows:
=20
 \begin{lstlisting}
 struct virtio_crypto_cipher_para {
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
     /*
      * Byte Length of valid IV/Counter data pointed to by the below iv dat=
a.
      *
@@ -691,12 +731,13 @@ struct virtio_crypto_cipher_para {
     le32 src_data_len;
     /* length of destination data */
     le32 dst_data_len;
-    le32 padding;
 };
=20
 struct virtio_crypto_cipher_data_req {
     /* Device-readable part */
     struct virtio_crypto_cipher_para para;
+    /* The cipher key */
+    u8 cipher_key[keylen];
     /*
      * Initialization Vector or Counter data.
      *
@@ -724,6 +765,31 @@ The packet of algorithm chaining is as follows:
=20
 \begin{lstlisting}
 struct virtio_crypto_alg_chain_data_para {
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
     le32 iv_len;
     /* Length of source data */
     le32 src_data_len;
@@ -747,6 +813,10 @@ struct virtio_crypto_alg_chain_data_para {
 struct virtio_crypto_alg_chain_data_req {
     /* Device-readable part */
     struct virtio_crypto_alg_chain_data_para para;
+    /* The cipher key */
+    u8 cipher_key[keylen];
+    /* The auth key */
+    u8 auth_key[auth_key_len];
     /* Initialization Vector or Counter data */
     u8 iv[iv_len];
     /* Source data */
@@ -783,11 +853,11 @@ struct virtio_crypto_sym_data_req {
 Each data request uses virtio_crypto_sym_data_req structure to store infor=
mation
 used to run the CIPHER operations.=20
=20
-The information includes the hash parameters stored by \field{para}, outpu=
t data and input data.
+The information includes the cipher parameters stored by \field{para}, out=
put data and input data.
 In the first virtio_crypto_cipher_para structure, \field{iv_len} specifies=
 the length of the initialization vector or counter,
 \field{src_data_len} specifies the length of the source data, and \field{d=
st_data_len} specifies the
 length of the destination data.=20
-For plain CIPHER operations, the output data here includes the IV/Counter =
data and source data, and the input data includes the destination data used=
 to save the results of the CIPHER operations.
+For plain CIPHER operations, the output data here includes the IV/Counter =
data and source data, and the input data includes the destination data used=
 to save the results of the CIPHER operations.=20
=20
 For algorithms chain, the output data here includes the IV/Counter data, s=
ource data and additional authenticated data if exists.
 The input data includes both destination data and hash result data used to=
 store the results of the HASH/MAC operations.
@@ -796,21 +866,24 @@ The input data includes both destination data and has=
h result data used to store
 \drivernormative{\paragraph}{Symmetric algorithms Operation}{Device Types =
/ Crypto Device / Device Operation / Symmetric algorithms Operation}
=20
 \begin{itemize*}
-\item The driver MUST set the \field{session_id} in struct virtio_crypto_o=
p_header to a valid value which assigned by the device when a session is cr=
eated.
+\item If the VIRTIO_CRYPTO_F_CIPHER_SESSION_MODE feature bit is negotiated=
 and the driver uses the session mode, then the driver MUST set the \field{=
session_id} in struct virtio_crypto_op_header
+      to a valid value which assigned by the device when a session is crea=
ted and MUST set \field{flag} field to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
+\item If the VIRTIO_CRYPTO_F_CIPHER_SESSION_MODE feature bit is not negoti=
ated or the driver doesn't use the session mode, then the driver MUST set \=
field{flag} field in struct virtio_crypto_op_header
+      to VIRTIO_CRYPTO_FLAG_SESSION_NONE_MODE and MUST set fields in struc=
t virtio_crypto_cipher_para.sess_para or struct virtio_crypto_alg_chain_dat=
a_para.sess_para.
 \item The driver MUST set \field{opcode} in struct virtio_crypto_op_header=
 to VIRTIO_CRYPTO_CIPHER_ENCRYPT or VIRTIO_CRYPTO_CIPHER_DECRYPT.
-\item The driver MUST set the \field{queue_id} field to show used dataq in=
 struct virtio_crypto_op_header.
-\item The driver MUST specify the fields of struct virtio_crypto_cipher_da=
ta_req in struct virtio_crypto_sym_data_req if the created session is based=
 on VIRTIO_CRYPTO_SYM_OP_CIPHER.
-\item The driver MUST specify the fields of both struct virtio_crypto_ciph=
er_data_req and struct virtio_crypto_mac_data_req in struct virtio_crypto_s=
ym_data_req if the created session
-\item is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING type and in the VI=
RTIO_CRYPTO_SYM_HASH_MODE_AUTH mode.
+\item The driver MUST specify the fields of struct virtio_crypto_cipher_da=
ta_req in struct virtio_crypto_sym_data_req if the packet is based on VIRTI=
O_CRYPTO_SYM_OP_CIPHER.
+\item The driver MUST specify the fields of both struct virtio_crypto_ciph=
er_data_req and struct virtio_crypto_mac_data_req in struct virtio_crypto_s=
ym_data_req if the packet
+      is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING type and in the VI=
RTIO_CRYPTO_SYM_HASH_MODE_AUTH mode.
 \end{itemize*}
=20
 \devicenormative{\paragraph}{Symmetric algorithms Operation}{Device Types =
/ Crypto Device / Device Operation / Symmetric algorithms Operation}
=20
 \begin{itemize*}
+\item The device MUST parse \field{flag} field in struct virtio_crypto_op_=
header in order to decide which mode the driver uses.
 \item The device MUST parse the virtio_crypto_sym_data_req based on the \f=
ield{opcode} in general header.
-\item The device SHOULD only parse fields of struct virtio_crypto_cipher_d=
ata_req in struct virtio_crypto_sym_data_req if the created session is VIRT=
IO_CRYPTO_SYM_OP_CIPHER type.
-\item The device MUST parse fields of both struct virtio_crypto_cipher_dat=
a_req and struct virtio_crypto_mac_data_req in struct virtio_crypto_sym_dat=
a_req if the created
-session is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING operation type a=
nd in the VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH mode.
+\item The device SHOULD only parse fields of struct virtio_crypto_cipher_d=
ata_req in struct virtio_crypto_sym_data_req if the packet is VIRTIO_CRYPTO=
_SYM_OP_CIPHER type.
+\item The device MUST parse fields of both struct virtio_crypto_cipher_dat=
a_req and struct virtio_crypto_mac_data_req in struct virtio_crypto_sym_dat=
a_req if the packet
+      is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING operation type and=
 in the VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH mode.
 \item The device MUST copy the result of cryptographic operation to the ds=
t_data[] in both plain CIPHER mode and algorithms chain mode.
 \item The device MUST check the \field{para}.\field{add_len} is bigger tha=
n 0 before parse the additional authenticated data in plain algorithms chai=
n mode.
 \item The device MUST copy the result of HASH/MAC operation to the hash_re=
sult[] is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING type.
@@ -819,7 +892,7 @@ session is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINI=
NG operation type and in
=20
 \paragraph{Steps of Operation}\label{sec:Device Types / Crypto Device / De=
vice Operation / Symmetric algorithms Operation / Steps of Operation}
=20
-\subparagraph{Step1: Create session}\label{sec:Device Types / Crypto Devic=
e / Device Operation / Symmetric algorithms Operation / Steps of Operation =
/ Step1: Create session}
+\subparagraph{Step1: Create session}\label{sec:Device Types / Crypto Devic=
e / Device Operation / Symmetric algorithms Operation / Steps of Operation =
/ Step1: Create session if using session mode}
=20
 \begin{enumerate}
 \item The driver specifies information in struct virtio_crypto_op_ctrl_req=
, including the algorithm name, key, keylen etc;
@@ -848,7 +921,7 @@ session is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINI=
NG operation type and in
 \item The device sets the \field{status} in struct virtio_crypto_inhdr;
 \item The device updates and flushes the Used Ring to return the cryptogra=
phic results to the driver;
 \item The device notifies the driver (Or the driver actively polls the dat=
aq's Used Ring);
-\item The driver saves the cryptographic result.
+\item The driver saves the cryptographic results.
 \end{enumerate}
=20
 \begin{note}
@@ -862,6 +935,15 @@ session is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAIN=
ING operation type and in
=20
 \begin{lstlisting}
 struct virtio_crypto_aead_para {
+    struct {
+        /* See VIRTIO_CRYPTO_AEAD_* above */
+        le32 algo;
+        /* length of key */
+        le32 key_len;
+        /* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
+        le32 op;
+    } sess_para;
+
     /*
      * Byte Length of valid IV data.
      *
@@ -871,20 +953,21 @@ struct virtio_crypto_aead_para {
      *   range 7 to 13 inclusive.
      */
     le32 iv_len;
+    /* Authentication tag length */
+    le32 tag_len;
     /* length of additional auth data */
     le32 aad_len;
     /* length of source data */
     le32 src_data_len;
-    /* length of dst data */
+    /* length of dst data, this should be at least src_data_len + tag_len =
*/
     le32 dst_data_len;
-    /* Length of the hash result */
-    le32 hash_result_len;
-    le32 reserver;
 };
=20
 struct virtio_crypto_aead_data_req {
     /* Device-readable part */
     struct virtio_crypto_aead_para para;
+    /* The cipher key */
+    u8 key[key_len];
     /*
      * Initialization Vector data.
      *
@@ -906,10 +989,9 @@ struct virtio_crypto_aead_data_req {
     u8 aad[aad_len];
=20
     /* Device-writable part */
-    /* Destination data */
+    /* Pointer to output data */
     u8 dst_data[dst_data_len];
-    /* Hash result data */
-    u8 hash_result[hash_result_len];
+
     struct virtio_crypto_inhdr inhdr;
 };
 \end{lstlisting}
@@ -918,10 +1000,9 @@ Each data request uses virtio_crypto_aead_data_req st=
ructure to store informatio
 used to run the AEAD operations.=20
=20
 The information includes the hash parameters stored by \field{para}, outpu=
t data and input data.
-In the first virtio_crypto_aead_para structure, \field{iv_len} specifies t=
he length of the initialization vector.
+In the first virtio_crypto_aead_para structure, \field{iv_len} specifies t=
he length of the initialization vector. \field{tag_len} specifies the lengt=
h of the authentication tag;
 \field{aad_len} specifies the length of additional authentication data, \f=
ield{src_data_len} specifies the
-length of the source data; \field{dst_data_len} specifies the length of th=
e destination data.
-The output data here includes the IV data and source data, and the input d=
ata includes the destination data used to save the results of the CIPHER op=
erations.
+length of the source data; \field{dst_data_len} specifies the length of th=
e destination data, which is at least \field{src_data_len} + \field{tag_len=
}.
=20
 The output data here includes the IV/Counter data, source data and additio=
nal authenticated data if exists.
 The input data includes both destination data used to save the results of =
the AEAD operations.
@@ -930,9 +1011,11 @@ The input data includes both destination data used to=
 save the results of the AE
 \drivernormative{\paragraph}{AEAD Service Operation}{Device Types / Crypto=
 Device / Device Operation / AEAD Service Operation}
=20
 \begin{itemize*}
-\item The driver MUST set the \field{session_id} in struct virtio_crypto_o=
p_header to a valid value which assigned by the device when a session is cr=
eated.
+\item If the VIRTIO_CRYPTO_F_AEAD_SESSION_MODE feature bit is negotiated a=
nd the driver uses the session mode, then the driver MUST set the \field{se=
ssion_id} in struct virtio_crypto_op_header
+      to a valid value which assigned by the device when a session is crea=
ted and MUST set \field{flag} field to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
+\item If the VIRTIO_CRYPTO_F_AEAD_SESSION_MODE feature bit is not negotiat=
ed or the driver doesn't use the session mode, then the driver MUST set \fi=
eld{flag} field in struct virtio_crypto_op_header
+      to VIRTIO_CRYPTO_FLAG_SESSION_NONE_MODE and MUST set fields in struc=
t virtio_crypto_aead_para.sess_para.
 \item The driver MUST set \field{opcode} in struct virtio_crypto_op_header=
 to VIRTIO_CRYPTO_AEAD_ENCRYPT or VIRTIO_CRYPTO_AEAD_DECRYPT.
-\item The driver MUST set the \field{queue_id} field to show used dataq in=
 struct virtio_crypto_op_header.
 \end{itemize*}
=20
 \devicenormative{\paragraph}{AEAD Service Operation}{Device Types / Crypto=
 Device / Device Operation / AEAD Service Operation}
@@ -940,7 +1023,7 @@ The input data includes both destination data used to =
save the results of the AE
 \begin{itemize*}
 \item The device MUST parse the virtio_crypto_aead_data_req based on the \=
field{opcode} in general header.
 \item The device MUST copy the result of cryptographic operation to the ds=
t_data[].
-\item The device MUST copy the hash result to the hash_result[].
+\item The device MUST copy the authentication tag to the dst_data[] offset=
 the cipher result.
 \item The device MUST set the \field{status} field in struct virtio_crypto=
_inhdr to one of the values of enum VIRITO_CRYPTO_STATUS.
 \item When the \field{opcode} is VIRTIO_CRYPTO_AEAD_DECRYPT, the device MU=
ST verify and return the verification result to the driver, and if the veri=
fication result is incorrect, VIRTIO_CRYPTO_BADMSG (bad message) MUST be re=
turned to the driver.
 \end{itemize*}
\ No newline at end of file



Regards,
-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Wednesday, January 04, 2017 6:03 PM
> To: qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org
> Cc: Luonengjun; mst@redhat.com; cornelia.huck@de.ibm.com;
> stefanha@redhat.com; denglingli@chinamobile.com; Jani Kokkonen;
> Ola.Liljedahl@arm.com; Varun.Sethi@freescale.com; xin.zeng@intel.com;
> brian.a.keating@intel.com; liang.j.ma@intel.com; john.griffin@intel.com;
> Huangweidong (C); mike.caraman@nxp.com; agraf@suse.de; Claudio Fontana;
> Zhoujian (jay, Euler); nmorey@kalray.eu; vincent.jardin@6wind.com; Wubin =
(H);
> Shiqing Fan; arei.gonglei@hotmail.com; pasic@linux.vnet.ibm.com; Gonglei
> (Arei)
> Subject: [PATCH v15 0/2] virtio-crypto: virtio crypto device specificatio=
n
>=20
> Changes since v14:
>  - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
>  - correct a sentence about dataqueue and controlq in the first paragraph=
.
> [Halil]
>  - change a MAY to MUST about max_dataqueues. [Halil]
>  - add non-session mode support
>    1) add four features for different crypto services to identify wheathe=
r
> support session mode.
>    2) extend virtio_crypto_*_para structures, for example, add the conten=
t of
>      struct virtio_crypto_cipher_session_para into struct
> virtio_crypto_cipher_para.
>    3) use the flag property of struct virtio_crypto_op_header to identify=
 the
>      type of crypto request. Aka Is it a session-based or non-session req=
uest
>=20
> For pervious versions of virtio crypto spec, Pls see:
>=20
> [v14]:
> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02212.html
>=20
> [v13]:
> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07348.html
>=20
> For more information, please see:
>  http://qemu-project.org/Features/VirtioCrypto
>=20
> Please help to review, thanks.
>=20
> Gonglei (2):
>   virtio-crypto: Add virtio crypto device specification
>   virtio-crypto: Add conformance clauses
>=20
>  conformance.tex   |   30 ++
>  content.tex       |    2 +
>  virtio-crypto.tex | 1029
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1061 insertions(+)
>  create mode 100644 virtio-crypto.tex
>=20
> --
> 1.7.12.4
>=20
