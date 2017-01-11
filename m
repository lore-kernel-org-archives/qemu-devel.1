Received: from eggs.gnu.org ([2001:4830:134:3::10]:36672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cRLRq-0000y6-QL
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cRLRl-0001Pu-SI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:08:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cRLRl-0001Pe-Lq
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:08:21 -0500
Date: Wed, 11 Jan 2017 17:08:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170111170817.215dbebd@nial.brq.redhat.com>
In-Reply-To: <20170111094443.2790-1-stefanha@redhat.com>
References: <20170111094443.2790-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvdimm acpi: fix g_array_free() with NULL
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 11 Jan 2017 09:44:43 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Unlike g_free(), g_array_free() does not accept a NULL pointer argument.
> The following error is logged when an nvdimm device is realized:
> 
>   GLib-CRITICAL **: g_array_free: assertion 'array' failed
> 
> Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/nvdimm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 8e7d6ec..8f0a484 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -375,7 +375,9 @@ static void nvdimm_init_fit_buffer(NvdimmFitBuffer *fit_buf)
>  
>  static void nvdimm_build_fit_buffer(NvdimmFitBuffer *fit_buf)
>  {
> -    g_array_free(fit_buf->fit, true);
> +    if (fit_buf->fit) {
> +        g_array_free(fit_buf->fit, true);
> +    }
>      fit_buf->fit = nvdimm_build_device_structure();
>      fit_buf->dirty = true;
>  }
