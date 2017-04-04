Received: from eggs.gnu.org ([2001:4830:134:3::10]:52592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvOGS-0001jv-SU
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvOGN-0001Js-T6
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cvOGN-0001Ja-Kh
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:12:47 -0400
Date: Tue, 4 Apr 2017 10:12:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170404131230.GS1910@thinpad.lan.raisama.net>
References: <CAFEAcA9bRwneynDYg6Lgowe21=rh8+miSZhqzmW81VLWrxafhQ@mail.gmail.com>
	<20170403133416.GB1910@thinpad.lan.raisama.net>
	<CAFEAcA-9r=Qktj1Oa6kvCPQrQ4XpPcxb2L4xNcPSfHeB9Ogt6A@mail.gmail.com>
	<20170403135445.GD1910@thinpad.lan.raisama.net>
	<CAFEAcA-+imjX_kfxPo6Vue-bX8HZo8ZV8s7XmyTNj7_GTd4Lrg@mail.gmail.com>
	<20170403183043.GF1910@thinpad.lan.raisama.net>
	<CAFEAcA9s6+WMEsMxK0Twac=TCfU-Wf4ouB1CNvJ9uDj++fGJVQ@mail.gmail.com>
	<20170403200550.GI1910@thinpad.lan.raisama.net>
	<d148549c-d689-3054-bfc8-7152a4e55ad2@redhat.com>
	<D762E290-3EDB-4AB5-982C-EF17AC7AF571@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D762E290-3EDB-4AB5-982C-EF17AC7AF571@suse.de>
Subject: Re: [Qemu-devel] [RFC 13/19] unimplemented-device: Remove
 user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Apr 04, 2017 at 09:12:59AM +0200, Alexander Graf wrote:
> 
> 
> > Am 04.04.2017 um 09:05 schrieb Thomas Huth <thuth@redhat.com>:
> > 
> >> On 03.04.2017 22:05, Eduardo Habkost wrote:
> >>> On Mon, Apr 03, 2017 at 08:42:12PM +0100, Peter Maydell wrote:
> >>>> On 3 April 2017 at 19:30, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >>>>> On Mon, Apr 03, 2017 at 03:08:06PM +0100, Peter Maydell wrote:
> >>>>>> On 3 April 2017 at 14:54, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >>>>>> This, on the other hand, currently works:
> >>>>>>  $ qemu-system-x86_64 -M q35 -device unimplemented-device,size=1024,name=foo
> >>>>> 
> >>>>> That's a bug in the q35 machine or the handling of -device
> >>>>> on non-platform-bus systems, though, isn't it? The default
> >>>>> for all sysbus devices has always been "you can't use
> >>>>> -device with this", [...]
> >>>> 
> >>>> This was true until 2014, only. commit
> >>>> 33cd52b5d7b9adfd009e95f07e6c64dd88ae2a31 changed sys-bus-device
> >>>> to have cannot_instantiate_with_device_add_yet=false. See patch
> >>>> 03/19 for more detailed info.
> >>> 
> >>> That commit shouldn't cause this problem -- unless the
> >>> machine sets has_dynamic_sysbus then the machine_init_notify()
> >>> that commit adds will cause it to complain.
> >>> 
> >>> I think the bug was introduced much later, in bf8d4924 in 2016,
> >>> when q35 had the has_dynamic_sysbus flag added but without
> >>> any code to restruct this to a whitelist of working
> >>> devices. (In fact you can see in that commit a very
> >>> minimal attempt to blacklist a few devices.)
> >> 
> >> It's true that the problem happened when q35 set
> >> has_dynamic_sysbus=1 without a whitelist. The point of this
> >> series is to make a per-machine-type whitelist unnecessary.
> >> 
> >>> 
> >>> The commit message says only intel-iommu was supposed to
> >>> be -device creatable, so it should have been the only
> >>> thing on the whitelist.
> >> 
> >> There was a thread about it (Subject: "q35 and sysbus devices"),
> >> and nobody knew for sure if the q35 whitelist was supposed to
> >> have *-iommu only, or not.
> >> 
> >> The conclusion of that thread is that we can simply use
> >> cannot_instantiate_with_device_add_yet to build the whitelist, if
> >> the field was set consistently. This series renames
> >> cannot_instantiate_with_device_add_yet to user_creatable, and
> >> sets it consistently.
> > 
> > I don't think that this will always work. While you can clearly mark
> > those devices that can never be added dynamically, there might also be
> > some devices that only work on certain machines. For example, there
> > might be devices that only work on the "ppce500" machine, but do not
> > work on the "pseries" machine. So we always need some kind of
> > whitelisting for the machines that have a dynamic sysbus.
> 
> It's even worse. Sysbus needs explicit logic to wire up memory
> regions and irqs. That logic is board specific (or at least was
> last time I checked).
> 
> So your board *needs* explicit logic for every sysbus device it
> spawns. And that's why you also get a board whitelist.

You're correct. My suggestion is that we (humans, not the machine
code) can build the whitelist inside q35 code by looking at the
remaining user-creatable devices (after this series is reviewed).

If I suggested that fixing cannot_instantiate_with_device_add_yet
is sufficient to fix the q35 bug, that was a mistake.

-- 
Eduardo
