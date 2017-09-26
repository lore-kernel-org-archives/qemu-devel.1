Received: from eggs.gnu.org ([2001:4830:134:3::10]:33919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dwvZ6-0002In-4y
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dwvZ2-0004zj-Un
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:30:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dwvZ2-0004zW-Mg
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:30:40 -0400
Date: Tue, 26 Sep 2017 22:30:31 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170926222730-mutt-send-email-mst@kernel.org>
References: <1506049617-25716-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506049617-25716-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/boot-sector: Increase timeout to 600
 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Victor Kaplansky <victork@redhat.com>, Stefan Weil <sw@weilnetz.de>

On Fri, Sep 22, 2017 at 05:06:57AM +0200, Thomas Huth wrote:
> If QEMU has been compiled with the flags --enable-tcg-interpreter and
> --enable-debug, the guest is running incredibly slow. The pxe boot test
> can take up to 400 seconds when testing the pseries ppc64 machine. While
> we should still look for ways to speed up the test on the pseries machine,
> it's better to increase the timeout in this test to 600 seconds anyway to
> allow the test to pass successfully now with this unusal configuration
> already.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Well I do break things sometimes and I won't be happy about
spending 10 minutes waiting for a test to fail.

Can we break out of the test if all CPUs are halted with
interrupts disabled?

> ---
>  tests/boot-sector.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/boot-sector.c b/tests/boot-sector.c
> index 9ee8537..be29d5b 100644
> --- a/tests/boot-sector.c
> +++ b/tests/boot-sector.c
> @@ -137,9 +137,9 @@ void boot_sector_test(void)
>      uint16_t signature;
>      int i;
>  
> -    /* Wait at most 90 seconds */
> +    /* Wait at most 600 seconds (test is slow with TCI and --enable-debug) */
>  #define TEST_DELAY (1 * G_USEC_PER_SEC / 10)
> -#define TEST_CYCLES MAX((90 * G_USEC_PER_SEC / TEST_DELAY), 1)
> +#define TEST_CYCLES MAX((600 * G_USEC_PER_SEC / TEST_DELAY), 1)
>  
>      /* Poll until code has run and modified memory.  Once it has we know BIOS
>       * initialization is done.  TODO: check that IP reached the halt
> -- 
> 1.8.3.1
