Received: from eggs.gnu.org ([2001:4830:134:3::10]:46060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1egCEq-00007z-3i
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1egCEn-00033k-FT
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1egCEn-00032z-3M
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:53 -0500
Date: Mon, 29 Jan 2018 17:24:36 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180129171848.708a60c5@redhat.com>
In-Reply-To: <20180126120306.19225-1-marcandre.lureau@redhat.com>
References: <20180126120306.19225-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, 26 Jan 2018 13:03:06 +0100
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
> Interface as defined in TCG PC Client Platform TPM Profile (PTP)
> Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v22.
>=20
> The PTP allows device implementation to switch between TIS and CRB
> model at run time, but given that CRB is a simpler device to
> implement, I chose to implement it as a different device.
>=20
> The device doesn't implement other locality than 0 for now (my laptop
> TPM doesn't either, so I assume this isn't so bad)
>=20
> Tested with some success with Linux upstream and Windows 10, seabios &
> modified ovmf. The device is recognized and correctly transmit
> command/response with passthrough & emu. However, we are missing PPI
> ACPI part atm.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>=20
> The patch is based on stefanb/tpm-next git branch.
>=20
[...]

> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index dc4b2b9ffe..ed78c4ed9f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2224,6 +2224,22 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              aml_append(sb_scope, scope);
>          }
>      }
> +
> +    if (TPM_IS_CRB(tpm_find())) {
> +        dev =3D aml_device("TPM");
> +        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> +        crs =3D aml_resource_template();
> +        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
> +                                           TPM_CRB_ADDR_SIZE, AML_READ_W=
RITE));
> +        aml_append(dev, aml_name_decl("_CRS", crs));
> +
[...]
> +        method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
> +        aml_append(method, aml_return(aml_int(0x0f)));
> +        aml_append(dev, method);
this is not needed as 0x0f is assumed default value if _STA is missing

[...]

> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> new file mode 100644
> index 0000000000..687d2557b7
> --- /dev/null
> +++ b/hw/tpm/tpm_crb.c
[...]

> +static void tpm_crb_realize(DeviceState *dev, Error **errp)
> +{
> +    CRBState *s =3D CRB(dev);
> +
> +    if (!tpm_find()) {
> +        error_setg(errp, "at most one TPM device is permitted");
> +        return;
> +    }
> +    if (!s->tpmbe) {
> +        error_setg(errp, "'tpmdev' property is required");
> +        return;
> +    }
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
> +        "tpm-crb-mmio", sizeof(s->regs));
> +    memory_region_init_ram(&s->cmdmem, OBJECT(s),
> +        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
> +
> +    memory_region_add_subregion(get_system_memory(),
> +        TPM_CRB_ADDR_BASE, &s->mmio);
> +    memory_region_add_subregion(get_system_memory(),
> +        TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
just curious, what if there is something else mapped at this addresses,
will it fail or just ignore error?=20

> +
> +    tpm_backend_reset(s->tpmbe);
> +
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     InterfaceVersion, CRB_INTF_VERSION_CRB);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapLocality, CRB_INTF_CAP_LOCALITY_0_ONLY);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapCRBIdleBypass, CRB_INTF_CAP_IDLE_FAST);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapDataXferSizeSupport, CRB_INTF_CAP_XFER_SIZE_64);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapFIFO, CRB_INTF_CAP_FIFO_NOT_SUPPORTED);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     RID, 0b0000);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
> +                     VID, PCI_VENDOR_ID_IBM);
> +
> +    s->regs[R_CRB_CTRL_CMD_SIZE] =3D CRB_CTRL_CMD_SIZE;
> +    s->regs[R_CRB_CTRL_CMD_LADDR] =3D TPM_CRB_ADDR_BASE + A_CRB_DATA_BUF=
FER;
> +    s->regs[R_CRB_CTRL_RSP_SIZE] =3D CRB_CTRL_CMD_SIZE;
> +    s->regs[R_CRB_CTRL_RSP_ADDR] =3D TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFF=
ER;
> +
> +    s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->tpmbe),
> +                            CRB_CTRL_CMD_SIZE);
> +
> +    tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size);
> +}
[...]
