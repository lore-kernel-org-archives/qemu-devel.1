Received: from eggs.gnu.org ([2001:4830:134:3::10]:48463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ewpK8-0005Sh-4y
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ewpK4-0002Dl-Ub
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:23:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ewpK4-0002CK-Lz
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:23:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GDMGDD028514
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 09:23:02 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2grbty7cdp-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 09:23:02 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 13:22:59 -0000
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4deae7b2-ae8a-f5a9-7979-0dcd20894729@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 14:22:52 +0100
MIME-Version: 1.0
In-Reply-To: <4deae7b2-ae8a-f5a9-7979-0dcd20894729@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <d0443435-a2d2-e256-3663-4e591f0e48bf@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/7] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net



On 03/16/2018 11:42 AM, Pierre Morel wrote:
> On 16/03/2018 00:24, Tony Krowiak wrote:
>> Introduces a VFIO based AP device. The device is defined via
>> the QEMU command line by specifying:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 -device vfio-ap,sysfsdev=3D<path-to-mediated-=
matrix-device>
>>
>> The mediated matrix device is created by the VFIO AP device
>> driver by writing a UUID to a sysfs attribute file (see
>> docs/vfio-ap.txt). The mediated matrix device will be named
>> after the UUID. Symbolic links to the $uuid are created in
>> many places, so the path to the mediated matrix device $uuid
>> can be specified in any of the following ways:
>>
>> /sys/devices/vfio_ap/matrix/$uuid
>> /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/d=
evices/$uuid
>> /sys/bus/mdev/devices/$uuid
>> /sys/bus/mdev/drivers/vfio_mdev/$uuid
>>
>> When the vfio-ap device is realized, it acquires and opens the
>> VFIO iommu group to which the mediated matrix device is
>> bound. This causes a VFIO group notification event to be
>> signaled. The vfio_ap device driver's group notification
>> handler will get called at which time the device driver
>> will configure the the AP devices to which the guest will
>> be granted access.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
[..]
>> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 VFIODevice *vbasedev;
>> +=C2=A0=C2=A0=C2=A0 VFIOGroup *vfio_group;
>> +=C2=A0=C2=A0=C2=A0 APDevice *apdev =3D DO_UPCAST(APDevice, parent_obj=
, dev);
>> +=C2=A0=C2=A0=C2=A0 VFIOAPDevice *vapdev =3D DO_UPCAST(VFIOAPDevice, a=
pdev, apdev);
>> +=C2=A0=C2=A0=C2=A0 char *mdevid;
>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!s390_has_feat(S390_FEAT_AP)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&local_err, "AP=
 support not enabled");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_err;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D kvm_s390_set_interpret_ap(1);
>=20
> If we have several devices, this is called once per device.

I don't think having several of these in a single vm makes
any sense. Or does it? IMHO we should make sure there is at
most one device taking care of the crypto pass-through.

> However it is a general switch for the VM.
> It looks strange to have this inside the realize callback
>=20

I kind of semi agree.

The previous solution (having this transparent for QEMU) had
benefits. Why did we move away from that again?

Regards,
Halil
