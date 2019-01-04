Received: from eggs.gnu.org ([208.118.235.92]:56724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfRMq-0003LK-JK
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfRMp-00086w-Pf
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:26:36 -0500
References: <20190104145018.16950-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f550c850-1b97-6c51-acb4-26762429536e@redhat.com>
Date: Fri, 4 Jan 2019 16:26:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190104145018.16950-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/hexloader-test: Don't pass
 -nographic to the QEMU under test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Su Hang <suhang16@mails.ucas.ac.cn>, patches@linaro.org, Laurent Vivier <lvivier@redhat.com>

On 2019-01-04 15:50, Peter Maydell wrote:
> The hexloader test invokes QEMU with the -nographic argument. This
> is unnecessary, because the qtest_initf() function will pass it
> -display none, which suffices to disable the graphical window.
> It also means that the QEMU process will make the stdin/stdout
> O_NONBLOCK. Since O_NONBLOCK is not per-file descriptor but per
> "file description", this non-blocking behaviour is then shared
> with any other process that's using the stdin/stdout of the
> 'make check' run, including make itself. This can result in make
> falling over with "make: write error: stdout" because it got
> an unexpected EINTR trying to write output messages to the terminal.
> This is particularly noticable if running 'make check' in a loop with
>   while make check; do true; done
> (It does not affect single make check runs so much because the
> shell will remove the O_NONBLOCK status before it reads the
> terminal for interactive input.)
> 
> Remove the unwanted -nographic argument.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This seems to be sufficient to resolve my "make falls over"
> issues with the current test harness and a build done for
> arm targets; I haven't checked whether other test cases which
> are specific to other target architectures might have similar
> accidental O_NONBLOCK behaviour.
> 
>  tests/hexloader-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/hexloader-test.c b/tests/hexloader-test.c
> index 834ed52c22b..8b7aa2d72d0 100644
> --- a/tests/hexloader-test.c
> +++ b/tests/hexloader-test.c
> @@ -23,7 +23,7 @@ static void hex_loader_test(void)
>      const unsigned int base_addr = 0x00010000;
>  
>      QTestState *s = qtest_initf(
> -        "-M vexpress-a9 -nographic -device loader,file=tests/data/hex-loader/test.hex");
> +        "-M vexpress-a9 -device loader,file=tests/data/hex-loader/test.hex");
>  
>      for (i = 0; i < 256; ++i) {
>          uint8_t val = qtest_readb(s, base_addr + i);

Reviewed-by: Thomas Huth <thuth@redhat.com>
