Received: from eggs.gnu.org ([208.118.235.92]:56523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfVaF-0000JZ-9B
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfVaB-00009y-9D
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:56:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gfVaB-00009C-20
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:56:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so37542528wrx.9
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 11:56:38 -0800 (PST)
References: <20190104145018.16950-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e075d742-6e09-9e91-d355-62e34b77687d@redhat.com>
Date: Fri, 4 Jan 2019 20:56:37 +0100
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
Cc: Su Hang <suhang16@mails.ucas.ac.cn>, patches@linaro.org

On 04/01/19 15:50, Peter Maydell wrote:
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
> 

Great, I'll put it in my pull request together with the TAP driver
(however, I'll also put in the </dev/null for good measure).

Paolo
