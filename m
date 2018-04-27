Received: from eggs.gnu.org ([2001:4830:134:3::10]:56710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBxeI-000818-10
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBxeE-0004uQ-RJ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:18:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180426183404.3756-1-lersek@redhat.com>
	<20180426183404.3756-2-lersek@redhat.com>
Date: Fri, 27 Apr 2018 09:18:17 +0200
In-Reply-To: <20180426183404.3756-2-lersek@redhat.com> (Laszlo Ersek's message
	of "Thu, 26 Apr 2018 20:34:01 +0200")
Message-ID: <877eotungm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qapi: fill in CpuInfoFast.arch in
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
Cc: qemu devel list <qemu-devel@nongnu.org>, qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>

Laszlo Ersek <lersek@redhat.com> writes:

> * Commit ca230ff33f89 added the @arch field to @CpuInfoFast, but it failed
>   to set the new field in qmp_query_cpus_fast(), when TARGET_S390X was not
>   defined. The updated @query-cpus-fast example in "qapi-schema.json"
>   showed "arch":"x86" only because qmp_query_cpus_fast() calls g_malloc0()
>   to allocate @CpuInfoFast, and the CPU_INFO_ARCH_X86 enum constant is
>   generated with value 0.
>
>   All @arch values other than @s390 implied the @CpuInfoOther sub-struct
>   for @CpuInfoFast -- at the time of writing the patch --, thus no fields
>   other than @arch needed to be set when TARGET_S390X was not defined. Set
>   @arch now, by copying the corresponding assignments from
>   qmp_query_cpus().
>
> * Commit 25fa194b7b11 added the @riscv enum constant to @CpuInfoArch (used
>   in both @CpuInfo and @CpuInfoFast -- the return types of the @query-cpus
>   and @query-cpus-fast commands, respectively), and assigned, in both
>   return structures, the @CpuInfoRISCV sub-structure to the new enum
>   value.
>
>   However, qmp_query_cpus_fast() would not populate either the @arch field
>   or the @CpuInfoRISCV sub-structure, when TARGET_RISCV was defined; only
>   qmp_query_cpus() would.
>
>   Assign @CpuInfoOther to the @riscv enum constant in @CpuInfoFast, and
>   populate only the @arch field in qmp_query_cpus_fast(). Getting CPU
>   state without interrupting KVM is an exceptional thing that only S390X
>   does currently. Quoting Cornelia Huck <cohuck@redhat.com>, "s390x is
>   exceptional in that it has state in QEMU that is actually interesting
>   for upper layers and can be retrieved without performance penalty". See
>   also
>   <https://www.redhat.com/archives/libvir-list/2018-February/msg00121.html>.
>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Cc: qemu-stable@nongnu.org
> Fixes: ca230ff33f89bf7102cbfbc2328716da6750aaed
> Fixes: 25fa194b7b11901561532e435beb83d046899f7a
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
