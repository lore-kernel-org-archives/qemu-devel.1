Received: from eggs.gnu.org ([2001:4830:134:3::10]:50564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2XSI-0000lr-Rb
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 02:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2XSE-0002ye-05
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 02:58:54 -0400
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-3-pasic@linux.vnet.ibm.com>
	<d6d2d73d-65c9-7ae1-fd37-cb8e304781e7@redhat.com>
	<7f454872-fae3-35b0-eff4-227b2aa0f77d@linux.vnet.ibm.com>
	<6c17b274-cd75-7864-94b9-fc8abff1a786@redhat.com>
	<da4228cb-d32c-dc77-0a80-bac306f07c24@linux.vnet.ibm.com>
	<0120aa4c-ffce-79c0-8c87-c7c1100232eb@redhat.com>
	<9d77c8e9-f875-4e42-5306-b847904b4a47@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <39f9e450-d618-6c4d-9401-031c5374ed88@redhat.com>
Date: Thu, 12 Oct 2017 08:58:45 +0200
MIME-Version: 1.0
In-Reply-To: <9d77c8e9-f875-4e42-5306-b847904b4a47@linux.vnet.ibm.com>
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

On 10.10.2017 13:41, Halil Pasic wrote:
> [..]
>>>
>>> Yeah, the ABI is smart enough (where it matters) and this one is obvi=
ously
>>> less that 8 bytes. I read this as you  assumed that the return won't =
be
>>> passed via register (general purpose register 2 for a z host + ELF as=
sumed),
>>> and that would have been ugly indeed.
>>>
>>> Btw I have seen putting an integral into a struct for type checking
>>> in the linux kernel too. For instance from:
>>> arch/s390/include/asm/page.h
>>>
>>> """
>>> /*
>>>  * These are used to make use of C type-checking..
>>>  */
>>>
>>> typedef struct { unsigned long pgprot; } pgprot_t;
>>> typedef struct { unsigned long pgste; } pgste_t;
>>> typedef struct { unsigned long pte; } pte_t;
>>> typedef struct { unsigned long pmd; } pmd_t;
>>> typedef struct { unsigned long pud; } pud_t;
>>> typedef struct { unsigned long pgd; } pgd_t;
>>> typedef pte_t *pgtable_t;
>>>
>>> #define pgprot_val(x)   ((x).pgprot)
>>> #define pgste_val(x)    ((x).pgste)
>>> #define pte_val(x)      ((x).pte)
>>> #define pmd_val(x)      ((x).pmd)
>>> #define pud_val(x)      ((x).pud)
>>> #define pgd_val(x)      ((x).pgd)
>>>
>>> #define __pgste(x)      ((pgste_t) { (x) } )
>>> #define __pte(x)        ((pte_t) { (x) } )
>>> #define __pmd(x)        ((pmd_t) { (x) } )
>>> #define __pud(x)        ((pud_t) { (x) } )
>>> #define __pgd(x)        ((pgd_t) { (x) } )
>>> #define __pgprot(x)     ((pgprot_t) { (x) } )
>>> """
>>>
>>> If you think, I could add a similar comment indicating that my
>>> struct is also just for type-checking.
>>
>> No, I think you've got the reason here slightly wrong. The kernel only
>> uses this since the pte_t and friends need to be urgently portable
>> between the different architectures. Have a look at the kernel
>> Documentation/CodingStyle file, it explicitly mentions this in chapter=
 5
>> ("Typedefs").
>=20
> IMHO we don't talk about typedefs here but about type checking. Btw QEM=
U
> has the exact opposite policy regarding typedefs and structs than Linux=
.
> You want to say that the comment at the top of my quote is wrong, and
> that it should be rather "These are used for hiding representation.."
> that "These are used to make use of C type-checking.."?

I certainly did not want to say that you should change the comment. I
just wanted to point you to the fact that these typedefs in the kernel
are likely rather used for hiding representation indeed, and not so much
for type checking, so using them as an example for introducing something
like type checking here in QEMU is quite a bad example.

> I'm also curious which of the rules would your original suggestion of
> doing "typedef unsigned int IOInstEnding" match (from chapter 5
> "Typedefs")? ;)

None, of course. That's the difference between the kernel and QEMU -
though I have to say that I rather prefer the kernel philosophy nowadays.

So yes, please don't do a "typedef unsigned int IOInstEnding" either. I
think the best match for QEMU would be a

typedef enum IOInstEnding {
    CC_...,
    CC_...,
    CC_...,
    CC_...
} IOInstEnding;

You then also should at least get some compiler checking thanks to
-Wswitch and -Wenum-compare, shouldn't you?

> I assume you have seen my reply to Connie about the benefit: among othe=
rs
> it prevents using something like -EFAULT as a cc by accident which neit=
her
> an enum nor a typedef does.

A confused developer could still do something like "return
(IOInstEnding){.cc =3D -EFAULT};", so this is also not completely safe.

 Thomas
