Received: from eggs.gnu.org ([2001:4830:134:3::10]:60644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cLLBp-0000mE-8E
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 21:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cLLBl-000428-FY
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 21:39:05 -0500
Received: from [45.249.212.187] (port=2501 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cLLBi-0003zM-R3
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 21:39:01 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 26 Dec 2016 02:38:29 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA16E01B@DGGEMA505-MBX.china.huawei.com>
References: <1478856187-284644-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1478856187-284644-1-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v14 0/2] virtio-crypto: virtio crypto
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
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, Claudio Fontana <Claudio.Fontana@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, Shiqing Fan <Shiqing.Fan@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, longpeng <longpeng2@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>

Hi all,

 Merry Christmas and Happy new year. :)

Both Alex and Stefan mentioned that the process of create/close a session
makes we have a least one full round-trip cost from guest to host to guest
to be able to send any data for symmetric algorithms. It gets ourself into
synchronization troubles in some scenarios like a web server handling lots
of small requests whose algorithms and keys are different.

Because the virtio crypto specification has not been voted yet and v15 is o=
n the way.
I'd like to make some changes in order to support those scenarios better. T=
hat means
we will support one-blob request (no sessions) as well for symmetric
algorithms, including HASH, MAC services. The benefit is obvious for
HASH service because it's usually a one-blob operation.

The main changes will be:
 1) using the flag property of struct virtio_crypto_op_header to identify t=
he
    type of crypto request. Aka Is it a session-based or non-session reques=
t?
    The flag is not used currently, so we can make use of it.

 2) extending virtio_crypto_*_para structures, for example, add the content=
 of
    struct virtio_crypto_cipher_session_para into struct virtio_crypto_ciph=
er_para.
    It's true that will increase the size of each crypto request after this=
 change.

Does it make sense? Thanks!



