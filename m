Received: from eggs.gnu.org ([2001:4830:134:3::10]:54205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK00F-0002Od-Mc
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK00F-0003JY-1i
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:49:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK00E-0003IE-Rq
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:49:34 -0500
References: <cover.1482164622.git.vpalatin@chromium.org>
	<bc2fa770d55e472477bcd5fef1524a2c5314d7f0.1482164622.git.vpalatin@chromium.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3de5e377-b08e-d286-219f-36e4208bdfdc@redhat.com>
Date: Thu, 22 Dec 2016 10:49:30 +0100
MIME-Version: 1.0
In-Reply-To: <bc2fa770d55e472477bcd5fef1524a2c5314d7f0.1482164622.git.vpalatin@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/4] hax: add Darwin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Palatin <vpalatin@chromium.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Yu Ning <yu.ning@linux.intel.com>, Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>



On 19/12/2016 17:24, Vincent Palatin wrote:
> diff --git a/cpus.c b/cpus.c
> index 0e01791..b8db313 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1264,6 +1264,11 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
>          return;
>      }
>      cpu->thread_kicked = true;
> +#ifdef CONFIG_DARWIN
> +    if (hax_enabled()) {
> +        cpu->exit_request = 1;
> +    }
> +#endif
>      err = pthread_kill(cpu->thread->thread, SIG_IPI);
>      if (err) {
>          fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));

Instead of this, please place the "if" in qemu_cpu_kick before the call
to qemu_cpu_kick_thread.  This way, it will be common to Win32 and Darwin.

Thanks,

Paolo
