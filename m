Received: from eggs.gnu.org ([2001:4830:134:3::10]:36904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eKnRX-0003h5-Ds
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eKnQP-00079h-3w
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:41:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35652
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eKnQN-00074f-MV
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:40:24 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB1CujE0029354
	for <qemu-devel@nongnu.org>; Fri, 1 Dec 2017 07:58:17 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ek43ahv4y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 07:58:17 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Fri, 1 Dec 2017 12:58:15 -0000
References: <1512046530-17773-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171201112959.3bdd442b.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 1 Dec 2017 13:58:11 +0100
MIME-Version: 1.0
In-Reply-To: <20171201112959.3bdd442b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <9e356172-a996-7ec1-7dd6-276aa18a3edb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/7] s390x/pci: Improve zPCI to cover
 more cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, mst@redhat.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org

On 01/12/2017 11:29, Cornelia Huck wrote:
> On Thu, 30 Nov 2017 13:55:23 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> This patch fixes the following BUG:
>> Even a guest is able to detect virtio_pci device, the init function
>> the Linux virtio_pci driver will hang because zPCI does not support
>> the subregions used by virtio_pci.
>>
>> It follows that right now the PCI support is very limited
>> (e.g. pass through of a host vfio device)
>> To enable features like virtio-pci several modifications needs to be
>> done.
>>
>> As already stated above, Virtio-PCI uses subregions, which may eventua=
lly
>> be discontinuous inside bars instead of a single flat region often use=
d
>> by real devices.
>> The address offset being formerly calculated from the BAR base address
>> must be adapted to the subregions instead of to the single region.
>>
>> This patch provides the new calculation for the three kind of BAR
>> access, zPCI STORE, zPCI LOAD and zPCI STORE BLOCK done by zPCI.
>>
>> We use the opportunity to
>>   - enhance the fault detection for zPCI STORE and LOAD,
>>   - enhance the fault detection and to provide the maximum STORE BLOCK
>>     block size, maxstbl, for zPCI STORE BLOCK
>>   - factor out part of the code used to calculate the offset and
>>     access the BARs,
>>   - factor out the code for endianess conversion.
>>
>>
>> Pierre Morel (7):
>>    s390x/pci: factor out endianess conversion
>>    s390x/pci: rework PCI STORE
>>    s390x/pci: rework PCI LOAD
>>    s390x/pci: rework PCI STORE BLOCK
>>    s390x/pci: move the memory region read from pcilg
>>    s390x/pci: move the memory region write from pcistg
>>    s390x/pci: search for subregion inside the BARs
>>
>>   hw/s390x/s390-pci-bus.h  |   1 +
>>   hw/s390x/s390-pci-inst.c | 251 ++++++++++++++++++++++++++++---------=
----------
>>   hw/s390x/s390-pci-inst.h |   6 +-
>>   3 files changed, 158 insertions(+), 100 deletions(-)
>>
>=20
> I massaged this to fit on top of David's patchset and it still works
> fine with my pci/tcg patches.
>=20
> Some small comments for things I can fix up myself (will reply to
> individual patches). On the whole, I'm inclined to queue this.
>=20

Great, thanks.

Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
