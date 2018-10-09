Received: from eggs.gnu.org ([2001:4830:134:3::10]:47210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9t9q-0004sY-E9
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9t9n-0007f4-49
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:38:46 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:51287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9t9m-0007aT-Re
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:38:43 -0400
Date: Tue, 9 Oct 2018 10:38:37 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181009143837.GA24820@flamenco>
References: <20181008232756.30704-1-cota@braap.org> <87murnmh7j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87murnmh7j.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC v2 0/5] Dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Tue, Oct 09, 2018 at 13:34:40 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01146.html
> >
> > Changes since v1:
> 
> Hmm I'm seeing some qtest failures, for example:
> 
>   $ make check-qtest-alpha V=1
>   ...
>   QTEST_QEMU_BINARY=alpha-softmmu/qemu-system-alpha QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} gtester -k --verbose -m=quick test
>   s/boot-serial-test tests/qmp-test tests/qmp-cmd-test tests/device-introspect-test tests/cdrom-test tests/machine-none-test tests/qom-test tests/test-hmp
>   TEST: tests/boot-serial-test... (pid=31091)
>     /alpha/boot-serial/clipper:                                          Broken pipe
>   tests/libqtest.c:129: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
>   FAIL
>   GTester: last random seed: R02S948c4a5112fd7682934f4d96e1aff38e
>   (pid=31099)
>   FAIL: tests/boot-serial-test

I'm pretty sure that the problem is that tlb_init is not being
called at all. Note that this applies to the tlb-lock series
as well, although there we're just calling qemu_spin_init,
which is not really necessary because CPUArchState is 0-allocated.

I'll take a look.

Thanks,

		E.
