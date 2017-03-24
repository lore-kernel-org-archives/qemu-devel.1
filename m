Received: from eggs.gnu.org ([2001:4830:134:3::10]:44753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crPcR-00081b-6N
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crPcO-0007bc-0S
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:51:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1crPcN-0007aR-Lr
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:51:03 -0400
Date: Fri, 24 Mar 2017 10:50:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170324135057.GD28530@thinpad.lan.raisama.net>
References: <20170323212848.8492-1-ehabkost@redhat.com>
	<20170323212848.8492-2-ehabkost@redhat.com>
	<0596af14-a95c-edbf-1441-2f1a39bdff99@suse.com>
	<CAFEAcA8Wif2DshJ1YEbxBU4MMY3W0r2U036+4qqL8YzWAuNzJg@mail.gmail.com>
	<2194e9a4-19f1-4a87-789e-f6353c6eb959@suse.com>
	<20170324111020.GB28530@thinpad.lan.raisama.net>
	<5b43c101-2dc8-0374-045f-6cc895bf10a9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b43c101-2dc8-0374-045f-6cc895bf10a9@suse.com>
Subject: Re: [Qemu-devel] [RFC 1/4] [UNTESTED] xen: Don't force
 has_dynamic_sysbus on machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Mar 24, 2017 at 01:27:31PM +0100, Juergen Gross wrote:
> On 24/03/17 12:10, Eduardo Habkost wrote:
> > On Fri, Mar 24, 2017 at 11:24:31AM +0100, Juergen Gross wrote:
> >> On 24/03/17 11:09, Peter Maydell wrote:
> >>> On 24 March 2017 at 08:23, Juergen Gross <jgross@suse.com> wrote:
> >>>> On 23/03/17 22:28, Eduardo Habkost wrote:
> >>>>> The xen-backend devices created by the Xen code are not supposed
> >>>>> to be treated as dynamic sysbus devices. This is an attempt to
> >>>>> change that and see what happens, but I couldn't test it because
> >>>>> I don't have a Xen host set up.
> >>>>>
> >>>>> If this patch breaks anything, this means we have a bug in
> >>>>> foreach_dynamic_sysbus_device(), which is supposed to return only
> >>>>> devices created using -device.
> >>>>>
> >>>>> The original code that sets has_dynamic_sysbus was added by
> >>>>> commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894, but I don't see
> >>>>> any comment explaining why it was necessary.
> >>>>
> >>>> xen-backend devices are created via qmp commands when attaching new
> >>>> pv-devices to a domain. They can be dynamically removed, too. Setting
> >>>> has_dynamic_sysbus was necessary to support this feature.
> >>>
> >>> This seems like it ought to be handled by marking the xen-backend
> >>> devices as being ok-to-dynamically-create somehow, not by marking
> >>> the machine as supporting dynamic-sysbus (which it doesn't).
> >>> Maybe we don't have the necessary support code to do that though?
> >>
> >> When writing the patches I couldn't find a way to do it differently.
> >> OTOH I'm not so deep in qemu internals I'd be able to add the needed
> >> support.
> >>
> >> I'd be happy to test any patch, though.
> > 
> > If xen-backend devices are created via QMP commands, then
> > has_dynamic_sysbus is (currently) really needed, although I would
> > have preferred to set it on all x86 machines instead of changing
> > MachineClass::has_dynamic_sysbus outside class_init.
> > 
> > But with the new whitelist implemented by this series, we could
> > simply include xen-backend in the whitelist for the machines that
> > can be used with Xen, and get rid of xen_set_dynamic_sysbus().
> > 
> > I assume plugging/unplugging xen-backend devices apply to both
> > xen{pv,fv} and pc,accel=xen, right? Do we need to make it work
> > with "-machine none,accel=xen" and "-machine isapc" too?
> 
> AFAIK -xenpv, -xenfv and -pc,accel=xen are the only machine types
> to support. Wouldn't it make sense to do the whitelisting in
> xen_be_register_common() in spite of setting has_dynamic_sysbus?

It would, but that would mean we would make the whitelisting
mechanism more complex: in addition to the static
per-machine-class whitelist, we would need a runtime whitelist.

This would make the interface for querying available/supported
device types more complex and messier, and I would like to avoid
that.

-- 
Eduardo
