Received: from eggs.gnu.org ([2001:4830:134:3::10]:55122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etWUy-0006Y0-UZ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etWUv-0006aU-OT
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:40:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43502 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1etWUv-0006aQ-Hi
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:40:37 -0500
Date: Wed, 7 Mar 2018 11:40:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180307114019.0a9917f1@redhat.com>
In-Reply-To: <20180305065710.25876-5-haozhong.zhang@intel.com>
References: <20180305065710.25876-1-haozhong.zhang@intel.com>
	<20180305065710.25876-5-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] tests/bios-tables-test: allow
 setting extra machine options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On Mon,  5 Mar 2018 14:57:09 +0800
Haozhong Zhang <haozhong.zhang@intel.com> wrote:

> Some test cases may require extra machine options than those used in
> the current test_acpi_ones(), e.g., nvdimm test cases require the
> machine option 'nvdimm=on'.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  tests/bios-tables-test.c | 45 +++++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 65b271a173..d45181aa51 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -654,17 +654,22 @@ static void test_smbios_structs(test_data *data)
>      }
>  }
>  
> -static void test_acpi_one(const char *params, test_data *data)
> +static void test_acpi_one(const char *extra_machine_opts,
> +                          const char *params, test_data *data)
>  {
>      char *args;
>  
>      /* Disable kernel irqchip to be able to override apic irq0. */
> -    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
> +    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off",
> +                           data->machine, "kvm:tcg");
> +    if (extra_machine_opts) {
> +        args = g_strdup_printf("%s,%s", args, extra_machine_opts);
> +    }
> +    args = g_strdup_printf("%s "
wouldn't 2nd and the rest of "args = g_strdup_printf", leak memory?

btw you don't really need this patch, you can just add
 "-machine nvdimm=on" to params argument at call site.
it's allowed to have several -FOO options on CLI, since
they are merged together and applied to machine object in QEMU.


>                             "-net none -display none %s "
>                             "-drive id=hd0,if=none,file=%s,format=raw "
>                             "-device ide-hd,drive=hd0 ",
> -                           data->machine, "kvm:tcg",
> -                           params ? params : "", disk);
> +                           args, params ? params : "", disk);
>  
>      qtest_start(args);
>  
> @@ -711,7 +716,7 @@ static void test_acpi_piix4_tcg(void)
>      data.machine = MACHINE_PC;
>      data.required_struct_types = base_required_struct_types;
>      data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> -    test_acpi_one(NULL, &data);
> +    test_acpi_one(NULL, NULL, &data);
>      free_test_data(&data);
>  }
>  
> @@ -724,7 +729,7 @@ static void test_acpi_piix4_tcg_bridge(void)
>      data.variant = ".bridge";
>      data.required_struct_types = base_required_struct_types;
>      data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> -    test_acpi_one("-device pci-bridge,chassis_nr=1", &data);
> +    test_acpi_one(NULL, "-device pci-bridge,chassis_nr=1", &data);
>      free_test_data(&data);
>  }
>  
> @@ -736,7 +741,7 @@ static void test_acpi_q35_tcg(void)
>      data.machine = MACHINE_Q35;
>      data.required_struct_types = base_required_struct_types;
>      data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> -    test_acpi_one(NULL, &data);
> +    test_acpi_one(NULL, NULL, &data);
>      free_test_data(&data);
>  }
>  
> @@ -749,7 +754,7 @@ static void test_acpi_q35_tcg_bridge(void)
>      data.variant = ".bridge";
>      data.required_struct_types = base_required_struct_types;
>      data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> -    test_acpi_one("-device pci-bridge,chassis_nr=1",
> +    test_acpi_one(NULL, "-device pci-bridge,chassis_nr=1",
>                    &data);
>      free_test_data(&data);
>  }
> @@ -761,7 +766,8 @@ static void test_acpi_piix4_tcg_cphp(void)
>      memset(&data, 0, sizeof(data));
>      data.machine = MACHINE_PC;
>      data.variant = ".cphp";
> -    test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
> +    test_acpi_one(NULL,
> +                  "-smp 2,cores=3,sockets=2,maxcpus=6"
>                    " -numa node -numa node"
>                    " -numa dist,src=0,dst=1,val=21",
>                    &data);
> @@ -775,7 +781,8 @@ static void test_acpi_q35_tcg_cphp(void)
>      memset(&data, 0, sizeof(data));
>      data.machine = MACHINE_Q35;
>      data.variant = ".cphp";
> -    test_acpi_one(" -smp 2,cores=3,sockets=2,maxcpus=6"
> +    test_acpi_one(NULL,
> +                  " -smp 2,cores=3,sockets=2,maxcpus=6"
>                    " -numa node -numa node"
>                    " -numa dist,src=0,dst=1,val=21",
>                    &data);
> @@ -795,7 +802,8 @@ static void test_acpi_q35_tcg_ipmi(void)
>      data.variant = ".ipmibt";
>      data.required_struct_types = ipmi_required_struct_types;
>      data.required_struct_types_len = ARRAY_SIZE(ipmi_required_struct_types);
> -    test_acpi_one("-device ipmi-bmc-sim,id=bmc0"
> +    test_acpi_one(NULL,
> +                  "-device ipmi-bmc-sim,id=bmc0"
>                    " -device isa-ipmi-bt,bmc=bmc0",
>                    &data);
>      free_test_data(&data);
> @@ -813,7 +821,8 @@ static void test_acpi_piix4_tcg_ipmi(void)
>      data.variant = ".ipmikcs";
>      data.required_struct_types = ipmi_required_struct_types;
>      data.required_struct_types_len = ARRAY_SIZE(ipmi_required_struct_types);
> -    test_acpi_one("-device ipmi-bmc-sim,id=bmc0"
> +    test_acpi_one(NULL,
> +                  "-device ipmi-bmc-sim,id=bmc0"
>                    " -device isa-ipmi-kcs,irq=0,bmc=bmc0",
>                    &data);
>      free_test_data(&data);
> @@ -826,7 +835,8 @@ static void test_acpi_q35_tcg_memhp(void)
>      memset(&data, 0, sizeof(data));
>      data.machine = MACHINE_Q35;
>      data.variant = ".memhp";
> -    test_acpi_one(" -m 128,slots=3,maxmem=1G"
> +    test_acpi_one(NULL,
> +                  " -m 128,slots=3,maxmem=1G"
>                    " -numa node -numa node"
>                    " -numa dist,src=0,dst=1,val=21",
>                    &data);
> @@ -840,7 +850,8 @@ static void test_acpi_piix4_tcg_memhp(void)
>      memset(&data, 0, sizeof(data));
>      data.machine = MACHINE_PC;
>      data.variant = ".memhp";
> -    test_acpi_one(" -m 128,slots=3,maxmem=1G"
> +    test_acpi_one(NULL,
> +                  " -m 128,slots=3,maxmem=1G"
>                    " -numa node -numa node"
>                    " -numa dist,src=0,dst=1,val=21",
>                    &data);
> @@ -854,7 +865,8 @@ static void test_acpi_q35_tcg_numamem(void)
>      memset(&data, 0, sizeof(data));
>      data.machine = MACHINE_Q35;
>      data.variant = ".numamem";
> -    test_acpi_one(" -numa node -numa node,mem=128", &data);
> +    test_acpi_one(NULL,
> +                  " -numa node -numa node,mem=128", &data);
>      free_test_data(&data);
>  }
>  
> @@ -865,7 +877,8 @@ static void test_acpi_piix4_tcg_numamem(void)
>      memset(&data, 0, sizeof(data));
>      data.machine = MACHINE_PC;
>      data.variant = ".numamem";
> -    test_acpi_one(" -numa node -numa node,mem=128", &data);
> +    test_acpi_one(NULL,
> +                  " -numa node -numa node,mem=128", &data);
>      free_test_data(&data);
>  }
>  
