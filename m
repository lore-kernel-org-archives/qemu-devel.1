Received: from eggs.gnu.org ([2001:4830:134:3::10]:51913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBJZ4-0000nW-Pq
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBJYy-0004Vp-Vt
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:30:26 -0400
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-2-lersek@redhat.com>
	<87r2n3aixh.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <98ebe30d-15f7-929a-2706-d5f9f02f5136@redhat.com>
Date: Wed, 25 Apr 2018 14:30:18 +0200
MIME-Version: 1.0
In-Reply-To: <87r2n3aixh.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] qapi: fill in CpuInfoFast.arch in
 query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 04/25/18 08:39, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> Commit ca230ff33f89 added added the @arch field to @CpuInfoFast, but it
>> failed to set the new field in qmp_query_cpus_fast(), when TARGET_S390X
>> was not defined. The updated @query-cpus-fast example in
>> "qapi-schema.json" showed "arch":"x86" only because qmp_query_cpus_fast()
>> calls g_malloc0() to allocate CpuInfoFast, and the CPU_INFO_ARCH_X86 enum
>> constant is generated with value 0.
>>
>> All @arch values other than @s390 implied the @CpuInfoOther sub-struct for
>> @CpuInfoFast -- at the time of writing the patch --, thus no fields other
>> than @arch needed to be set when TARGET_S390X was not defined. Set @arch
>> now, by copying the corresponding assignments from qmp_query_cpus().
> 
> Now I'm confused.
> 
> In the schema, @arch "riscv" implies CpuInfoRISCV:
> 
>     { 'union': 'CpuInfoFast',
>       'base': {'cpu-index': 'int', 'qom-path': 'str',
>                'thread-id': 'int', '*props': 'CpuInstanceProperties',
>                'arch': 'CpuInfoArch' },
>       'discriminator': 'arch',
>       'data': { 'x86': 'CpuInfoOther',
>                 'sparc': 'CpuInfoOther',
>                 'ppc': 'CpuInfoOther',
>                 'mips': 'CpuInfoOther',
>                 'tricore': 'CpuInfoOther',
>                 's390': 'CpuInfoS390',
>                 'riscv': 'CpuInfoRISCV',
>                 'other': 'CpuInfoOther' } }
> 
> In qmp_query_cpus_fast(), it can't imply anything, because can't occur.
> That's a bug, and this patch fixes it.  Except it sets @arch to "other"
> instead of "riscv" when defined(TARGET_RISCV).  Why?  Oh, I see, that
> gets fixed in the next patch.  Please explain that in your commit
> message, or squash the two patches.  The latter feels simpler, so that's
> what I'd do.

I figured I'd keep one "Fixes:" tag per patch, but I see this separation
confused at least three reviewers, so I'll squash #1 and #2, and will
list two "Fixes:" tags.

Thanks!
Laszlo
