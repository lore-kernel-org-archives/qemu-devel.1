Received: from eggs.gnu.org ([209.51.188.92]:50181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmDUo-0005K5-5u
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmDUi-0001Di-3z
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:02:50 -0500
References: <20190122125133.1191-1-david@redhat.com>
	<20190122140110.47cf348b.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cd8ed071-e68d-df12-62b7-4e9b6b932956@redhat.com>
Date: Wed, 23 Jan 2019 09:02:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190122140110.47cf348b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/2] s390x/pci: PCI bridge plugging fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Pierre Morel <pmorel@linux.ibm.com>

On 22.01.19 14:01, Cornelia Huck wrote:
> On Tue, 22 Jan 2019 13:51:31 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> Hotplugging of PCI bridges is right now pretty much broken. Coldpluggi=
ng
>> and hotplugging will assign wrong primary bus numbers in some scenario=
s.
>>
>> I base my knowledge on how this is supposed to work on
>> http://www.science.unitn.it/~fiorella/guidelinux/tlk/node76.html
>>
>> I did a couple of tests, building whole hierarchies of bridges, both
>> hot and coldplugged. "info pci" as well as the Linux guests showed
>> what I was expecting.
>>
>> David Hildenbrand (2):
>>   s390x/pci: Fix primary bus number for PCI bridges
>>   s390x/pci: Fix hotplugging of PCI bridges
>>
>>  hw/s390x/s390-pci-bus.c | 41 +++++++++++++++++++++++++++-------------=
-
>>  1 file changed, 27 insertions(+), 14 deletions(-)
>>
>=20
> I'll leave the actual review of this to folks familiar with how zPCI is
> supposed to work :)
>=20
> Does the guest actually see anything of this? Consistency is good, and
> not crashing even better, but I think all of the topology is invisible
> on the guest side anyway...
>=20

I am no PCI expert, but I think the guest is able to read/write these
numbers via the configuration space. As far as I can see, on x86 the
BIOS builds the topology. On Power/s390x this job is delegated to
firmware / QEMU.

There are quite some numbers in QEMU relying on these numbers to be
correct: E.g. pci_secondary_bus_in_range()

If the guest relies on the topology to be correct, things can go wrong.
I have no idea how Linux guests actually use the topology.

Also, the output of "info pci" will be wrong.

Anyhow, this is the right thing to do, but I agree that Patch #1 might
not be as critical as patch #2.

--=20

Thanks,

David / dhildenb
