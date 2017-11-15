Received: from eggs.gnu.org ([2001:4830:134:3::10]:46904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEuXL-0007C2-Rc
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEuXG-0005kB-Q9
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:03:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eEuXG-0005jn-G3
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:03:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAF9xqjZ007995
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 05:03:04 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e8jdn2yk5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 05:03:03 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 15 Nov 2017 10:03:01 -0000
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171113181305.5786d700.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 11:02:57 +0100
MIME-Version: 1.0
In-Reply-To: <20171113181305.5786d700.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <997d47da-e652-4eba-15c1-8ab793c89da7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] s390x/pci: Improve zPCI to cover more
 cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On 13/11/2017 18:13, Cornelia Huck wrote:
> On Tue,  7 Nov 2017 18:24:32 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> Right now the PCI support is very limited (e.g. pass through of a
>> host vfio device)
>> To enable features like virtio-pci several modifications needs to be
>> done.
>>
>> Virtio-PCI uses subregions, which may eventually be discontinuous
>> inside bars instead of a single flat region.
>> The address offset being formerly calculated from the BAR base address
>> must be adapted to the subregions instead of to the single region.
>>
>> This patch provides the new calculation for the three kind of BAR
>> access, zPCI STORE, zPCI LOAD and zPCI STORE BLOCK.
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
>>   hw/s390x/s390-pci-inst.c | 250 ++++++++++++++++++++++++++++---------=
----------
>>   hw/s390x/s390-pci-inst.h |   2 +-
>>   3 files changed, 153 insertions(+), 100 deletions(-)
>>
>=20
> I assume you'll send a v2?

Yes, I have a lot of mater to do this now.

Thanks for reviewing,

Pierre

>=20
> I'll see if I can find some time to wire up pci in tcg (as this would
> get us additional test coverage, especially regarding endianness), but
> I won't complain should someone beat me to it.
>=20
Yes, would be fine to have it to increase test coverage.


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
