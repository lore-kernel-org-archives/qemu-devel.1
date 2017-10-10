Received: from eggs.gnu.org ([2001:4830:134:3::10]:54005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1svL-000513-7q
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1svA-0003l1-Hz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:42:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56268
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e1svA-0003kN-C1
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:42:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9ABdUo1112349
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 07:41:56 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dgve6c2m2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 07:41:56 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 12:41:53 +0100
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-3-pasic@linux.vnet.ibm.com>
	<d6d2d73d-65c9-7ae1-fd37-cb8e304781e7@redhat.com>
	<7f454872-fae3-35b0-eff4-227b2aa0f77d@linux.vnet.ibm.com>
	<6c17b274-cd75-7864-94b9-fc8abff1a786@redhat.com>
	<da4228cb-d32c-dc77-0a80-bac306f07c24@linux.vnet.ibm.com>
	<0120aa4c-ffce-79c0-8c87-c7c1100232eb@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 13:41:50 +0200
MIME-Version: 1.0
In-Reply-To: <0120aa4c-ffce-79c0-8c87-c7c1100232eb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9d77c8e9-f875-4e42-5306-b847904b4a47@linux.vnet.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

[..]
>>
>> Yeah, the ABI is smart enough (where it matters) and this one is obviously
>> less that 8 bytes. I read this as you  assumed that the return won't be
>> passed via register (general purpose register 2 for a z host + ELF assumed),
>> and that would have been ugly indeed.
>>
>> Btw I have seen putting an integral into a struct for type checking
>> in the linux kernel too. For instance from:
>> arch/s390/include/asm/page.h
>>
>> """
>> /*
>>  * These are used to make use of C type-checking..
>>  */
>>
>> typedef struct { unsigned long pgprot; } pgprot_t;
>> typedef struct { unsigned long pgste; } pgste_t;
>> typedef struct { unsigned long pte; } pte_t;
>> typedef struct { unsigned long pmd; } pmd_t;
>> typedef struct { unsigned long pud; } pud_t;
>> typedef struct { unsigned long pgd; } pgd_t;
>> typedef pte_t *pgtable_t;
>>
>> #define pgprot_val(x)   ((x).pgprot)
>> #define pgste_val(x)    ((x).pgste)
>> #define pte_val(x)      ((x).pte)
>> #define pmd_val(x)      ((x).pmd)
>> #define pud_val(x)      ((x).pud)
>> #define pgd_val(x)      ((x).pgd)
>>
>> #define __pgste(x)      ((pgste_t) { (x) } )
>> #define __pte(x)        ((pte_t) { (x) } )
>> #define __pmd(x)        ((pmd_t) { (x) } )
>> #define __pud(x)        ((pud_t) { (x) } )
>> #define __pgd(x)        ((pgd_t) { (x) } )
>> #define __pgprot(x)     ((pgprot_t) { (x) } )
>> """
>>
>> If you think, I could add a similar comment indicating that my
>> struct is also just for type-checking.
> 
> No, I think you've got the reason here slightly wrong. The kernel only
> uses this since the pte_t and friends need to be urgently portable
> between the different architectures. Have a look at the kernel
> Documentation/CodingStyle file, it explicitly mentions this in chapter 5
> ("Typedefs").
>

Disclaimer: I agree with your conclusion, the maintainers will have
to make the final call here. I will still reply point by point for
the fun of pointless academic discussions.

IMHO we don't talk about typedefs here but about type checking. Btw QEMU
has the exact opposite policy regarding typedefs and structs than Linux.
You want to say that the comment at the top of my quote is wrong, and
that it should be rather "These are used for hiding representation.."
that "These are used to make use of C type-checking.."?

I'm also curious which of the rules would your original suggestion of
doing "typedef unsigned int IOInstEnding" match (from chapter 5
"Typedefs")? ;)

 
>>> Then, in the follow up patches, you do something like this:
>>>
>>>    return (IOInstEnding){.cc = 0};
>>>
>>> ... and that just looks very, very ugly in my eyes. The more I look at
>>
>> Interesting, I found this quite expressive.
> 
> C'mon, we're writing C code, not Java ;-)

Yeah, me written much C++ and also Java before might be a part
of the problem. Btw there is no such construct in Java AFAIR :P.
> 
>>> it, the more I think we really want to have a named enum instead. That
>>> will give you some sort of basic type safety and semantics, too, and
>>
>> AFAIK we don't have strongly typed enums in C, at least not from
>> the language perspective. In c++ we got enum class and enum struct
>> with c++11 for that reason.
>>
>>> we'll also get proper names for those magic values - otherwise I'll
>>> always have to look up what cc = 2 or cc = 3 means... (I always keep
>>> forgetting what each value means...)
>>
>> Can you suggest some proper names for those magic values? Unfortunately
>> the PoP refers to this stuff as setting condition code [0-3], so in my
>> reading the numbers are the canonical names for this stuff. The best
>> 'proper names' I can think of for these are CC_0, CC_1, CC_2, and CC_3.
> 
> Well, you already gave a description in your comment in the  struct
> IOInstEnding, so maybe something similar? Or maybe this could even be
> merged with the definitions for the SIGP status codes:
> 
> #define SIGP_CC_ORDER_CODE_ACCEPTED 0
> #define SIGP_CC_STATUS_STORED       1
> #define SIGP_CC_BUSY                2
> #define SIGP_CC_NOT_OPERATIONAL     3
> 
> ?
> 

Maybe.

>> Sorry, I may be a bit to persistent on this one: I don't think it's
>> a huge difference, but I don't feel great about changing something to
>> what I think is (slightly) worse without being first convinced that
>> I was wrong.
> 
> In the end, the code has to be accepted by the maintainers, so let's
> leave the decision up to them whether they like this typedef struct
> IOInstEnding or not...

I agree. Especially if the change in behavior in #3 does not get trough
I will have to revert indicating exceptions too (like in v1), and then
I really need the struct (which can be still less than 8 bytes).

I assume you have seen my reply to Connie about the benefit: among others
it prevents using something like -EFAULT as a cc by accident which neither
an enum nor a typedef does.

In practice, I think either of the proposed solutions will do.

Halil
 
> 
>  Thomas
> 
