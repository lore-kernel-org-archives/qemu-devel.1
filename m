Received: from eggs.gnu.org ([2001:4830:134:3::10]:58980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daOjt-0006Am-FB
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daOjp-0006en-8D
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:00:45 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daOjp-0006eb-0S
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:00:41 -0400
Received: by mail-qk0-x244.google.com with SMTP id d136so15796036qkg.3
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 09:00:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170726150446.20381-1-otubo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7ff46b33-1b47-88ad-83e3-54030c12eaa0@amsat.org>
Date: Wed, 26 Jul 2017 13:00:36 -0300
MIME-Version: 1.0
In-Reply-To: <20170726150446.20381-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: thuth@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 07/26/2017 12:04 PM, Eduardo Otubo wrote:
> Starting qemu-system-unicore32 without the -kernel parameter results in
> an assert() returns false and aborts qemu. This patch replaces it with a
> proper error message followed by exit(1).
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>   hw/unicore32/puv3.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index e9d1a60b6f..ff62efb4df 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -92,7 +92,10 @@ static void puv3_load_kernel(const char *kernel_filename)
>       if (kernel_filename == NULL && qtest_enabled()) {
>           return;
>       }
> -    assert(kernel_filename != NULL);
> +    if (kernel_filename == NULL) {
> +        error_report("kernel parameter cannot be empty");
> +        exit(1);
> +    }

This seems a temporary kludge for 2.10 but not the correct long-term fix.

As commented in another thread [1] where I got a bit discomfited, it'd 
be nice if during the 2.11 schedule the industry provide some help to 
clean/unify the loader.c code, ideally remove all duplicated code not 
arch-specific and use hw/core/loader*.

[1] http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg06760.html

>   
>       /* only zImage format supported */
>       size = load_image_targphys(kernel_filename, KERNEL_LOAD_ADDR,
> 
