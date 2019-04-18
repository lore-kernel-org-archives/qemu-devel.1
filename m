Received: from eggs.gnu.org ([209.51.188.92]:33707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGyfi-0008PJ-RH
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGyfe-0005l6-U0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:29:12 -0400
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
	<20190417220147.67648-7-stephen.checkoway@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <68f7c64a-263b-78a2-39fc-8b79a833f9ae@redhat.com>
Date: Thu, 18 Apr 2019 06:28:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190417220147.67648-7-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/10] block/pflash_cfi02: Fix CFI in
 autoselect mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 18/04/2019 00.01, Stephen Checkoway wrote:
> After a flash device enters CFI mode from autoselect mode, the reset
> command returns the device to autoselect mode. An additional reset
> command is necessary to return to read array mode.
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
[...]
> diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
> index 82bc5695e1..4039647604 100644
> --- a/tests/pflash-cfi02-test.c
> +++ b/tests/pflash-cfi02-test.c
> @@ -480,6 +480,42 @@ static void test_geometry(const void *opaque)
>      qtest_quit(qtest);
>  }
>  
> +/*
> + * Test that
> + * 1. enter autoselect mode;
> + * 2. enter CFI mode; and then
> + * 3. exit CFI mode
> + * leaves the flash device in autoselect mode.
> + */
> +static void test_cfi_in_autoselect(const void *opaque)
> +{
> +    const FlashConfig *config = opaque;
> +    QTestState *qtest = qtest_initf("-M musicpal,accel=qtest"
> +                                    " -drive if=pflash,file=%s,format=raw,"
> +                                    "copy-on-read",
> +                                    image_path);

Just a matter of taste, but I think here I'd declare the variable first,
and do the qtest_initf on a separate line, so you don't have to break
the string between "format=raw," and "copy-on-read".

Anyway, it's just a nit, so still:

Acked-by: Thomas Huth <thuth@redhat.com>
