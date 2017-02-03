Received: from eggs.gnu.org ([2001:4830:134:3::10]:39069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZelP-0000m3-PR
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZelJ-0004E9-2K
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:22:59 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cZelI-0004Dc-JU
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:22:53 -0500
Received: by mail-wm0-x242.google.com with SMTP id v77so4678918wmv.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 06:22:52 -0800 (PST)
Date: Fri, 3 Feb 2017 10:33:16 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170203103316.GA29200@stefanha-x1.localdomain>
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v16 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, weidong.huang@huawei.com, mst@redhat.com, john.griffin@intel.com, jianjay.zhou@huawei.com, Varun.Sethi@freescale.com, denglingli@chinamobile.com, arei.gonglei@hotmail.com, agraf@suse.de, nmorey@kalray.eu, longpeng2@huawei.com, vincent.jardin@6wind.com, Ola.Liljedahl@arm.com, luonengjun@huawei.com, xin.zeng@intel.com, liang.j.ma@intel.com, stefanha@redhat.com, cornelia.huck@de.ibm.com, Jani.Kokkonen@huawei.com, pasic@linux.vnet.ibm.com, brian.a.keating@intel.com, claudio.fontana@huawei.com, mike.caraman@nxp.com, wu.wubin@huawei.com


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 04:22:36PM +0800, Gonglei wrote:
> The virtio crypto device is a virtual crypto device (ie. hardware
> crypto accelerator card). Currently, the virtio crypto device provides
> the following crypto services: CIPHER, MAC, HASH, and AEAD.
>=20
> In this patch, CIPHER, MAC, HASH, AEAD services are introduced.
>=20
> VIRTIO-153
>=20
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Cornelia Huck <cornelia.huck@de.ibm.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Lingli Deng <denglingli@chinamobile.com>
> CC: Jani Kokkonen <Jani.Kokkonen@huawei.com>
> CC: Ola Liljedahl <Ola.Liljedahl@arm.com>
> CC: Varun Sethi <Varun.Sethi@freescale.com>
> CC: Zeng Xin <xin.zeng@intel.com>
> CC: Keating Brian <brian.a.keating@intel.com>
> CC: Ma Liang J <liang.j.ma@intel.com>
> CC: Griffin John <john.griffin@intel.com>
> CC: Mihai Claudiu Caraman <mike.caraman@nxp.com>
> ---
>  content.tex       |    2 +
>  virtio-crypto.tex | 1245 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 1247 insertions(+)
>  create mode 100644 virtio-crypto.tex

I'm happy with the device overall.  See specific comments below.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>=20
> diff --git a/content.tex b/content.tex
> index 4b45678..ab75f78 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5750,6 +5750,8 @@ descriptor for the \field{sense_len}, \field{residu=
al},
>  \field{status_qualifier}, \field{status}, \field{response} and
>  \field{sense} fields.
> =20
> +\input{virtio-crypto.tex}
> +
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> =20
>  Currently there are three device-independent feature bits defined:
> diff --git a/virtio-crypto.tex b/virtio-crypto.tex
> new file mode 100644
> index 0000000..732cd30
> --- /dev/null
> +++ b/virtio-crypto.tex
> @@ -0,0 +1,1245 @@
> +\section{Crypto Device}\label{sec:Device Types / Crypto Device}
> +
> +The virtio crypto device is a virtual cryptography device as well as a k=
ind of
> +virtual hardware accelerator for virtual machines. The encryption and
> +decryption requests are placed in any of the data active queues and are =
ultimately handled by the
> +backend crypto accelerators. The second kind of queue is the control que=
ue used to create=20
> +or destroy sessions for symmetric algorithms and will control some advan=
ced
> +features in the future. The virtio crypto device provides the following =
crypto
> +services: CIPHER, MAC, HASH, and AEAD.
> +
> +
> +\subsection{Device ID}\label{sec:Device Types / Crypto Device / Device I=
D}
> +
> +20
> +
> +\subsection{Virtqueues}\label{sec:Device Types / Crypto Device / Virtque=
ues}
> +
> +\begin{description}
> +\item[0] dataq1
> +\item[\ldots]
> +\item[N-1] dataqN
> +\item[N] controlq
> +\end{description}
> +
> +N is set by \field{max_dataqueues}.
> +
> +\subsection{Feature bits}\label{sec:Device Types / Crypto Device / Featu=
re bits}
> +
> +VIRTIO_CRYPTO_F_NON_SESSION_MODE (0) non-session mode is available.
> +VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE (1) non-session mode is availabl=
e for CIPHER service.
> +VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE (2) non-session mode is available =
for HASH service.
> +VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE (3) non-session mode is available f=
or MAC service.
> +VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE (4) non-session mode is available =
for AEAD service.

Bits 1-4 require bit 0.  Is bit 0 necessary at all?  Or may bits 1-4 can
be eliminated in favor of just bit 0.

> +
> +\subsubsection{Feature bit requirements}\label{sec:Device Types / Crypto=
 Device / Feature bits}
> +
> +Some crypto feature bits require other crypto feature bits
> +(see \ref{drivernormative:Basic Facilities of a Virtio Device / Feature =
Bits}):
> +
> +\begin{description}
> +\item[VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE] Requires VIRTIO_CRYPTO_F_=
NON_SESSION_MODE.
> +\item[VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE] Requires VIRTIO_CRYPTO_F_NO=
N_SESSION_MODE.
> +\item[VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE] Requires VIRTIO_CRYPTO_F_NON=
_SESSION_MODE.
> +\item[VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE] Requires VIRTIO_CRYPTO_F_NO=
N_SESSION_MODE.
> +\end{description}
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / Crypto=
 Device / Device configuration layout}
> +
> +The following driver-read-only configuration fields are defined:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_config {
> +    le32 status;
> +    le32 max_dataqueues;
> +    le32 crypto_services;
> +    /* Detailed algorithms mask */
> +    le32 cipher_algo_l;
> +    le32 cipher_algo_h;
> +    le32 hash_algo;
> +    le32 mac_algo_l;
> +    le32 mac_algo_h;
> +    le32 aead_algo;
> +    /* Maximum length of cipher key */
> +    le32 max_cipher_key_len;
> +    /* Maximum length of authenticated key */
> +    le32 max_auth_key_len;
> +    le32 reserved;
> +    /* Maximum size of each crypto request's content */
> +    le64 max_size;
> +};
> +\end{lstlisting}
> +
> +The value of the \field{status} field is VIRTIO_CRYPTO_S_HW_READY or ~VI=
RTIO_CRYPTO_S_HW_READY.
> +
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
> +\end{lstlisting}
> +
> +The VIRTIO_CRYPTO_S_HW_READY flag is used to show whether the hardware i=
s ready to work or not.
> +
> +The following driver-read-only fields include \field{max_dataqueues}, wh=
ich specifies the
> +maximum number of data virtqueues (dataq1\ldots dataqN), and \field{cryp=
to_services},
> +which indicates the crypto services the virtio crypto supports.
> +
> +The following services are defined:
> +
> +\begin{lstlisting}
> +/* CIPHER service */
> +#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
> +/* HASH service */
> +#define VIRTIO_CRYPTO_SERVICE_HASH   1
> +/* MAC (Message Authentication Codes) service */
> +#define VIRTIO_CRYPTO_SERVICE_MAC    2
> +/* AEAD (Authenticated Encryption with Associated Data) service */
> +#define VIRTIO_CRYPTO_SERVICE_AEAD   3
> +\end{lstlisting}
> +
> +The last driver-read-only fields specify detailed algorithms masks=20

