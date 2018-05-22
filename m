Received: from eggs.gnu.org ([2001:4830:134:3::10]:60069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fLEii-00014B-F5
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fLEid-0005DR-Gm
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:21:24 -0400
Received: from chuckie.co.uk ([82.165.15.123]:59253
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fLEid-0005AF-8n
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:21:19 -0400
References: <1526977831-31129-1-git-send-email-thuth@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d12338f0-277e-99bf-388b-61c9ec2919f5@ilande.co.uk>
Date: Tue, 22 May 2018 22:21:03 +0100
MIME-Version: 1.0
In-Reply-To: <1526977831-31129-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial: Do not delete the
 output file in case of errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

On 22/05/18 09:30, Thomas Huth wrote:

> Peter reported that the boot-serial tester sometimes runs into timeouts
> with SPARC guests. It's currently completely unclear whether this is due
> to too much load on the host machine (so that the guest really just ran
> too slow), or whether there is something wrong with the guest's firmware
> boot. For further debugging, we need the serial output of the guest in
> case of errors, so instead of unlinking the file immediately, this is
> now only done in case of success. In case of error, print the name of the
> file with the serial output via g_error() (which then also calls abort()
> internally to mark the test as failed).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/boot-serial-test.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 4d6815c..952a2e7 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -111,9 +111,8 @@ static testdef_t tests[] = {
>       { NULL }
>   };
>   
> -static void check_guest_output(const testdef_t *test, int fd)
> +static bool check_guest_output(const testdef_t *test, int fd)
>   {
> -    bool output_ok = false;
>       int i, nbr = 0, pos = 0, ccnt;
>       char ch;
>   
> @@ -125,8 +124,7 @@ static void check_guest_output(const testdef_t *test, int fd)
>                   pos += 1;
>                   if (test->expect[pos] == '\0') {
>                       /* We've reached the end of the expected string! */
> -                    output_ok = true;
> -                    goto done;
> +                    return true;
>                   }
>               } else {
>                   pos = 0;
> @@ -136,8 +134,7 @@ static void check_guest_output(const testdef_t *test, int fd)
>           g_usleep(10000);
>       }
>   
> -done:
> -    g_assert(output_ok);
> +    return false;
>   }
>   
>   static void test_machine(const void *data)
> @@ -180,12 +177,16 @@ static void test_machine(const void *data)
>                                   "-no-shutdown -serial chardev:serial0 %s",
>                                   codeparam, code ? codetmp : "",
>                                   test->machine, serialtmp, test->extra);
> -    unlink(serialtmp);
>       if (code) {
>           unlink(codetmp);
>       }
>   
> -    check_guest_output(test, ser_fd);
> +    if (!check_guest_output(test, ser_fd)) {
> +        g_error("Failed to find expected string. Please check '%s'",
> +                serialtmp);
> +    }
> +    unlink(serialtmp);
> +
>       qtest_quit(global_qtest);
>   
>       close(ser_fd);

Is this for qemu-system-sparc rather than qemu-system-sparc64? The 
reason for asking is that OpenBIOS for SPARC32 writes zeros to all 
physical RAM before launching the Forth machine to work around a bug in 
older Solaris versions whereby the kernel page tables weren't explicitly 
zeroed and so the kernel would panic on boot due to junk PTEs.

At some point I should look at trying to move this to a higher level 
rather than doing this quite so early, but last time I looked at it IIRC 
there were complications related to the MMU mappings used at startup.


ATB,

Mark.
