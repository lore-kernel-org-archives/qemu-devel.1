Received: from eggs.gnu.org ([2001:4830:134:3::10]:47648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEOhk-0000wz-3J
	for qemu-devel@nongnu.org; Thu, 03 May 2018 20:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEOhf-0003cw-73
	for qemu-devel@nongnu.org; Thu, 03 May 2018 20:36:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fEOhf-0003c0-1c
	for qemu-devel@nongnu.org; Thu, 03 May 2018 20:36:03 -0400
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-27-git-send-email-mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1f476403-7ba8-a1f1-363c-b866dd6f4d4b@redhat.com>
Date: Fri, 4 May 2018 02:35:49 +0200
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-27-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 26/67] cpu: replace command line flags with
 preprocessor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

On 03.05.2018 21:51, Michael S. Tsirkin wrote:
> Each target is currently built with a different set of include
> directories, this is what makes it possible to pull in a separate copy
> of cpu.h depending on the target.
> 
> Replace with per-target ifdefs which are easier to understand.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/cpu.h | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 include/cpu.h
> 
> diff --git a/include/cpu.h b/include/cpu.h
> new file mode 100644
> index 0000000..b18f163
> --- /dev/null
> +++ b/include/cpu.h
> @@ -0,0 +1,2 @@
> +#include "target-dir.h"
> +#include TARGET_DIR(cpu.h)

That's a *bad* idea. As far as I can see, this way, cpu.h is now
suddenly available to generic, non-target specific code. The headers in
target/* are "hidden" by purpose for all code that gets compiled via
common-obj-y and if you now make it available for everybody again, we'll
end up in ugly situation where common code might have been compiled with
target specific defines from target specific headers... Please don't do
that!

 Thomas
