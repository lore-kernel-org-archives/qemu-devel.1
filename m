Received: from eggs.gnu.org ([2001:4830:134:3::10]:53901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1egCdN-0000Op-Ie
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1egCdK-0004cS-CV
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:50:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46562
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1egCdK-0004bM-7G
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:50:14 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0TGnEQq056996
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 11:50:12 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ft56hev9q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 11:50:11 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 29 Jan 2018 09:50:10 -0700
References: <20180126120306.19225-1-marcandre.lureau@redhat.com>
	<20180129171848.708a60c5@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 29 Jan 2018 11:50:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180129171848.708a60c5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <09b823ea-f0d3-1428-fceb-a54d881e9333@linux.vnet.ibm.com>
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
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 01/29/2018 11:24 AM, Igor Mammedov wrote:
> On Fri, 26 Jan 2018 13:03:06 +0100
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
>> tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
>> Interface as defined in TCG PC Client Platform TPM Profile (PTP)
>> Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v22.
>>
>> The PTP allows device implementation to switch between TIS and CRB
>> model at run time, but given that CRB is a simpler device to
>> implement, I chose to implement it as a different device.
>>
>> The device doesn't implement other locality than 0 for now (my laptop
>> TPM doesn't either, so I assume this isn't so bad)
>>
>> Tested with some success with Linux upstream and Windows 10, seabios &
>> modified ovmf. The device is recognized and correctly transmit
>> command/response with passthrough & emu. However, we are missing PPI
>> ACPI part atm.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>
>> The patch is based on stefanb/tpm-next git branch.
>>
> [...]
>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index dc4b2b9ffe..ed78c4ed9f 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2224,6 +2224,22 @@ build_dsdt(GArray *table_data, BIOSLinker *link=
er,
>>               aml_append(sb_scope, scope);
>>           }
>>       }
>> +
>> +    if (TPM_IS_CRB(tpm_find())) {
>> +        dev =3D aml_device("TPM");
>> +        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101"))=
);
>> +        crs =3D aml_resource_template();
>> +        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
>> +                                           TPM_CRB_ADDR_SIZE, AML_REA=
D_WRITE));
>> +        aml_append(dev, aml_name_decl("_CRS", crs));
>> +
> [...]
>> +        method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
>> +        aml_append(method, aml_return(aml_int(0x0f)));
>> +        aml_append(dev, method);
> this is not needed as 0x0f is assumed default value if _STA is missing

Well, it seems to be in good neighborhood with other devices created=20
that do the same thing: build_kbd_device_aml(),=20
build_mouse_device_aml(), part of \_SB.PCI0.ISA...

>
> [...]
>
>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>> new file mode 100644
>> index 0000000000..687d2557b7
>> --- /dev/null
>> +++ b/hw/tpm/tpm_crb.c
> [...]
>
>> +static void tpm_crb_realize(DeviceState *dev, Error **errp)
>> +{
>> +    CRBState *s =3D CRB(dev);
>> +
>> +    if (!tpm_find()) {
>> +        error_setg(errp, "at most one TPM device is permitted");
>> +        return;
>> +    }
>> +    if (!s->tpmbe) {
>> +        error_setg(errp, "'tpmdev' property is required");
>> +        return;
>> +    }
>> +
>> +    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s=
,
>> +        "tpm-crb-mmio", sizeof(s->regs));
>> +    memory_region_init_ram(&s->cmdmem, OBJECT(s),
>> +        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
>> +
>> +    memory_region_add_subregion(get_system_memory(),
>> +        TPM_CRB_ADDR_BASE, &s->mmio);
>> +    memory_region_add_subregion(get_system_memory(),
>> +        TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
> just curious, what if there is something else mapped at this addresses,
> will it fail or just ignore error?

All these memory APIs return void...



>
>> +
>> +    tpm_backend_reset(s->tpmbe);
>> +
>> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>> +                     InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
>> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>> +                     InterfaceVersion, CRB_INTF_VERSION_CRB);
>> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>> +                     CapLocality, CRB_INTF_CAP_LOCALITY_0_ONLY);
>> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>> +                     CapCRBIdleBypass, CRB_INTF_CAP_IDLE_FAST);
>> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>> +                     CapDataXferSizeSupport, CRB_INTF_CAP_XFER_SIZE_6=
4);
>> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>> +                     CapFIFO, CRB_INTF_CAP_FIFO_NOT_SUPPORTED);
>> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>> +                     CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
>> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>> +                     InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
>> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>> +                     RID, 0b0000);
>> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
>> +                     VID, PCI_VENDOR_ID_IBM);
>> +
>> +    s->regs[R_CRB_CTRL_CMD_SIZE] =3D CRB_CTRL_CMD_SIZE;
>> +    s->regs[R_CRB_CTRL_CMD_LADDR] =3D TPM_CRB_ADDR_BASE + A_CRB_DATA_=
BUFFER;
>> +    s->regs[R_CRB_CTRL_RSP_SIZE] =3D CRB_CTRL_CMD_SIZE;
>> +    s->regs[R_CRB_CTRL_RSP_ADDR] =3D TPM_CRB_ADDR_BASE + A_CRB_DATA_B=
UFFER;
>> +
>> +    s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->tpmbe),
>> +                            CRB_CTRL_CMD_SIZE);
>> +
>> +    tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size);
>> +}
> [...]
>
