Received: from eggs.gnu.org ([2001:4830:134:3::10]:34670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ff2cc-00081N-AM
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ff2cZ-0002s4-2D
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:28:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ff2cY-0002rV-SE
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:28:55 -0400
Date: Mon, 16 Jul 2018 14:28:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180716142849.240ff3d8@redhat.com>
In-Reply-To: <1529421657-14969-7-git-send-email-jingqi.liu@intel.com>
References: <1529421657-14969-1-git-send-email-jingqi.liu@intel.com>
	<1529421657-14969-7-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V1 RESEND 6/6] hmat acpi: Implement _HMA
 method to update HMAT at runtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Jingqi <jingqi.liu@intel.com>
Cc: ehabkost@redhat.com, eblake@redhat.com, pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, rth@twiddle.net, armbru@redhat.com, qemu-devel@nongnu.org

On Tue, 19 Jun 2018 23:20:57 +0800
Liu Jingqi <jingqi.liu@intel.com> wrote:

> OSPM evaluates HMAT only during system initialization.
> Any changes to the HMAT state at runtime or information
> regarding HMAT for hot plug are communicated using _HMA method.
> 
> _HMA is an optional object that enables the platform to provide
> the OS with updated Heterogeneous Memory Attributes information
> at runtime. _HMA provides OSPM with the latest HMAT in entirety
> overriding existing HMAT.

this patch is too big and lacks any documentation how this thing
is supposed to work.
Pls restructure and split in mode sensible chunks.

Now beside above ranting I noticed that it's build using
NFIT as template. However it's adding extra ABI and
a lot of complex code on both qemu/AML sides to transfer
updated HMAT table to guest similar to NFIT.

I don't think that duplicating NFIT approach for every new
table is sustainable both in terms of consuming limited
IO/memory resources and maintainability (too much
complex code duplication and extra ABI to keep stable).

We should generalize/reuse NFIT code and ABI (io/memory buffer)
that intersects with this series first and then build _HMA update
on top of it.


> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> ---
>  hw/acpi/hmat.c       | 356 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/hmat.h       |  71 ++++++++++
>  hw/i386/acpi-build.c |   2 +
>  hw/i386/pc.c         |   2 +
>  hw/i386/pc_piix.c    |   3 +
>  hw/i386/pc_q35.c     |   3 +
>  include/hw/i386/pc.h |   2 +
>  7 files changed, 439 insertions(+)
> 
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> index 9d29ef7..cf17c0a 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -275,6 +275,267 @@ static void hmat_build_hma(GArray *hma, PCMachineState *pcms)
>      hmat_build_cache(hma);
>  }
>  
> +static uint64_t
> +hmat_hma_method_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    printf("BUG: we never read _HMA IO Port.\n");
> +    return 0;
> +}
> +
> +/* _HMA Method: read HMA data. */
> +static void hmat_handle_hma_method(AcpiHmaState *state,
> +                                   HmatHmamIn *in, hwaddr hmam_mem_addr)
> +{
> +    HmatHmaBuffer *hma_buf = &state->hma_buf;
> +    HmatHmamOut *read_hma_out;
> +    GArray *hma;
> +    uint32_t read_len = 0, ret_status;
> +    int size;
> +
> +    le32_to_cpus(&in->offset);
> +
> +    hma = hma_buf->hma;
> +    if (in->offset > hma->len) {
> +        ret_status = HMAM_RET_STATUS_INVALID;
> +        goto exit;
> +    }
> +
> +   /* It is the first time to read HMA. */
> +    if (!in->offset) {
> +        hma_buf->dirty = false;
> +    } else if (hma_buf->dirty) { /* HMA has been changed during Reading HMA. */
> +        ret_status = HMAM_RET_STATUS_HMA_CHANGED;
> +        goto exit;
> +    }
> +
> +    ret_status = HMAM_RET_STATUS_SUCCESS;
> +    read_len = MIN(hma->len - in->offset,
> +                   HMAM_MEMORY_SIZE - 2 * sizeof(uint32_t));
> +exit:
> +    size = sizeof(HmatHmamOut) + read_len;
> +    read_hma_out = g_malloc(size);
> +
> +    read_hma_out->len = cpu_to_le32(size);
> +    read_hma_out->ret_status = cpu_to_le32(ret_status);
> +    memcpy(read_hma_out->data, hma->data + in->offset, read_len);
> +
> +    cpu_physical_memory_write(hmam_mem_addr, read_hma_out, size);
> +
> +    g_free(read_hma_out);
> +}
> +
> +static void
> +hmat_hma_method_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    AcpiHmaState *state = opaque;
> +    hwaddr hmam_mem_addr = val;
> +    HmatHmamIn *in;
> +
> +    in = g_new(HmatHmamIn, 1);
> +    cpu_physical_memory_read(hmam_mem_addr, in, sizeof(*in));
> +
> +    hmat_handle_hma_method(state, in, hmam_mem_addr);
> +}
> +
> +static const MemoryRegionOps hmat_hma_method_ops = {
> +    .read = hmat_hma_method_read,
> +    .write = hmat_hma_method_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void hmat_init_hma_buffer(HmatHmaBuffer *hma_buf)
> +{
> +    hma_buf->hma = g_array_new(false, true /* clear */, 1);
> +}
> +
> +static uint8_t hmat_acpi_table_checksum(uint8_t *buffer, uint32_t length)
> +{
> +    uint8_t sum = 0;
> +    uint8_t *end = buffer + length;
> +
> +    while (buffer < end) {
> +        sum = (uint8_t) (sum + *(buffer++));
> +    }
> +    return (uint8_t)(0 - sum);
> +}
> +
> +static void hmat_build_header(AcpiTableHeader *h,
> +             const char *sig, int len, uint8_t rev,
> +             const char *oem_id, const char *oem_table_id)
> +{
> +    memcpy(&h->signature, sig, 4);
> +    h->length = cpu_to_le32(len);
> +    h->revision = rev;
> +
> +    if (oem_id) {
> +        strncpy((char *)h->oem_id, oem_id, sizeof h->oem_id);
> +    } else {
> +        memcpy(h->oem_id, ACPI_BUILD_APPNAME6, 6);
> +    }
> +
> +    if (oem_table_id) {
> +        strncpy((char *)h->oem_table_id, oem_table_id, sizeof(h->oem_table_id));
> +    } else {
> +        memcpy(h->oem_table_id, ACPI_BUILD_APPNAME4, 4);
> +        memcpy(h->oem_table_id + 4, sig, 4);
> +    }
> +
> +    h->oem_revision = cpu_to_le32(1);
> +    memcpy(h->asl_compiler_id, ACPI_BUILD_APPNAME4, 4);
> +    h->asl_compiler_revision = cpu_to_le32(1);
> +
> +    /* Caculate the checksum of acpi table. */
> +    h->checksum = 0;
> +    h->checksum = hmat_acpi_table_checksum((uint8_t *)h, len);
> +}
> +
> +static void hmat_build_hma_buffer(PCMachineState *pcms)
> +{
> +    HmatHmaBuffer *hma_buf = &(pcms->acpi_hma_state.hma_buf);
> +
> +    /* Free the old hma buffer before new allocation. */
> +    g_array_free(hma_buf->hma, true);
> +
> +    hma_buf->hma = g_array_new(false, true /* clear */, 1);
> +    acpi_data_push(hma_buf->hma, sizeof(AcpiHmat));
> +
> +    /* build HMAT in a given buffer. */
> +    hmat_build_hma(hma_buf->hma, pcms);
> +    hmat_build_header((void *)hma_buf->hma->data,
> +                      "HMAT", hma_buf->hma->len, 1, NULL, NULL);
> +    hma_buf->dirty = true;
> +}
> +
> +static void hmat_build_common_aml(Aml *dev)
> +{
> +    Aml *method, *ifctx, *hmam_mem;
> +    Aml *unsupport;
> +    Aml *pckg, *pckg_index, *pckg_buf, *field;
> +    Aml *hmam_out_buf, *hmam_out_buf_size;
> +    uint8_t byte_list[1];
> +
> +    method = aml_method(HMA_COMMON_METHOD, 1, AML_SERIALIZED);
> +    hmam_mem = aml_local(6);
> +    hmam_out_buf = aml_local(7);
> +
> +    aml_append(method, aml_store(aml_name(HMAM_ACPI_MEM_ADDR), hmam_mem));
> +
> +    /* map _HMA memory and IO into ACPI namespace. */
> +    aml_append(method, aml_operation_region(HMAM_IOPORT, AML_SYSTEM_IO,
> +               aml_int(HMAM_ACPI_IO_BASE), HMAM_ACPI_IO_LEN));
> +    aml_append(method, aml_operation_region(HMAM_MEMORY,
> +               AML_SYSTEM_MEMORY, hmam_mem, HMAM_MEMORY_SIZE));
> +
> +    /*
> +     * _HMAC notifier:
> +     * HMAM_NOTIFY: write the address of DSM memory and notify QEMU to
> +     *                    emulate the access.
> +     *
> +     * It is the IO port so that accessing them will cause VM-exit, the
> +     * control will be transferred to QEMU.
> +     */
> +    field = aml_field(HMAM_IOPORT, AML_DWORD_ACC, AML_NOLOCK,
> +                      AML_PRESERVE);
> +    aml_append(field, aml_named_field(HMAM_NOTIFY,
> +               sizeof(uint32_t) * BITS_PER_BYTE));
> +    aml_append(method, field);
> +
> +    /*
> +     * _HMAC input:
> +     * HMAM_OFFSET: store the current offset of _HMA buffer.
> +     *
> +     * They are RAM mapping on host so that these accesses never cause VMExit.
> +     */
> +    field = aml_field(HMAM_MEMORY, AML_DWORD_ACC, AML_NOLOCK,
> +                      AML_PRESERVE);
> +    aml_append(field, aml_named_field(HMAM_OFFSET,
> +               sizeof(typeof_field(HmatHmamIn, offset)) * BITS_PER_BYTE));
> +    aml_append(method, field);
> +
> +    /*
> +     * _HMAC output:
> +     * HMAM_OUT_BUF_SIZE: the size of the buffer filled by QEMU.
> +     * HMAM_OUT_BUF: the buffer QEMU uses to store the result.
> +     *
> +     * Since the page is reused by both input and out, the input data
> +     * will be lost after storing new result into ODAT so we should fetch
> +     * all the input data before writing the result.
> +     */
> +    field = aml_field(HMAM_MEMORY, AML_DWORD_ACC, AML_NOLOCK,
> +                      AML_PRESERVE);
> +    aml_append(field, aml_named_field(HMAM_OUT_BUF_SIZE,
> +               sizeof(typeof_field(HmatHmamOut, len)) * BITS_PER_BYTE));
> +    aml_append(field, aml_named_field(HMAM_OUT_BUF,
> +       (sizeof(HmatHmamOut) - sizeof(uint32_t)) * BITS_PER_BYTE));
> +    aml_append(method, field);
> +
> +    /*
> +     * do not support any method if HMA memory address has not been
> +     * patched.
> +     */
> +    unsupport = aml_if(aml_equal(hmam_mem, aml_int(0x0)));
> +    byte_list[0] = HMAM_RET_STATUS_UNSUPPORT;
> +    aml_append(unsupport, aml_return(aml_buffer(1, byte_list)));
> +    aml_append(method, unsupport);
> +
> +    /* The parameter (Arg0) of _HMAC is a package which contains a buffer. */
> +    pckg = aml_arg(0);
> +    ifctx = aml_if(aml_and(aml_equal(aml_object_type(pckg),
> +                   aml_int(4 /* Package */)) /* It is a Package? */,
> +                   aml_equal(aml_sizeof(pckg), aml_int(1)) /* 1 element */,
> +                   NULL));
> +
> +    pckg_index = aml_local(2);
> +    pckg_buf = aml_local(3);
> +    aml_append(ifctx, aml_store(aml_index(pckg, aml_int(0)), pckg_index));
> +    aml_append(ifctx, aml_store(aml_derefof(pckg_index), pckg_buf));
> +    aml_append(ifctx, aml_store(pckg_buf, aml_name(HMAM_OFFSET)));
> +    aml_append(method, ifctx);
> +
> +    /*
> +     * tell QEMU about the real address of HMA memory, then QEMU
> +     * gets the control and fills the result in _HMAC memory.
> +     */
> +    aml_append(method, aml_store(hmam_mem, aml_name(HMAM_NOTIFY)));
> +
> +    hmam_out_buf_size = aml_local(1);
> +    /* RLEN is not included in the payload returned to guest. */
> +    aml_append(method, aml_subtract(aml_name(HMAM_OUT_BUF_SIZE),
> +                                aml_int(4), hmam_out_buf_size));
> +    aml_append(method, aml_store(aml_shiftleft(hmam_out_buf_size, aml_int(3)),
> +                                 hmam_out_buf_size));
> +    aml_append(method, aml_create_field(aml_name(HMAM_OUT_BUF),
> +                                aml_int(0), hmam_out_buf_size, "OBUF"));
> +    aml_append(method, aml_concatenate(aml_buffer(0, NULL), aml_name("OBUF"),
> +                                hmam_out_buf));
> +    aml_append(method, aml_return(hmam_out_buf));
> +    aml_append(dev, method);
> +}
> +
> +void hmat_init_acpi_state(AcpiHmaState *state, MemoryRegion *io,
> +                          FWCfgState *fw_cfg, Object *owner)
> +{
> +    memory_region_init_io(&state->io_mr, owner, &hmat_hma_method_ops, state,
> +                          "hma-acpi-io", HMAM_ACPI_IO_LEN);
> +    memory_region_add_subregion(io, HMAM_ACPI_IO_BASE, &state->io_mr);
> +
> +    state->hmam_mem = g_array_new(false, true /* clear */, 1);
> +    fw_cfg_add_file(fw_cfg, HMAM_MEM_FILE, state->hmam_mem->data,
> +                    state->hmam_mem->len);
> +
> +    hmat_init_hma_buffer(&state->hma_buf);
> +}
> +
> +void hmat_update(PCMachineState *pcms)
> +{
> +    /* build HMAT in a given buffer. */
> +    hmat_build_hma_buffer(pcms);
> +}
> +
>  void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
>                       MachineState *machine)
>  {
> @@ -291,3 +552,98 @@ void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
>                   (void *)(table_data->data + hmat_start),
>                   "HMAT", hmat_len, 1, NULL, NULL);
>  }
> +
> +void hmat_build_aml(Aml *dev)
> +{
> +    Aml *method, *pkg, *buf, *buf_size, *offset, *call_result;
> +    Aml *whilectx, *ifcond, *ifctx, *elsectx, *hma;
> +
> +    hmat_build_common_aml(dev);
> +
> +    buf = aml_local(0);
> +    buf_size = aml_local(1);
> +    hma = aml_local(2);
> +
> +    aml_append(dev, aml_name_decl(HMAM_RHMA_STATUS, aml_int(0)));
> +
> +    /* build helper function, RHMA. */
> +    method = aml_method("RHMA", 1, AML_SERIALIZED);
> +    aml_append(method, aml_name_decl("OFST", aml_int(0)));
> +
> +    /* prepare input package. */
> +    pkg = aml_package(1);
> +    aml_append(method, aml_store(aml_arg(0), aml_name("OFST")));
> +    aml_append(pkg, aml_name("OFST"));
> +
> +    /* call Read HMA function. */
> +    call_result = aml_call1(HMA_COMMON_METHOD, pkg);
> +    aml_append(method, aml_store(call_result, buf));
> +
> +    /* handle _HMAC result. */
> +    aml_append(method, aml_create_dword_field(buf,
> +               aml_int(0) /* offset at byte 0 */, "STAU"));
> +
> +    aml_append(method, aml_store(aml_name("STAU"),
> +                                 aml_name(HMAM_RHMA_STATUS)));
> +
> +    /* if something is wrong during _HMAC. */
> +    ifcond = aml_equal(aml_int(HMAM_RET_STATUS_SUCCESS),
> +                       aml_name("STAU"));
> +    ifctx = aml_if(aml_lnot(ifcond));
> +    aml_append(ifctx, aml_return(aml_buffer(0, NULL)));
> +    aml_append(method, ifctx);
> +
> +    aml_append(method, aml_store(aml_sizeof(buf), buf_size));
> +    aml_append(method, aml_subtract(buf_size,
> +                                    aml_int(4) /* the size of "STAU" */,
> +                                    buf_size));
> +
> +    /* if we read the end of hma. */
> +    ifctx = aml_if(aml_equal(buf_size, aml_int(0)));
> +    aml_append(ifctx, aml_return(aml_buffer(0, NULL)));
> +    aml_append(method, ifctx);
> +
> +    aml_append(method, aml_create_field(buf,
> +                            aml_int(4 * BITS_PER_BYTE), /* offset at byte 4.*/
> +                            aml_shiftleft(buf_size, aml_int(3)), "BUFF"));
> +    aml_append(method, aml_return(aml_name("BUFF")));
> +    aml_append(dev, method);
> +
> +    /* build _HMA. */
> +    method = aml_method("_HMA", 0, AML_SERIALIZED);
> +    offset = aml_local(3);
> +
> +    aml_append(method, aml_store(aml_buffer(0, NULL), hma));
> +    aml_append(method, aml_store(aml_int(0), offset));
> +
> +    whilectx = aml_while(aml_int(1));
> +    aml_append(whilectx, aml_store(aml_call1("RHMA", offset), buf));
> +    aml_append(whilectx, aml_store(aml_sizeof(buf), buf_size));
> +
> +    /*
> +     * if hma buffer was changed during RHMA, read from the beginning
> +     * again.
> +     */
> +    ifctx = aml_if(aml_equal(aml_name(HMAM_RHMA_STATUS),
> +                             aml_int(HMAM_RET_STATUS_HMA_CHANGED)));
> +    aml_append(ifctx, aml_store(aml_buffer(0, NULL), hma));
> +    aml_append(ifctx, aml_store(aml_int(0), offset));
> +    aml_append(whilectx, ifctx);
> +
> +    elsectx = aml_else();
> +
> +    /* finish hma read if no data is read out. */
> +    ifctx = aml_if(aml_equal(buf_size, aml_int(0)));
> +    aml_append(ifctx, aml_return(hma));
> +    aml_append(elsectx, ifctx);
> +
> +    /* update the offset. */
> +    aml_append(elsectx, aml_add(offset, buf_size, offset));
> +    /* append the data we read out to the hma buffer. */
> +    aml_append(elsectx, aml_concatenate(hma, buf, hma));
> +    aml_append(whilectx, elsectx);
> +    aml_append(method, whilectx);
> +
> +    aml_append(dev, method);
> +}
> +
> diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
> index f9fdcdc..dd6948f 100644
> --- a/hw/acpi/hmat.h
> +++ b/hw/acpi/hmat.h
> @@ -183,11 +183,82 @@ struct numa_hmat_cache_info {
>      uint16_t    num_smbios_handles;
>  };
>  
> +#define HMAM_MEMORY_SIZE    4096
> +#define HMAM_MEM_FILE       "etc/acpi/hma-mem"
> +
> +/*
> + * 32 bits IO port starting from 0x0a19 in guest is reserved for
> + * HMA ACPI emulation.
> + */
> +#define HMAM_ACPI_IO_BASE     0x0a19
> +#define HMAM_ACPI_IO_LEN      4
> +
> +#define HMAM_ACPI_MEM_ADDR  "HMTA"
> +#define HMAM_MEMORY         "HRAM"
> +#define HMAM_IOPORT         "HPIO"
> +
> +#define HMAM_NOTIFY         "NTFI"
> +#define HMAM_OUT_BUF_SIZE   "RLEN"
> +#define HMAM_OUT_BUF        "ODAT"
> +
> +#define HMAM_RHMA_STATUS    "RSTA"
> +#define HMA_COMMON_METHOD   "HMAC"
> +#define HMAM_OFFSET         "OFFT"
> +
> +#define HMAM_RET_STATUS_SUCCESS        0 /* Success */
> +#define HMAM_RET_STATUS_UNSUPPORT      1 /* Not Supported */
> +#define HMAM_RET_STATUS_INVALID        2 /* Invalid Input Parameters */
> +#define HMAM_RET_STATUS_HMA_CHANGED    0x100 /* HMA Changed */
> +
> +/*
> + * HmatHmaBuffer:
> + * @hma: HMA buffer with the updated HMAT. It is updated when
> + *   the memory device is plugged or unplugged.
> + * @dirty: It allows OSPM to detect changes and restart read if there is any.
> + */
> +struct HmatHmaBuffer {
> +    GArray *hma;
> +    bool dirty;
> +};
> +typedef struct HmatHmaBuffer HmatHmaBuffer;
> +
> +struct AcpiHmaState {
> +    /* detect if HMA support is enabled. */
> +    bool is_enabled;
> +
> +    /* the data of the fw_cfg file HMAM_MEM_FILE. */
> +    GArray *hmam_mem;
> +
> +    HmatHmaBuffer hma_buf;
> +
> +    /* the IO region used by OSPM to transfer control to QEMU. */
> +    MemoryRegion io_mr;
> +};
> +typedef struct AcpiHmaState AcpiHmaState;
> +
> +struct HmatHmamIn {
> +    /* the offset in the _HMA buffer */
> +    uint32_t offset;
> +} QEMU_PACKED;
> +typedef struct HmatHmamIn HmatHmamIn;
> +
> +struct HmatHmamOut {
> +    /* the size of buffer filled by QEMU. */
> +    uint32_t len;
> +    uint32_t ret_status;   /* return status code. */
> +    uint8_t data[4088];
> +} QEMU_PACKED;
> +typedef struct HmatHmamOut HmatHmamOut;
> +
>  extern struct numa_hmat_lb_info *hmat_lb_info[HMAT_LB_LEVELS][HMAT_LB_TYPES];
>  extern struct numa_hmat_cache_info
>                *hmat_cache_info[MAX_NODES][MAX_HMAT_CACHE_LEVEL + 1];
>  
>  void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
>                       MachineState *machine);
> +void hmat_build_aml(Aml *dsdt);
> +void hmat_init_acpi_state(AcpiHmaState *state, MemoryRegion *io,
> +                          FWCfgState *fw_cfg, Object *owner);
> +void hmat_update(PCMachineState *pcms);
>  
>  #endif
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4cc9cc8..d80a865 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1845,6 +1845,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_q35_pci0_int(dsdt);
>      }
>  
> +    hmat_build_aml(dsdt);
> +
>      if (pcmc->legacy_cpu_hotplug) {
>          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>      } else {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 622e49d..6f553b6 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1722,6 +1722,8 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
>          nvdimm_plug(&pcms->acpi_nvdimm_state);
>      }
>  
> +    hmat_update(pcms);
> +
>      hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
>      hhc->plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
>  out:
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 3b87f3c..0edddf4 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -298,6 +298,9 @@ static void pc_init1(MachineState *machine,
>          nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
>                                 pcms->fw_cfg, OBJECT(pcms));
>      }
> +
> +    hmat_init_acpi_state(&pcms->acpi_hma_state, system_io,
> +                         pcms->fw_cfg, OBJECT(pcms));
>  }
>  
>  /* Looking for a pc_compat_2_4() function? It doesn't exist.
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 087f263..cd455ca 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -278,6 +278,9 @@ static void pc_q35_init(MachineState *machine)
>          nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
>                                 pcms->fw_cfg, OBJECT(pcms));
>      }
> +
> +    hmat_init_acpi_state(&pcms->acpi_hma_state, system_io,
> +                         pcms->fw_cfg, OBJECT(pcms));
>  }
>  
>  #define DEFINE_Q35_MACHINE(suffix, name, compatfn, optionfn) \
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fc8dedc..3144d59 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -17,6 +17,7 @@
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/mem/nvdimm.h"
>  #include "hw/acpi/acpi_dev_interface.h"
> +#include "hw/acpi/hmat.h"
>  
>  #define HPET_INTCAP "hpet-intcap"
>  
> @@ -47,6 +48,7 @@ struct PCMachineState {
>      OnOffAuto smm;
>  
>      AcpiNVDIMMState acpi_nvdimm_state;
> +    AcpiHmaState acpi_hma_state;
>  
>      bool acpi_build_enabled;
>      bool smbus;
