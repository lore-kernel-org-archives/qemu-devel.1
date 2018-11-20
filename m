Received: from eggs.gnu.org ([2001:4830:134:3::10]:50665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6LO-0003os-9r
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6LG-000669-J7
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:45:32 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP6LE-0005tb-Ou
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:45:25 -0500
Received: by mail-oi1-x244.google.com with SMTP id h25so1524648oig.1
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 05:45:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181113165247.4806-5-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-5-sameo@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 13:45:03 +0000
Message-ID: <CAFEAcA9wvrnshOTYz-jZ0n6m7SfusYY+bnB-iPnQuVNqqdg5Ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/13] target: arm: Move all interrupt and
 exception handlers into their own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Most of them are TCG dependent so we want to be able to not build them
> in order to support TCG disablement with ARM.
>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> ---
>  target/arm/excp_helper.c | 550 +++++++++++++++++++++++++++++++++++++++
>  target/arm/helper.c      | 531 -------------------------------------
>  target/arm/Makefile.objs |   2 +-
>  3 files changed, 551 insertions(+), 532 deletions(-)
>  create mode 100644 target/arm/excp_helper.c

You'll find that you need to rebase as there is a recent change
that your moved copies are missing: commit e24ad484909e7.
(I have just discovered git diff's --color-moved option which
is great for checking this sort of code-movement patch.)

What is your plan for dealing with the way that the KVM code
for injecting a breakpoint exception into the guest works
by calling the do_interrupt code ?
(see target/arm/kvm64.c:kvm_arm_handle_debug(),
which calls cc->do_interrupt(cs).) This patch moves those
functions to a file which won't be compiled and a later one
in the series seems to stop cc->do_interrupt being set at all
if CONFIG_TCG is not defined. That will result in QEMU crashing
when it tries to inject an exception, won't it?

thanks
-- PMM
