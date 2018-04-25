Received: from eggs.gnu.org ([2001:4830:134:3::10]:49194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBE5n-0006lg-UJ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBE5j-0007m6-CJ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:39:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-2-lersek@redhat.com>
Date: Wed, 25 Apr 2018 08:39:38 +0200
In-Reply-To: <20180424214550.32549-2-lersek@redhat.com> (Laszlo Ersek's
	message of "Tue, 24 Apr 2018 23:45:45 +0200")
Message-ID: <87r2n3aixh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Laszlo Ersek <lersek@redhat.com> writes:

> Commit ca230ff33f89 added added the @arch field to @CpuInfoFast, but it
> failed to set the new field in qmp_query_cpus_fast(), when TARGET_S390X
> was not defined. The updated @query-cpus-fast example in
> "qapi-schema.json" showed "arch":"x86" only because qmp_query_cpus_fast()
> calls g_malloc0() to allocate CpuInfoFast, and the CPU_INFO_ARCH_X86 enum
> constant is generated with value 0.
>
> All @arch values other than @s390 implied the @CpuInfoOther sub-struct for
> @CpuInfoFast -- at the time of writing the patch --, thus no fields other
> than @arch needed to be set when TARGET_S390X was not defined. Set @arch
> now, by copying the corresponding assignments from qmp_query_cpus().

Now I'm confused.

In the schema, @arch "riscv" implies CpuInfoRISCV:

    { 'union': 'CpuInfoFast',
      'base': {'cpu-index': 'int', 'qom-path': 'str',
               'thread-id': 'int', '*props': 'CpuInstanceProperties',
               'arch': 'CpuInfoArch' },
      'discriminator': 'arch',
      'data': { 'x86': 'CpuInfoOther',
                'sparc': 'CpuInfoOther',
                'ppc': 'CpuInfoOther',
                'mips': 'CpuInfoOther',
                'tricore': 'CpuInfoOther',
                's390': 'CpuInfoS390',
                'riscv': 'CpuInfoRISCV',
                'other': 'CpuInfoOther' } }

In qmp_query_cpus_fast(), it can't imply anything, because can't occur.
That's a bug, and this patch fixes it.  Except it sets @arch to "other"
instead of "riscv" when defined(TARGET_RISCV).  Why?  Oh, I see, that
gets fixed in the next patch.  Please explain that in your commit
message, or squash the two patches.  The latter feels simpler, so that's
what I'd do.

>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: qemu-stable@nongnu.org
> Fixes: ca230ff33f89bf7102cbfbc2328716da6750aaed
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
