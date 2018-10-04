Received: from eggs.gnu.org ([2001:4830:134:3::10]:43831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g85El-0001IW-F2
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g85EZ-0006gW-Gg
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:08:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g85EX-0006T8-IL
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:08:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so9395898wme.3
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 08:07:54 -0700 (PDT)
References: <1538164055-23719-1-git-send-email-wei@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <81006285-7644-c03e-a2a8-7458cfd064b8@redhat.com>
Date: Thu, 4 Oct 2018 17:07:51 +0200
MIME-Version: 1.0
In-Reply-To: <1538164055-23719-1-git-send-email-wei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] tests: Add migration test for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peter.maydell@linaro.org, drjones@redhat.com, dgilbert@redhat.com, quintela@redhat.com

On 28/09/2018 21:47, Wei Huang wrote:
[...]> +++ b/tests/migration/aarch64/Makefile
> @@ -0,0 +1,20 @@
> +# To specify cross compiler prefix, use CROSS_PREFIX=
> +#   $ make CROSS_PREFIX=aarch64-linux-gnu-
> +
> +.PHONY: all clean
> +all: a-b-kernel.h
> +
> +a-b-kernel.h: aarch64.kernel
> +	echo "$$__note" > header.tmp

This won't work on a read-only fs.

Why don't you use $@ directly?

> +	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp

Please use:

xxd -g4 ...

xxd might not be installed on the host.

That said we should however install it on the docker cross images.

> +	mv header.tmp $@
> +
> +aarch64.kernel: aarch64.elf
> +	$(CROSS_PREFIX)objcopy -O binary $< $@
> +
> +aarch64.elf: a-b-kernel.S
> +	$(CROSS_PREFIX)gcc -o $@ -nostdlib -Wl,--build-id=none $<
> +
> +clean:
> +	@rm -rf *.kernel *.elf
