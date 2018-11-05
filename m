Received: from eggs.gnu.org ([2001:4830:134:3::10]:53769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJj5O-0000BA-AH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJj5M-000411-QN
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:54:50 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJj5M-0003wN-Al
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:54:48 -0500
Received: by mail-oi1-x243.google.com with SMTP id x63-v6so4545850oix.9
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 09:54:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181105104524.933-1-jusual@mail.ru>
References: <20181105104524.933-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 17:54:25 +0000
Message-ID: <CAFEAcA9fy0xJM18+ktEpvAfZdXpkDLrjy6i1+Y0X1WNkN_jATg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] tests/microbit-test: Check nRF51 UART
 functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>

On 5 November 2018 at 10:45, Julia Suvorova <jusual@mail.ru> wrote:
> Some functional tests for:
>     Basic reception/transmittion
>     Suspending
>     INTEN* registers
>
> Based-on: <20181031002526.14262-1-contrib@steffen-goertz.de>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
> This patch was part of nRF51 UART patchset, but wasn't included in the latest
> revision. Due to upcoming loader fixes, we need this test instead of
> boot-serial-test, which doesn't support -device loader.
>
> v3:
>     * Fix directory leak [Stefan]
>
>  tests/microbit-test.c | 109 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 2 deletions(-)
>
> diff --git a/tests/microbit-test.c b/tests/microbit-test.c
> index ab319eb466..23d343cfdd 100644
> --- a/tests/microbit-test.c
> +++ b/tests/microbit-test.c
> @@ -21,9 +21,87 @@
>  #include "hw/arm/nrf51.h"
>  #include "hw/nvram/nrf51_nvm.h"
>  #include "hw/gpio/nrf51_gpio.h"
> +#include "hw/char/nrf51_uart.h"
> +
> +#include <sys/socket.h>
> +#include <sys/un.h>
>
>  #define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
>
> +static bool wait_for_event(uint32_t event_addr)
> +{
> +    int i;
> +
> +    for (i = 0; i < 1000; i++) {
> +        if (readl(event_addr) == 1) {
> +            writel(event_addr, 0x00);
> +            return true;
> +        }
> +        g_usleep(10000);

Hmm, is this the right way to wait for a device model?
I thought there was a qtest thing to say "advance the
time in the QEMU under test" and otherwise its internal
clock won't tick.

> +    }
> +
> +    return false;
> +}

>  int main(int argc, char **argv)
>  {
> -    int ret;
> +    int ret, sock_fd;
> +    char serialtmpdir[] = "/tmp/qtest-microbit-serial-sXXXXXX";
> +    char serialtmp[40];
> +    struct sockaddr_un addr;
> +
> +    g_assert(mkdtemp(serialtmpdir));
> +    sprintf(serialtmp, "%s/sock", serialtmpdir);

Prefer g_strdup_printf() to sprintf into a fixed size buffer:
it allocates memory so we don't have to think about whether
the buffer might ever overflow or whether we miscounted a
buffer length.

> +
> +    sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +    g_assert(sock_fd != -1);
> +
> +    memset(&addr, 0, sizeof(struct sockaddr_un));
> +
> +    addr.sun_family = AF_UNIX;
> +    strncpy(addr.sun_path, serialtmp, sizeof(addr.sun_path) - 1);
>
>      g_test_init(&argc, &argv, NULL);
>
> -    global_qtest = qtest_initf("-machine microbit");
> +    global_qtest = qtest_initf("-machine microbit "
> +                               "-chardev socket,id=s0,path=%s,server,nowait "
> +                               "-no-shutdown -serial chardev:s0",
> +                               serialtmp);
> +
> +    g_assert(connect(sock_fd, (const struct sockaddr *) &addr,
> +                     sizeof(struct sockaddr_un)) != -1);
>
> +    unlink(serialtmp);
> +    rmdir(serialtmpdir);

"Create a socket so I can give one end of it to a QEMU
chardev and use the other end in my test code" seems
like a feature that would be more widely useful than in
just this test, but I'll let people who understand our
qtest framework better than me weigh in on that.

thanks
-- PMM
