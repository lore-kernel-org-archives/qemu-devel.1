Received: from eggs.gnu.org ([2001:4830:134:3::10]:59084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e1rmG-000529-9w
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e1rmE-0002qg-SW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e1rmE-0002qP-Io
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:28:42 -0400
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-3-pasic@linux.vnet.ibm.com>
	<d6d2d73d-65c9-7ae1-fd37-cb8e304781e7@redhat.com>
	<7f454872-fae3-35b0-eff4-227b2aa0f77d@linux.vnet.ibm.com>
	<6c17b274-cd75-7864-94b9-fc8abff1a786@redhat.com>
	<da4228cb-d32c-dc77-0a80-bac306f07c24@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0120aa4c-ffce-79c0-8c87-c7c1100232eb@redhat.com>
Date: Tue, 10 Oct 2017 12:28:35 +0200
MIME-Version: 1.0
In-Reply-To: <da4228cb-d32c-dc77-0a80-bac306f07c24@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/8] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 09.10.2017 17:00, Halil Pasic wrote:
>=20
>=20
> On 10/09/2017 01:07 PM, Thomas Huth wrote:
>> On 09.10.2017 12:54, Halil Pasic wrote:
>>>
>>>
>>> On 10/09/2017 10:20 AM, Thomas Huth wrote:
>>>> On 04.10.2017 17:41, Halil Pasic wrote:
>>>>> CSS code needs to tell the IO instruction handlers located in how s=
hould
>>>>
>>>> located in how?
>>>>
>>>
>>> First, thanks for your review!
>>>
>>> Wanted to say: in target/s390x/ioinst.c just forgot to copy paste.
>>>
>>>>> the emulated instruction be ended. Currently this is done by return=
ing
>>>>> generic (POSIX) error codes, and mapping them to outcomes like cond=
ition
>>>>> codes. This makes bugs easy to create and hard to recognise.
>>>>>
>>>>> As a preparation for moving a way form (mis)using generic error cod=
es for
>>>>> flow control let us introduce a struct which tells the instruction
>>>>> handler function how to end the instruction, in a more straight-for=
ward
>>>>> and less ambiguous way.
>>>>>
>>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>> ---
>>>>>  include/hw/s390x/css.h | 12 ++++++++++++
>>>>>  1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
>>>>> index 0653d3c9be..66916b6546 100644
>>>>> --- a/include/hw/s390x/css.h
>>>>> +++ b/include/hw/s390x/css.h
>>>>> @@ -75,6 +75,18 @@ typedef struct CMBE {
>>>>>      uint32_t reserved[7];
>>>>>  } QEMU_PACKED CMBE;
>>>>> =20
>>>>> +/* IO instructions conclude according this */
>>>>> +typedef struct IOInstEnding {
>>>>> +        /*
>>>>> +         * General semantic of cc codes of IO instructions is (bri=
ef):
>>>>> +         * 0 -- produced expected result
>>>>> +         * 1 --  status conditions were present or produced altern=
ate result
>>>>> +         * 2 -- ineffective, because busy with previously initiate=
d function
>>>>> +         * 3 -- ineffective, not operational
>>>>> +         */
>>>>> +        int cc;
>>>>> +} IOInstEnding;
>>>>
>>>> Why do you need a struct for this? Do you plan to extend it later? I=
f
>>>> so, I think you should mention that in the patch description. If not=
,
>>>> please use a named enum or a "typedef unsigned int IOInstEnding" ins=
tead.
>>>>
>>>>  Thomas
>>>
>>> We may, we may not. In the previous version we also had to support
>>> do end a certain instruction with an addressing exception, but this
>>> is going away in patch #3. Honestly I don't expect this being extende=
d.
>>>
>>> I have other reasons for the struct. Type safety and clear semantics,
>>> and frankly at least for s390 and linux I don't see any downsides giv=
en
>>> what is written in the "zSeries ELF Application Binary Interface Supp=
lement".
>>> Can you please explain to me what is the problem with using this stru=
ct, and
>>> what is the benefit switching to a unsigned int?
>>
>> First, returning a struct is ugly in most cases, since it might need t=
o
>> be passed on the stack if it is bigger than 8 bytes. Ok, that's likely
>> not the case here (if the compiler / ABI is smart enough - I did not
>> check), but still, if I see something like this, there is an alarm
>> signal somewhere in my head that starts to ring...
>>
>=20
> Yeah, the ABI is smart enough (where it matters) and this one is obviou=
sly
> less that 8 bytes. I read this as you  assumed that the return won't be
> passed via register (general purpose register 2 for a z host + ELF assu=
med),
> and that would have been ugly indeed.
>=20
> Btw I have seen putting an integral into a struct for type checking
> in the linux kernel too. For instance from:
> arch/s390/include/asm/page.h
>=20
> """
> /*
>  * These are used to make use of C type-checking..
>  */
>=20
> typedef struct { unsigned long pgprot; } pgprot_t;
> typedef struct { unsigned long pgste; } pgste_t;
> typedef struct { unsigned long pte; } pte_t;
> typedef struct { unsigned long pmd; } pmd_t;
> typedef struct { unsigned long pud; } pud_t;
> typedef struct { unsigned long pgd; } pgd_t;
> typedef pte_t *pgtable_t;
>=20
> #define pgprot_val(x)   ((x).pgprot)
> #define pgste_val(x)    ((x).pgste)
> #define pte_val(x)      ((x).pte)
> #define pmd_val(x)      ((x).pmd)
> #define pud_val(x)      ((x).pud)
> #define pgd_val(x)      ((x).pgd)
>=20
> #define __pgste(x)      ((pgste_t) { (x) } )
> #define __pte(x)        ((pte_t) { (x) } )
> #define __pmd(x)        ((pmd_t) { (x) } )
> #define __pud(x)        ((pud_t) { (x) } )
> #define __pgd(x)        ((pgd_t) { (x) } )
> #define __pgprot(x)     ((pgprot_t) { (x) } )
> """
>=20
> If you think, I could add a similar comment indicating that my
> struct is also just for type-checking.

