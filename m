Received: from eggs.gnu.org ([2001:4830:134:3::10]:40593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAeUV-00008X-2B
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAeUR-0008Qd-3f
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:34:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dAeUQ-0008QD-RN
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:34:23 -0400
Date: Tue, 16 May 2017 16:33:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516153348.GR8498@stefanha-x1.localdomain>
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kuk/n493crKO4rgR"
Content-Disposition: inline
In-Reply-To: <1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v18 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, wu.wubin@huawei.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, linqiangmin@huawei.com, zhbzg@huawei.com, eety.chen@huawei.com, amy.zhanghuimin@huawei.com, lixiao91@huawei.com


--Kuk/n493crKO4rgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 22, 2017 at 02:23:50PM +0800, Gonglei wrote:
> +Dataq requests for both session and stateless modes are as follows:
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
> +        struct virtio_crypto_sym_data_req_stateless   sym_stateless_req;
> +        struct virtio_crypto_hash_data_req_stateless  hash_stateless_req;
> +        struct virtio_crypto_mac_data_req_stateless   mac_stateless_req;
> +        struct virtio_crypto_aead_data_req_stateless  aead_stateless_req;
> +    } u;
> +};
> +\end{lstlisting}

Halil touched on this in the discussion: this spec uses a C-like struct
syntax but does not define whether unions really affect sizeof(mystruct)
like they would in C or whether you just mean that any of the union
fields can be used.  This distinction is important so device and driver
authors understand the exact memory layout of requests and responses.

Please include an explanation about the meaning of "union" in the text.

> +Session mode MAC service requests are as follows:
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
> +Each data request uses virtio_crypto_mac_data_req structure to store information

"Each request uses the virtio_crypto_mac_data_req structure to store
information"

> +Session mode requests of symmetric algorithm are as follows:
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
> +Each data request uses virtio_crypto_sym_data_req structure to store information

s/virtio_crypto_sym_data_req structure/the virtio_crypto_sym_data_req structure/

--Kuk/n493crKO4rgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGxvcAAoJEJykq7OBq3PIoE4H/3pQHeHGM/lMDPkV8mgbkCpq
AjmLuXmzQ/TA6RDhM7QHnmMHXi1aT3zXhBOS+Xtx87mq2vtBa6TjepU34Ft5Oj7r
1C49GMNfew0AydI1iiQfbzQCftpLCmyOgMHa2Tbs4XW0zCOM6svIqqCH1PF1VTsH
an8of+2qsNV//KjlkRbyLf6H91Itc4Khhw57FUQsii4+uYk1dXofFOHRVPXXgA9O
3dQJkWtlhyjseY+wav+ExhnxqZU3oCjS3HRMLz01ickF78pP+kiqZ09mpjsYXIWN
NKn6k24XGfgungVl/lPuJcCtB34G3IKJgkH1vLBKjHD4ihYd7ehYU1tKChagWFI=
=g4Ug
-----END PGP SIGNATURE-----

--Kuk/n493crKO4rgR--
