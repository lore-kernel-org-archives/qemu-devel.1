Received: from eggs.gnu.org ([2001:4830:134:3::10]:49262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHD04-0002hZ-Nr
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eHD01-0000Ky-AW
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:10:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57382
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eHD00-0000Km-VK
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:10:21 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vALI9fja119691
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 13:10:12 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ecs63r19r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 13:10:11 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 21 Nov 2017 18:10:10 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id vALIA7lp40239288
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 18:10:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9F2952041
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 17:03:38 +0000 (GMT)
Received: from [9.145.75.203] (unknown [9.145.75.203])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C7ADB5203F
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 17:03:38 +0000 (GMT)
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171121115249.5709c8c9.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 21 Nov 2017 19:10:06 +0100
MIME-Version: 1.0
In-Reply-To: <20171121115249.5709c8c9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <93e837b2-efa1-d2e3-1618-22c1d1731d1f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/7] s390x/pci: Improve zPCI to cover
 more cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 21/11/2017 11:52, Cornelia Huck wrote:
> On Thu, 16 Nov 2017 18:51:48 +0100
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
>=20
> I'll play with this a bit, but I think this is good for s390-next.
>=20
> [I'd still like to play with this under tcg as well to make sure we are
> endian-clean, but I'm making slower progress there than I hoped.]
>=20

OK, thanks.
I wait for the answers for the points I am still not sure, (#define and=20
broken English) and send a v3 with the corrections.

Best regards,

Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
