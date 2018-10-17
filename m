Received: from eggs.gnu.org ([2001:4830:134:3::10]:48320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCiQu-0004oI-K1
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCiQp-0002FG-KN
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:48:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gCiQp-0002D2-Cd
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:47:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so1444855wmf.1
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 02:47:58 -0700 (PDT)
References: <20181016175236.5840-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2fea129c-46d1-d299-0d3e-c1480ac6890d@redhat.com>
Date: Wed, 17 Oct 2018 11:47:55 +0200
MIME-Version: 1.0
In-Reply-To: <20181016175236.5840-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, patches@linaro.org

On 16/10/2018 19:52, Peter Maydell wrote:
> Taking the address of a field in a packed struct is a bad idea, because
> it might not be actually aligned enough for that pointer type (and
> thus cause a crash on dereference on some host architectures). Newer
> versions of clang warn about this. Avoid the bug by not using the
> "modify in place" byte swapping functions.
> 
> Patch produced with scripts/coccinelle/inplace-byteswaps.cocci.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
> 
