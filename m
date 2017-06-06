Received: from eggs.gnu.org ([2001:4830:134:3::10]:58347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIGdb-0000Vn-0D
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIGda-0006ys-4j
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:43:19 -0400
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149676257896.31274.8551304687945725648.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f6a1e425-7c2f-ed6e-46f9-6294f043b6c6@redhat.com>
Date: Tue, 6 Jun 2017 17:43:13 +0200
MIME-Version: 1.0
In-Reply-To: <149676257896.31274.8551304687945725648.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] spapr: fix memory leak in
 spapr_memory_pre_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06.06.2017 17:22, Greg Kurz wrote:
> The string returned by object_property_get_str() is dynamically allocated.
> 
> (Spotted by Coverity, CID 1375942)
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 86e622834f63..f834a6a7dfac 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2617,8 +2617,11 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
>          error_setg(errp, "Memory backend has bad page size. "
>                     "Use 'memory-backend-file' with correct mem-path.");
> -        return;
> +        goto out;
>      }
> +
> +out:
> +    g_free(mem_dev);
>  }

You don't need the goto and the "out" label here.

 Thomas
