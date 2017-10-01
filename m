Received: from eggs.gnu.org ([2001:4830:134:3::10]:54474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyeyH-0000r1-2c
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 10:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyeyE-0002fY-CM
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 10:11:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dyeyE-0002eR-1r
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 10:11:50 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<3fe4e8e663e8b4d76fea0b37a8279de41f541cc5.1506730372.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c2aea730-f17d-4f5e-3553-168a1a6e923b@redhat.com>
Date: Sun, 1 Oct 2017 16:11:41 +0200
MIME-Version: 1.0
In-Reply-To: <3fe4e8e663e8b4d76fea0b37a8279de41f541cc5.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/47] hw/core: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On 30.09.2017 02:15, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
> V2:
>  - Split hw patch into individual directories
> 
>  hw/core/loader.c | 31 ++++++++++++++++---------------
>  hw/core/ptimer.c |  7 ++++---
>  2 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 4593061445..95bdcbbe36 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -43,6 +43,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "disas/disas.h"
> @@ -82,7 +83,7 @@ int load_image(const char *filename, uint8_t *addr)
>          return -1;
>      size = lseek(fd, 0, SEEK_END);
>      if (size == -1) {
> -        fprintf(stderr, "file %-20s: get size error: %s\n",
> +        error_report("file %-20s: get size error: %s",
>                  filename, strerror(errno));
>          close(fd);
>          return -1;
> @@ -623,7 +624,7 @@ static int load_uboot_image(const char *filename, hwaddr *ep, hwaddr *loadaddr,
>          goto out;
>  
>      if (hdr->ih_type != image_type) {
> -        fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type,
> +        error_report("Wrong image type %d, expected %d", hdr->ih_type,
>                  image_type);

Looks like indentation is broken again in this patch. Please fix it first!

 Thomas
