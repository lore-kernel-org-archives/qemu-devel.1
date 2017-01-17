Received: from eggs.gnu.org ([2001:4830:134:3::10]:38223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xin.zeng@intel.com>) id 1cTT4m-0005zj-PO
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xin.zeng@intel.com>) id 1cTT4h-0003sC-Oz
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:41:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:22908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xin.zeng@intel.com>) id 1cTT4h-0003rb-8J
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:41:19 -0500
From: "Zeng, Xin" <xin.zeng@intel.com>
Date: Tue, 17 Jan 2017 12:41:11 +0000
Message-ID: <82063967A54EF84C8AFCD6BD7F6AD93310C4C74E@SHSMSX103.ccr.corp.intel.com>
References: <1484051484-86503-1-git-send-email-xin.zeng@intel.com>
In-Reply-To: <1484051484-86503-1-git-send-email-xin.zeng@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH v3 1/1] virtio crypto device
 specification: asymmetric crypto service
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Keating, Brian A" <brian.a.keating@intel.com>, "Griffin, John" <john.griffin@intel.com>, "Ma, Liang J" <liang.j.ma@intel.com>, "weidong.huang@huawei.com" <weidong.huang@huawei.com>

Ping...
Any comments on this part of virtio crypto spec?

We also plan to add asymmetric crypto service part support in LKCF based vi=
rtio crypto frontend driver, and upstream DPDK vhost library based vhost us=
er for cryptodev which also focuses on asymmetric crypto service , any comm=
ents?

Thanks

> -----Original Message-----
> From: Zeng, Xin
> Sent: Tuesday, January 10, 2017 8:31 PM
> To: virtio-dev@lists.oasis-open.org; qemu-devel@nongnu.org
> Cc: mst@redhat.com; arei.gonglei@huawei.com; stefanha@redhat.com;
> cornelia.huck@de.ibm.com; Keating, Brian A; Griffin, John; Ma, Liang J;
> weidong.huang@huawei.com; Zeng, Xin
> Subject: [RFC PATCH v3 1/1] virtio crypto device specification: asymmetri=
c
> crypto service
>=20
> This patch introduces asymmetric crypto service into virtio crypto device
> spec. The asymmetric crypto service can be referred as signature,
> verification, encryption, decryption, key generation and key exchange.
> This patch depends on virtio crypto device spec patch:
> http://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00291.html
>=20
> Please help to review, thanks!
>=20
> Changes since v2:
> - Update some sections according to the update of virtio crypto device sp=
ec
> v15.
> - Fix minor spelling mistakes
> - Remove trail spaces in the spec
>=20
> Changes since v1:
> - Remove virtio_crypto_buf  to be consistent with other  virtio devices'
> buf representation. [Lei]
> - Use "MUST" instead of "SHOULD" in some places. [Lei]
>=20
> Changes since v0:
> - Use devicenormative/drivernormative instead of self-defined
>   device/driver label.  [Lei]
> - Change the error code of verification to general virtio_crypto
>   error code. [Lei]
> - Use macro instead of enum in verification result. [Lei]
> - Fix the incorrect label value for paragraph and section. [Lei]
>=20
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> ---
>  virtio-crypto.tex | 1109
> ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 1107 insertions(+), 2 deletions(-)
>=20
> diff --git a/virtio-crypto.tex b/virtio-crypto.tex index 44819f9..d3236df=
 100644
