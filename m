Received: from eggs.gnu.org ([2001:4830:134:3::10]:34443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2Z3r-0001r9-4p
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 04:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2Z3n-00035g-P2
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 04:41:47 -0400
References: <20170927170027.8539-1-david@redhat.com>
	<20170927170027.8539-3-david@redhat.com>
	<466fa6a0-ac91-66aa-aabb-a15a8ac62e0f@redhat.com>
	<3d5ea6d8-b3bf-b1a5-b4a1-082ff49ae842@redhat.com>
	<20170929132717.23ecf350.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <469b7729-0e9a-1c20-6a68-b3b8e55bafb4@redhat.com>
Date: Thu, 12 Oct 2017 10:41:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170929132717.23ecf350.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/3] s390x/tcg: low-address protection
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org

On 29.09.2017 13:27, Cornelia Huck wrote:
> On Thu, 28 Sep 2017 15:08:11 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 28.09.2017 06:50, Thomas Huth wrote:
>>> On 27.09.2017 19:00, David Hildenbrand wrote: =20
>>>> This is a neat way to implement low address protection, whereby
>>>> only the first 512 bytes of the first two pages (each 4096 bytes) of
>>>> every address space are protected.
>>>>
>>>> Store a tec of 0 for the access exception, this is what is defined b=
y
>>>> Enhanced Suppression on Protection in case of a low address protecti=
on
>>>> (Bit 61 set to 0, rest undefined).
>>>>
>>>> We have to make sure to to pass the access address, not the masked p=
age
>>>> address into mmu_translate*().
>>>>
>>>> Drop the check from testblock. So we can properly test this via
>>>> kvm-unit-tests.
>>>>
>>>> This will check every access going through one of the MMUs.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  target/s390x/excp_helper.c |  3 +-
>>>>  target/s390x/mem_helper.c  |  8 ----
>>>>  target/s390x/mmu_helper.c  | 96 +++++++++++++++++++++++++++++------=
-----------
>>>>  3 files changed, 62 insertions(+), 45 deletions(-) =20
>>> [...] =20
>>>> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
>>>> index 9daa0fd8e2..44a15449d2 100644
>>>> --- a/target/s390x/mmu_helper.c
>>>> +++ b/target/s390x/mmu_helper.c
>>>> @@ -106,6 +106,37 @@ static void trigger_page_fault(CPUS390XState *e=
nv, target_ulong vaddr,
>>>>      trigger_access_exception(env, type, ilen, tec);
>>>>  }
>>>> =20
>>>> +/* check whether the address would be proteted by Low-Address Prote=
ction */
>>>> +static bool is_low_address(uint64_t addr)
>>>> +{
>>>> +    return addr < 512 || (addr >=3D 4096 && addr < 4607);
>>>> +} =20
>>>
>>> I like the check from the kernel sources better:
>>>
>>> static inline int is_low_address(unsigned long ga)
>>> {
>>>     /* Check for address ranges 0..511 and 4096..4607 */
>>>     return (ga & ~0x11fful) =3D=3D 0;
>>> }
>>>
>>> ... that might result in slightly faster code (depending on the
>>> compiler, of course). =20
>>
>> I think that lim (readability) -> 0. Without that comment you're at
>> first sight really clueless what this is about.
>>
>> My check exactly corresponds to the wording in the PoP (and smart
>> compilers should be able to optimize).
>>
>> But I don't have a strong opinion on this micro optimization.
>=20
> FWIW, I'd be happy with both, but has anyone actually looked at the
> generated code?

This is what I get for David's original code:

    80000510:   c4 18 00 00 0d a4       lgrl    %r1,80002058 <x1>
    80000516:   a7 29 01 ff             lghi    %r2,511
    8000051a:   ec 12 00 4f c0 65       clgrjnh %r1,%r2,800005b8 <main+0x=
d8>
    80000520:   a7 1b f0 00             aghi    %r1,-4096
    80000524:   c2 1e 00 00 01 fe       clgfi   %r1,510
    8000052a:   a7 18 00 00             lhi     %r1,0
    8000052e:   b9 99 00 11             slbr    %r1,%r1
    80000532:   13 11                   lcr     %r1,%r1
    80000534:   c4 1f 00 00 0d 96       strl    %r1,80002060 <b1>

And this is the optimized kernel version:

    8000054a:   c4 18 00 00 0d 7f       lgrl    %r1,80002048 <x2>
    80000550:   a5 17 ee 00             nill    %r1,60928
    80000554:   b9 00 00 11             lpgr    %r1,%r1
    80000558:   a7 1b ff ff             aghi    %r1,-1
    8000055c:   eb 11 00 3f 00 0c       srlg    %r1,%r1,63
    80000562:   c4 1f 00 00 0d 77       strl    %r1,80002050 <b2>

So that's indeed a little bit better :-)
(I was using GCC 4.8.5 from RHEL7, with -O2)

By the way, I think there's a bug in David's code: It should either be
"addr <=3D 4607" or "addr < 4608" instead of "addr < 4607".

With that bug fixed, David's version get's optimized even more:

    80000510:   c4 18 00 00 0d a4       lgrl    %r1,80002058 <x1>
    80000516:   a5 17 ef ff             nill    %r1,61439
    8000051a:   c2 1e 00 00 01 ff       clgfi   %r1,511
    80000520:   a7 18 00 00             lhi     %r1,0
    80000524:   b9 99 00 11             slbr    %r1,%r1
    80000528:   13 11                   lcr     %r1,%r1
    8000052a:   c4 1f 00 00 0d 9b       strl    %r1,80002060 <b1>

... so the difference is really very minimal in that case --> We could
really use the more readable version, I think.

 Thomas
