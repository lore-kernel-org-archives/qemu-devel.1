Received: from eggs.gnu.org ([2001:4830:134:3::10]:33565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gSLIx-0004XN-Vj
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gSLIq-000164-RI
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:20:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gSLIq-0000wu-Fh
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:20:20 -0500
Date: Thu, 29 Nov 2018 12:20:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181129121959.GC2333@work-vm>
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-9-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126200435.23408-9-minyard@acm.org>
Subject: Re: [Qemu-devel] [PATCH v3 08/16] boards.h: Ignore migration for
 SMBus devices on older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

* minyard@acm.org (minyard@acm.org) wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Migration capability is being added for pm_smbus and SMBus devices.
> This change will allow backwards compatibility to be kept when
> migrating back to an old qemu version.  Add a bool to the machine
> class tho keep smbus migration from happening.  Future changes
> will use this.

Still needs the 3.0 and 3.1, but other than that:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>  hw/i386/pc_piix.c   | 1 +
>  hw/i386/pc_q35.c    | 1 +
>  include/hw/boards.h | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index cb28227cc3..3d1ccb1af1 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -443,6 +443,7 @@ static void pc_i440fx_2_12_machine_options(MachineClass *m)
>      pc_i440fx_3_0_machine_options(m);
>      m->is_default = 0;
>      m->alias = NULL;
> +    m->smbus_no_migration_support = true;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
>  }
>  
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 90e88c9b28..0c6fca6a40 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -324,6 +324,7 @@ static void pc_q35_2_12_machine_options(MachineClass *m)
>  {
>      pc_q35_3_0_machine_options(m);
>      m->alias = NULL;
> +    m->smbus_no_migration_support = true;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
>  }
>  
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index f82f28468b..65314fbe2a 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -207,6 +207,7 @@ struct MachineClass {
>      void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
>                                   int nb_nodes, ram_addr_t size);
>      bool ignore_boot_device_suffixes;
> +    bool smbus_no_migration_support;
>  
>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                             DeviceState *dev);
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