> --- a/virtio-crypto.tex
> +++ b/virtio-crypto.tex
> @@ -6,7 +6,7 @@ decryption requests are placed in any of teh data active
> queues and are ultimate  backend crypto accelerators. The second kind of
> queue is the control queue used to create  or destroy sessions for symmet=
ric
> algorithms and will control some advanced  features in the future. The vi=
rtio
> crypto device provides the following crypto
> -services: CIPHER, MAC, HASH, and AEAD.
> +services: CIPHER, MAC, HASH, AEAD and ASYM.
>=20
>=20
>  \subsection{Device ID}\label{sec:Device Types / Crypto Device / Device I=
D}
> @@ -47,6 +47,9 @@ struct virtio_crypto_config {
>      le32 mac_algo_l;
>      le32 mac_algo_h;
>      le32 aead_algo;
> +    le32 asym_algo;
> +    /*Rsa padding capabilities*/
> +    le32 rsa_padding;
>      /* Maximum length of cipher key */
>      le32 max_cipher_key_len;
>      /* Maximum length of authenticated key */ @@ -80,6 +83,8 @@ The
> following services are defined:
>  #define VIRTIO_CRYPTO_SERVICE_MAC    2
>  /* AEAD (Authenticated Encryption with Associated Data) service */
>  #define VIRTIO_CRYPTO_SERVICE_AEAD   3
> +/* ASYM (Asymmetric crypto algorithms) service */
> +#define VIRTIO_CRYPTO_SERVICE_ASYM   4
>  \end{lstlisting}
>=20
>  The last driver-read-only fields specify detailed algorithms masks @@ -1=
53,6
> +158,28 @@ The following AEAD algorithms are defined:
>  #define VIRTIO_CRYPTO_AEAD_CHACHA20_POLY1305  3  \end{lstlisting}
>=20
> +The following asymmetric algorithms are defined:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_ASYM_NONE   0
> +#define VIRTIO_CRYPTO_ASYM_RSA    1
> +#define VIRTIO_CRYPTO_ASYM_DSA    2
> +#define VIRTIO_CRYPTO_ASYM_DH     3
> +#define VIRTIO_CRYPTO_ASYM_ECDSA  4
> +#define VIRTIO_CRYPTO_ASYM_ECDH   5
> +\end{lstlisting}
> +
> +The following rsa padding capabilities are defined:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_RSA_NO_PADDING          0
> +#define VIRTIO_CRYPTO_RSA_PKCS1_PADDING       1
> +#define VIRTIO_CRYPTO_RSA_SSLV23_PADDING      2
> +#define VIRTIO_CRYPTO_RSA_PKCS1_OAEP_PADDING  3
> +#define VIRTIO_CRYPTO_RSA_X931_PADDING        4
> +#define VIRTIO_CRYPTO_RSA_PKCS1_PSS_PADDING   5
> +\end{lstlisting}
> +
>  \begin{note}
>  Any other value is reserved for future use.
>  \end{note}
> @@ -168,6 +195,7 @@ Any other value is reserved for future use.
>  \item The device MUST set \field{max_size} to show the maximum size of
> crypto request the device supports.
>  \item The device MUST set \field{max_cipher_key_len} to show the
> maximum length of cipher key if the device supports CIPHER service.
>  \item The device MUST set \field{max_auth_key_len} to show the
> maximum length of authenticated key if the device supports MAC service.
> +\item The device MUST set \field{rsa_padding} to show the padding
> capabilities offered by the device.
>  \end{itemize*}
>=20
>  \drivernormative{\subsubsection}{Device configuration layout}{Device
> Types / Crypto Device / Device configuration layout} @@ -182,6 +210,7 @@
> Any other value is reserved for future use.
>  \item The driver SHOULD read \field{max_size} to discover the maximum
> size of crypto request the device supports.
>  \item The driver SHOULD read \field{max_cipher_key_len} to discover the
> maximum length of cipher key the device supports.
>  \item The driver SHOULD read \field{max_auth_key_len} to discover the
> maximum length of authenticated key the device supports.
> +\item The driver MAY read \field{rsa_padding} to discover the padding
> capabilities offered by the device.
>  \end{itemize*}
>=20
>  \subsection{Device Initialization}\label{sec:Device Types / Crypto Devic=
e /
> Device Initialization} @@ -264,6 +293,18 @@ struct virtio_crypto_op_heade=
r
> {
>      VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)  #define
> VIRTIO_CRYPTO_AEAD_DECRYPT \
>      VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
> +#define VIRTIO_CRYPTO_ASYM_SIGN    \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_ASYM, 0x00)
> #define
> +VIRTIO_CRYPTO_ASYM_VERIFY \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_ASYM, 0x01)
> #define
> +VIRTIO_CRYPTO_ASYM_ENCRYPT  \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_ASYM, 0x02)
> #define
> +VIRTIO_CRYPTO_ASYM_DECRYPT  \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_ASYM, 0x03)
> #define
> +VIRTIO_CRYPTO_ASYM_KEY_GEN  \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_ASYM, 0x04)
> #define
> +VIRTIO_CRYPTO_ASYM_KEY_EXCHG \
> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_ASYM, 0x05)
>      le32 opcode;
>      /* algo should be service-specific algorithms */
>      le32 algo;
> @@ -575,6 +616,23 @@ struct virtio_crypto_op_data_req {
>          struct virtio_crypto_hash_data_req  hash_req;
>          struct virtio_crypto_mac_data_req   mac_req;
>          struct virtio_crypto_aead_data_req  aead_req;
> +
> +        struct virtio_crypto_ecdsa_sign_req ecdsa_sign_req;
> +        struct virtio_crypto_dsa_sign_req dsa_sign_req;
> +        struct virtio_crypto_rsa_sign_req rsa_sign_req;
> +        struct virtio_crypto_ecdsa_verify_req ecdsa_verify_req;
> +        struct virtio_crypto_dsa_verify_req dsa_verify_req;
> +        struct virtio_crypto_rsa_verify_req rsa_verify_req;
> +        struct virtio_crypto_rsa_enc_req rsa_enc_req
> +        struct virtio_crypto_rsa_dec_req rsa_dec_req;
> +        struct virtio_crypto_rsa_keygen_req rsa_keygen_req;
> +        struct virtio_crypto_dsa_keygen_req dsa_keygen_req;
> +        struct virtio_crypto_ec_keygen_req ec_keygen_req;
> +        struct virtio_crypto_dh_keyexchg_param_gen_req
> dh_keyexchg_param_gen_req;
> +        struct virtio_crypto_dh_keyexchg_key_gen_req
> dh_keyexchg_key_gen_req;
> +        struct virtio_crypto_dh_keyexchg_key_compute_req
> dh_keyexchg_key_compute_req;
> +        struct virtio_crypto_ecdh_keyexchg_key_gen_req
> ecdh_keyexchg_key_gen_req;
> +        struct virtio_crypto_ecdh_keyexchg_key_compute_req
> + ecdh_keyexchg_key_compute_req;
>      } u;
>  };
>  \end{lstlisting}
> @@ -1026,4 +1084,1051 @@ The input data includes both destination data
> used to save the results of the AE  \item The device MUST copy the
> authentication tag to the dst_data[] offset the cipher result.
>  \item The device MUST set the \field{status} field in struct
> virtio_crypto_inhdr to one of the values of enum VIRITO_CRYPTO_STATUS.
>  \item When the \field{opcode} is VIRTIO_CRYPTO_AEAD_DECRYPT, the
> device MUST verify and return the verification result to the driver, and =
if the
> verification result is incorrect, VIRTIO_CRYPTO_BADMSG (bad message)
> MUST be returned to the driver.
> -\end{itemize*}
> \ No newline at end of file
> +\end{itemize*}
> +
> +\subsubsection{Asymmetric Crypto Service Operation}\label{sec:Device
> +Types / Crypto Device / Device Operation / Crypto operation /
> +Asymmetric Crypto Service Operation}
> +
> +In general, asymmetric crypto service can be referred as signature,
> +verification, encryption, decryption, key generation and key exchange.
> +Not each algorithm supports all these services.
> +
> +Asymmetric crypto service normally does't need session operations, the
> +request is encapsulated within one packet which is represented by
> \field{virtio_crypto_op_data_req}.
> +(see \ref{sec:Device Types / Crypto Device / Device Operation / Data
> Virtqueue}).
> +
> +Once service request is handled by the device, the device writes back
> +the operation results to the corresponding fields in the request packet.
> +
> +\devicenormative{\paragraph}{Asymmetric Crypto Service
> +Operation}{Device Types / Crypto Device / Device Operation / Asymmetric
> +Crypto Service Operation} \begin{itemize*} \item The device MUST parse
> +the field \field{opcode} within \field{virtio_crypto_op_header} (see
> \ref{sec:Device Types / Crypto Device / Device Operation}) before it hand=
les
> the corresponding service request.
> +\item The device MUST set the operation status in field \field{status} w=
ithin
> \field{idata}.
> +\item The device MUST update the operation result to the fields in
> \field{idata} if the operation is successful.
> +\end{itemize*}
> +
> +\drivernormative{\paragraph}{Asymmetric Crypto Service
> +Operation}{Device Types / Crypto Device / Device Operation / Asymmetric
> +Crypto Service Operation} \begin{itemize*} \item The driver MUST set the
> corresponding \field{opcode} in \field{virtio_crypto_op_header} according
> to different services.
> +\item The driver MUST offer operatable buffer within \field{idata} if th=
e
> service request structure defines.
> +\end{itemize*}
> +
> +\paragraph{Signature: ECDSA signature operation}\label{sec:Device Types
> +/ Crypto Device / Device Operation / Crypto operation / Asymmetric
> +Crypto Service Operation / Signature: ECDSA signature operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_ec_group {
> +    le32 xg_len;
> +    le32 yg_len;
> +    le32 n_len;
> +    le32 q_len;
> +    le32 a_len;
> +    le32 b_len;
> +    le32 h_len;
> +    le32 reserved;
> +};
> +
> +struct virtio_crypto_ec_group_data {
> +    u8 xg[xg_len];
> +    u8 yg[yg_len];
> +    u8 n[n_len];
> +    u8 q[q_len];
> +    u8 a[a_len];
> +    u8 b[b_len];
> +    u8 h[h_len];
> +};
> +
> +#define VIRTIO_CRYPTO_EC_FIELD_TYPE_PRIME 0 #define
> +VIRTIO_CRYPTO_EC_FIELD_TYPE_BINARY 1
> +
> +struct virtio_crypto_ecdsa_sign_para{
> +    /* Hash alogrithms applied to msg */
> +    le32 hash_algo;
> +    /* EC field_type, see VIRTIO_CRYPTO_EC_FIELD_TYPE_* definition */
> +    le32 field_type;
> +    /* EC Group parameters */
> +    struct virtio_crypto_ec_group ec;
> +    /* length of random value */
> +    le32 k_len;
> +    /* length of private key */
> +    le32 d_len;
> +
> +    /* length of message */
> +    le32 msg_len;
> +    /* length of signature result */
> +    le32 r_len;
> +    le32 s_len;
> +    le32 reserved;
> +
> +    struct virtio_crypto_ec_group_data ec_data;
> +    u8 k[k_len];
> +    u8 d[d_len];
> +};
> +
> +struct virtio_crypto_ecdsa_sign_output {
> +    /* Message need to be signed */
> +    u8 msg[msg_len];
> +};
> +
> +struct virtio_crypto_ecdsa_sign_input {
> +    /* operation result */
> +    le32 status;
> +    le32 reserved;
> +
> +    /* signature result */
> +    u8 r[r_len];
> +    u8 s[s_len];
> +};
> +\end{lstlisting}
> +
> +ECDSA signature operation request is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_ecdsa_sign_req {
> +    struct virtio_crypto_ecdsa_sign_para parameter;
> +    struct virtio_crypto_ecdsa_sign_output odata;
> +
> +    struct virtio_crypto_ecdsa_sign_input idata; }; \end{lstlisting}
> +
> +
> +\devicenormative{\subparagraph}{ECDSA signature operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / ECDSA signature operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{ECDSA signature operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / ECDSA signature operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_SIGN,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_ECDSA.
> +\item The driver SHOULD set all fields in \field{parameter} and \field{o=
data}
> except field \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} before it operates other fields in \field{idata}.
> +Only if the operation is successful, the \field{r,s} in \field{idata} ar=
e
> operatable.
> +\end{itemize*}
> +
> +\paragraph{Signature: DSA signature operation}\label{sec:Device Types /
> Crypto Device /
> +Device Operation / Crypto operation / Asymmetric Crypto Service
> Operation/ Signature: DSA signature operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_dsa_group {
> +    le32 p_len;
> +    le32 q_len;
> +    le32 g_len;
> +    le32 reserved;
> +};
> +
> +struct virtio_crypto_dsa_group_data {
> +    u8 p[p_len];
> +    u8 q[q_len];
> +    u8 g[g_len];
> +}
> +
> +struct virtio_crypto_dsa_sign_para {
> +    /* Hash alogrithms applied to msg */
> +    le32 hash_algo;
> +    le32 reserved1;
> +
> +    /* DSA group parameter */
> +    struct virtio_crypto_dsa_group dsa;
> +    /* length of random value */
> +    le32 k_len;
> +    /* length of private key */
> +    le32 x_len;
> +
> +    /* length of message */
> +    le32 msg_len;
> +    /* length of signautre result */
> +    le32 r_len;
> +    le32 s_len;
> +    le32 reserved2;
> +
> +    struct virtio_crypto_dsa_group_data dsa_group_data;
> +    u8 k[k_len];
> +    u8 x[x_len];
> +};
> +
> +struct virtio_crypto_dsa_sign_output {
> +    u8 msg[msg_len];
> +};
> +
> +struct virtio_crypto_dsa_sign_input  {
> +    /* operation result */
> +    le32 status;
> +    le32 reserved;
> +
> +    /* signature result */
> +    u8 r[r_len];
> +    u8 s[s_len];
> +};
> +\end{lstlisting}
> +DSA signature operation request is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_dsa_sign_req {
> +    struct virtio_crypto_dsa_sign_para parameter;
> +    struct virtio_crypto_dsa_sign_output odata;
> +
> +    struct virtio_crypto_dsa_sign_input idata;
> +};
> +\end{lstlisting}
> +
> +
> +\devicenormative{\subparagraph}{DSA signature operation}{Device Types /
> Crypto Device / Device Operation / Asymmetric Crypto Service Operation /
> DSA signature operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{DSA signature operation}{Device Types /
> Crypto Device / Device Operation / Asymmetric Crypto Service Operation /
> DSA signature operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_SIGN,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_DSA.
> +\item The driver SHOULD set all fields in \field{parameter} and \field{o=
data}
> except field \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} before it operates other fields in \field{idata}.
> +Only if the operation is successful, the \field{r,s} in \field{idata} ar=
e
> operatable.
> +\end{itemize*}
> +
> +\paragraph{Signature: RSA signature operation}\label{sec:Device Types /
> Crypto Device /
> +Device Operation / Crypto operation / Asymmetric Crypto Service
> Operation / Signature: RSA signature operation}
> +
> +\begin{lstlisting}
> +
> +struct virtio_crypto_rsa_pub_key{
> +    /* The RSA modules */
> +    le32 n_len;
> +    /* The RSA public exponent */
> +    le32 e_len;
> +};
> +
> +struct virtio_crypto_rsa_pub_key_data{
> +    /* The RSA modules */
> +    u8 n[n_len];
> +    /* The RSA public exponent */
> +    u8 e[e_len];
> +};
> +
> +struct virtio_crypto_rsa_priv_key_rep1{
> +    /* The RSA modules */
> +    le32 n_len;
> +    /* The RSA private exponent */
> +    le32 d_len;
> +}
> +
> +struct virtio_crypto_rsa_priv_key_rep1_data{
> +    /* The RSA modules */
> +    u8 n[n_len];
> +    /* The RSA private exponent */
> +    u8 d[d_len];
> +};
> +
> +struct virtio_crypto_rsa_priv_key_rep2{
> +    /* The first factor */
> +    le32 p_len;
> +    /* The second factor */
> +    le32 q_len;
> +    /* The first factor's CRT exponent */
> +    le32 dp_len;
> +    /* The second factor's CRT exponent */
> +    le32 dp_len;
> +    /* The first CRT coeffieient */
> +    le32 qinv_len;
> +    /* The factors array when prime_number > 2 */
> +    le32 r_len;
> +    /* The CRT exponent array when prime_number > 2 */
> +    le32 d_len;
> +    /* The CRT coeffieient array when prime_number > 2 */
> +    le32 t_len;
> +};
> +
> +struct virtio_crypto_rsa_priv_key_rep2_data{
> +    /* The first factor */
> +    u8 p[p_len];
> +    /* The second factor */
> +    u8 q[q_len];
> +    /* The first factor's CRT exponent */
> +    u8 dp[dp_len];
> +    /* The second factor's CRT exponent */
> +    u8 dq[dp_len];
> +    /* The first CRT coeffieient */
> +    u8 qinv[qinv_len];
> +    /* The factors array when prime_number > 2 */
> +    u8 r[][r_len];
> +    /* The CRT exponent array when prime_number > 2 */
> +    u8 d[][d_len];
> +    /* The CRT coeffieient array when prime_number > 2 */
> +    u8 t[][t_len];
> +};
> +
> +struct virtio_crypto_rsa_priv_key {
> +    le32 prime_number;
> +#define VIRTIO_CRYPTO_RSA_PRIV_KEY_REPTYPE1 0
> +#define VIRTIO_CRYPTO_RSA_PRIV_KEY_REPTYPE2 1
> +    le32 priv_key_rep_type;
> +    union {
> +        struct virtio_crypto_rsa_priv_key_rep1 privkey_rep1;
> +        struct virtio_crypto_rsa_priv_key_rep2 privkey_rep2;
> +    }key;
> +
> +    union {
> +        struct virtio_crypto_rsa_priv_key_rep1_data privkey_rep1_data;
> +        struct virtio_crypto_rsa_priv_key_rep2_data privkey_rep2_data;
> +    }key_data;
> +};
> +
> +struct virtio_crypto_rsa_sign_para {
> +    /* Hash alogrithms applied to msg */
> +    le32 hash_algo;
> +    le32 padding_mode;
> +    struct virtio_crypto_rsa_priv_key priv_key;
> +
> +    le32 msg_len;
> +    le32 signature_len;
> +
> +    struct virtio_crypto_rsa_priv_key_data priv_key_data;
> +};
> +
> +struct virtio_crypto_rsa_sign_output {
> +    u8 msg[msg_len];
> +};
> +
> +struct virtio_crypto_rsa_sign_input {
> +    le32 status;
> +    le32 reserved;
> +
> +    u8 signature[signature_len];
> +};
> +\end{lstlisting}
> +
> +RSA signature operation request is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_rsa_sign_req {
> +    struct virtio_crypto_rsa_sign_para parameter;
> +    struct virtio_crypto_rsa_sign_output odata;
> +
> +    struct virtio_crypto rsa_sign_input idata;
> +};
> +\end{lstlisting}
> +
> +
> +\devicenormative{\subparagraph}{ECDSA signature operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / RSA signature operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{ECDSA signature operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / RSA signature operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_SIGN,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_RSA.
> +\item The driver SHOULD set all fields in \field{parameter} and \field{o=
data}
> except field \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} before it operates other fields in \field{idata}.
> +Only if the operation is successful, the \field{signature} in \field{ida=
ta} is
> operatable.
> +\end{itemize*}
> +
> +\paragraph{Verification: Common Structure}\label{sec:Device Types /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Verification: Common Structure}
> +
> +The result of verification operation can be represented by structure
> \field{virtio_crypto_asym_verify_gen_input}.
> +
> +\begin{lstlisting}
> +struct virtio_crypto_asym_verify_gen_input {
> +    /* Operation result */
> +    le32 status;
> +    /* Verification result, VIRTIO_CRYPTO_OK for a susscssful verificati=
on
> +     VIRTIO_CRYPTO_BADMSG for a failed verification */
> +    le32 verify_result;
> +};
> +\end{lstlisting}
> +
> +\paragraph{Verification: ECDSA Verification Operation}\label{sec:Device
> Types /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Verification: ECDSA Verification Operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_ecdsa_verify_para {
> +    /* Hash alogrithms applied to msg */
> +    le32 hash_algo;
> +    /* EC field_type, see VIRTIO_CRYPTO_EC_FIELD_TYPE_* definition */
> +    le32 field_type;
> +    /* EC Group parameters */
> +    struct virtio_crypto_ec_group ec;
> +    /* length of public key */
> +    le32 x_len;
> +    le32 y_len;
> +
> +    /* length of signauture value */
> +    le32 r_len;
> +    le32 s_len;
> +    /* length of message */
> +    le32 msg_len;
> +    le32 reserved;
> +
> +    struct virtio_crypto_ec_group_data ec_data;
> +    /* Public key */
> +    u8 x[x_len];
> +    u8 y[y_len];
> +};
> +
> +struct virtio_crypto_ecdsa_verify_output {
> +    /* Signature value */
> +    u8 r[r_len];
> +    u8 s[s_len];
> +
> +    u8 msg[msg_len];
> +};
> +\end{lstlisting}
> +
> +ECDSA Verification Operation request is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_ecdsa_verify_req {
> +    struct virtio_crypto_ecdsa_verify_para parameter;
> +    struct virtio_crypto_ecdsa_verify_output odata;
> +
> +    struct virtio_crypto_asym_verify_gen_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{ECDSA verification operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / ECDSA verification operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{ECDSA verification operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / ECDSA verification operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_VERIFY,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_ECDSA.
> +\item The driver SHOULD set all fields in \field{parameter} and \field{o=
data}
> except field \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} before it checks \field{verify_result}.
> +\end{itemize*}
> +
> +\paragraph{Verification: DSA Verification Operation}\label{sec:Device Ty=
pes
> /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Verification: DSA Verification Operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_dsa_verify_para {
> +    le32 hash_algo;
> +    le32 reserved;
> +
> +    /* DSA Group parameters */
> +    struct virtio_crypto_dsa_group dsa;
> +    le32 y_len;
> +
> +    /* length of signature value */
> +    le32 r_len;
> +    le32 s_len;
> +    /* length of message */
> +    le32 msg_len;
> +
> +    struct virtio_crypto_dsa_group_data dsa_data;
> +    /* Public key */
> +    u8 y[y_len];
> +};
> +
> +struct virtio_crypto_dsa_verify_output {
> +    /* Signature value */
> +    u8 r[r_len];
> +    u8 s[s_len];
> +
> +    u8 msg[msg_len];
> +};
> +\end{lstlisting}
> +
> +DSA Verification Operation request is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_dsa_verify_req {
> +    struct virtio_crypto_dsa_verify_para parameter;
> +    struct virtio_crypto_dsa_verify_output odata;
> +
> +    struct virtio_crypto_asym_verify_gen_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{DSA verification operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / DSA verification operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata}.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{DSA verification operation}{Device Types
> / Crypto Device / Device Operation / Asymmetric Crypto Service Operation =
/
> DSA verification operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_VERIFY,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_DSA.
> +\item The driver SHOULD set all fields in \field{parameter} and \field{o=
data}
> except field \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} before it checks \field{verify_result}.
> +\end{itemize*}
> +
> +\paragraph{Verification: RSA Verification Operation}\label{sec:Device Ty=
pes
> /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Verification: RSA Verification Operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_rsa_verify_para {
> +    le32 hash_algo;
> +    le32 padding_mode;
> +    struct virtio_crypto_rsa_pub_key pubkey;
> +
> +    le32 msg_len;
> +    le32 reserved;
> +
> +    struct virtio_crypto_rsa_pub_key_data pubkey_data;
> +};
> +
> +struct virtio_crypto_rsa_verify_output {
> +    u8 msg[msg_len];
> +};
> +\end{lstlisting}
> +
> +RSA verification operation request is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_rsa_verify_req {
> +    struct virtio_crypto_rsa_verify_para parameter;
> +    struct virtio_crypto_rsa_verify_output odata;
> +
> +    struct virtio_crypto_asym_verify_gen_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{RSA verification operation}{Device Types
> / Crypto Device / Device Operation / Asymmetric Crypto Service Operation =
/
> RSA verification operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata}.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{RSA verification operation}{Device Types
> / Crypto Device / Device Operation / Asymmetric Crypto Service Operation =
/
> RSA verification operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_VERIFY,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_RSA.
> +\item The driver SHOULD set all fields in \field{parameter} and \field{o=
data}
> except field \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} before it checks \field{verify_result}.
> +\end{itemize*}
> +
> +\paragraph{Encryption: RSA Encryption Operation}\label{sec:Device Types =
/
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Encryption: RSA Encryption Operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_rsa_enc_para {
> +    le32 padding_mode;
> +    struct virtio_crypto_rsa_pub_key pub_key;
> +    le32 msg_len;
> +
> +    struct virtio_crypto_rsa_pub_key_data pub_key_data;
> +};
> +
> +struct virtio_crypto_rsa_enc_output {
> +    u8 msg[msg_len];
> +};
> +
> +struct virtio_crypto_rsa_enc_input {
> +    le32 status;
> +    le32 reserved;
> +
> +    u8 cmsg[msg_len];
> +};
> +\end{lstlisting}
> +
> +RSA encryption operation request is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_rsa_enc_req {
> +    struct virtio_crypto_rsa_enc_para parameter;
> +    struct virtio_crypto_rsa_enc_output odata;
> +
> +    struct virtio_crypto_rsa_enc_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{RSA Encryption Operation}{Device Types
> / Crypto Device / Device Operation / Asymmetric Crypto Service Operation =
/
> RSA Encryption Operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{RSA Encryption Operation}{Device Types
> / Crypto Device / Device Operation / Asymmetric Crypto Service Operation =
/
> RSA Encryption Operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_ENCRYPT,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_RSA.
> +\item The driver SHOULD set all fields in \field{parameter} and \field{o=
data}
> except field \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} before it operates other fields in \field{idata}.
> +Only if the operation is successful, the \field{cmsg} in \field{idata} i=
s
> operatable.
> +\end{itemize*}
> +
> +\paragraph{Decryption: RSA Decryption Operation}\label{sec:Device Types
> /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Decryption: RSA Decryption Operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_rsa_dec_para {
> +    le32 padding_mode;
> +    struct virtio_crypto_rsa_priv_key priv_key;
> +    le32 cmsg_len;
> +
> +    struct virtio_crypto_rsa_priv_key_data priv_key_data;
> +};
> +
> +struct virtio_crypto_rsa_dec_output {
> +    u8 cmsg[cmsg_len];
> +}
> +
> +struct virtio_crypto_rsa_dec_input {
> +    le32 status;
> +    le32 reserved;
> +
> +    u8 msg[cmsg_len];
> +};
> +\end{lstlisting}
> +
> +RSA decryption operation request is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_rsa_dec_req {
> +    struct virtio_crypto_rsa_dec_para parameter;
> +    struct virtio_crypto_rsa_dec_output odata;
> +
> +    struct virtio_crypto_rsa_dec_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{RSA Decryption Operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / RSA Decryption Operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{RSA Decryption Operation}{Device Types
> / Crypto Device / Device Operation / Asymmetric Crypto Service Operation =
/
> RSA Decryption Operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_DECRYPT,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_RSA.
> +\item The driver SHOULD set all fields in \field{parameter} and \field{o=
data}
> except field \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} before it operates other fields in \field{idata}.
> +Only if the operation is successful, the \field{msg} in \field{idata} is
> operatable.
> +\end{itemize*}
> +
> +\paragraph{Key Generation: RSA Key Generation
> Operation}\label{sec:Device Types /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Key Generation: RSA Key Generation Operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_rsa_keygen_para {
> +    /* The modules length in bytes */
> +    le32 modulus_len;
> +    le32 rsa_prime_number;
> +    le32 priv_key_rep_type;
> +    le32 e_len;
> +
> +    /* the public exponent */
> +    u8 e[e_len];
> +};
> +
> +struct virtio_crypto_rsa_keygen_input {
> +    le32 status;
> +    le32 reserved;
> +
> +    struct virtio_crypto_rsa_priv_key priv_key;
> +    struct virtio_crypto_rsa_pub_key pub_key;
> +
> +    struct virtio_crypto_rsa_priv_key_data priv_key_data;
> +    struct virtio_crypto_rsa_pub_key_data pub_key_data;
> +};
> +\end{lstlisting}
> +
> +RSA key-generation operation request is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_rsa_keygen_req {
> +    struct virtio_crypto_rsa_keygen_para parameter;
> +
> +    struct virtio_crypto_rsa_keygen_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{RSA Key Generation Operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / RSA Key Generation Operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{RSA Key Generation Operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / RSA Key Generation Operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_KEY_GEN,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_RSA.
> +\item The driver SHOULD set all fields in \field{parameter} except
> \field{reserved} field.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} before it operates other fields in \field{idata}.
> +Only if the operation is successful, the \field{priv_key} and \field{pub=
_key}
> in \field{idata} are operatable.
> +\end{itemize*}
> +
> +\paragraph{Key Generation: DSA Key Generation
> operation}\label{sec:Device Types /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Key Generation: DSA Key Generation operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_dsa_keygen_para {
> +    le32 modulus_len;
> +    le32 reserved;
> +};
> +
> +struct virtio_crypto_dsa_keygen_input {
> +    le32 status;
> +    le32 reserved;
> +
> +    /* DSA Group parameters */
> +    struct virtio_crypto_dsa_group dsa;
> +    /* length of private key */
> +    le32 x_len;
> +    /* length of public key */
> +    le32 y_len;
> +
> +    struct virtio_crypto_dsa_group_data dsa_data;
> +    /* Private key */
> +    u8 x[x_len];
> +    /* Public key */
> +    u8 y[y_len];
> +};
> +\end{lstlisting}
> +
> +DSA key-generation operation request is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_dsa_keygen_req {
> +    struct virtio_crypto_dsa_keygen_para parameter;
> +
> +    struct virtio_crypto_dsa_keygen_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{DSA Key Generation Operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / DSA Key Generation Operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{DSA Key Generation Operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / DSA Key Generation Operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_KEY_GEN,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_DSA.
> +\item The driver SHOULD set all fields in \field{parameter} except
> \field{reserved} field.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} before it operates other fields in \field{idata}.
> +Only if the operation is successful, the \field{priv_key} and \field{pub=
_key}
> in \field{idata} are operatable.
> +\end{itemize*}
> +
> +\paragraph{Key Generation: EC Key Generation
> operation}\label{sec:Device Types /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Key Generation: EC Key Generation operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_ec_keygen_para {
> +    /* EC field_type, see VIRTIO_CRYPTO_EC_FIELD_TYPE_* definition */
> +    le32 field_type;
> +    le32 reserved;
> +
> +    struct virtio_crypto_ec_group ec;
> +
> +    /* length of private key */
> +    le32 d_len;
> +    /* length of public key */
> +    le32 x_len;
> +    le32 y_len;
> +
> +    /* EC group parameters */
> +    struct virtio_crypto_ec_group_data ec_data;
> +};
> +
> +struct virtio_crypto_ec_keygen_input {
> +    le32 status;
> +    le32 reserved;
> +
> +    /* Private key */
> +    u8 d[d_len];
> +
> +    /* Public key */
> +    u8 x[x_len];
> +    u8 y[y_len];
> +};
> +\end{lstlisting}
> +
> +EC key-generation operation request is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_ec_keygen_req {
> +    struct virtio_crypto_ec_keygen_para parameter;
> +
> +    struct virtio_crypto_ec_keygen_input key;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{EC Key Generation Operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / EC Key Generation Operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{EC Key Generation Operation}{Device
> Types / Crypto Device / Device Operation / Asymmetric Crypto Service
> Operation / EC Key Generation Operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_KEY_GEN,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_ECDH or
> VIRTIO_CRYPTO_ASYM_ECDSA.
> +\item The driver SHOULD set all fields in \field{parameter} except
> \field{reserved} field.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} before it operates other fields in \field{idata}.
> +Only if the operation is successful, the other fields in \field{idata} a=
re
> operatable.
> +\end{itemize*}
> +
> +\paragraph{Key Exchange: Common Structure}\label{sec:Device Types /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Key Exchange: Common Structure}
> +
> +Key Exchange request has two kinds of operations in general, key
> generation and key computation.
> +For DH, it has additional operation: parameter generation operation.
> +
> +\paragraph{Key Exchange: DH Parameter Generation
> Operation}\label{sec:Device Types /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Key Exchange: DH Parameter Generation Operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_dh_parameter {
> +    le32 modules_len;
> +    le32 reserved;
> +
> +    /* length of random odd prime number */
> +    le32 p_len;
> +    /* length of base (g) */
> +    le32 g_len;
> +
> +    /* random odd prime number */
> +    u8 p[p_len];
> +    /* base (g) */
> +    u8 g[g_len];
> +};
> +
> +#define VIRTIO_CRYPTO_KEY_EXCHANGE_GEN_KEY 0
> +#define VIRTIO_CRYPTO_KEY_EXCHANGE_COMPUTE_KEY 1
> +/* It's only valid in case DH algorithm*/
> +#define VIRTIO_CRYPTO_KEY_EXCHANGE_GEN_DH_PARAM 2
> +
> +struct virtio_crypto_dh_keyexchg_para {
> +    /*
> +    * The sub-operation in key exchange,
> +    * see VIRTIO_CRYPTO_KEY_EXCHANGE_ definition
> +    */
> +    le32 keyexchg_op;
> +    le32 reserved;
> +
> +    struct virtio_crypto_dh_parameter dh_param;
> +};
> +
> +struct virtio_crypto_dh_keyexchg_param_gen_input {
> +    le32 status;
> +    le32 reserved;
> +};
> +\end{lstlisting}
> +
> +DH Parameter Generation Operation in Key-Exchange is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_dh_keyexchg_param_gen_req {
> +    struct virtio_crypto_dh_keyexchg_para parameter;
> +
> +    struct virtio_crypto_dh_keyexchg_param_gen_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{Key Exchange: DH Parameter
> Generation Operation}{Device Types / Crypto Device / Device Operation /
> +Asymmetric Crypto Service Operation / Key Exchange: DH Parameter
> Generation Operation}
> +\begin{itemize*}
> +\item The device SHOULD set the operation result in \field{idata}, and s=
et
> \field{p} and \field{g} in \field{dh_param}.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{Key Exchange: DH Parameter Generation
> Operation}{Device Types / Crypto Device / Device Operation /
> +Asymmetric Crypto Service Operation / Key Exchange: DH Parameter
> Generation Operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_KEY_EXCHG,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_DH.
> +\item The driver MUST set the \field{keyexchg_op} to
> VIRTIO_CRYPTO_KEY_EXCHANGE_GEN_DH_PARAM in \field{parameter}.
> +\item The driver SHOULD set \field{modules_len} in \field{dh_param}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} firstly.
> +Only if the operation is successful, the other fields in \field{idata} a=
re
> operatable.
> +\end{itemize*}
> +
> +\paragraph{Key Exchange: DH Key Generation Operation}\label{sec:Device
> Types /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Key Exchange: DH Key Generation Operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_dh_keyexchg_keygen_input {
> +    le32 status;
> +    le32 reserved;
> +
> +    /* length of private key */
> +    le32 x_len;
> +    /* length of public key */
> +    le32 y_len;
> +
> +    /* private key */
> +    u8 x[x_len];
> +    /* public key */
> +    u8 y[y_len];
> +};
> +\end{lstlisting}
> +
> +DH Key Generation Operation in Key-Exchange is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_dh_keyexchg_key_gen_req {
> +    struct virtio_crypto_dh_keyexchg_para parameter;
> +
> +    struct virtio_crypto_dh_key_exchg_keygen_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{Key Exchange: DH Key Generation
> Operation}{Device Types / Crypto Device / Device Operation /
> +Asymmetric Crypto Service Operation / Key Exchange: DH Key Generation
> Operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{Key Exchange: DH Key Generation
> Operation}{Device Types / Crypto Device / Device Operation /
> +Asymmetric Crypto Service Operation / Key Exchange: DH Key Generation
> Operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_KEY_EXCHG,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_DH.
> +\item The driver MUST set the \field{keyexchg_op} to
> VIRTIO_CRYPTO_KEY_EXCHANGE_GEN_KEY in \field{parameter}.
> +\item The driver SHOULD set all other fields in \field{parameter} except
> field \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} firstly.
> +Only if the operation is successful, the other fields in \field{idata} a=
re
> operatable.
> +\end{itemize*}
> +
> +\paragraph{Key Exchange: DH Key Computation
> Operation}\label{sec:Device Types /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Key Exchange: DH Key Computation Operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_dh_keyexchg_compute_key_output {
> +    /* length of local private key */
> +    le32 x_len;
> +    /* length of peer's public key */
> +    le32 y_len;
> +
> +    le32 shared_secret_len;
> +    le32 reserved;
> +
> +    /* local private key */
> +    u8 x[x_len];
> +    /* peer's public key */
> +    u8 y[y_len];
> +};
> +
> +struct virtio_crypto_dh_keyexchg_compute_key_input {
> +    le32 status;
> +    le32 reserved;
> +
> +    u8 shared_secret[shared_secret_len];
> +};
> +\end{lstlisting}
> +
> +DH Key Computation Operation in Key-Exchange is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_dh_keyexchg_key_compute_req {
> +    struct virtio_crypto_dh_keyexchg_para parameter;
> +    struct virtio_crypto_dh_keyexchg_compute_key_output odata;
> +
> +    struct virtio_crypto_dh_keyexchg_compute_key_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{Key Exchange: DH Key Computation
> Operation}{Device Types / Crypto Device / Device Operation /
> +Asymmetric Crypto Service Operation / Key Exchange: DH Key Computation
> Operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{Key Exchange: DH Key Computation
> Operation}{Device Types / Crypto Device / Device Operation /
> +Asymmetric Crypto Service Operation / Key Exchange: DH Key Computation
> Operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_KEY_EXCHG,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_DH.
> +\item The driver MUST set the \field{keyexchg_op} to
> VIRTIO_CRYPTO_KEY_EXCHANGE_COMPUTE_KEY in \field{parameter}.
> +\item The driver SHOULD set all other fields in \field{parameter} except
> field \field{reserved}.
> +\item The driver SHOULD set all fields in \field{odata} except field
> \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} firstly.
> +Only if the operation is successful, the other fields in \field{idata} a=
re
> operatable.
> +\end{itemize*}
> +
> +\paragraph{Key Exchange: ECDH Key Generation
> Operation}\label{sec:Device Types /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Key Exchange: ECDH Key Generation Operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_ecdh_keyexchg_keygen_para {
> +    /*
> +    * The sub-operation in key exchange,
> +    * see VIRTIO_CRYPTO_KEY_EXCHANGE_ definition
> +    */
> +    le32 keyexchg_op;
> +    le32 reserved;
> +
> +    struct virtio_crypto_ec_keygen_para parameter;
> +};
> +\end{lstlisting}
> +
> +ECDH Key Generation Operation in Key-Exchange is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_ecdh_keyexchg_key_gen_req {
> +    struct virtio_crypto_ecdh_keyexchg_keygen_para parameter;
> +
> +    struct virtio_crypto_ec_keygen_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{Key Exchange: ECDH Key Generation
> Operation}{Device Types / Crypto Device / Device Operation /
> +Asymmetric Crypto Service Operation / Key Exchange: ECDH Key
> Generation Operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{Key Exchange: ECDH Key Generation
> Operation}{Device Types / Crypto Device / Device Operation /
> +Asymmetric Crypto Service Operation / Key Exchange: ECDH Key
> Generation Operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_KEY_EXCHG,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_ECDH.
> +\item The driver MUST set the \field{keyexchg_op} to
> VIRTIO_CRYPTO_KEY_EXCHANGE_GEN_KEY in \field{parameter}.
> +\item The driver SHOULD set all other fields in \field{parameter} except
> field \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} firstly.
> +Only if the operation is successful, the other fields in \field{idata} a=
re
> operatable.
> +\end{itemize*}
> +
> +\paragraph{Key Exchange: ECDH Key Computation
> Operation}\label{sec:Device Types /
> +Crypto Device / Device Operation / Crypto operation / Asymmetric Crypto
> Service Operation / Key Exchange: ECDH Key Computation Operation}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_ecdh_keyexchg_compute_key_para {
> +    /*
> +    * The sub-operation in key exchange,
> +    * see VIRTIO_CRYPTO_KEY_EXCHANGE_ definition
> +    */
> +    le32 keyexchg_op;
> +    le32 reserved;
> +
> +    /* length of local private key */
> +    le32 d_len;
> +    /* length of peer's public key */
> +    le32 x_len;
> +    le32 y_len;
> +    /* length of shared_secret */
> +    le32 shared_secret_len;
> +
> +    struct virtio_crypto_ec_keygen_para parameter;
> +};
> +
> +struct virtio_crypto_ecdh_keyexchg_compute_key_output {
> +    /* local private key */
> +    u8 d[d_len];
> +
> +    /* peer's public key */
> +    u8 x[x_len];
> +    u8 y[y_len];
> +};
> +
> +struct virtio_crypto_ecdh_keyexchg_compute_key_input {
> +    le32 status;
> +    le32 reserved;
> +
> +    u8 shared_secret[shared_secret_len];
> +};
> +\end{lstlisting}
> +
> +ECDH Key Computation Operation in Key-Exchange is defined as below:
> +\begin{lstlisting}
> +struct virtio_crypto_ecdh_keyexchg_key_compute_req {
> +    struct virtio_crypto_ecdh_keyexchg_compute_key_para parameter;
> +    struct virtio_crypto_ecdh_keyexchg_compute_key_output odata;
> +
> +    struct virtio_crypto_ecdh_keyexchg_compute_key_input idata;
> +};
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{Key Exchange: ECDH Key Computation
> Operation}{Device Types / Crypto Device / Device Operation /
> +Asymmetric Crypto Service Operation / Key Exchange: ECDH Key
> Computation Operation}
> +\begin{itemize*}
> +\item The device MUST set the operation results in \field{idata} accordi=
ng
> to the general device requirments for asymmetric crypto service.
> +\end{itemize*}
> +
> +\drivernormative{\subparagraph}{Key Exchange: ECDH Key Computation
> Operation}{Device Types / Crypto Device / Device Operation /
> +Asymmetric Crypto Service Operation / Key Exchange: ECDH Key
> Computation Operation}
> +\begin{itemize*}
> +\item The driver MUST set the \field{opcode} in
> \field{virtio_crypto_op_header} to VIRTIO_CRYPTO_ASYM_KEY_EXCHG,
> +set \field{algo} to VIRTIO_CRYPTO_ASYM_ECDH.
> +\item The driver MUST set the \field{keyexchg_op} to
> VIRTIO_CRYPTO_KEY_EXCHANGE_GEN_KEY in \field{parameter}.
> +\item The driver SHOULD set all other fields in \field{parameter} except
> field \field{reserved}.
> +\item The driver MUST check the operation result \field{status} in
> \field{idata} firstly.
> +Only if the operation is successful, the other fields in \field{idata} a=
re
> operatable.
> +\end{itemize*}
> --
> 1.9.3
