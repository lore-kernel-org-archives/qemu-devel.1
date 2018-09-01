Received: from eggs.gnu.org ([2001:4830:134:3::10]:41242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fw2on-0000cP-3o
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 06:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fw2om-0002pN-AG
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 06:07:49 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fw2om-0002p9-59
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 06:07:48 -0400
Received: by mail-oi0-x243.google.com with SMTP id r69-v6so25990120oie.3
	for <qemu-devel@nongnu.org>; Sat, 01 Sep 2018 03:07:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1535778675-32170-5-git-send-email-wei@redhat.com>
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-5-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Sep 2018 11:07:26 +0100
Message-ID: <CAFEAcA_ycC8=YnUBF+zUHcTnsCHTCzXG5M77mu2yAgunuEpapg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V8 4/4] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Andrew Jones <drjones@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 1 September 2018 at 06:11, Wei Huang <wei@redhat.com> wrote:
> This patch adds migration test support for aarch64. The test code, which
> implements the same functionality as x86, is booted as a kernel in qemu.
> Here are the design choices we make for aarch64:
>
>  * We choose this -kernel approach because aarch64 QEMU doesn't provide a
>    built-in fw like x86 does. So instead of relying on a boot loader, we
>    use -kernel approach for aarch64.
>  * The serial output is sent to PL011 directly.
>  * The physical memory base for mach-virt machine is 0x40000000. We change
>    the start_address and end_address for aarch64.
>
> In addition to providing the binary, this patch also includes the source
> code and the build script in tests/migration/aarch64. So users can change
> the source and/or re-compile the binary as they wish.
> +    } else if (strcmp(arch, "aarch64") == 0) {
> +        struct utsname utsname;
> +

The comment says:

> +        /* kvm and tcg need different cpu and gic-version configs */

...but the code below it doesn't change the cpu or gic-version
based on 'accel'.

> +        if (access("/dev/kvm", F_OK) == 0 && uname(&utsname) == 0 &&
> +            strcmp(utsname.machine, "aarch64") == 0) {
> +            accel = "kvm";
> +        } else {
> +            accel = "tcg";
> +        }

Maybe we could just use -accel=kvm,tcg rather than guessing
whether kvm is going to work ? If this is how the x86 code
works then probably best to do the same as that, though.

> +
> +        init_bootfile(bootpath, aarch64_kernel);
> +        cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
> +                                  "-name vmsource,debug-threads=on -cpu max "
> +                                  "-m 150M -serial file:%s/src_serial "
> +                                  "-kernel %s ",
> +                                  accel, tmpfs, bootpath);
> +        cmd_dst = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
> +                                  "-name vmdest,debug-threads=on -cpu max "
> +                                  "-m 150M -serial file:%s/dest_serial "
> +                                  "-kernel %s "
> +                                  "-incoming %s ",
> +                                  accel, tmpfs, bootpath, uri);
> +
> +        start_address = ARM_TEST_MEM_START;
> +        end_address = ARM_TEST_MEM_END;
> +
> +        g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);

thanks
-- PMM
