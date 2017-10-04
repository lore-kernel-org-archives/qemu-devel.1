Received: from eggs.gnu.org ([2001:4830:134:3::10]:58762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dzlS8-0003CC-5y
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dzlRy-00038U-Aq
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:19:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1dzlRx-000359-NA
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:19:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94FIGQ9049764
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 11:19:01 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dd1rchnkw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:19:01 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 16:18:58 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v94FIvgd8388714
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 15:18:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5730052041
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 15:13:36 +0100 (BST)
Received: from [9.145.179.43] (unknown [9.145.179.43])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3BDBF5203F
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 15:13:36 +0100 (BST)
References: <1507125199-22562-1-git-send-email-thuth@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 4 Oct 2017 17:18:57 +0200
MIME-Version: 1.0
In-Reply-To: <1507125199-22562-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b3bebf28-76e6-5a4c-3a4c-34b940f85fb9@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/sclp: Mark the sclp device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 04/10/2017 15:53, Thomas Huth wrote:
> The "sclp" device is just an internal device that can not be instantiat=
ed
> by the users. If they try to use it, they only get a simple error messa=
ge:
>=20
> $ qemu-system-s390x -nographic -device sclp
> qemu-system-s390x: Option '-device s390-sclp-event-facility' cannot be
> handled by this machine
>=20
> Since sclp_init() tries to create a TYPE_SCLP_EVENT_FACILITY which is
> a non-pluggable sysbus device, there is really no way that the "sclp"
> device can be used by the user, so let's set the user_creatable =3D fal=
se
> accordingly.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/sclp.c | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 30aefbf..9be0cb8 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -606,6 +606,11 @@ static void sclp_class_init(ObjectClass *oc, void =
*data)
>       dc->realize =3D sclp_realize;
>       dc->hotpluggable =3D false;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    /*
> +     * Reason: Creates TYPE_SCLP_EVENT_FACILITY in sclp_init
> +     * which is a non-pluggable sysbus device
> +     */
> +    dc->user_creatable =3D false;
>=20
>       sc->read_SCP_info =3D read_SCP_info;
>       sc->read_storage_element0_info =3D read_storage_element0_info;
>=20

I must miss something.
Why is the sclp device not a SYS_BUS_DEVICE ?
The problem seems to come from the heterogeneity of the sclp and sclp=20
generated devices.

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
