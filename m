Received: from eggs.gnu.org ([2001:4830:134:3::10]:40710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gRLD2-000770-Ti
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gRLCx-0004hQ-39
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:02:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28901
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gRLCw-0004gp-Sx
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:02:07 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAQHxPcD072817
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 13:02:03 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p0nc010p9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 13:02:02 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Mon, 26 Nov 2018 18:02:00 -0000
Reply-To: pmorel@linux.ibm.com
References: <20181122165457.4517-1-cohuck@redhat.com>
	<20181122165457.4517-3-cohuck@redhat.com>
	<8fbbe0b6-6924-ad61-1d94-26517765f346@linux.ibm.com>
	<20181126105843.2efa2d06.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 26 Nov 2018 19:01:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181126105843.2efa2d06.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <0a15ec08-5902-b6fa-f00d-883c0905c56b@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] vfio-ccw: support async command
 subregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On 26/11/2018 10:58, Cornelia Huck wrote:
> On Fri, 23 Nov 2018 15:13:12 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> On 22/11/2018 17:54, Cornelia Huck wrote:
>>> A vfio-ccw device may provide an async command subregion for
>>> issuing halt/clear subchannel requests. If it is present, use
>>> it for sending halt/clear request to the device; if not, fall
>>> back to emulation (as done today).
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    hw/s390x/css.c              |  27 +++++++--
>>>    hw/vfio/ccw.c               | 109 ++++++++++++++++++++++++++++++++=
+++-
>>>    include/hw/s390x/s390-ccw.h |   3 +
>>>    3 files changed, 133 insertions(+), 6 deletions(-)
>>>
>=20
>>> @@ -114,6 +120,87 @@ again:
>>>        }
>>>    }
>>>   =20
>>> +int vfio_ccw_handle_clear(SubchDev *sch)
>>> +{
>>> +    S390CCWDevice *cdev =3D sch->driver_data;
>>> +    VFIOCCWDevice *vcdev =3D DO_UPCAST(VFIOCCWDevice, cdev, cdev);
>>> +    struct ccw_cmd_region *region =3D vcdev->async_cmd_region;
>>> +    int ret;
>>> +
>>> +    if (!vcdev->async_cmd_region) {
>>> +        /* Async command region not available, fall back to emulatio=
n */
>>> +        return -ENOSYS;
>>> +    }
>>> +
>>> +    memset(region, 0, sizeof(*region));
>>> +    region->command =3D VFIO_CCW_ASYNC_CMD_CSCH;
>>> +
>>> +again:
>>> +    ret =3D pwrite(vcdev->vdev.fd, region,
>>> +                 vcdev->async_cmd_region_size, vcdev->async_cmd_regi=
on_offset);
>>> +    if (ret !=3D vcdev->async_cmd_region_size) {
>>> +        if (errno =3D=3D EAGAIN) {
>>
>>
>> Where do the EAGAIN come from?
>=20
> It might be set by pwrite.

I saw that the man indicate this, and so we are legitimate to handle the=20
fail case, but I did not find EAGAIN in the path of the write for=20
accessing devices and I did not find it in the access to the CSS.

If we do not set it explicitly from the driver, the concern I have is:=20
isn't it dangerous to try again and shouldn't we better abort?


>=20
>>
>>
>>> +            goto again;
>>> +        }
>>> +        error_report("vfio-ccw: wirte I/O region failed with errno=3D=
%d", errno);
>=20
> I should also fix up this message here and for hsch as well :)
>=20
>>> +        ret =3D -errno;
>>> +    } else {
>>> +        ret =3D region->ret_code;
>>> +    }
>>> +    switch (ret) {
>>> +    case 0:
>>> +    case -ENODEV:
>>> +    case -EACCES:
>>
>> should never happen?
>=20
> It should not happen; but it can nevertheless be returned, so...

I understand: nothing to clear :)


>=20
>>
>>> +        return 0;
>>> +    case -EFAULT:
>>> +    default:
>>> +        sch_gen_unit_exception(sch);
>>> +        css_inject_io_interrupt(sch);
>>> +        return 0;
>>> +    }
>>> +}
>>> +
>>
>> otherwise LGTM
>=20
> Thanks!
>=20






--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
