Received: from eggs.gnu.org ([2001:4830:134:3::10]:50993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fFavx-0007ik-IK
	for qemu-devel@nongnu.org; Mon, 07 May 2018 03:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fFavw-0002DJ-MP
	for qemu-devel@nongnu.org; Mon, 07 May 2018 03:51:45 -0400
Date: Mon, 7 May 2018 09:51:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180507095126.2fd146b7@redhat.com>
In-Reply-To: <CAFEAcA-6nkVOEBc59H0mcgnRy9ifPRoRjUrvJ_4Gcr94GdjuSQ@mail.gmail.com>
References: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA9nG0_Eq1QWsCJMA6TKbZ_tf6mXWCVTrkxrFO5-UkmEvw@mail.gmail.com>
	<CAFEAcA-6nkVOEBc59H0mcgnRy9ifPRoRjUrvJ_4Gcr94GdjuSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] arm: isolate and clean up dtb
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On Fri, 4 May 2018 17:28:55 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 3 May 2018 at 16:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 1 May 2018 at 13:08, Igor Mammedov <imammedo@redhat.com> wrote:  
> >>
> >> Changelog v2->v3:
> >>    * drop already merged patches
> >>        'arm: always start from  first_cpu when registering loader cpu reset callback'
> >>        'ppc: e500: switch E500 based  machines to full machine definition'
> >>    * add small not related cleanup
> >>        'arm: boot: set boot_info starting from first_cpu'
> >>    * add extra suggested patch
> >>        'make sure that we aren't overwriting mc->get_hotplug_handler by accident'
> >>    * make sure that dtb_limit initialized to 0
> >>    * drop stale comment
> >>    * drop not needed line movement
> >>    * drop not needed extra new line
> >> Changelog v1->v2:
> >>    * drop "arm: reuse  arm_boot_address_space() in armv7m_load_kernel()"
> >>    * move "arm: always start from first_cpu  when registering loader cpu reset callback"
> >>      at the begigning of series and rebase
> >>    * add "ppc: e500: switch E500 based machines to full  machine definition"
> >>      and rebase 4/5 on top of it
> >>    * fixup typo in virt_machine_get_hotpug_handler() name
> >>    * add doc comment to skip_dtb_autoload field
> >>    * 1-2/5 are queued in respective arm/ppc trees and are included for series
> >>      completness so it would be easier to test, I expect series to go through
> >>      arm tree
> >>  
> >
> > Applied to target-arm.next, thanks.  
> 
> Doing further testing within target-arm.next shows that this series (and
> specifically patch 3/5) causes segfaults for the "no DTB provided" case.
> 
> $ gdb --args ./build/x86/arm-softmmu/qemu-system-arm -M vexpress-a15
[...]

> arm_load_dtb() is trying to call the binfo->get_dtb() hook and is not
> handling the case where it is NULL (which it is on pretty much every
> board except "virt").
> 
> (You get a segfault with an actual guest kernel as well; I just used
> /dev/null here as an easy no-dependencies-required repro case.)
> 
> I've left patch 4 in target-arm.next as that was a standalone bugfix,
> but have dropped the rest of the series for now.

Fix is really trivial, I've lost have_dtb() guard, while consolidating
multiple load_dtb() calls into one.
I'll respin v4 shortly with fixed 3/5.


> thanks
> -- PMM
