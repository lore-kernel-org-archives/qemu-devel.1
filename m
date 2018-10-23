Received: from eggs.gnu.org ([2001:4830:134:3::10]:37326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF58F-0000BL-3A
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF58B-0007q4-Ra
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:26:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gF58B-0007p2-I3
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:26:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so3389779wrt.2
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 15:26:31 -0700 (PDT)
References: <20181022183656.4902-1-sameo@linux.intel.com>
	<20181022183656.4902-19-sameo@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91940d43-d478-e694-0902-e958d54d8d29@redhat.com>
Date: Wed, 24 Oct 2018 00:26:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181022183656.4902-19-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/26] hw: acpi: Initial hardware-reduced
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 22/10/2018 20:36, Samuel Ortiz wrote:
> +
> +static void acpi_reduced_build_update(void *build_opaque)
> +{
> +    MachineState *ms = MACHINE(build_opaque);
> +    AcpiBuildState *build_state = ms->firmware_build_state.acpi.state;
> +    AcpiConfiguration *conf = ms->firmware_build_state.acpi.conf;
> +    AcpiBuildTables tables;
> +
> +    /* No ACPI configuration? Nothing to do. */
> +    if (!conf) {
> +        return;
> +    }
> +
> +    /* No state to update or already patched? Nothing to do. */
> +    if (!build_state || build_state->patched) {
> +        return;
> +    }
> +    build_state->patched = true;
> +
> +    acpi_build_tables_init(&tables);
> +
> +    acpi_reduced_build(ms, &tables, conf);
> +
> +    acpi_ram_update(build_state->table_mr, tables.table_data);
> +    acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
> +    acpi_ram_update(build_state->linker_mr, tables.linker->cmd_blob);
> +
> +    acpi_build_tables_cleanup(&tables, true);
> +}
> +

ms is not needed here; just pass the FirmwareBuildState as the opaque
value in rom_add_blob.

In fact, here:

> +    AcpiBuildState *build_state;
> +
> +    build_state = g_malloc0(sizeof(*build_state));
> +    machine->firmware_build_state.acpi.state = build_state;
> +    machine->firmware_build_state.acpi.conf = conf;
> +

I would say that you don't need FirmwareBuildState at all.  I cannot be
100% sure because I cannot see the caller of acpi_reduced_setup, but I
think you can add an AcpiConfiguration* field to AcpiBuildState and
encapsulate everything in AcpiBuildState.  In addition, the
AcpiBuildState need not be stored in the MachineState.

Instead, FirmwareBuildMethods should be a QOM interface (also please
refer explicitly to ACPI in the names, don't call it "firmware").  The
setup method of FirmwareBuildMethods can take that QOM interface, not
the MachineState, i.e. its prototype should be

void (*setup)(AcpiBuildMethods *acpibuild,
	      AcpiConfiguration *conf);

so that pc_machine_done does

    if (pcms->acpi_build_enabled) {
        acpi_conf_pc_init(pcms);
	/* This calls the ->setup method.  */
        acpi_builder_setup(ACPI_BUILD_METHODS(pcms),
			   &pcms->acpi_configuration);
    }

This is because MachineClass is used for dozens of machines that have
nothing to with ACPI.  Instead, machines that use ACPI (either reduced
or normal) can define the AcpiBuildMethods interface, and invoke the
entry point firmware_build_methods->setup (either acpi_setup or
acpi_reduced_setup) through acpi_builder_setup.

Paolo
