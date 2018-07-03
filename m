Received: from eggs.gnu.org ([2001:4830:134:3::10]:47715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faO9U-0002bD-OX
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faO9Q-0001sk-QY
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:27:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1faO9Q-0001sJ-Ka
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:27:36 -0400
References: <86b43998-fc9e-75bf-564c-a64d72163793@huawei.com>
	<20180702131518.GF2155@stefanha-x1.localdomain>
	<c3e76f29-9259-f56d-6829-8abd6dd7da88@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <65ada9e4-0495-ce50-1404-3ee6b74d0607@redhat.com>
Date: Tue, 3 Jul 2018 18:27:31 +0200
MIME-Version: 1.0
In-Reply-To: <c3e76f29-9259-f56d-6829-8abd6dd7da88@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] question: disk missing in the guest contingently
 when hotplug several virtio scsi disks consecutively.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: l00284672 <lizhengui@huawei.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: famz@redhat.com, kwolf@redhat.com, "Fangyi (C)" <eric.fangyi@huawei.com>, qemu-devel@nongnu.org

On 03/07/2018 09:20, l00284672 wrote:
>=20
> }
>=20
> The scsi inqury request from guest is cancelled by qemu. The qemu bt is
> below:
>=20
> (gdb) bt
> #0=A0 scsi_req_cancel_async (req=3D0x7f86d00055c0, notifier=3D0x0) at
> hw/scsi/scsi-bus.c:1825
> #1=A0 0x000055b50ac254c7 in scsi_device_purge_requests
> (sdev=3Dsdev@entry=3D0x55b50f9a8990, sense=3D...) at hw/scsi/scsi-bus.c=
:1925
> #2=A0 0x000055b50ac1d337 in scsi_disk_reset (dev=3D0x55b50f9a8990) at
> hw/scsi/scsi-disk.c:2186
> #3=A0 0x000055b50ab95d91 in device_set_realized (obj=3D<optimized out>,
> value=3D<optimized out>, errp=3D0x7ffedda81898) at hw/core/qdev.c:949
> #4=A0 0x000055b50acd167e in property_set_bool (obj=3D0x55b50f9a8990,
> v=3D<optimized out>, name=3D<optimized out>, opaque=3D0x55b50f9c1b50,
> errp=3D0x7ffedda81898) at qom/object.c:1854
> #5=A0 0x000055b50acd5091 in object_property_set_qobject
> (obj=3Dobj@entry=3D0x55b50f9a8990, value=3Dvalue@entry=3D0x55b50f997350=
,
> name=3Dname@entry=3D0x55b50ae0260b "realized",
> =A0=A0=A0 errp=3Derrp@entry=3D0x7ffedda81898) at qom/qom-qobject.c:27
> #6=A0 0x000055b50acd3210 in object_property_set_bool (obj=3D0x55b50f9a8=
990,
> value=3D<optimized out>, name=3D0x55b50ae0260b "realized",
> errp=3D0x7ffedda81898) at qom/object.c:1157
> #7=A0 0x000055b50ab1e0b5 in qdev_device_add
> (opts=3Dopts@entry=3D0x55b50ceb9880, errp=3Derrp@entry=3D0x7ffedda81978=
) at
> qdev-monitor.c:627

It looks like the hotplug event is sent too early to the guest?

Paolo
