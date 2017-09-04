Received: from eggs.gnu.org ([2001:4830:134:3::10]:53725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dosCC-0004Zd-Bn
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dosC7-00065y-OO
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:17:48 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dosC7-00065d-Ho
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:17:43 -0400
Received: by mail-wm0-x234.google.com with SMTP id u26so4272355wma.0
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 07:17:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500471597-2517-5-git-send-email-drjones@redhat.com>
References: <1500471597-2517-1-git-send-email-drjones@redhat.com>
	<1500471597-2517-5-git-send-email-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 15:17:21 +0100
Message-ID: <CAFEAcA_xDei18gfdLuo5=aPM=9D9Ou6LBLfT+gtGUKgcpDC88A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] target/arm/kvm: pmu: improve error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alexander Graf <agraf@suse.de>, Christoffer Dall <cdall@linaro.org>

On 19 July 2017 at 14:39, Andrew Jones <drjones@redhat.com> wrote:
> If a KVM PMU init or set-irq attr call fails we just silently stop
> the PMU DT node generation. The only way they could fail, though,
> is if the attr's respective KVM has-attr call fails. But that should
> never happen if KVM advertises the PMU capability, because both
> attrs have been available since the capability was introduced. Let's
> just abort if this should-never-happen stuff does happen, because,
> if it does, then something is obviously horribly wrong.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt.c        |  9 +++------
>  target/arm/kvm32.c   |  3 +--
>  target/arm/kvm64.c   | 28 ++++++++++++++++++++--------
>  target/arm/kvm_arm.h | 15 ++++-----------
>  4 files changed, 28 insertions(+), 27 deletions(-)

This breaks compile on 32-bit ARM:

/home/peter.maydell/qemu/target/arm/kvm32.c:530:5: error: conflicting
types for 'kvm_arm_pmu_init'
 int kvm_arm_pmu_init(CPUState *cs)
     ^
In file included from /home/peter.maydell/qemu/target/arm/kvm32.c:21:0:
/home/peter.maydell/qemu/target/arm/kvm_arm.h:199:6: note: previous
declaration of 'kvm_arm_pmu_init' w
as here
 void kvm_arm_pmu_init(CPUState *cs);
      ^

Looks like you forgot to update the 32-bit version of the function
to the new API; I'll just fix up the patch in my queue.

thanks
-- PMM