Regards,
-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Friday, November 11, 2016 5:23 PM
> (Arei)
> Subject: [PATCH v14 0/2] virtio-crypto: virtio crypto device specificatio=
n
>=20
> Hi,
>=20
> Changes since v13:
>  - drop the all GPA stuff in the spec. [Cornelia]
>  - drop all structures undefined in virtio_crypto.h. [Halil]
>  - re-describe per request for per crypto service avoid confusion.
>  - fix typos here and there.           [Michael]
>  - drop descriptions about using indirect table. [Michael]
>  - make consistency check including nameing and layout notation. [Halil]
>  - use a byte array variable size holding all kind of data [Halil]
>  - other trivial fixes.
>=20
>=20
> This is the specification about a new virtio crypto device.
>=20
> You can get the source code from the QEMU master tree.
>=20
> For more information, please see:
>  http://qemu-project.org/Features/VirtioCrypto
>=20
> Please help to review, thanks.
>=20
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
> CC: Hanweidong <hanweidong@huawei.com>
> CC: Mihai Claudiu Caraman <mike.caraman@nxp.com>
>=20
> Changes since v12:
>  - add max_size field in the virtio-crypto device config in order
>    to tell the driver what's maximum size of crypto request the
>    device supports.     [Michael]
>  - add max_cipher_key_len and max_auth_key_len in the device config
>    too for the symmetric algorithms to limit resource utilization by
>    guest. [Thoughts come from Michael]
>=20
> Changes since v11:
>  - drop scatter-gather I/O definition for virtio crypto device because
>    The vring already provides scatter-gather I/O.  It is usually not
>    necessary to define scatter-gather I/O at the device level.      [Stef=
an]
>  - perfect algorithm chain parameters' definition.
>  - add HASH/MAC parameter structure.
>=20
> Changes since v10:
>  - fix typos s/filed/field/. [Xin]
>  - replace 'real cypto accelerator' with 'backend crypto accelerator'. [m=
st]
>  - drop KDF, ASYM, PRIMITIVE services description temporarily. [mst]
>  - write a device requirement are testable about
> VIRTIO_CRYPTO_S_HW_READY. [mst]
>  - add a space before * in one code comment. [mst]
>  - reset the layout of all crypto operations for better asymmetric algos =
support.
> [Xin]
>  - add more detailed description for initialization vector under differen=
t modes.
>  - sed -i 's/VIRTIO_CRYPTO_OP_/VIRTIO_CRYPTO_/g' for general usage in
> asym algos. [Xin]
>=20
> Changes since v9:
>  - request a native speaker go over the text and fix corresponding gramma=
r
> issues. [mst]
>  - make some description more appropriated over here and there. [mst]
>  - rewrite some requirement for both device and driver. [mst]
>  - use RFC 2119 keywords. [mst]
>  - fix some complaints by Xelatex and typoes. [Xin Zeng]
>  - add scatter/getter chain support for possible large block data.
>=20
> Thanks for your review, Michael and Xin.
>=20
> Changes from v8:
>  - add additional auth gpa and length to struct virtio_crypto_sym_data_re=
q;
>  - add definition of op in struct virtio_crypto_cipher_session_para,
>   VIRTIO_CRYPTO_OP_ENCRYPT and VIRTIO_CRYPTO_OP_DECRYPT;
>  - make all structures 64bit aligned in order to support different
>   architectures more conveniently [Alex & Stefan]
>  - change to devicenormative{\subsection} and \drivernormative{\subsectio=
n}
> in some sections [Stefan]
>  - driver does not have to initialize all data virtqueues if it wants to =
use fewer
> [Stefan]
>  - drop VIRTIO_CRYPTO_NO_SERVICE definition [Stefan]
>  - many grammatical problems and typos. [Stefan]
>  - rename VIRTIO_CRYPTO_MAC_CMAC_KASUMI_F9 to
> VIRTIO_CRYPTO_MAC_CMAC_KASUMI_F9,
>   and VIRTIO_CRYPTO_MAC_CMAC_SNOW3G_UIA2 to
> VIRTIO_CRYPTO_MAC_SNOW3G_UIA2. [Liang Ma]
>  - drop queue_id property of struct virtio_crypto_op_data_req.
>  - reconstruct some structures about session operation request.
>  - introduce struct virtio_crypto_alg_chain_session_req and struct
> virtio_crypto_alg_chain_data_req,
>   introduce chain para, output, input structures as well.
>  - change some sections' layout for better compatibility, for asymmetric =
algos.
> [Xin Zeng]
>=20
> Changes from v7:
>  - fix some grammar or typo problems.
>  - add more detailed description at steps of encryption section.
>=20
> Changes from v6:
>  - drop verion filed in struct virtio_crypto_config. [Michael & Cornelia]
>  - change the incorrect description in initialization routine. [Zeng Xin]
>  - redefine flag u16 to make structure alignment. [Zeng Xin]
>  - move the content of virtio_crypto_hash_session_para into
>    virtio_crypto_hash_session_input directly, Same to MAC/SYM/AEAD
> session creation. [Zeng Xin]
>  - adjuest the sequence of idata and odata refer to the virtio scsi parts=
,
>    meanwhile add the comments of device-readable/writable for them.
>  - add restrictive documents for the guest memory in some structure, whic=
h
>    MUST be gauranted to be allocated and physically-contiguous.
>=20
> Changes from v5:
>  - add conformance clauses for virtio crypto device. [Michael]
>  - drop VIRTIO_CRYPTO_S_STARTED. [Michael]
>  - fix some characters problems. [Stefan]
>  - add a MAC algorithm, named VIRTIO_CRYPTO_MAC_ZUC_EIA3. [Zeng Xin]
>  - add the fourth return code, named VIRTIO_CRYPTO_OP_INVSESS used
>    for invalid session id when executing crypto operations.
>  - drop some gpu stuff forgot to delete. [Michael]
>  - convert tab to space all over the content.
>=20
> Changes from v4:
>  - introduce crypto services into virtio crypto device. The services
>    currently defined are CIPHER, MAC, HASH, AEAD, KDF, ASYM, PRIMITIVE.
>  - define a unified crypto request format that is consisted of
>    general header + service specific request,  Where 'general header' is =
for
> all
>    crypto request,  'service specific request' is composed of
>    operation parameter + input data + output data in generally.
>    operation parameter is algorithm-specific parameters,
>    input data is the data should be operated ,
>    output data is the "operation result + result buffer".
>  - redefine the algorithms and structure based on above crypto services.
>  - rearrange the title and subtitle
>  - Only support CIPHER, MAC, HASH and AEAD crypto services, and Xin will
>    focus KDF, ASYM and PRIMITIVE services.
>  - Some other corresponding fixes.
>  - Make a formal patch using tex type.
>=20
> This version is a big reconstruction based on Zeng, Xin' comments, thanks=
 a lot.
>=20
> Changes from v3:
>  - Don't use enum is the spec but macros in specific structures. [Michael=
 &
> Stefan]
>  - Add two complete structures for session creation and closing, so that
>   the spec is clear on how to lay out the request.  [Stefan]
>  - Definite the crypto operation request with assigned structure, in this=
 way,
>   each data request only occupies *one entry* of the Vring descriptor tab=
le,
>   which *improves* the *throughput* of data transferring.
>=20
> Changes from v2:
>  - Reserve virtio device ID 20 for crypto device. [Cornelia]
>  - Drop all feature bits, those capabilities are offered by the device al=
l the time.
> [Stefan & Cornelia]
>  - Add a new section 1.4.2 for driver requirements. [Stefan]
>  - Use definite type definition instead of enum type in some structure. [=
Stefan]
>  - Add virtio_crypto_cipher_alg definition. [Stefan]
>  - Add a "Device requirements" section as using MUST. [Stefan]
>  - Some grammar nits fixes and typo fixes. [Stefan & Cornelia]
>  - Add one VIRTIO_CRYPTO_S_STARTED status for the driver as the flag of
> virtio-crypto device started and can work now.
>=20
> Great thanks for Stefan and Cornelia!
>=20
> Gonglei (2):
>   virtio-crypto: Add virtio crypto device specification
>   virtio-crypto: Add conformance clauses
>=20
>  conformance.tex   |  30 ++
>  content.tex       |   2 +
>  virtio-crypto.tex | 945
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 977 insertions(+)
>  create mode 100644 virtio-crypto.tex
>=20
> --
> 1.7.12.4
>=20
