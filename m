Received: from eggs.gnu.org ([2001:4830:134:3::10]:54889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGMUP-0000Zj-9X
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGMUM-0003ro-3d
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:33:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dGMUL-0003qt-QJ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:33:54 -0400
References: <8550033a-3ab0-4fdc-0138-8a3300f29dcc@lauterbach.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <194b0f32-a11a-5527-3d71-cd58a85b5712@redhat.com>
Date: Thu, 1 Jun 2017 11:33:47 +0200
MIME-Version: 1.0
In-Reply-To: <8550033a-3ab0-4fdc-0138-8a3300f29dcc@lauterbach.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-x86: Add GDB XML description for
 SSE registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>, qemu-devel@nongnu.org
Cc: Khaled Jmal <khaled.jmal@lauterbach.com>, rth@twiddle.net, ehabkost@redhat.com



On 31/05/2017 18:00, Abdallah Bouassida wrote:
> [Qemu-devel] [PATCH] target-x86: Add GDB XML description for SSE registers
> 
> Add an XML description for SSE registers (XMM+MXCSR) for both X86
> and X86-64 architectures in the GDB stub:
> - configure: Define gdb_xml_files for the X86 targets (32 and 64bit).
> - gdb-xml/i386-32bit-sse.xml & gdb-xml/i386-64bit-sse.xml: The XML files
> that contain a description of the XMM + MXCSR registers.
> - gdb-xml/i386-32bit.xml & gdb-xml/i386-64bit.xml: wrappers that include
> the XML file of the core registers and the other XML file of the SSE
> registers.
> - target/i386/cpu.c: Modify the gdb_core_xml_file to the new XML wrapper,
>   modify the gdb_num_core_regs to fit the registers number defined in each
>   XML file.
> 
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---
> @Paolo: This patch is in response to your hints here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg03314.html
> Thank you for pointing me on the missing registers!

Thanks, looks good!

Paolo

> 
>  configure                  |  4 ++--
>  gdb-xml/i386-32bit-sse.xml | 52 ++++++++++++++++++++++++++++++++++++++++
>  gdb-xml/i386-32bit.xml     | 14 +++++++++++
>  gdb-xml/i386-64bit-sse.xml | 60
> ++++++++++++++++++++++++++++++++++++++++++++++
>  gdb-xml/i386-64bit.xml     | 14 +++++++++++
>  target/i386/cpu.c          |  8 +++----
>  6 files changed, 146 insertions(+), 6 deletions(-)
>  create mode 100644 gdb-xml/i386-32bit-sse.xml
>  create mode 100644 gdb-xml/i386-32bit.xml
>  create mode 100644 gdb-xml/i386-64bit-sse.xml
>  create mode 100644 gdb-xml/i386-64bit.xml
> 
> diff --git a/configure b/configure
> index 1a5ee4b..d4f154d 100755
> --- a/configure
> +++ b/configure
> @@ -6044,11 +6044,11 @@ TARGET_ABI_DIR=""
>  
>  case "$target_name" in
>    i386)
> -    gdb_xml_files="i386-32bit-core.xml"
> +    gdb_xml_files="i386-32bit.xml i386-32bit-core.xml i386-32bit-sse.xml"
>    ;;
>    x86_64)
>      TARGET_BASE_ARCH=i386
> -    gdb_xml_files="i386-64bit-core.xml"
> +    gdb_xml_files="i386-64bit.xml i386-64bit-core.xml i386-64bit-sse.xml"
>    ;;
>    alpha)
>      mttcg="yes"
> diff --git a/gdb-xml/i386-32bit-sse.xml b/gdb-xml/i386-32bit-sse.xml
> new file mode 100644
> index 0000000..5767847
> --- /dev/null
> +++ b/gdb-xml/i386-32bit-sse.xml
> @@ -0,0 +1,52 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2010-2017 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.i386.32bit.sse">
> +  <vector id="v4f" type="ieee_single" count="4"/>
> +  <vector id="v2d" type="ieee_double" count="2"/>
> +  <vector id="v16i8" type="int8" count="16"/>
> +  <vector id="v8i16" type="int16" count="8"/>
> +  <vector id="v4i32" type="int32" count="4"/>
> +  <vector id="v2i64" type="int64" count="2"/>
> +  <union id="vec128">
> +    <field name="v4_float" type="v4f"/>
> +    <field name="v2_double" type="v2d"/>
> +    <field name="v16_int8" type="v16i8"/>
> +    <field name="v8_int16" type="v8i16"/>
> +    <field name="v4_int32" type="v4i32"/>
> +    <field name="v2_int64" type="v2i64"/>
> +    <field name="uint128" type="uint128"/>
> +  </union>
> +  <flags id="i386_mxcsr" size="4">
> +    <field name="IE" start="0" end="0"/>
> +    <field name="DE" start="1" end="1"/>
> +    <field name="ZE" start="2" end="2"/>
> +    <field name="OE" start="3" end="3"/>
> +    <field name="UE" start="4" end="4"/>
> +    <field name="PE" start="5" end="5"/>
> +    <field name="DAZ" start="6" end="6"/>
> +    <field name="IM" start="7" end="7"/>
> +    <field name="DM" start="8" end="8"/>
> +    <field name="ZM" start="9" end="9"/>
> +    <field name="OM" start="10" end="10"/>
> +    <field name="UM" start="11" end="11"/>
> +    <field name="PM" start="12" end="12"/>
> +    <field name="FZ" start="15" end="15"/>
> +  </flags>
> +
> +  <reg name="xmm0" bitsize="128" type="vec128" regnum="32"/>
> +  <reg name="xmm1" bitsize="128" type="vec128"/>
> +  <reg name="xmm2" bitsize="128" type="vec128"/>
> +  <reg name="xmm3" bitsize="128" type="vec128"/>
> +  <reg name="xmm4" bitsize="128" type="vec128"/>
> +  <reg name="xmm5" bitsize="128" type="vec128"/>
> +  <reg name="xmm6" bitsize="128" type="vec128"/>
> +  <reg name="xmm7" bitsize="128" type="vec128"/>
> +
> +  <reg name="mxcsr" bitsize="32" type="i386_mxcsr" group="vector"/>
> +</feature>
> diff --git a/gdb-xml/i386-32bit.xml b/gdb-xml/i386-32bit.xml
> new file mode 100644
> index 0000000..956fc7f
> --- /dev/null
> +++ b/gdb-xml/i386-32bit.xml
> @@ -0,0 +1,14 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2010-2017 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!-- I386 with SSE -->
> +
> +<!DOCTYPE target SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.i386.32bit">
> +  <xi:include href="i386-32bit-core.xml"/>
> +  <xi:include href="i386-32bit-sse.xml"/>
> +</feature>
> diff --git a/gdb-xml/i386-64bit-sse.xml b/gdb-xml/i386-64bit-sse.xml
> new file mode 100644
> index 0000000..e86efc9
> --- /dev/null
> +++ b/gdb-xml/i386-64bit-sse.xml
> @@ -0,0 +1,60 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2010-2017 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.i386.64bit.sse">
> +  <vector id="v4f" type="ieee_single" count="4"/>
> +  <vector id="v2d" type="ieee_double" count="2"/>
> +  <vector id="v16i8" type="int8" count="16"/>
> +  <vector id="v8i16" type="int16" count="8"/>
> +  <vector id="v4i32" type="int32" count="4"/>
> +  <vector id="v2i64" type="int64" count="2"/>
> +  <union id="vec128">
> +    <field name="v4_float" type="v4f"/>
> +    <field name="v2_double" type="v2d"/>
> +    <field name="v16_int8" type="v16i8"/>
> +    <field name="v8_int16" type="v8i16"/>
> +    <field name="v4_int32" type="v4i32"/>
> +    <field name="v2_int64" type="v2i64"/>
> +    <field name="uint128" type="uint128"/>
> +  </union>
> +  <flags id="i386_mxcsr" size="4">
> +    <field name="IE" start="0" end="0"/>
> +    <field name="DE" start="1" end="1"/>
> +    <field name="ZE" start="2" end="2"/>
> +    <field name="OE" start="3" end="3"/>
> +    <field name="UE" start="4" end="4"/>
> +    <field name="PE" start="5" end="5"/>
> +    <field name="DAZ" start="6" end="6"/>
> +    <field name="IM" start="7" end="7"/>
> +    <field name="DM" start="8" end="8"/>
> +    <field name="ZM" start="9" end="9"/>
> +    <field name="OM" start="10" end="10"/>
> +    <field name="UM" start="11" end="11"/>
> +    <field name="PM" start="12" end="12"/>
> +    <field name="FZ" start="15" end="15"/>
> +  </flags>
> +
> +  <reg name="xmm0" bitsize="128" type="vec128" regnum="40"/>
> +  <reg name="xmm1" bitsize="128" type="vec128"/>
> +  <reg name="xmm2" bitsize="128" type="vec128"/>
> +  <reg name="xmm3" bitsize="128" type="vec128"/>
> +  <reg name="xmm4" bitsize="128" type="vec128"/>
> +  <reg name="xmm5" bitsize="128" type="vec128"/>
> +  <reg name="xmm6" bitsize="128" type="vec128"/>
> +  <reg name="xmm7" bitsize="128" type="vec128"/>
> +  <reg name="xmm8" bitsize="128" type="vec128"/>
> +  <reg name="xmm9" bitsize="128" type="vec128"/>
> +  <reg name="xmm10" bitsize="128" type="vec128"/>
> +  <reg name="xmm11" bitsize="128" type="vec128"/>
> +  <reg name="xmm12" bitsize="128" type="vec128"/>
> +  <reg name="xmm13" bitsize="128" type="vec128"/>
> +  <reg name="xmm14" bitsize="128" type="vec128"/>
> +  <reg name="xmm15" bitsize="128" type="vec128"/>
> +
> +  <reg name="mxcsr" bitsize="32" type="i386_mxcsr" group="vector"/>
> +</feature>
> diff --git a/gdb-xml/i386-64bit.xml b/gdb-xml/i386-64bit.xml
> new file mode 100644
> index 0000000..0b2f00c
> --- /dev/null
> +++ b/gdb-xml/i386-64bit.xml
> @@ -0,0 +1,14 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2010-2017 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!-- I386 64bit -->
> +
> +<!DOCTYPE target SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.i386.64bit">
> +  <xi:include href="i386-64bit-core.xml"/>
> +  <xi:include href="i386-64bit-sse.xml"/>
> +</feature>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a41d595..2e2661b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4063,11 +4063,11 @@ static void
> x86_cpu_common_class_init(ObjectClass *oc, void *data)
>  #endif
>      cc->gdb_arch_name = x86_gdb_arch_name;
>  #ifdef TARGET_X86_64
> -    cc->gdb_core_xml_file = "i386-64bit-core.xml";
> -    cc->gdb_num_core_regs = 40;
> +    cc->gdb_core_xml_file = "i386-64bit.xml";
> +    cc->gdb_num_core_regs = 57;
>  #else
> -    cc->gdb_core_xml_file = "i386-32bit-core.xml";
> -    cc->gdb_num_core_regs = 32;
> +    cc->gdb_core_xml_file = "i386-32bit.xml";
> +    cc->gdb_num_core_regs = 41;
>  #endif
>  #ifndef CONFIG_USER_ONLY
>      cc->debug_excp_handler = breakpoint_handler;
> -- 
> 1.9.1
