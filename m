Received: from eggs.gnu.org ([2001:4830:134:3::10]:33952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQCCg-0002TO-Sf
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQCCd-0006dy-PZ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:13:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gQCCd-0006ag-Hs
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:13:03 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wANEAjPD078576
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 09:13:02 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nxjft9u2x-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 09:13:01 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 23 Nov 2018 14:12:59 -0000
Reply-To: pmorel@linux.ibm.com
References: <20181122165457.4517-1-cohuck@redhat.com>
	<20181122165457.4517-2-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 23 Nov 2018 15:12:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181122165457.4517-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <1cf1b1a1-9fde-e93f-020b-624b7fbf3fe2@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio-ccw: new capability chain support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On 22/11/2018 17:54, Cornelia Huck wrote:
> To be replaced with a real linux-headers update.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   linux-headers/linux/vfio.h     |  4 ++++
>   linux-headers/linux/vfio_ccw.h | 12 ++++++++++++
>   2 files changed, 16 insertions(+)
>=20
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index ceb6453394..c9ba8d52a0 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -297,12 +297,16 @@ struct vfio_region_info_cap_type {
>  =20
>   #define VFIO_REGION_TYPE_PCI_VENDOR_TYPE	(1 << 31)
>   #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
> +#define VFIO_REGION_TYPE_CCW			(1 << 30)
>  =20
>   /* 8086 Vendor sub-types */
>   #define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION	(1)
>   #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>   #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>  =20
> +/* ccw sub-types */
> +#define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
> +
>   /*
>    * The MSIX mappable capability informs that MSIX data of a BAR can b=
e mmapped
>    * which allows direct access to non-MSIX registers which happened to=
 be within
> diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_=
ccw.h
> index 5bf96c3812..fcc3e69ef5 100644
> --- a/linux-headers/linux/vfio_ccw.h
> +++ b/linux-headers/linux/vfio_ccw.h
> @@ -12,6 +12,7 @@
>  =20
>   #include <linux/types.h>
>  =20
> +/* used for START SUBCHANNEL, always present */
>   struct ccw_io_region {
>   #define ORB_AREA_SIZE 12
>   	__u8	orb_area[ORB_AREA_SIZE];
> @@ -22,4 +23,15 @@ struct ccw_io_region {
>   	__u32	ret_code;
>   } __attribute__((packed));
>  =20
> +/*
> + * used for processing commands that trigger asynchronous actions
> + * Note: this is controlled by a capability
> + */
> +#define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
> +#define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
> +struct ccw_cmd_region {
> +	__u32 command;
> +	__u32 ret_code;
> +} __attribute__((packed));
> +
>   #endif
>=20

LGTM

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
