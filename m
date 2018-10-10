Received: from eggs.gnu.org ([2001:4830:134:3::10]:51643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gADw9-0000zb-IZ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gADw4-0006sc-6t
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:50:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gADw3-0006rm-Rc
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:49:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ACinV9087994
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 08:49:54 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1eqxyntv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 08:49:54 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 10 Oct 2018 13:49:51 +0100
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
	<b5b11801-256d-dc7b-2a16-ad4b25d9681b@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 10 Oct 2018 14:49:41 +0200
MIME-Version: 1.0
In-Reply-To: <b5b11801-256d-dc7b-2a16-ad4b25d9681b@linux.ibm.com>
Content-Language: en-US
Message-Id: <386c2fbc-e859-ef60-5aa8-9c7821355369@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 5/6] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com



On 10/10/2018 02:37 PM, Pierre Morel wrote:
> On 09/10/2018 19:52, Tony Krowiak wrote:

>> +static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **err=
p)
>> +{
>> +=C2=A0=C2=A0=C2=A0 GError *gerror;
>> +=C2=A0=C2=A0=C2=A0 char *symlink, *group_path;
>> +=C2=A0=C2=A0=C2=A0 int groupid;
>> +
>> +=C2=A0=C2=A0=C2=A0 symlink =3D g_strdup_printf("%s/iommu_group", vapd=
ev->vdev.sysfsdev);
>> +=C2=A0=C2=A0=C2=A0 group_path =3D g_file_read_link(symlink, &gerror);
>=20
>=20
> hum I oversaw this change, it leads to segfault.

Yes, this was a review feedback from v9 to use the glib function.
>=20
> You must initialize gerror before use.
> The following patch avoid a segmentation fault:
>=20
>=20
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 5543406afc..3b8e9ba6dc 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -59,7 +59,7 @@ static void vfio_ap_put_device(VFIOAPDevice *vapdev)
>=20
> =C2=A0static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error *=
*errp)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 GError *gerror;
> +=C2=A0=C2=A0=C2=A0 GError *gerror =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0 char *symlink, *group_path;
> =C2=A0=C2=A0=C2=A0=C2=A0 int groupid;

With that fix, series
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

Tony, can you fold that fixup from Pierre into your v11?
