Received: from eggs.gnu.org ([2001:4830:134:3::10]:50744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBlXD-00080F-ME
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBlX9-0003sl-I1
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:50:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41146
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBlX9-0003rw-Cr
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:50:03 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6HjsD6095135
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 12:49:57 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e2v808v07-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 12:49:56 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 10:49:56 -0700
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-43-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 12:49:49 -0500
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-43-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <25929999-f22e-f386-29d6-d250e34c54f5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 42/42] WIP: add TPM CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 10/09/2017 06:56 PM, Marc-Andr=C3=A9 Lureau wrote:
> +
> +#define CRB_INTF_TYPE_CRB_ACTIVE 0b1
> +#define CRB_INTF_VERSION_CRB 0b1
> +#define CRB_INTF_CAP_LOCALITY_0_ONLY 0b0
> +#define CRB_INTF_CAP_IDLE_FAST 0b0
> +#define CRB_INTF_CAP_XFER_SIZE_64 0b11
> +#define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
> +#define CRB_INTF_CAP_CRB_SUPPORTED 0b1
> +#define CRB_INTF_IF_SELECTOR_CRB 0b1
> +#define CRB_INTF_IF_SELECTOR_UNLOCKED 0b0
> +
> +#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - sizeof(struct crb_regs)=
)

So this here seems to declare the size of the buffer, which is a bit=20
less than 4k now. Theoretically this could cause problems with the TPM=20
on the backend side that may assume that there's a buffer of 4k=20
available on the interface side. So there can be a mismatch between=20
these buffersize if for example one usesCRB with passthrough and the=20
host has a TIS with a TPM with full 4k buffersize.

I went through the exercise of extending libtpms and swtpm with commands=20
to get and set the buffersize 'swtpm' is suppose to use.=20
TPM/TPM2_GetCapability() can be used by a user to read the buffer size=20
from the device and that now returns a possibly adjusted buffersize. I=20
also modified QEMU to read the buffer size from the backend and have it=20
configure the frontend's buffer to use the backend's buffer size. It is=20
currently hard coded to 4096 and correct for the TIS.

https://github.com/stefanberger/qemu-tpm/commits/tpm_backend_buffer_size

The problem may only be theoretical since I am not sure whether any=20
commands of TPM 2 (where it's relevant for CRB) would return a full 4k=20
buffer that the CRB wouldn't be able to pass on to the OS. We have the=20
possibility to match up the buffersizes now, though.

     Stefan
