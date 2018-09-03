Received: from eggs.gnu.org ([2001:4830:134:3::10]:50206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fwnJE-0002E7-U6
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fwnJ9-0005Qj-SV
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:46:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fwnJ9-0005Py-Lq
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:46:15 -0400
Date: Mon, 3 Sep 2018 13:46:09 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180903114609.57ekganetm7sltn7@kamzik.brq.redhat.com>
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-5-git-send-email-wei@redhat.com>
	<CAFEAcA_ycC8=YnUBF+zUHcTnsCHTCzXG5M77mu2yAgunuEpapg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_ycC8=YnUBF+zUHcTnsCHTCzXG5M77mu2yAgunuEpapg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Sat, Sep 01, 2018 at 11:07:26AM +0100, Peter Maydell wrote:
> On 1 September 2018 at 06:11, Wei Huang <wei@redhat.com> wrote:
> > This patch adds migration test support for aarch64. The test code, which
> > implements the same functionality as x86, is booted as a kernel in qemu.
> > Here are the design choices we make for aarch64:
> >
> >  * We choose this -kernel approach because aarch64 QEMU doesn't provide a
> >    built-in fw like x86 does. So instead of relying on a boot loader, we
> >    use -kernel approach for aarch64.
> >  * The serial output is sent to PL011 directly.
> >  * The physical memory base for mach-virt machine is 0x40000000. We change
> >    the start_address and end_address for aarch64.
> >
> > In addition to providing the binary, this patch also includes the source
> > code and the build script in tests/migration/aarch64. So users can change
> > the source and/or re-compile the binary as they wish.
> > +    } else if (strcmp(arch, "aarch64") == 0) {
> > +        struct utsname utsname;
> > +
> 
> The comment says:
> 
> > +        /* kvm and tcg need different cpu and gic-version configs */
> 
> ...but the code below it doesn't change the cpu or gic-version
> based on 'accel'.
> 
> > +        if (access("/dev/kvm", F_OK) == 0 && uname(&utsname) == 0 &&
> > +            strcmp(utsname.machine, "aarch64") == 0) {
> > +            accel = "kvm";
> > +        } else {
> > +            accel = "tcg";
> > +        }
> 
> Maybe we could just use -accel=kvm,tcg rather than guessing
> whether kvm is going to work ? If this is how the x86 code
> works then probably best to do the same as that, though.

Yeah, using '-accel=kvm:tcg' is what I suggested in the v7 review when
suggesting to switch to -cpu max and gic-version=max. That allows the
uname() use and the new utsname.h include to go away.

Thanks,
drew

> 
> > +
> > +        init_bootfile(bootpath, aarch64_kernel);
> > +        cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
> > +                                  "-name vmsource,debug-threads=on -cpu max "
> > +                                  "-m 150M -serial file:%s/src_serial "
> > +                                  "-kernel %s ",
> > +                                  accel, tmpfs, bootpath);
> > +        cmd_dst = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
> > +                                  "-name vmdest,debug-threads=on -cpu max "
> > +                                  "-m 150M -serial file:%s/dest_serial "
> > +                                  "-kernel %s "
> > +                                  "-incoming %s ",
> > +                                  accel, tmpfs, bootpath, uri);
> > +
> > +        start_address = ARM_TEST_MEM_START;
> > +        end_address = ARM_TEST_MEM_END;
> > +
> > +        g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
> 
> thanks
> -- PMM
> 
