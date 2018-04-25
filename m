Received: from eggs.gnu.org ([2001:4830:134:3::10]:54247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fBJgp-0005Lb-Do
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fBJgl-0000ob-TG
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:38:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1fBJgl-0000mP-Kt
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:38:23 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3PCb0B6085676
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:38:21 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hjqgmxpf1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:38:20 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Wed, 25 Apr 2018 13:38:17 +0100
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-3-lersek@redhat.com>
	<87muxraips.fsf@dusky.pond.sub.org>
	<20180425094849.3dd619d1.cohuck@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Wed, 25 Apr 2018 14:38:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180425094849.3dd619d1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <8373fb9c-e7cf-3f37-936d-eae9601faab9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] qapi: handle the riscv CpuInfoArch in
 query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Riku Voipio <riku.voipio@iki.fi>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Luiz Capitulino <lcapitulino@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

On 25.04.2018 09:48, Cornelia Huck wrote:
> On Wed, 25 Apr 2018 08:44:15 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
> 
>> Laszlo Ersek <lersek@redhat.com> writes:
>>
>>> Commit 25fa194b7b11 added the @riscv enum constant to @CpuInfoArch (used
>>> in both @CpuInfo and @CpuInfoFast -- the return types of the @query-cpus
>>> and @query-cpus-fast commands, respectively), and assigned, in both return
>>> structures, the @CpuInfoRISCV sub-structure to the new enum value.
>>>
>>> However, qmp_query_cpus_fast() would not populate either the @arch field
>>> or the @CpuInfoRISCV sub-structure, when TARGET_RISCV was defined; only
>>> qmp_query_cpus() would.
>>>
>>> In theory, there are two ways to fix this:
>>>
>>> (a) Fill in both the @arch field and the @CpuInfoRISCV sub-structure in
>>>     qmp_query_cpus_fast(), by copying the logic from qmp_query_cpus().
>>>
>>> (b) Assign @CpuInfoOther to the @riscv enum constant in @CpuInfoFast, and
>>>     populate only the @arch field in qmp_query_cpus_fast().
>>>
>>> Approach (b) seems more robust, because:
>>>
>>> - clearly there has never been an attempt to get actual RISV CPU state
>>>   from qmp_query_cpus_fast(), so its lack of RISCV support is not actually
>>>   a problem,
>>>
>>> - getting CPU state without interrupting KVM looks like an exceptional
>>>   thing to do (only S390X does it currently).
>>>
>>> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Cc: Laurent Vivier <laurent@vivier.eu>
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Cc: Michael Clark <mjc@sifive.com>
>>> Cc: Palmer Dabbelt <palmer@sifive.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>>> Cc: Richard Henderson <rth@twiddle.net>
>>> Cc: Riku Voipio <riku.voipio@iki.fi>
>>> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 25fa194b7b11901561532e435beb83d046899f7a
>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>> ---
>>>
>>> Notes:
>>>     PATCHv1:
>>>     
>>>     - new patch
>>>
>>>  qapi/misc.json | 2 +-
>>>  cpus.c         | 2 ++
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/misc.json b/qapi/misc.json
>>> index 5636f4a14997..104d013adba6 100644
>>> --- a/qapi/misc.json
>>> +++ b/qapi/misc.json
>>> @@ -565,23 +565,23 @@
>>>  { 'union': 'CpuInfoFast',
>>>    'base': {'cpu-index': 'int', 'qom-path': 'str',
>>>             'thread-id': 'int', '*props': 'CpuInstanceProperties',
>>>             'arch': 'CpuInfoArch' },
>>>    'discriminator': 'arch',
>>>    'data': { 'x86': 'CpuInfoOther',
>>>              'sparc': 'CpuInfoOther',
>>>              'ppc': 'CpuInfoOther',
>>>              'mips': 'CpuInfoOther',
>>>              'tricore': 'CpuInfoOther',
>>>              's390': 'CpuInfoS390',
>>> -            'riscv': 'CpuInfoRISCV',
>>> +            'riscv': 'CpuInfoOther',
>>>              'other': 'CpuInfoOther' } }  
>>
>> Why do CpuInfoFast's variants match CpuInfo's for s390, but not the
>> others?  Your commit message has an educated guess: "looks like an
>> exceptional thing to do (only S390X does it currently)".  But why guess
>> when we can ask authors of commit ce74ee3dea6?  Luiz and Victor, please
>> advise.
> 
> I'm neither Luiz nor Viktor, but Laszlo's educated guess is correct. See
> https://www.redhat.com/archives/libvir-list/2018-February/msg00121.html
> for some background. So yes, s390x is exceptional in that it has state
> in QEMU that is actually interesting for upper layers and can be
> retrieved without performance penalty.
Right, the only 'upper layer' using this I'm aware of is libvirt and the
arch evaluation is only done for s390. Not pretty, but no harm done so far.
> 
> Might make sense to refer to the above.
> 
[...]

-- 
Regards,
  Viktor Mihajlovski
