Received: from eggs.gnu.org ([2001:4830:134:3::10]:55930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1coV3K-0002ix-FY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1coV3G-0001ZT-Ds
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:02:50 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:49396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1coV3G-0001Uz-1g
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:02:46 -0400
References: <2b3c8119-1602-28c7-eab4-296593877103@lauterbach.com>
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Message-ID: <099222b0-dc53-9428-ed1c-48ad497464aa@lauterbach.com>
Date: Thu, 16 Mar 2017 14:02:27 +0100
MIME-Version: 1.0
In-Reply-To: <2b3c8119-1602-28c7-eab4-296593877103@lauterbach.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target-x86:Add GDB XML register
 description support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Khaled Jmal <khaled.jmal@lauterbach.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

ping
http://patchwork.ozlabs.org/patch/709408/

Le 12/28/2016 à 5:34 PM, Abdallah Bouassida a écrit :
> [Qemu-devel] [PATCH] target-x86:Add GDB XML register description support
>
> This patch implements XML target description support for X86 and X86-64
> architectures in the GDB stub, as the way with ARM and PowerPC:
> - gdb-xml/32bit-core.xml & gdb-xml/64bit-core.xml: Adding the XML target
>   description files, these files are picked from GDB source code.
> - configure: Define gdb_xml_files for X86 targets.
> - target/i386/cpu.c: Define gdb_core_xml_file and gdb_arch_name to add
>   XML awareness for this architecture, modify the gdb_num_core_regs to
>   fit the registers number defined in each XML file.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---
>  configure              |  2 ++
>  gdb-xml/32bit-core.xml | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  gdb-xml/64bit-core.xml | 73 
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/cpu.c      | 21 ++++++++++++---
>  4 files changed, 157 insertions(+), 4 deletions(-)
>  create mode 100644 gdb-xml/32bit-core.xml
>  create mode 100644 gdb-xml/64bit-core.xml
>
> diff --git a/configure b/configure
> index 218df87..b701d1e 100755
> --- a/configure
> +++ b/configure
> @@ -5890,9 +5890,11 @@ TARGET_ABI_DIR=""
>
>  case "$target_name" in
>    i386)
> +    gdb_xml_files="32bit-core.xml"
>    ;;
>    x86_64)
>      TARGET_BASE_ARCH=i386
> +    gdb_xml_files="64bit-core.xml"
>    ;;
>    alpha)
>    ;;
> diff --git a/gdb-xml/32bit-core.xml b/gdb-xml/32bit-core.xml
> new file mode 100644
> index 0000000..7aeeeca
> --- /dev/null
> +++ b/gdb-xml/32bit-core.xml
> @@ -0,0 +1,65 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2010-2015 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without 
> modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.i386.core">
> +  <flags id="i386_eflags" size="4">
> +    <field name="CF" start="0" end="0"/>
> +    <field name="" start="1" end="1"/>
> +    <field name="PF" start="2" end="2"/>
> +    <field name="AF" start="4" end="4"/>
> +    <field name="ZF" start="6" end="6"/>
> +    <field name="SF" start="7" end="7"/>
> +    <field name="TF" start="8" end="8"/>
> +    <field name="IF" start="9" end="9"/>
> +    <field name="DF" start="10" end="10"/>
> +    <field name="OF" start="11" end="11"/>
> +    <field name="NT" start="14" end="14"/>
> +    <field name="RF" start="16" end="16"/>
> +    <field name="VM" start="17" end="17"/>
> +    <field name="AC" start="18" end="18"/>
> +    <field name="VIF" start="19" end="19"/>
> +    <field name="VIP" start="20" end="20"/>
> +    <field name="ID" start="21" end="21"/>
> +  </flags>
> +
> +  <reg name="eax" bitsize="32" type="int32"/>
> +  <reg name="ecx" bitsize="32" type="int32"/>
> +  <reg name="edx" bitsize="32" type="int32"/>
> +  <reg name="ebx" bitsize="32" type="int32"/>
> +  <reg name="esp" bitsize="32" type="data_ptr"/>
> +  <reg name="ebp" bitsize="32" type="data_ptr"/>
> +  <reg name="esi" bitsize="32" type="int32"/>
> +  <reg name="edi" bitsize="32" type="int32"/>
> +
> +  <reg name="eip" bitsize="32" type="code_ptr"/>
> +  <reg name="eflags" bitsize="32" type="i386_eflags"/>
> +  <reg name="cs" bitsize="32" type="int32"/>
> +  <reg name="ss" bitsize="32" type="int32"/>
> +  <reg name="ds" bitsize="32" type="int32"/>
> +  <reg name="es" bitsize="32" type="int32"/>
> +  <reg name="fs" bitsize="32" type="int32"/>
> +  <reg name="gs" bitsize="32" type="int32"/>
> +
> +  <reg name="st0" bitsize="80" type="i387_ext"/>
> +  <reg name="st1" bitsize="80" type="i387_ext"/>
> +  <reg name="st2" bitsize="80" type="i387_ext"/>
> +  <reg name="st3" bitsize="80" type="i387_ext"/>
> +  <reg name="st4" bitsize="80" type="i387_ext"/>
> +  <reg name="st5" bitsize="80" type="i387_ext"/>
> +  <reg name="st6" bitsize="80" type="i387_ext"/>
> +  <reg name="st7" bitsize="80" type="i387_ext"/>
> +
> +  <reg name="fctrl" bitsize="32" type="int" group="float"/>
> +  <reg name="fstat" bitsize="32" type="int" group="float"/>
> +  <reg name="ftag" bitsize="32" type="int" group="float"/>
> +  <reg name="fiseg" bitsize="32" type="int" group="float"/>
> +  <reg name="fioff" bitsize="32" type="int" group="float"/>
> +  <reg name="foseg" bitsize="32" type="int" group="float"/>
> +  <reg name="fooff" bitsize="32" type="int" group="float"/>
> +  <reg name="fop" bitsize="32" type="int" group="float"/>
> +</feature>
> diff --git a/gdb-xml/64bit-core.xml b/gdb-xml/64bit-core.xml
> new file mode 100644
> index 0000000..5088d84
> --- /dev/null
> +++ b/gdb-xml/64bit-core.xml
> @@ -0,0 +1,73 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2010-2015 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without 
> modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.i386.core">
> +  <flags id="i386_eflags" size="4">
> +    <field name="CF" start="0" end="0"/>
> +    <field name="" start="1" end="1"/>
> +    <field name="PF" start="2" end="2"/>
> +    <field name="AF" start="4" end="4"/>
> +    <field name="ZF" start="6" end="6"/>
> +    <field name="SF" start="7" end="7"/>
> +    <field name="TF" start="8" end="8"/>
> +    <field name="IF" start="9" end="9"/>
> +    <field name="DF" start="10" end="10"/>
> +    <field name="OF" start="11" end="11"/>
> +    <field name="NT" start="14" end="14"/>
> +    <field name="RF" start="16" end="16"/>
> +    <field name="VM" start="17" end="17"/>
> +    <field name="AC" start="18" end="18"/>
> +    <field name="VIF" start="19" end="19"/>
> +    <field name="VIP" start="20" end="20"/>
> +    <field name="ID" start="21" end="21"/>
> +  </flags>
> +
> +  <reg name="rax" bitsize="64" type="int64"/>
> +  <reg name="rbx" bitsize="64" type="int64"/>
> +  <reg name="rcx" bitsize="64" type="int64"/>
> +  <reg name="rdx" bitsize="64" type="int64"/>
> +  <reg name="rsi" bitsize="64" type="int64"/>
> +  <reg name="rdi" bitsize="64" type="int64"/>
> +  <reg name="rbp" bitsize="64" type="data_ptr"/>
> +  <reg name="rsp" bitsize="64" type="data_ptr"/>
> +  <reg name="r8" bitsize="64" type="int64"/>
> +  <reg name="r9" bitsize="64" type="int64"/>
> +  <reg name="r10" bitsize="64" type="int64"/>
> +  <reg name="r11" bitsize="64" type="int64"/>
> +  <reg name="r12" bitsize="64" type="int64"/>
> +  <reg name="r13" bitsize="64" type="int64"/>
> +  <reg name="r14" bitsize="64" type="int64"/>
> +  <reg name="r15" bitsize="64" type="int64"/>
> +
> +  <reg name="rip" bitsize="64" type="code_ptr"/>
> +  <reg name="eflags" bitsize="32" type="i386_eflags"/>
> +  <reg name="cs" bitsize="32" type="int32"/>
> +  <reg name="ss" bitsize="32" type="int32"/>
> +  <reg name="ds" bitsize="32" type="int32"/>
> +  <reg name="es" bitsize="32" type="int32"/>
> +  <reg name="fs" bitsize="32" type="int32"/>
> +  <reg name="gs" bitsize="32" type="int32"/>
> +
> +  <reg name="st0" bitsize="80" type="i387_ext"/>
> +  <reg name="st1" bitsize="80" type="i387_ext"/>
> +  <reg name="st2" bitsize="80" type="i387_ext"/>
> +  <reg name="st3" bitsize="80" type="i387_ext"/>
> +  <reg name="st4" bitsize="80" type="i387_ext"/>
> +  <reg name="st5" bitsize="80" type="i387_ext"/>
> +  <reg name="st6" bitsize="80" type="i387_ext"/>
> +  <reg name="st7" bitsize="80" type="i387_ext"/>
> +
> +  <reg name="fctrl" bitsize="32" type="int" group="float"/>
> +  <reg name="fstat" bitsize="32" type="int" group="float"/>
> +  <reg name="ftag" bitsize="32" type="int" group="float"/>
> +  <reg name="fiseg" bitsize="32" type="int" group="float"/>
> +  <reg name="fioff" bitsize="32" type="int" group="float"/>
> +  <reg name="foseg" bitsize="32" type="int" group="float"/>
> +  <reg name="fooff" bitsize="32" type="int" group="float"/>
> +  <reg name="fop" bitsize="32" type="int" group="float"/>
> +</feature>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b0640f1..d712e8b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2371,6 +2371,15 @@ static void x86_cpu_load_def(X86CPU *cpu, 
> X86CPUDefinition *def, Error **errp)
>
>  }
>
> +static gchar *x86_gdb_arch_name(CPUState *cs)
> +{
> +#ifdef TARGET_X86_64
> +    return g_strdup("i386:x86-64");
> +#else
> +    return g_strdup("i386");
> +#endif
> +}
> +
>  X86CPU *cpu_x86_init(const char *cpu_model)
>  {
>      return X86_CPU(cpu_generic_init(TYPE_X86_CPU, cpu_model));
> @@ -3720,10 +3729,14 @@ static void 
> x86_cpu_common_class_init(ObjectClass *oc, void *data)
>      cc->write_elf32_qemunote = x86_cpu_write_elf32_qemunote;
>      cc->vmsd = &vmstate_x86_cpu;
>  #endif
> -    /* CPU_NB_REGS * 2 = general regs + xmm regs
> -     * 25 = eip, eflags, 6 seg regs, st[0-7], fctrl,...,fop, mxcsr.
> -     */
> -    cc->gdb_num_core_regs = CPU_NB_REGS * 2 + 25;
> +    cc->gdb_arch_name = x86_gdb_arch_name;
> +#ifdef TARGET_X86_64
> +    cc->gdb_core_xml_file = "64bit-core.xml";
> +    cc->gdb_num_core_regs = 40;
> +#else
> +    cc->gdb_core_xml_file = "32bit-core.xml";
> +    cc->gdb_num_core_regs = 32;
> +#endif
>  #ifndef CONFIG_USER_ONLY
>      cc->debug_excp_handler = breakpoint_handler;
>  #endif
