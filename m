Received: from eggs.gnu.org ([2001:4830:134:3::10]:45519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cv8Eh-0005IU-2A
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cv8Ed-0007GS-Sy
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:05:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cv8Ed-0007GE-JM
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:05:55 -0400
Date: Mon, 3 Apr 2017 17:05:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170403200550.GI1910@thinpad.lan.raisama.net>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-14-ehabkost@redhat.com>
	<CAFEAcA9bRwneynDYg6Lgowe21=rh8+miSZhqzmW81VLWrxafhQ@mail.gmail.com>
	<20170403133416.GB1910@thinpad.lan.raisama.net>
	<CAFEAcA-9r=Qktj1Oa6kvCPQrQ4XpPcxb2L4xNcPSfHeB9Ogt6A@mail.gmail.com>
	<20170403135445.GD1910@thinpad.lan.raisama.net>
	<CAFEAcA-+imjX_kfxPo6Vue-bX8HZo8ZV8s7XmyTNj7_GTd4Lrg@mail.gmail.com>
	<20170403183043.GF1910@thinpad.lan.raisama.net>
	<CAFEAcA9s6+WMEsMxK0Twac=TCfU-Wf4ouB1CNvJ9uDj++fGJVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9s6+WMEsMxK0Twac=TCfU-Wf4ouB1CNvJ9uDj++fGJVQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Apr 03, 2017 at 08:42:12PM +0100, Peter Maydell wrote:
> On 3 April 2017 at 19:30, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Mon, Apr 03, 2017 at 03:08:06PM +0100, Peter Maydell wrote:
> >> On 3 April 2017 at 14:54, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> > This, on the other hand, currently works:
> >> >   $ qemu-system-x86_64 -M q35 -device unimplemented-device,size=1024,name=foo
> >>
> >> That's a bug in the q35 machine or the handling of -device
> >> on non-platform-bus systems, though, isn't it? The default
> >> for all sysbus devices has always been "you can't use
> >> -device with this", [...]
> >
> > This was true until 2014, only. commit
> > 33cd52b5d7b9adfd009e95f07e6c64dd88ae2a31 changed sys-bus-device
> > to have cannot_instantiate_with_device_add_yet=false. See patch
> > 03/19 for more detailed info.
> 
> That commit shouldn't cause this problem -- unless the
> machine sets has_dynamic_sysbus then the machine_init_notify()
> that commit adds will cause it to complain.
> 
> I think the bug was introduced much later, in bf8d4924 in 2016,
> when q35 had the has_dynamic_sysbus flag added but without
> any code to restruct this to a whitelist of working
> devices. (In fact you can see in that commit a very
> minimal attempt to blacklist a few devices.)

It's true that the problem happened when q35 set
has_dynamic_sysbus=1 without a whitelist. The point of this
series is to make a per-machine-type whitelist unnecessary.

> 
> The commit message says only intel-iommu was supposed to
> be -device creatable, so it should have been the only
> thing on the whitelist.

There was a thread about it (Subject: "q35 and sysbus devices"),
and nobody knew for sure if the q35 whitelist was supposed to
have *-iommu only, or not.

The conclusion of that thread is that we can simply use
cannot_instantiate_with_device_add_yet to build the whitelist, if
the field was set consistently. This series renames
cannot_instantiate_with_device_add_yet to user_creatable, and
sets it consistently.

> Commit 9e3f9733 shows how this
> should be done (that's where spapr got has_dynamic_sysbus).
> 
> Maybe we should just fix the q35 bug first?

This fixes the q35 bug by setting user_creatable correctly on
sys-bus-devices, and makes a q35-specific whitelist unnecessary.

> 
> >>               [...] there's never been a requirement to
> >> mark them as such separately (because it would require
> >> touching the files for a huge number of devices for no
> >> particularly good reason when you can default the whole
> >> set of devices subclassing SysBusDevice).
> >
> > Yes, and this is the whole point of this series. At the end of
> > this series, only the few devices that are actually usable with
> > some machine will have an explicit user_creatable=true
> > assignment. See cover letter for details.
> 
> ...OK, but in that case why not just set that where it should
> be set, rather than having a big long patchset that touches
> a lot of devices that in the end are right back where
> they started? I think a lot of why I'm confused by
> this patchset is that it seems like it's changing
> behaviour on devices like this one which don't need
> any changes...

The devices don't get back right where they started: they start
with cannot_instantiate_with_device_add_yet=false (meaning they
are user-creatable in q35), and end up with user_creatable=false
(meaning they become non-user-creatable in all machines).

I could squash patches 04/19 to 19/19 into patch 03/19, it's
true. But then I would probably not get confirmation from you
(and other developers) that unimplemented-device (and other
devices) is really not supposed to be user-creatable. I wouldn't
know if I am breaking a valid q35 use case, or not.

-- 
Eduardo
