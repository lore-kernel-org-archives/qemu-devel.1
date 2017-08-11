Received: from eggs.gnu.org ([2001:4830:134:3::10]:39344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dg9YQ-0006xP-I7
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dg9YM-0001zB-Hd
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:00:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dg9YM-0001yC-3S
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:00:38 -0400
Date: Fri, 11 Aug 2017 10:00:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170811130026.GG3108@localhost.localdomain>
References: <1502417472-15511-1-git-send-email-tianyu.lan@intel.com>
	<1502418366-28289-1-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502418366-28289-1-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [Update PATCH V2] x86: Increase max vcpu number to
 8192
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, berrange@redhat.com, rkrcmar@redhat.com

On Thu, Aug 10, 2017 at 10:26:06PM -0400, Lan Tianyu wrote:
> Intel Xeon phi chip will support 352 logical threads. For HPC
> usage case, it will create a huge VM with vcpus number as same as host
> cpus. This patch is to increase max vcpu number from 288 to 8192 which
> is current default maximum cpu number for Linux kernel.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
> Change since v1:
> 	* Bump max vcpu number from 352 to 8192
> 	* Add compat support for new max vcpu limitation
> 
>  hw/i386/pc_q35.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 169a214..e093601 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -299,13 +299,21 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->default_display = "std";
>      m->no_floppy = 1;
>      m->has_dynamic_sysbus = true;
> -    m->max_cpus = 288;
> +    m->max_cpus = 8192;
>  }
>  
> +static void pc_q35_2_11_machine_options(MachineClass *m)
> +{
> +     pc_q35_machine_options(m);
> +     m->alias = "q35";
> +}
> +DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
> +                   pc_q35_2_11_machine_options);
> +
>  static void pc_q35_2_10_machine_options(MachineClass *m)
>  {
> -    pc_q35_machine_options(m);
> -    m->alias = "q35";
> +    pc_q35_2_11_machine_options(m);

You need m->alias=NULL here.

> +    m->max_cpus = 288;
>      m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
>  }
>  

Please add the pc-*-2.11 machine-types in a separate patch.  This
way we can add the new machine-types in other series/trees and
deal more easily with conflicts.

You can use commit 465238d9f873a6251223db1669aa4766822a8783
("pc: add 2.10 machine type") as reference.

-- 
Eduardo
