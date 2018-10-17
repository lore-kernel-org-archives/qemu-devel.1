Received: from eggs.gnu.org ([2001:4830:134:3::10]:54953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gClWH-0002Vj-V0
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gClWD-0006gb-Kh
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:05:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1735
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gClWD-0006Yz-Bm
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:05:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9HD4hNR078321
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 09:05:42 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n641kve9w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 09:05:41 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 17 Oct 2018 14:05:39 +0100
Reply-To: pmorel@linux.ibm.com
References: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
	<20181017125638.7ab687c6.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 17 Oct 2018 15:05:34 +0200
MIME-Version: 1.0
In-Reply-To: <20181017125638.7ab687c6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <4330c759-4db2-ce41-58c2-76d19c63e4a3@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] call HotplugHandler->plug() as the last
 step in device realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com

On 17/10/2018 12:56, Cornelia Huck wrote:
> On Tue, 16 Oct 2018 15:33:40 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
>> When [2] was fixed it was agreed that adding and calling post_plug()
>> callback after device_reset() was low risk approach to hotfix issue
>> right before release. So it was merged instead of moving already
>> existing plug() callback after device_reset() is called which would
>> be more risky and require all plug() callbacks audit.
>>
>> Looking at the current plug() callbacks, it doesn't seem that moving
>> plug() callback after device_reset() is breaking anything, so here
>> goes agreed upon [3] proper fix which essentially reverts [1][2]
>> and moves plug() callback after device_reset().
>> This way devices always comes to plug() stage, after it's been fully
>> initialized (including being reset), which fixes race condition [2]
>> without need for an extra post_plug() callback.
>>
>>   1. (25e897881 "qdev: add HotplugHandler->post_plug() callback")
>>   2. (8449bcf94 "virtio-scsi: fix hotplug ->reset() vs event race")
>>   3. https://www.mail-archive.com/qemu-devel@nongnu.org/msg549915.html
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> TODO:
>>   remove usage of Error** from plug() callback, we need to factor out
>>   pre_plug part from plug() callbacks, before proceeding with it.
>>   DavidH has recently finished it for pc-dimm/memory_devices, cpus
>>   mostly have pre_plug parts factored out, but there still are parts
>>   that could fail so it needs some more work to eliminate failure poin=
ts
>>   from plug() callbacks. Meanwhile, I'll plan to treat other misc
>>   handlers (pci[e]/acpi/usb/...) and introduce pre_plug() where
>>   necessary.
>> ---
>>   include/hw/hotplug.h  | 11 -----------
>>   hw/core/hotplug.c     | 10 ----------
>>   hw/core/qdev.c        | 16 ++++++----------
>>   hw/scsi/virtio-scsi.c | 11 +----------
>>   4 files changed, 7 insertions(+), 41 deletions(-)
>=20
> I've looked at the s390x users of this interface, and it seems to be
> sane. The one I'm a bit unsure about is zPCI with its bridge
> enumeration code as introduced in d2f07120a35a ("s390x/pci: handle
> PCIBridge bus number"). I *think* that one is fine as well. Pierre, can
> you confirm?

Yes, I can confirm.
We have no problem with this patch in VFIO_PCI nor in VIRTIO_PCI with=20
zPCI emulation, for devices bridge or bus.

I played the patch and tested locally. all fine.

For the S390:
Tested-by: Pierre Morel<pmorel@linux.ibm.com>

also
Acked-by: Pierre Morel<pmorel@linux.ibm.com>

Regards,
Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
