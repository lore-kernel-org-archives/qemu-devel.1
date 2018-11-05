Received: from eggs.gnu.org ([2001:4830:134:3::10]:39664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJg3f-0003pS-2T
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJg3Z-0004Hv-9e
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:40:50 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJg3Y-0004Gk-Tm
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:40:45 -0500
Received: by mail-oi1-x241.google.com with SMTP id i138-v6so4627118oib.1
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 06:40:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181016175236.5840-1-peter.maydell@linaro.org>
References: <20181016175236.5840-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 14:40:23 +0000
Message-ID: <CAFEAcA_PZ6XDz70tbRJM8dJZQYUg=F23cmmXpc=PZC5=eP17Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/acpi/nvdimm: Don't take address of
 fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "patches@linaro.org" <patches@linaro.org>

Ping? This patch got reviewed but does not seem to have
made it into anybody's tree.

thanks
-- PMM

On 16 October 2018 at 18:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> Taking the address of a field in a packed struct is a bad idea, because
> it might not be actually aligned enough for that pointer type (and
> thus cause a crash on dereference on some host architectures). Newer
> versions of clang warn about this. Avoid the bug by not using the
> "modify in place" byte swapping functions.
>
> Patch produced with scripts/coccinelle/inplace-byteswaps.cocci.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Automatically generated patch, tested with "make check" only.
>
>  hw/acpi/nvdimm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 27eeb6609f5..e53b2cb6819 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -581,7 +581,7 @@ static void nvdimm_dsm_func_read_fit(AcpiNVDIMMState *state, NvdimmDsmIn *in,
>      int size;
>
>      read_fit = (NvdimmFuncReadFITIn *)in->arg3;
> -    le32_to_cpus(&read_fit->offset);
> +    read_fit->offset = le32_to_cpu(read_fit->offset);
>
>      fit = fit_buf->fit;
>
> @@ -742,8 +742,8 @@ static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
>      int size;
>
>      get_label_data = (NvdimmFuncGetLabelDataIn *)in->arg3;
> -    le32_to_cpus(&get_label_data->offset);
> -    le32_to_cpus(&get_label_data->length);
> +    get_label_data->offset = le32_to_cpu(get_label_data->offset);
> +    get_label_data->length = le32_to_cpu(get_label_data->length);
>
>      nvdimm_debug("Read Label Data: offset %#x length %#x.\n",
>                   get_label_data->offset, get_label_data->length);
> @@ -781,8 +781,8 @@ static void nvdimm_dsm_set_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
>
>      set_label_data = (NvdimmFuncSetLabelDataIn *)in->arg3;
>
> -    le32_to_cpus(&set_label_data->offset);
> -    le32_to_cpus(&set_label_data->length);
> +    set_label_data->offset = le32_to_cpu(set_label_data->offset);
> +    set_label_data->length = le32_to_cpu(set_label_data->length);
>
>      nvdimm_debug("Write Label Data: offset %#x length %#x.\n",
>                   set_label_data->offset, set_label_data->length);
> @@ -877,9 +877,9 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>      in = g_new(NvdimmDsmIn, 1);
>      cpu_physical_memory_read(dsm_mem_addr, in, sizeof(*in));
>
> -    le32_to_cpus(&in->revision);
> -    le32_to_cpus(&in->function);
> -    le32_to_cpus(&in->handle);
> +    in->revision = le32_to_cpu(in->revision);
> +    in->function = le32_to_cpu(in->function);
> +    in->handle = le32_to_cpu(in->handle);
>
>      nvdimm_debug("Revision %#x Handler %#x Function %#x.\n", in->revision,
>                   in->handle, in->function);
> --
