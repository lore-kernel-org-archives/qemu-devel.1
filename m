Received: from eggs.gnu.org ([2001:4830:134:3::10]:49266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crM1S-0008Bf-D0
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crM1P-0007Qx-Cm
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:00:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1crM1P-0007Pw-7i
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:00:39 -0400
References: <1490347615-19222-1-git-send-email-thuth@redhat.com>
	<f3b0b14e-4ea1-6c4e-f9c6-cb86e78c6104@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <36f3edcf-9589-a223-4ef6-57785564c9d4@redhat.com>
Date: Fri, 24 Mar 2017 11:00:34 +0100
MIME-Version: 1.0
In-Reply-To: <f3b0b14e-4ea1-6c4e-f9c6-cb86e78c6104@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/s390x/kvm: Fix problem when running
 with SELinux under z/VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

On 24.03.2017 10:39, Christian Borntraeger wrote:
> On 03/24/2017 10:26 AM, Thomas Huth wrote:
>> When running QEMU with KVM under z/VM, the memory for the guest
>> is allocated via legacy_s390_alloc() since the KVM_CAP_S390_COW
>> extension is not supported on z/VM. legacy_s390_alloc() then uses
>> mmap(... PROT_EXEC ...) for the guest memory - but this does not
>> work when running with SELinux enabled, mmap() fails and QEMU aborts
>> with the following error message:
>>
>>  cannot set up guest memory 's390.ram': Permission denied
>>
>> Looking at the other allocator function qemu_anon_ram_alloc(), it
>> seems like PROT_EXEC is normally not needed for allocating the
>> guest RAM, and indeed, the guest also starts successfully under
>> z/VM when we remove the PROT_EXEC from the legacy_s390_alloc()
>> function. So let's get rid of that flag here to be able to run
>> with SELinux under z/VM, too.
>=20
> Older z/VM versions do not provide the enhanced suppression on protecti=
on
> facility, which would result in guest failures as soon as the kernel
> starts dirty pages tracking by write protecting the pages via the page
> table. Some kernel release back (last time I checked) the PROT_EXEC was=
=20
> necessary to prevent the dirty pages tracking from taking place. So thi=
s
> patch would break KVM in that case.

OK, then please ignore it.

> Newer z/VMs (e.g. 6.3) do provide ESOP. SO the question is,
> why is KVM_CAP_S390_COW not set?

I'll check whether MACHINE_HAS_ESOP is correctly set in my kernel...

 Thomas
