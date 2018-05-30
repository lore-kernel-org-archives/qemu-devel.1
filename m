Received: from eggs.gnu.org ([2001:4830:134:3::10]:46748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fNy4v-0007V9-Rx
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fNy4s-0008Nh-MB
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:11:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44450 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fNy4s-0008NL-H0
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:11:34 -0400
Date: Wed, 30 May 2018 12:11:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180530121131.17c8bee0@redhat.com>
In-Reply-To: <20180522104000.9044-3-peter.maydell@linaro.org>
References: <20180522104000.9044-1-peter.maydell@linaro.org>
	<20180522104000.9044-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/i386: Rename 2.13 machine types to
 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, guangrong.xiao@linux.intel.com, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 22 May 2018 11:39:57 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> Rename the 2.13 machine types to match what we're going to
> use as our next release number.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
[...]
q35 hunk of this patch for no apparent reasons causes
change of the NVDIMM's DSM page allocated by Seabios.

@ -5,13 +5,13 @@
  * 
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/acpi-test-data/q35/SSDT.dimmpxm, Wed May 30 11:20:51 2018
+ * Disassembly of /tmp/aml-3XMAJZ, Wed May 30 11:20:51 2018
  *
  * Original Table Header:
  *     Signature        "SSDT"
  *     Length           0x000002AD (685)
  *     Revision         0x01
- *     Checksum         0x50
+ *     Checksum         0x40
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "NVDIMM"
  *     OEM Revision     0x00000001 (1)
@@ -183,6 +183,6 @@ DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
         }
     }
 
-    Name (MEMA, 0x07FFE000)
+    Name (MEMA, 0x07FFF000)
 }

As far as I see it should safe wrt NVDIMMs,
but the question is what in this commit forced Seabios
to change allocated address?

Offending commit aa78a16d86:
Testcase to reproduce:
 QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/bios-tables-test

CLI to reproduce manually:
x86_64-softmmu/qemu-system-x86_64 -M q35 -machine nvdimm=on -smp 4,sockets=4  -m 128M,slots=3,maxmem=1G  -numa node,mem=32M,nodeid=0  -numa node,mem=32M,nodeid=1  -numa node,mem=32M,nodeid=2 -numa node,mem=32M,nodeid=3 -numa cpu,node-id=0,socket-id=0 -numa cpu,node-id=1,socket-id=1 -numa cpu,node-id=2,socket-id=2 -numa cpu,node-id=3,socket-id=3 -object memory-backend-ram,id=ram0,size=128M -object memory-backend-ram,id=nvm0,size=128M -device pc-dimm,id=dimm0,memdev=ram0,node=1  -device nvdimm,id=dimm1,memdev=nvm0,node=2 

> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 2372457c6a..83d6d75efa 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -308,18 +308,18 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->max_cpus = 288;
>  }
>  
> -static void pc_q35_2_13_machine_options(MachineClass *m)
> +static void pc_q35_3_0_machine_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>      m->alias = "q35";
>  }
>  
> -DEFINE_Q35_MACHINE(v2_13, "pc-q35-2.13", NULL,
> -                    pc_q35_2_13_machine_options);
> +DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
> +                    pc_q35_3_0_machine_options);
>  
>  static void pc_q35_2_12_machine_options(MachineClass *m)
>  {
> -    pc_q35_2_13_machine_options(m);
> +    pc_q35_3_0_machine_options(m);
>      m->alias = NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
>  }
