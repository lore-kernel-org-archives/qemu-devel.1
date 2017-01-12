Received: from eggs.gnu.org ([2001:4830:134:3::10]:60035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@linux.intel.com>) id 1cRW3L-0007Xo-Ie
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@linux.intel.com>) id 1cRW3G-0005S1-IX
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:27:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:45974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guangrong.xiao@linux.intel.com>)
	id 1cRW3G-0005Kg-8c
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:27:46 -0500
References: <20170111093630.2088-1-stefanha@redhat.com>
From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Message-ID: <1b6e2788-f162-a709-f086-850adf7a70d3@linux.intel.com>
Date: Thu, 12 Jan 2017 11:18:25 +0800
MIME-Version: 1.0
In-Reply-To: <20170111093630.2088-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>



On 01/11/2017 05:36 PM, Stefan Hajnoczi wrote:
> Unlike g_free(), g_array_free() does not accept a NULL pointer argument.
> The following error is logged when an nvdimm device is realized:
>
>   GLib-CRITICAL **: g_array_free: assertion 'array' failed
>
> Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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

Er, i do not know why it is NULL as we have init-ed it in nvdimm_init_fit_buffer:

static void nvdimm_init_fit_buffer(NvdimmFitBuffer *fit_buf)
{
     fit_buf->fit = g_array_new(false, true /* clear */, 1);
}

And i can not reproduce it on my box, could you share your command line and the
based commit id?

Thanks!