s/The last driver-read-only fields/Further driver-read-only fields/

(cipher_algo_l, cipher_algo_h, etc are not the last fields.)

> +the device offers for corresponding services. The following CIPHER algor=
ithms
> +are defined:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_NO_CIPHER                 0
> +#define VIRTIO_CRYPTO_CIPHER_ARC4               1
> +#define VIRTIO_CRYPTO_CIPHER_AES_ECB            2
> +#define VIRTIO_CRYPTO_CIPHER_AES_CBC            3
> +#define VIRTIO_CRYPTO_CIPHER_AES_CTR            4
> +#define VIRTIO_CRYPTO_CIPHER_DES_ECB            5
> +#define VIRTIO_CRYPTO_CIPHER_DES_CBC            6
> +#define VIRTIO_CRYPTO_CIPHER_3DES_ECB           7
> +#define VIRTIO_CRYPTO_CIPHER_3DES_CBC           8
> +#define VIRTIO_CRYPTO_CIPHER_3DES_CTR           9
> +#define VIRTIO_CRYPTO_CIPHER_KASUMI_F8          10
> +#define VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2        11
> +#define VIRTIO_CRYPTO_CIPHER_AES_F8             12
> +#define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
> +#define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
> +\end{lstlisting}
> +
> +The following HASH algorithms are defined:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_NO_HASH            0
> +#define VIRTIO_CRYPTO_HASH_MD5           1
> +#define VIRTIO_CRYPTO_HASH_SHA1          2
> +#define VIRTIO_CRYPTO_HASH_SHA_224       3
> +#define VIRTIO_CRYPTO_HASH_SHA_256       4
> +#define VIRTIO_CRYPTO_HASH_SHA_384       5
> +#define VIRTIO_CRYPTO_HASH_SHA_512       6
> +#define VIRTIO_CRYPTO_HASH_SHA3_224      7
> +#define VIRTIO_CRYPTO_HASH_SHA3_256      8
> +#define VIRTIO_CRYPTO_HASH_SHA3_384      9
> +#define VIRTIO_CRYPTO_HASH_SHA3_512      10
> +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE128      11
> +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE256      12
> +\end{lstlisting}
> +
> +The following MAC algorithms are defined:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_NO_MAC                       0
> +#define VIRTIO_CRYPTO_MAC_HMAC_MD5                 1
> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA1                2
> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_224             3
> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_256             4
> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_384             5
> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_512             6
> +#define VIRTIO_CRYPTO_MAC_CMAC_3DES                25
> +#define VIRTIO_CRYPTO_MAC_CMAC_AES                 26
> +#define VIRTIO_CRYPTO_MAC_KASUMI_F9                27
> +#define VIRTIO_CRYPTO_MAC_SNOW3G_UIA2              28
> +#define VIRTIO_CRYPTO_MAC_GMAC_AES                 41
> +#define VIRTIO_CRYPTO_MAC_GMAC_TWOFISH             42
> +#define VIRTIO_CRYPTO_MAC_CBCMAC_AES               49
> +#define VIRTIO_CRYPTO_MAC_CBCMAC_KASUMI_F9         50
> +#define VIRTIO_CRYPTO_MAC_XCBC_AES                 53
> +#define VIRTIO_CRYPTO_MAC_ZUC_EIA3                 54
> +\end{lstlisting}
> +
> +The following AEAD algorithms are defined:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_NO_AEAD     0
> +#define VIRTIO_CRYPTO_AEAD_GCM    1
> +#define VIRTIO_CRYPTO_AEAD_CCM    2
> +#define VIRTIO_CRYPTO_AEAD_CHACHA20_POLY1305  3
> +\end{lstlisting}
> +
> +\begin{note}
> +Any other values are reserved for future use.
> +\end{note}
> +
> +\devicenormative{\subsubsection}{Device configuration layout}{Device Typ=
es / Crypto Device / Device configuration layout}
> +
> +\begin{itemize*}
> +\item The device MUST set \field{max_dataqueues} to between 1 and 65535 =
inclusive.
> +\item The device MUST set \field{status} based on the status of the hard=
ware-backed implementation.=20
> +\item The device MUST accept and handle requests after \field{status} is=
 set to VIRTIO_CRYPTO_S_HW_READY.
> +\item The device MUST set \field{crypto_services} based on the crypto se=
rvices the device offers.
> +\item The device MUST set detailed algorithms masks based on the \field{=
crypto_services} field.
> +\item The device MUST set \field{max_size} to show the maximum size of c=
rypto request the device supports.

In bytes?

> +\item The device MUST set \field{max_cipher_key_len} to show the maximum=
 length of cipher key if the device supports CIPHER service.

In bits or bytes?

> +\item The device MUST set \field{max_auth_key_len} to show the maximum l=
ength of authenticated key if the device supports MAC service.

In bits or bytes?

> +\end{itemize*}
> +
> +\drivernormative{\subsubsection}{Device configuration layout}{Device Typ=
es / Crypto Device / Device configuration layout}
> +
> +\begin{itemize*}
> +\item The driver MUST read the ready \field{status} from the bottom bit =
of status to check whether the hardware-backed
> +      implementation is ready or not, and the driver MUST reread it afte=
r the device reset.=20
> +\item The driver MUST NOT transmit any packets to the device if the read=
y \field{status} is not set.
> +\item The driver MUST read \field{max_dataqueues} field to discover the =
number of data queues the device supports.
> +\item The driver MUST read \field{crypto_services} field to discover whi=
ch services the device is able to offer.
> +\item The driver MUST read the detailed algorithms fields based on \fiel=
d{crypto_services} field.
> +\item The driver SHOULD read \field{max_size} to discover the maximum si=
ze of crypto request the device supports.
> +\item The driver SHOULD read \field{max_cipher_key_len} to discover the =
maximum length of cipher key the device supports.
> +\item The driver SHOULD read \field{max_auth_key_len} to discover the ma=
ximum length of authenticated key the device supports.
> +\end{itemize*}
> +
> +\subsection{Device Initialization}\label{sec:Device Types / Crypto Devic=
e / Device Initialization}
> +
> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / C=
rypto Device / Device Initialization}
> +
> +\begin{itemize*}
> +\item The driver MUST identify and initialize the control virtqueue.
> +\item The driver MUST read the supported crypto services from bits of \f=
ield{crypto_services}.=20
> +\item The driver MUST read the supported algorithms based on \field{cryp=
to_services} field.
> +\end{itemize*}
> +
> +\devicenormative{\subsubsection}{Device Initialization}{Device Types / C=
rypto Device / Device Initialization}
> +
> +\begin{itemize*}
> +\item The device MUST be configured with at least one accelerator which =
executes backend crypto operations.
> +\item The device MUST write the \field{crypto_services} field based on t=
he capacities of the backend accelerator.
> +\end{itemize*}
> +
> +\subsection{Device Operation}\label{sec:Device Types / Crypto Device / D=
evice Operation}
> +
> +Packets can be transmitted by placing them in both the controlq and data=
q.
> +Packets consist of a general header and a service-specific request.
> +Where 'general header' is for all crypto requests, and 'service specific=
 requests'
