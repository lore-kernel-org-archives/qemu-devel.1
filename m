Received: from eggs.gnu.org ([2001:4830:134:3::10]:55163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMXSW-0000Gv-Tv
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMXSR-00034h-5Z
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:01:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eMXSQ-00033q-Tl
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:01:43 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6AxC15100256
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 06:01:40 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epdy14bc0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 06:01:39 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 11:01:35 -0000
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
	<1512545840-10256-2-git-send-email-longpeng2@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 6 Dec 2017 12:01:27 +0100
MIME-Version: 1.0
In-Reply-To: <1512545840-10256-2-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
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
Cc: luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com



On 12/06/2017 08:37 AM, Longpeng(Mike) wrote:
> +\field{outcome_len} is the size of struct virtio_crypto_session_input or
> +ZERO for the session-destroy operation.

This ain't correct. It should have been something like virtio_crypto_destroy_session_input.

> +
> +
> +\paragraph{Session operation}\label{sec:Device Types / Crypto Device / Device
> +Operation / Control Virtqueue / Session operation}
> +
> +The session is a handle which describes the cryptographic parameters to be
> +applied to a number of buffers.
> +
> +The following structure stores the result of session creation set by the device:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_session_input {
> +    /* Device write only portion */
> +    le64 session_id;
> +    le32 status;
> +    le32 padding;
> +};
> +\end{lstlisting}
> +
> +A request to destroy a session includes the following information:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_destroy_session_flf {
> +    /* Device read only portion */
> +    le64  session_id;
> +    /* Device write only portion */

This is the device writable portion and thus what we cal op_outcome above.
So it should have been
};


struct virtio_crypto_destroy_session_input {
> +    le32  status;
> +    le32  padding;
> +};

If we aren't consistent about it the dividing into parts (like op specific
fixed and variable length (output) fields, operation outcome (input))
isn't really helpful.


Regards,
Halil
> +\end{lstlisting}