No, I think you've got the reason here slightly wrong. The kernel only
uses this since the pte_t and friends need to be urgently portable
between the different architectures. Have a look at the kernel
Documentation/CodingStyle file, it explicitly mentions this in chapter 5
("Typedefs").

>> Then, in the follow up patches, you do something like this:
>>
>>    return (IOInstEnding){.cc =3D 0};
>>
>> ... and that just looks very, very ugly in my eyes. The more I look at
>=20
> Interesting, I found this quite expressive.

C'mon, we're writing C code, not Java ;-)

>> it, the more I think we really want to have a named enum instead. That
>> will give you some sort of basic type safety and semantics, too, and
>=20
> AFAIK we don't have strongly typed enums in C, at least not from
> the language perspective. In c++ we got enum class and enum struct
> with c++11 for that reason.
>=20
>> we'll also get proper names for those magic values - otherwise I'll
>> always have to look up what cc =3D 2 or cc =3D 3 means... (I always ke=
ep
>> forgetting what each value means...)
>=20
> Can you suggest some proper names for those magic values? Unfortunately
> the PoP refers to this stuff as setting condition code [0-3], so in my
> reading the numbers are the canonical names for this stuff. The best
> 'proper names' I can think of for these are CC_0, CC_1, CC_2, and CC_3.

Well, you already gave a description in your comment in the  struct
IOInstEnding, so maybe something similar? Or maybe this could even be
merged with the definitions for the SIGP status codes:

#define SIGP_CC_ORDER_CODE_ACCEPTED 0
#define SIGP_CC_STATUS_STORED       1
#define SIGP_CC_BUSY                2
#define SIGP_CC_NOT_OPERATIONAL     3

?

> Sorry, I may be a bit to persistent on this one: I don't think it's
> a huge difference, but I don't feel great about changing something to
> what I think is (slightly) worse without being first convinced that
> I was wrong.

In the end, the code has to be accepted by the maintainers, so let's
leave the decision up to them whether they like this typedef struct
IOInstEnding or not...

 Thomas
