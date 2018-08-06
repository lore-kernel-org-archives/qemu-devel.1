Received: from eggs.gnu.org ([2001:4830:134:3::10]:36009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmeaD-0007oL-5m
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 08:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmeaC-0002OL-DS
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 08:25:57 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmeaC-0002OA-8V
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 08:25:56 -0400
Received: by mail-oi0-x241.google.com with SMTP id s198-v6so21747858oih.11
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 05:25:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806121304.9440-1-dgilbert@redhat.com>
References: <20180806121304.9440-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Aug 2018 13:25:34 +0100
Message-ID: <CAFEAcA_jWy+uT6ALXZGF3dMBi_rkgrs6i0VK9jUh7nPUdo4AVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docs/migration: Clarify pre_load in
 subsections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

On 6 August 2018 at 13:13, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Clarify that the pre_load function in a subsection is only called if
> the subsection is found; to handle a missing subsection you may
> set values in the pre_load of the parent vmsd.

NB: I did a quick audit of all the uses of pre_load in the tree:

These uses rely on the hook not being called unless the
subsection is found:
hw/acpi/ich9.c
hw/acpi/piix4.c
hw/net/vmxnet3.c

These are buggy (and I have a patch I'm testing to fix it)
hw/intc/arm_gicv3_common.c:    .pre_load = vmstate_gicv3_cpu_pre_load,
hw/intc/arm_gicv3_common.c:    .pre_load = gicv3_pre_load,

and all the rest are not in VMSDs for subsections.

(I didn't audit the post_load uses; gicv3 has a wrong
use of that too.)

thanks
-- PMM