> +are composed of operation parameter + output data + input data in genera=
l.
> +Operation parameters are algorithm-specific parameters, output data is t=
he
> +data that should be utilized in operations, and input data is equal to
> +"operation result + result data".
> +
> +The device can support both session mode (See \ref{sec:Device Types / Cr=
ypto Device / Device Operation / Control Virtqueue / Session operation}) an=
d non-session mode, for example,
> +As VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE feature bit is negotiated, th=
e driver can use non-session mode for CIPHER service, otherwise it can only=
 use session mode.
> +
> +\begin{note}
> +The basic unit of all data length the byte.

s/data length the byte/data length is the byte/

> +\end{note}
> +
> +The general header for controlq is as follows:
> +
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
> +    le32 algo;
> +    le32 flag;
> +    /* data virtqueue id */
> +    le32 queue_id;
> +};
> +\end{lstlisting}
> +
> +The general header of dataq:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_op_header {
> +#define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
> +#define VIRTIO_CRYPTO_CIPHER_DECRYPT \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
> +#define VIRTIO_CRYPTO_HASH \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
> +#define VIRTIO_CRYPTO_MAC \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
> +#define VIRTIO_CRYPTO_AEAD_ENCRYPT \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
> +#define VIRTIO_CRYPTO_AEAD_DECRYPT \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
> +    le32 opcode;
> +    /* algo should be service-specific algorithms */
> +    le32 algo;
> +    /* session_id should be service-specific algorithms */
> +    le64 session_id;
> +#define VIRTIO_CRYPTO_FLAG_SESSION_MODE 1
> +#define VIRTIO_CRYPTO_FLAG_NON_SESSION_MODE 2
> +    /* control flag to control the request */
> +    le32 flag;
> +    le32 padding;
> +};
> +\end{lstlisting}
> +
> +The device can set the operation status as follows: VIRTIO_CRYPTO_OK: su=
ccess;
> +VIRTIO_CRYPTO_ERR: failure or device error; VIRTIO_CRYPTO_NOTSUPP: not s=
upported;
> +VIRTIO_CRYPTO_INVSESS: invalid session ID when executing crypto operatio=
ns.
> +
> +\begin{lstlisting}
> +enum VIRITO_CRYPTO_STATUS {
> +    VIRTIO_CRYPTO_OK =3D 0,
> +    VIRTIO_CRYPTO_ERR =3D 1,
> +    VIRTIO_CRYPTO_BADMSG =3D 2,
> +    VIRTIO_CRYPTO_NOTSUPP =3D 3,
> +    VIRTIO_CRYPTO_INVSESS =3D 4,
> +    VIRTIO_CRYPTO_MAX
> +};
> +\end{lstlisting}
> +
> +\subsubsection{Control Virtqueue}\label{sec:Device Types / Crypto Device=
 / Device Operation / Control Virtqueue}
> +
> +The driver uses the control virtqueue to send control commands to the
> +device which handles the non-data plane operations, such as session
> +operations (See \ref{sec:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation}).
> +
> +The packet of controlq:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_op_ctrl_req {
> +    struct virtio_crypto_ctrl_header header;
> +
> +    union {
> +        struct virtio_crypto_sym_create_session_req   sym_create_session;
> +        struct virtio_crypto_hash_create_session_req  hash_create_sessio=
n;
> +        struct virtio_crypto_mac_create_session_req   mac_create_session;
> +        struct virtio_crypto_aead_create_session_req  aead_create_sessio=
n;
> +        struct virtio_crypto_destroy_session_req      destroy_session;
> +    } u;
> +};
> +\end{lstlisting}
> +
> +The header is the general header, and the union is of the algorithm-spec=
ific type,
> +which is set by the driver. All the properties in the union are shown as=
 follows.

The spec isn't clear on whether crtl reqs should be sizeof(struct
virtio_crypto_op_ctrl_req) or if it's okay to use the smaller
sizeof(struct virtio_crypto_ctrl_header) + sizeof(struct
virtio_crypto_sym_create_session_req), for example.

Please clarify.

