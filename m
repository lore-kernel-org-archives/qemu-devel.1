Received: from eggs.gnu.org ([2001:4830:134:3::10]:57847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrbu-0002tm-34
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrbt-0005Eu-0H
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:07:22 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjrbs-0005Ci-Pj
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:07:20 -0500
Received: by mail-wm0-x22b.google.com with SMTP id v186so21401945wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 10:07:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170303123232.4967-1-drjones@redhat.com>
References: <20170303123232.4967-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 18:06:58 +0000
Message-ID: <CAFEAcA8e-DX5OFPmND-9Oercr5vt6eW-tmDWcD7C81+T_uksXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] [RFT] target/arm/arm-powerctl: Fix psci
 info return values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 3 March 2017 at 12:32, Andrew Jones <drjones@redhat.com> wrote:
> The power state spec section 5.1.5 AFFINITY_INFO defines the
> affinity info return values as
>
>   0 ON
>   1 OFF
>   2 ON_PENDING
>
> I grepped QEMU for power_state to ensure that no assumptions
> of OFF=0 were being made.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
>
> ---
>
> I found this with the yet to be committed kvm-unit-tests test
> https://lists.cs.columbia.edu/pipermail/kvmarm/2017-February/023820.html
>
> I've added the RFT because I didn't bother to confirm Linux is still
> happy (although I can't see why it wouldn't be happier).

Nice catch. Without this patch:

root@genericarmv8:~# echo 0 > /sys/devices/system/cpu/cpu1/online
[  112.797621] CPU1: shutdown
[  112.822447] psci: Retrying again to check for CPU kill
[  112.841306] psci: Retrying again to check for CPU kill
[  112.861303] psci: Retrying again to check for CPU kill
[  112.881346] psci: Retrying again to check for CPU kill
[  112.901302] psci: Retrying again to check for CPU kill
[  112.921301] psci: Retrying again to check for CPU kill
[  112.941303] psci: Retrying again to check for CPU kill
[  112.961302] psci: Retrying again to check for CPU kill
[  112.981350] psci: Retrying again to check for CPU kill
[  113.001368] psci: Retrying again to check for CPU kill
[  113.001789] psci: CPU1 may not have shut down cleanly
(AFFINITY_INFO reports 0)
[  113.002429] CPU1 may not have shut down cleanly: -110

With the patch:
root@genericarmv8:~# echo 0 > /sys/devices/system/cpu/cpu1/online
[   83.303563] CPU1: shutdown
[   83.308003] psci: CPU1 killed.

Applied to target-arm.next for 2.9.

thanks
-- PMM
