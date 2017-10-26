Received: from eggs.gnu.org ([2001:4830:134:3::10]:52847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e7dEu-0006bp-1z
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e7dEq-00036G-3E
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:10:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e7dEp-000361-Qa
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:10:04 -0400
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<d028d04a-9c28-af10-3410-f9007867cc05@de.ibm.com>
	<1ac27ce2-091d-e1b7-fc94-ebdf696a35e9@redhat.com>
	<9f4037d8-93a3-be0f-8cb4-4424158e236b@linux.vnet.ibm.com>
	<a7b30204-a854-afde-af01-234520cc6d7b@redhat.com>
	<87wp3jqips.fsf@marc-ibm.boeblingen.de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <04fe8f34-6f23-93d4-f388-ad7f03a24ca7@redhat.com>
Date: Thu, 26 Oct 2017 10:09:46 +0200
MIME-Version: 1.0
In-Reply-To: <87wp3jqips.fsf@marc-ibm.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 25.10.2017 18:45, Marc Hartmayer wrote:
> On Wed, Oct 25, 2017 at 05:50 PM +0200, David Hildenbrand <david@redhat=
.com> wrote:
>> On 25.10.2017 17:09, Boris Fiuczynski wrote:
>>> On 10/25/2017 12:23 PM, David Hildenbrand wrote:
>>>> On 25.10.2017 12:18, Christian Borntraeger wrote:
>>>>> Ping, I plan to submit belows patch for 2.11. We can then still loo=
k into
>>>>> a libvirt<->qemu interface for limiting host-model depending on mac=
hine versions
>>>>> (or not).
>>>>
>>>> I think this would be sufficient for now.
>>>>
>>>> Having different host models, depending on the the machine type soun=
ds
>>>> wrong. But maybe we'll need it in the future.
>>>>
>>>
>>> David, I disagree if your proposal is to generally tolerate new cpu
>>> features in old machine types. This *might* work for gs but how do yo=
u
>>> guaranty that guests do not behave differently/wrong when suddenly ne=
w
>>> cpu features are made available to guest when (re-)starting them.
>>> That is my feedback for the qemu side of this mater.
>>
>> Just re-reading this section, so what you mean is:
>>
>> a) guest is started, host model is copied and used. guest works.
>> b) guest is stopped.
>> c) QEMU/KVM/HW is updated.
>> d) guest is started, new host model is copied. guest no longer works.
>>
>> d) could be because there are now some additional features with e.g.
>> broken guest implementation or now missing features.
>>
>>
>> What you propose (if I am not wrong) is a to bind features somehow to =
a
>> QEMU machine. I think that should never be done. You could not catch n=
ow
>> missing features.
>=20
> What exactly do you mean by the last sentence?

In general, up/downgrading QEMU/KVM/HW can lead to the removal of feature=
s.

Another example is the "nested" flag for KVM. toggling that can lead to
the host feature looking differently (+/- SIE features).

So if you really want to make sure that a VM XML that once ran perfectly
fine on a host will still run after any QEMU/KVM/HW changes on that host:

a) specify an explicit CPU model, not the host model (e.g. "z13")
b) copy the host model to the XML persistently.

Linking any of that to the machine types is in my opinion the very wrong
approach.

>=20
>>
>> What would you think about a persistent host-model copy option? So
>> instead of copying at every start, only copy and replace it once in th=
e XML?
>>
>> Easy to specify by the user and no CPU feature changes will happend
>> "blindly".
>>
>>
>> --
>>
>> Thanks,
>>
>> David
>>
> --
> Beste Gr=C3=BC=C3=9Fe / Kind regards
>    Marc Hartmayer
>=20
> IBM Deutschland Research & Development GmbH
> Vorsitzende des Aufsichtsrats: Martina Koederitz
> Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
> Sitz der Gesellschaft: B=C3=B6blingen
> Registergericht: Amtsgericht Stuttgart, HRB 243294
>=20


--=20

Thanks,

David