> +
> +\paragraph{Session operation}\label{sec:Device Types / Crypto Device / D=
evice Operation / Control Virtqueue / Session operation}
> +
> +The symmetric algorithms involve the concept of sessions. A session is a
> +handle which describes the cryptographic parameters to be applied to
> +a number of buffers. The data within a session handle includes the follo=
wing:
> +
> +\begin{enumerate}
> +\item The operation (CIPHER, HASH/MAC or both, and if both, the order in
> +      which the algorithms should be applied).
> +\item The CIPHER set data, including the CIPHER algorithm and mode,
> +      the key and its length, and the direction (encryption or decryptio=
n).
> +\item The HASH/MAC set data, including the HASH algorithm or MAC algorit=
hm,
> +      and hash result length (to allow for truncation).
> +\begin{itemize*}
> +\item Authenticated mode can refer to MAC, which requires that the key a=
nd
> +      its length are also specified.
> +\item For nested mode, the inner and outer prefix data and length are sp=
ecified,
> +      as well as the outer HASH algorithm.
> +\end{itemize*}
> +\end{enumerate}
> +
> +The following structure stores the result of session creation set by the=
 device:
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
> +\subparagraph{Session operation: HASH session}\label{sec:Device Types / =
Crypto Device / Device
> +Operation / Control Virtqueue / Session operation / Session operation: H=
ASH session}
> +
> +The packet of HASH session is as follows:
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
> +\subparagraph{Session operation: MAC session}\label{sec:Device Types / C=
rypto Device / Device
> +Operation / Control Virtqueue / Session operation / Session operation: M=
AC session}
> +
> +The packet of MAC session is as follows:
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
> +\subparagraph{Session operation: Symmetric algorithms session}\label{sec=
:Device Types / Crypto Device / Device
> +Operation / Control Virtqueue / Session operation / Session operation: S=
ymmetric algorithms session}
> +
> +The request of symmetric session includes two parts, CIPHER algorithms a=
nd chain
> +algorithms (chaining CIPHER and HASH/MAC). The packet for CIPHER session=
 is as follows:
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
> +    /* Device-writable part */
> +    struct virtio_crypto_session_input input;
> +};
> +\end{lstlisting}
> +
> +The packet for algorithm chaining is as follows:
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
> +    union {
> +        struct virtio_crypto_hash_session_para hash_param;
> +        struct virtio_crypto_mac_session_para mac_param;
> +    } u;
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
> +The packet for symmetric algorithm is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_sym_create_session_req {
> +    union {
> +        struct virtio_crypto_cipher_session_req cipher;
> +        struct virtio_crypto_alg_chain_session_req chain;
> +    } u;
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
> +\subparagraph{Session operation: AEAD session}\label{sec:Device Types / =
Crypto Device / Device
> +Operation / Control Virtqueue / Session operation / Session operation: A=
EAD session}
> +
> +The packet for AEAD session is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_aead_session_para {
> +    /* See VIRTIO_CRYPTO_AEAD_* above */
> +    le32 algo;
> +    /* length of key */
> +    le32 key_len;
> +    /* Authentication tag length */
> +    le32 tag_len;
> +    /* The length of the additional authenticated data (AAD) in bytes */
> +    le32 aad_len;
> +    /* encryption or decryption, See above VIRTIO_CRYPTO_OP_* */
> +    le32 op;
> +    le32 padding;
> +};
> +
> +struct virtio_crypto_aead_create_session_req {
> +    /* Device-readable part */
> +    struct virtio_crypto_aead_session_para para;
> +    u8 key[key_len];
> +
> +    /* Device-writeable part */
> +    struct virtio_crypto_session_input input;
> +};
> +\end{lstlisting}
> +
> +\drivernormative{\subparagraph}{Session operation: create session}{Devic=
e Types / Crypto Device / Device Operation / Control Virtqueue / Session op=
eration / Session operation: create session}
> +
> +\begin{itemize*}
> +\item The driver MUST set the control general header and corresponding p=
roperties of the union in structure virtio_crypto_op_ctrl_req. See \ref{sec=
:Device Types / Crypto Device / Device Operation / Control Virtqueue}.
> +\item The driver MUST set \field{opcode} field based on service type: CI=
PHER, HASH, MAC, or AEAD.
> +\item The driver MUST set \field{queue_id} field to show used dataq.
> +\end{itemize*}
> +
> +\devicenormative{\subparagraph}{Session operation: create session}{Devic=
e Types / Crypto Device / Device
> +Operation / Control Virtqueue / Session operation / Session operation: c=
reate session}
> +
> +\begin{itemize*}
> +\item The device MUST set \field{session_id} field as a session identifi=
er return to the driver when the device finishes processing session creatio=
n.
> +\item The device MUST set \field{status} field to one of the values of e=
num VIRITO_CRYPTO_STATUS.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{Session operation: destroy session}{Devi=
ce Types / Crypto Device / Device
> +Operation / Control Virtqueue / Session operation / Session operation: d=
estroy session}
> +
> +\begin{itemize*}
> +\item The driver MUST set \field{opcode} field based on service type: CI=
PHER, HASH, MAC, or AEAD.
> +\item The driver MUST set the \field{session_id} to a valid value which =
assigned by the device when a session is created.
> +\end{itemize*}
> +
> +\devicenormative{\subparagraph}{Session operation: destroy session}{Devi=
ce Types / Crypto Device / Device
> +Operation / Control Virtqueue / Session operation / Session operation: d=
estroy session}
> +
> +\begin{itemize*}
> +\item The device MUST set \field{status} field to one of the values of e=
num VIRITO_CRYPTO_STATUS.
> +\end{itemize*}
> +
> +\subsubsection{Data Virtqueue}\label{sec:Device Types / Crypto Device / =
Device Operation / Data Virtqueue}
> +
> +The driver uses the data virtqueue to transmit the requests of crypto op=
eration to the device,
> +and completes the data plane operations (such as crypto operation).
> +
> +The session mode packet of dataq is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_op_data_req {
> +    struct virtio_crypto_op_header header;
> +
> +    union {
> +        struct virtio_crypto_sym_data_req   sym_req;
> +        struct virtio_crypto_hash_data_req  hash_req;
> +        struct virtio_crypto_mac_data_req   mac_req;
> +        struct virtio_crypto_aead_data_req  aead_req;
> +    } u;
> +};
> +\end{lstlisting}
> +
> +The packet of dataq, mixing both session and non-session mode is as foll=
ows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_op_data_req_mux {
> +    struct virtio_crypto_op_header header;
> +
> +    union {
> +        struct virtio_crypto_sym_data_req   sym_req;
> +        struct virtio_crypto_hash_data_req  hash_req;
> +        struct virtio_crypto_mac_data_req   mac_req;
> +        struct virtio_crypto_aead_data_req  aead_req;
> +        struct virtio_crypto_sym_data_req_non_sess   sym_non_sess_req;
> +        struct virtio_crypto_hash_data_req_non_sess  hash_non_sess_req;
> +        struct virtio_crypto_mac_data_req_non_sess   mac_non_sess_req;
> +        struct virtio_crypto_aead_data_req_non_sess  aead_non_sess_req;
> +    } u;
> +};
> +\end{lstlisting}
> +
> +The header is the general header and the union is of the algorithm-speci=
fic type,
> +which is set by the driver. All properties in the union are shown as fol=
lows.
> +
> +There is a unified input header structure for all crypto services.
> +
> +The structure is defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_inhdr {
> +    u8 status;
> +};
> +\end{lstlisting}
> +
> +\subsubsection{HASH Service Operation}\label{sec:Device Types / Crypto D=
evice / Device Operation / HASH Service Operation}
> +
> +The session mode packet of HASH service:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_hash_para {
> +    /* length of source data */
> +    le32 src_data_len;
> +    /* hash result length */
> +    le32 hash_result_len;
> +};
> +
> +struct virtio_crypto_hash_data_req {
> +    /* Device-readable part */
> +    struct virtio_crypto_hash_para para;
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +
> +    /* Device-writable part */
> +    /* Hash result data */
> +    u8 hash_result[hash_result_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +Each data request uses virtio_crypto_hash_data_req structure to store in=
formation
> +used to run the HASH operations.=20
> +
> +The information includes the hash parameters stored by \field{para}, out=
put data and input data.
> +The output data here includes the source data and the input data include=
s the hash result data used to save the results of the HASH operations.
> +\field{inhdr} stores status of executing the HASH operations.
> +
> +The non-session mode packet of HASH service is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_hash_para_non_session {
> +    struct {
> +        /* See VIRTIO_CRYPTO_HASH_* above */
> +        le32 algo;
> +    } sess_para;
> +
> +    /* length of source data */
> +    le32 src_data_len;
> +    /* hash result length */
> +    le32 hash_result_len;
> +    le32 reserved;
> +};
> +struct virtio_crypto_hash_data_req_non_sess {
> +    /* Device-readable part */
> +    struct virtio_crypto_hash_para_non_session para;
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +
> +    /* Device-writable part */
> +    /* Hash result data */
> +    u8 hash_result[hash_result_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +\drivernormative{\paragraph}{HASH Service Operation}{Device Types / Cryp=
to Device / Device Operation / HASH Service Operation}
> +
> +\begin{itemize*}
> +\item If the driver uses the session mode, then the driver MUST set the =
\field{session_id} in struct virtio_crypto_op_header
> +      to a valid value which assigned by the device when a session is cr=
eated.
> +\item If the VIRTIO_CRYPTO_F_NON_SESSION_MODE feature bit is negotiated,=
 the driver MUST use the struct virtio_crypto_op_data_req_mux to wrap crypt=
o packets. Otherwise, the driver MUST use the struct virtio_crypto_op_data_=
req.
> +\item If the VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE feature bit is negoti=
ated, 1) if the driver use the non-session mode, then the driver MUST set \=
field{flag} field in struct virtio_crypto_op_header
> +      to VIRTIO_CRYPTO_FLAG_NON_SESSION_MODE and MUST set fields in stru=
ct virtio_crypto_hash_para_non_session.sess_para, 2) if the driver still us=
es the session mode, then the driver MUST set \field{flag} field in struct =
virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
> +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_head=
er to VIRTIO_CRYPTO_HASH.
> +\end{itemize*}
> +
> +\devicenormative{\paragraph}{HASH Service Operation}{Device Types / Cryp=
to Device / Device Operation / HASH Service Operation}
> +
> +\begin{itemize*}
> +\item If the VIRTIO_CRYPTO_F_NON_SESSION_MODE feature bit is negotiated,=
 the device MUST parse the struct virtio_crypto_op_data_req_mux for crypto =
packets. Otherwise, the device MUST parse the struct virtio_crypto_op_data_=
req.
> +\item If the VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE feature bit is negoti=
ated, the device MUST parse \field{flag} field in struct virtio_crypto_op_h=
eader in order to decide which mode the driver uses.
> +\item The device MUST copy the results of HASH operations to the hash_re=
sult[] if HASH operations success.
> +\item The device MUST set \field{status} in struct virtio_crypto_inhdr t=
o one of the values of enum VIRITO_CRYPTO_STATUS.
> +\end{itemize*}
> +
> +\subsubsection{MAC Service Operation}\label{sec:Device Types / Crypto De=
vice / Device Operation / MAC Service Operation}
> +
> +The session mode packet of MAC service is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_mac_para {
> +    struct virtio_crypto_hash_para hash;
> +};
> +
> +struct virtio_crypto_mac_data_req {
> +    /* Device-readable part */
> +    struct virtio_crypto_mac_para para;
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +
> +    /* Device-writable part */
> +    /* Hash result data */
> +    u8 hash_result[hash_result_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +Each data request uses virtio_crypto_mac_data_req structure to store inf=
ormation
> +used to run the MAC operations.=20
> +
> +The information includes the hash parameters stored by \field{para}, out=
put data and input data.
> +The output data here includes the source data and the input data include=
s the hash result data used to save the results of the MAC operations.
> +\field{inhdr} stores status of executing the MAC operations.
> +
> +The non-session mode packet of MAC service:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_mac_para_non_sess {
> +    struct {
> +        /* See VIRTIO_CRYPTO_MAC_* above */
> +        le32 algo;
> +        /* length of authenticated key */
> +        le32 auth_key_len;
> +    } sess_para;
> +
> +    /* length of source data */
> +    le32 src_data_len;
> +    /* hash result length */
> +    le32 hash_result_len;
> +};
> +
> +struct virtio_crypto_mac_data_req_non_sess {
> +    /* Device-readable part */
> +    struct virtio_crypto_mac_para_non_sess para;
> +    /* The authenticated key */
> +    u8 auth_key[auth_key_len];
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +
> +    /* Device-writable part */
> +    /* Hash result data */
> +    u8 hash_result[hash_result_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +\drivernormative{\paragraph}{MAC Service Operation}{Device Types / Crypt=
o Device / Device Operation / MAC Service Operation}
> +
> +\begin{itemize*}
> +\item If the driver uses the session mode, then the driver MUST set the =
\field{session_id} in struct virtio_crypto_op_header
> +      to a valid value which assigned by the device when a session is cr=
eated.
> +\item If the VIRTIO_CRYPTO_F_NON_SESSION_MODE feature bit is negotiated,=
 the driver MUST use the struct virtio_crypto_op_data_req_mux to wrap crypt=
o packets. Otherwise, the driver MUST use the struct virtio_crypto_op_data_=
req.
> +\item If the VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE feature bit is negotia=
ted, 1) if the driver use the non-session mode, then the driver MUST set \f=
ield{flag} field in struct virtio_crypto_op_header
> +      to VIRTIO_CRYPTO_FLAG_NON_SESSION_MODE and MUST set fields in stru=
ct virtio_crypto_mac_para_non_session.sess_para, 2) if the driver still use=
s the session mode, then the driver MUST set \field{flag} field in struct v=
irtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
> +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_head=
er to VIRTIO_CRYPTO_MAC.
> +\end{itemize*}
> +
> +\devicenormative{\paragraph}{MAC Service Operation}{Device Types / Crypt=
o Device / Device Operation / MAC Service Operation}
> +
> +\begin{itemize*}
> +\item If the VIRTIO_CRYPTO_F_NON_SESSION_MODE feature bit is negotiated,=
 the device MUST parse the struct virtio_crypto_op_data_req_mux for crypto =
packets. Otherwise, the device MUST parse the struct virtio_crypto_op_data_=
req.
> +\item If the VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE feature bit is negotia=
ted, the device MUST parse \field{flag} field in struct virtio_crypto_op_he=
ader in order to decide which mode the driver uses.
> +\item The device MUST copy the results of MAC operations to the hash_res=
ult[] if HASH operations success.
> +\item The device MUST set \field{status} in struct virtio_crypto_inhdr t=
o one of the values of enum VIRITO_CRYPTO_STATUS.
> +\end{itemize*}
> +
> +\subsubsection{Symmetric algorithms Operation}\label{sec:Device Types / =
Crypto Device / Device Operation / Symmetric algorithms Operation}
> +
> +The session mode packet of plain CIPHER service is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_cipher_para {
> +    /*
> +     * Byte Length of valid IV/Counter data pointed to by the below iv d=
ata.
> +     *
> +     * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or=
 for
> +     *   SNOW3G in UEA2 mode, this is the length of the IV (which
> +     *   must be the same as the block length of the cipher).
> +     * For block ciphers in CTR mode, this is the length of the counter
> +     *   (which must be the same as the block length of the cipher).
> +     */
> +    le32 iv_len;
> +    /* length of source data */
> +    le32 src_data_len;
> +    /* length of destination data */
> +    le32 dst_data_len;
> +    le32 padding;
> +};
> +
> +struct virtio_crypto_cipher_data_req {
> +    /* Device-readable part */
> +    struct virtio_crypto_cipher_para para;
> +    /*
> +     * Initialization Vector or Counter data.
> +     *
> +     * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or=
 for
> +     *   SNOW3G in UEA2 mode, this is the Initialization Vector (IV)
> +     *   value.
> +     * For block ciphers in CTR mode, this is the counter.
> +     * For AES-XTS, this is the 128bit tweak, i, from IEEE Std 1619-2007.
> +     *
> +     * The IV/Counter will be updated after every partial cryptographic
> +     * operation.
> +     */
> +    u8 iv[iv_len];
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +
> +    /* Device-writable part */
> +    /* Destination data */
> +    u8 dst_data[dst_data_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +The session mode packet of algorithm chaining is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_alg_chain_data_para {
> +    le32 iv_len;
> +    /* Length of source data */
> +    le32 src_data_len;
> +    /* Length of destination data */
> +    le32 dst_data_len;
> +    /* Starting point for cipher processing in source data */
> +    le32 cipher_start_src_offset;
> +    /* Length of the source data that the cipher will be computed on */
> +    le32 len_to_cipher;
> +    /* Starting point for hash processing in source data */
> +    le32 hash_start_src_offset;
> +    /* Length of the source data that the hash will be computed on */
> +    le32 len_to_hash;
> +    /* Length of the additional auth data */
> +    le32 aad_len;
> +    /* Length of the hash result */
> +    le32 hash_result_len;
> +    le32 reserved;
> +};
> +
> +struct virtio_crypto_alg_chain_data_req {
> +    /* Device-readable part */
> +    struct virtio_crypto_alg_chain_data_para para;
> +    /* Initialization Vector or Counter data */
> +    u8 iv[iv_len];
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +    /* Additional authenticated data if exists  */
> +    u8 aad[aad_len];
> +
> +    /* Device-writable part */
> +    /* Destination data */
> +    u8 dst_data[dst_data_len];
> +    /* Hash result data */
> +    u8 hash_result[hash_result_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +The session mode packet of symmetric algorithm is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_sym_data_req {
> +    union {
> +        struct virtio_crypto_cipher_data_req cipher;
> +        struct virtio_crypto_alg_chain_data_req chain;
> +    } u;
> +
> +    /* Device-readable part */
> +
> +    /* See above VIRTIO_CRYPTO_SYM_OP_* */
> +    le32 op_type;
> +    le32 padding;
> +};
> +\end{lstlisting}
> +
> +Each data request uses virtio_crypto_sym_data_req structure to store inf=
ormation
> +used to run the CIPHER operations.=20
> +
> +The information includes the cipher parameters stored by \field{para}, o=
utput data and input data.
> +In the first virtio_crypto_cipher_para structure, \field{iv_len} specifi=
es the length of the initialization vector or counter,
> +\field{src_data_len} specifies the length of the source data, and \field=
{dst_data_len} specifies the
> +length of the destination data.=20
> +For plain CIPHER operations, the output data here includes the IV/Counte=
r data and source data, and the input data includes the destination data us=
ed to save the results of the CIPHER operations.=20
> +
> +For algorithms chain, the output data here includes the IV/Counter data,=
 source data and additional authenticated data if exists.
> +The input data includes both destination data and hash result data used =
to store the results of the HASH/MAC operations.
> +\field{inhdr} stores status of executing the crypto operations.
> +
> +The non-session mode packet of plain CIPHER service is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_cipher_para_non_sess {
> +    struct {
> +        /* See VIRTIO_CRYPTO_CIPHER* above */
> +        le32 algo;
> +        /* length of key */
> +        le32 keylen;
> +
> +        /* See VIRTIO_CRYPTO_OP_* above */
> +        le32 op;
> +    } sess_para;
> +
> +    /*
> +     * Byte Length of valid IV/Counter data pointed to by the below iv d=
ata.
> +     */
> +    le32 iv_len;
> +    /* length of source data */
> +    le32 src_data_len;
> +    /* length of destination data */
> +    le32 dst_data_len;
> +};
> +
> +struct virtio_crypto_cipher_data_req_non_sess {
> +    /* Device-readable part */
> +    struct virtio_crypto_cipher_para_non_sess para;
> +    /* The cipher key */
> +    u8 cipher_key[keylen];
> +
> +    /* Initialization Vector or Counter data. */
> +    u8 iv[iv_len];
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +
> +    /* Device-writable part */
> +    /* Destination data */
> +    u8 dst_data[dst_data_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +The non-session mode packet of algorithm chaining is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_alg_chain_data_para_non_sess {
> +    struct {
> +        /* See VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_* above */
> +        le32 alg_chain_order;
> +        /* length of the additional authenticated data in bytes */
> +        le32 aad_len;
> +
> +        struct {
> +            /* See VIRTIO_CRYPTO_CIPHER* above */
> +            le32 algo;
> +            /* length of key */
> +            le32 keylen;
> +            /* See VIRTIO_CRYPTO_OP_* above */
> +            le32 op;
> +        } cipher;
> +
> +        struct {
> +            /* See VIRTIO_CRYPTO_HASH_* or VIRTIO_CRYPTO_MAC_* above */
> +            le32 algo;
> +            /* length of authenticated key */
> +            le32 auth_key_len;
> +            /* See VIRTIO_CRYPTO_SYM_HASH_MODE_* above */
> +            le32 hash_mode;
> +        } hash;
> +    } sess_para;
> +
> +    le32 iv_len;
> +    /* Length of source data */
> +    le32 src_data_len;
> +    /* Length of destination data */
> +    le32 dst_data_len;
> +    /* Starting point for cipher processing in source data */
> +    le32 cipher_start_src_offset;
> +    /* Length of the source data that the cipher will be computed on */
> +    le32 len_to_cipher;
> +    /* Starting point for hash processing in source data */
> +    le32 hash_start_src_offset;
> +    /* Length of the source data that the hash will be computed on */
> +    le32 len_to_hash;
> +    /* Length of the additional auth data */
> +    le32 aad_len;
> +    /* Length of the hash result */
> +    le32 hash_result_len;
> +    le32 reserved;
> +};
> +
> +struct virtio_crypto_alg_chain_data_req_non_sess {
> +    /* Device-readable part */
> +    struct virtio_crypto_alg_chain_data_para_non_sess para;
> +    /* The cipher key */
> +    u8 cipher_key[keylen];
> +    /* The auth key */
> +    u8 auth_key[auth_key_len];
> +    /* Initialization Vector or Counter data */
> +    u8 iv[iv_len];
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +    /* Additional authenticated data if exists  */
> +    u8 aad[aad_len];
> +
> +    /* Device-writable part */
> +    /* Destination data */
> +    u8 dst_data[dst_data_len];
> +    /* Hash result data */
> +    u8 hash_result[hash_result_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +The non-session mode packet of symmetric algorithm is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_sym_data_req_non_sess {
> +    union {
> +        struct virtio_crypto_cipher_data_req_non_sess cipher;
> +        struct virtio_crypto_alg_chain_data_req_non_sess chain;
> +    } u;
> +
> +    /* Device-readable part */
> +
> +    /* See above VIRTIO_CRYPTO_SYM_OP_* */
> +    le32 op_type;
> +    le32 padding;
> +};
> +\end{lstlisting}
> +
> +\drivernormative{\paragraph}{Symmetric algorithms Operation}{Device Type=
s / Crypto Device / Device Operation / Symmetric algorithms Operation}
> +
> +\begin{itemize*}
> +\item If the driver uses the session mode, then the driver MUST set the =
\field{session_id} in struct virtio_crypto_op_header
> +      to a valid value which assigned by the device when a session is cr=
eated.
> +\item If the VIRTIO_CRYPTO_F_NON_SESSION_MODE feature bit is negotiated,=
 the driver MUST use the struct virtio_crypto_op_data_req_mux to wrap crypt=
o packets. Otherwise, the driver MUST use the struct virtio_crypto_op_data_=
req.
> +\item If the VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE feature bit is nego=
tiated, 1) if the driver use the non-session mode, then the driver MUST set=
 \field{flag} field in struct virtio_crypto_op_header
> +      to VIRTIO_CRYPTO_FLAG_NON_SESSION_MODE and MUST set fields in stru=
ct virtio_crypto_cipher_para_non_session.sess_para or struct virtio_crypto_=
alg_chain_data_para_non_sess.sess_para, 2) if the driver still uses the ses=
sion mode, then the driver MUST set \field{flag} field in struct virtio_cry=
pto_op_header to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
> +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_head=
er to VIRTIO_CRYPTO_CIPHER_ENCRYPT or VIRTIO_CRYPTO_CIPHER_DECRYPT.
> +\item The driver MUST specify the fields of struct virtio_crypto_cipher_=
data_req in struct virtio_crypto_sym_data_req if the packet is based on VIR=
TIO_CRYPTO_SYM_OP_CIPHER.
> +\item The driver MUST specify the fields of both struct virtio_crypto_ci=
pher_data_req and struct virtio_crypto_mac_data_req in struct virtio_crypto=
_sym_data_req if the packet
> +      is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING type and in the =
VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH mode.
> +\end{itemize*}
> +
> +\devicenormative{\paragraph}{Symmetric algorithms Operation}{Device Type=
s / Crypto Device / Device Operation / Symmetric algorithms Operation}
> +
> +\begin{itemize*}
> +\item If the VIRTIO_CRYPTO_F_NON_SESSION_MODE feature bit is negotiated,=
 the device MUST parse the struct virtio_crypto_op_data_req_mux for crypto =
packets. Otherwise, the device MUST parse the struct virtio_crypto_op_data_=
req.
> +\item If the VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE feature bit is nego=
tiated, the device MUST parse \field{flag} field in struct virtio_crypto_op=
_header in order to decide which mode the driver uses.
> +\item The device MUST parse the virtio_crypto_sym_data_req based on the =
\field{opcode} in general header.
> +\item The device SHOULD only parse fields of struct virtio_crypto_cipher=
_data_req in struct virtio_crypto_sym_data_req if the packet is VIRTIO_CRYP=
TO_SYM_OP_CIPHER type.
> +\item The device MUST parse fields of both struct virtio_crypto_cipher_d=
ata_req and struct virtio_crypto_mac_data_req in struct virtio_crypto_sym_d=
ata_req if the packet
> +      is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING operation type a=
nd in the VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH mode.
> +\item The device MUST copy the result of cryptographic operation to the =
dst_data[] in both plain CIPHER mode and algorithms chain mode.
> +\item The device MUST check the \field{para}.\field{add_len} is bigger t=
han 0 before parse the additional authenticated data in plain algorithms ch=
ain mode.
> +\item The device MUST copy the result of HASH/MAC operation to the hash_=
result[] is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING type.
> +\item The device MUST set the \field{status} field in struct virtio_cryp=
to_inhdr to one of the values of enum VIRITO_CRYPTO_STATUS.
> +\end{itemize*}
> +
> +\paragraph{Steps of Operation}\label{sec:Device Types / Crypto Device / =
Device Operation / Symmetric algorithms Operation / Steps of Operation}
> +
> +\subparagraph{Step1: Create session}\label{sec:Device Types / Crypto Dev=
ice / Device Operation / Symmetric algorithms Operation / Steps of Operatio=
n / Step1: Create session on session mode}
> +
> +\begin{enumerate}
> +\item The driver specifies information in struct virtio_crypto_op_ctrl_r=
eq, including the algorithm name, key, keylen etc;
> +\item The driver adds the request of session creation into the controlq'=
s Vring Descriptor Table;
> +\item The driver kicks the device;
> +\item The device receives the request from controlq;
> +\item The device parses information about the request, and determines th=
e information concerning the backend crypto accelerator;
> +\item The device packs information based on the APIs of the backend cryp=
to accelerator;
> +\item The device invokes the session creation APIs of the backend crypto=
 accelerator to create a session;
> +\item The device returns the session id to the driver.
> +\end{enumerate}
> +
> +\subparagraph{Step2: Execute cryptographic operation}\label{sec:Device T=
ypes / Crypto Device / Device Operation / Symmetric algorithms Operation / =
Steps of Operation / Step2: Execute cryptographic operation}
> +
> +\begin{enumerate}
> +\item The driver specifies information in struct virtio_crypto_op_data_r=
eq, including struct virtio_crypto_op_header and struct virtio_crypto_sym_d=
ata_req, see \ref{sec:Device Types / Crypto Device / Device
> +      Operation / Symmetric algorithms Operation};
> +\item The driver adds the request for cryptographic operation into the d=
ataq's Vring Descriptor Table;
> +\item The driver kicks the device (Or the device actively polls the data=
q's Vring Descriptor Table);
> +\item The device receives the request from dataq;
> +\item The device parses information about the request, and determines th=
e identification information for the backend crypto accelerator. For exampl=
e, converting guest physical addresses to host physical addresses;
> +\item The device packs identification information based on the API of th=
e backend crypto accelerator;
> +\item The device invokes the cryptographic APIs of the backend crypto ac=
celerator;
> +\item The backend crypto accelerator executes the cryptographic operatio=
n implicitly;
> +\item The device receives the cryptographic results from the backend cry=
pto accelerator (synchronous or asynchronous);
> +\item The device sets the \field{status} in struct virtio_crypto_inhdr;
> +\item The device updates and flushes the Used Ring to return the cryptog=
raphic results to the driver;
> +\item The device notifies the driver (Or the driver actively polls the d=
ataq's Used Ring);
> +\item The driver saves the cryptographic results.
> +\end{enumerate}
> +
> +\begin{note}
> +\begin{itemize*}
> +\item For better performance, the device should by preference use vhost =
scheme (user space or kernel space)
> +      as the backend crypto accelerator in the real production environme=
nt.
> +\end{itemize*}
> +\end{note}
> +
> +\subsubsection{AEAD Service Operation}\label{sec:Device Types / Crypto D=
evice / Device Operation / AEAD Service Operation}
> +
> +The session mode packet of symmetric algorithm is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_aead_para {
> +    /*
> +     * Byte Length of valid IV data.
> +     *
> +     * For GCM mode, this is either 12 (for 96-bit IVs) or 16, in which
> +     *   case iv points to J0.
> +     * For CCM mode, this is the length of the nonce, which can be in the
> +     *   range 7 to 13 inclusive.
> +     */
> +    le32 iv_len;
> +    /* length of additional auth data */
> +    le32 aad_len;
> +    /* length of source data */
> +    le32 src_data_len;
> +    /* length of dst data, this should be at least src_data_len + tag_le=
n */
> +    le32 dst_data_len;
> +    /* Authentication tag length */
> +    le32 tag_len;
> +    le32 reserved;
> +};
> +
> +struct virtio_crypto_aead_data_req {
> +    /* Device-readable part */
> +    struct virtio_crypto_aead_para para;
> +    /*
> +     * Initialization Vector data.
> +     *
> +     * For GCM mode, this is either the IV (if the length is 96 bits) or=
 J0
> +     *   (for other sizes), where J0 is as defined by NIST SP800-38D.
> +     *   Regardless of the IV length, a full 16 bytes needs to be alloca=
ted.
> +     * For CCM mode, the first byte is reserved, and the nonce should be
> +     *   written starting at &iv[1] (to allow space for the implementati=
on
> +     *   to write in the flags in the first byte).  Note that a full 16 =
bytes
> +     *   should be allocated, even though the iv_len field will have
> +     *   a value less than this.
> +     *
> +     * The IV will be updated after every partial cryptographic operatio=
n.
> +     */
> +    u8 iv[iv_len];
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +    /* Additional authenticated data if exists  */
> +    u8 aad[aad_len];
> +
> +    /* Device-writable part */
> +    /* Pointer to output data */
> +    u8 dst_data[dst_data_len];
> +
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +Each data request uses virtio_crypto_aead_data_req structure to store in=
formation
> +used to run the AEAD operations.=20
> +
> +The information includes the hash parameters stored by \field{para}, out=
put data and input data.
> +In the first virtio_crypto_aead_para structure, \field{iv_len} specifies=
 the length of the initialization vector. \field{tag_len} specifies the len=
gth of the authentication tag;
> +\field{aad_len} specifies the length of additional authentication data, =
\field{src_data_len} specifies the
> +length of the source data; \field{dst_data_len} specifies the length of =
the destination data, which is at least \field{src_data_len} + \field{tag_l=
en}.
> +
> +The output data here includes the IV/Counter data, source data and addit=
ional authenticated data if exists.
> +The input data includes both destination data used to save the results o=
f the AEAD operations.
> +\field{inhdr} stores status of executing the AEAD operations.
> +
> +The non-session mode packet of AEAD service is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_aead_para_non_sess {
> +    struct {
> +        /* See VIRTIO_CRYPTO_AEAD_* above */
> +        le32 algo;
> +        /* length of key */
> +        le32 key_len;
> +        /* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
> +        le32 op;
> +    } sess_para;
> +
> +    /* Byte Length of valid IV data. */
> +    le32 iv_len;
> +    /* Authentication tag length */
> +    le32 tag_len;
> +    /* length of additional auth data */
> +    le32 aad_len;
> +    /* length of source data */
> +    le32 src_data_len;
> +    /* length of dst data, this should be at least src_data_len + tag_le=
n */
> +    le32 dst_data_len;
> +};
> +
> +struct virtio_crypto_aead_data_req_non_sess {
> +    /* Device-readable part */
> +    struct virtio_crypto_aead_para_non_sess para;
> +    /* The cipher key */
> +    u8 key[key_len];
> +    /* Initialization Vector data. */
> +    u8 iv[iv_len];
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +    /* Additional authenticated data if exists  */
> +    u8 aad[aad_len];
> +
> +    /* Device-writable part */
> +    /* Pointer to output data */
> +    u8 dst_data[dst_data_len];
> +
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +\drivernormative{\paragraph}{AEAD Service Operation}{Device Types / Cryp=
to Device / Device Operation / AEAD Service Operation}
> +
> +\begin{itemize*}
> +\item If the driver uses the session mode, then the driver MUST set the =
\field{session_id} in struct virtio_crypto_op_header
> +      to a valid value which assigned by the device when a session is cr=
eated.
> +\item If the VIRTIO_CRYPTO_F_NON_SESSION_MODE feature bit is negotiated,=
 the driver MUST use the struct virtio_crypto_op_data_req_mux to wrap crypt=
o packets. Otherwise, the driver MUST use the struct virtio_crypto_op_data_=
req.
> +\item If the VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE feature bit is negoti=
ated, 1) if the driver use the non-session mode, then the driver MUST set \=
field{flag} field in struct virtio_crypto_op_header
> +      to VIRTIO_CRYPTO_FLAG_NON_SESSION_MODE and MUST set fields in stru=
ct virtio_crypto_aead_para_non_session.sess_para, 2) if the driver still us=
es the session mode, then the driver MUST set \field{flag} field in struct =
virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_SESSION_MODE.
> +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_head=
er to VIRTIO_CRYPTO_AEAD_ENCRYPT or VIRTIO_CRYPTO_AEAD_DECRYPT.
> +\end{itemize*}
> +
> +\devicenormative{\paragraph}{AEAD Service Operation}{Device Types / Cryp=
to Device / Device Operation / AEAD Service Operation}
> +
> +\begin{itemize*}
> +\item If the VIRTIO_CRYPTO_F_NON_SESSION_MODE feature bit is negotiated,=
 the device MUST parse the struct virtio_crypto_op_data_req_mux for crypto =
packets. Otherwise, the device MUST parse the struct virtio_crypto_op_data_=
req.
> +\item If the VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE feature bit is negoti=
ated, the device MUST parse the virtio_crypto_aead_data_req based on the \f=
ield{opcode} in general header.
> +\item The device MUST copy the result of cryptographic operation to the =
dst_data[].
> +\item The device MUST copy the authentication tag to the dst_data[] offs=
et the cipher result.
> +\item The device MUST set the \field{status} field in struct virtio_cryp=
to_inhdr to one of the values of enum VIRITO_CRYPTO_STATUS.
> +\item When the \field{opcode} is VIRTIO_CRYPTO_AEAD_DECRYPT, the device =
MUST verify and return the verification result to the driver, and if the ve=
rification result is incorrect, VIRTIO_CRYPTO_BADMSG (bad message) MUST be =
returned to the driver.
> +\end{itemize*}
> \ No newline at end of file
> --=20
> 1.7.12.4
>=20
>=20
>=20

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYlFxsAAoJEJykq7OBq3PIOTUIAKZJ24o1V60oH4BI58lsFAgg
nFFCJn7eyMztobDQtu8iJX4d4kyaKmQIsrVRkjb8tLLNCXt6pBreoW36d7Zc7Wfg
3rq1i0IwBiJkjLNzoHefQhO5YBka+k0cQa/rVGz4jIrO8o7kIyJKGDgHLNRCczIv
419q+kkcnZn9/V5PWPkmutkLXIzFYQcdScvDFM608NZs6tCEJJWydHnME4oJ77/n
SIS7d5HdH9YLuSvu11NqPsdPY73TdLBrR9mOM3RrsQ4VXthdyYDyuACivVLsslIm
gzPRtzKuX3uqKjLkb8JeYZ0/yMEhwBR2AgwPJdMliKnJKV+Jxt4LANNznbINv3E=
=7JOp
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
