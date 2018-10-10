Received: from eggs.gnu.org ([2001:4830:134:3::10]:56992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gA8w3-0006Ow-Qc
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gA8vv-0005Gx-Vm
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:29:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gA8vs-000555-LP
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:29:26 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9A7OK7Y017002
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 03:29:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1b134tk2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 03:29:20 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 10 Oct 2018 08:29:17 +0100
Reply-To: pmorel@linux.ibm.com
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
	<cd6e06e4-0549-3c1a-96e4-2b2354b9866d@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 10 Oct 2018 09:29:10 +0200
MIME-Version: 1.0
In-Reply-To: <cd6e06e4-0549-3c1a-96e4-2b2354b9866d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <703ea817-fea6-f443-0bed-b6e5465ec5b2@linux.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, fiuczy@linux.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

On 09/10/2018 21:51, David Hildenbrand wrote:
>=20
>> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
>> +{
>> +    int ret;
>> +    char *mdevid;
>> +    Error *local_err =3D NULL;
>> +    VFIOGroup *vfio_group;
>> +    APDevice *apdev =3D AP_DEVICE(dev);
>> +    VFIOAPDevice *vapdev =3D VFIO_AP_DEVICE(apdev);
>> +
>> +    vfio_group =3D vfio_ap_get_group(vapdev, &local_err);
>> +    if (!vfio_group) {
>> +        goto out_err;
>> +    }
>> +
>> +    vapdev->vdev.ops =3D &vfio_ap_ops;
>> +    vapdev->vdev.type =3D VFIO_DEVICE_TYPE_AP;
>> +    mdevid =3D basename(vapdev->vdev.sysfsdev);
>> +    vapdev->vdev.name =3D g_strdup_printf("%s", mdevid);
>> +    vapdev->vdev.dev =3D dev;
>> +
>> +    ret =3D vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local=
_err);
>> +    if (ret) {
>> +        goto out_get_dev_err;
>> +    }
>> +
>> +    /* Enable hardware to intepret AP instructions executed on the gu=
est */
>> +    object_property_set_bool(OBJECT(qdev_get_machine()), true, "apie"=
, NULL);
>> +
>=20
> I commented on the old version that this is wrong (if I am not starting
> to lose my memory). This has to go. (there is no such property, this
> will simply report an error we ignore)
>=20
> (can most probably be fixed when applying)
>=20

+1
absolutely no problem to remove this line.
I also tested without this line.

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
