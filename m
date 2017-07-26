Received: from eggs.gnu.org ([2001:4830:134:3::10]:39378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daOES-00073X-Cx
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daOEP-0002MX-6Q
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:28:16 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daOEP-0002Lq-0W
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:28:13 -0400
Received: by mail-wm0-f48.google.com with SMTP id t201so76014253wmt.1
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 08:28:12 -0700 (PDT)
References: <20170726150446.20381-1-otubo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4568463e-566f-538b-9be2-dae026670378@redhat.com>
Date: Wed, 26 Jul 2017 17:28:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170726150446.20381-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fix qemu-system-unicore32 crashing when
 calling without -kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On 26/07/2017 17:04, Eduardo Otubo wrote:
> Starting qemu-system-unicore32 without the -kernel parameter results in
> an assert() returns false and aborts qemu. This patch replaces it with a
> proper error message followed by exit(1).
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  hw/unicore32/puv3.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index e9d1a60b6f..ff62efb4df 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -92,7 +92,10 @@ static void puv3_load_kernel(const char *kernel_filename)
>      if (kernel_filename == NULL && qtest_enabled()) {
>          return;
>      }
> -    assert(kernel_filename != NULL);
> +    if (kernel_filename == NULL) {
> +        error_report("kernel parameter cannot be empty");
> +        exit(1);
> +    }
>  
>      /* only zImage format supported */
>      size = load_image_targphys(kernel_filename, KERNEL_LOAD_ADDR,
> 

Cc: qemu-trivial@nongnu.org
