Received: from eggs.gnu.org ([2001:4830:134:3::10]:40080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ef8Cp-0003Y3-Am
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ef8Co-0007Zy-Cm
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:54:27 -0500
Date: Fri, 26 Jan 2018 15:54:18 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180126175418.GH25150@localhost.localdomain>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-UO5Y_ACSZ2EEQEzgy30wdfEm3u8wUrBrXWaQaE_v+Kw@mail.gmail.com>
	<20171209010811.GJ3037@localhost.localdomain>
	<CAFEAcA9oG=+mJ+jSGTM_z54S09gjHoFowDkOvofdkhJd+g3=Cw@mail.gmail.com>
	<20180122183301.GA31237@localhost.localdomain>
	<CAFEAcA8pGXMs3hMxSs-t7qGfeR__H-CQ1roRVe5NFMCP8R2vjw@mail.gmail.com>
	<20180126104247.GF25150@localhost.localdomain>
	<CAFEAcA_zU+tAMvcqNHQAaVOEaJrrGOEWPS8RpUi+eZQ3tf1yiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_zU+tAMvcqNHQAaVOEaJrrGOEWPS8RpUi+eZQ3tf1yiQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On Fri, Jan 26, 2018 at 11:02:24AM +0000, Peter Maydell wrote:
> On 26 January 2018 at 10:42, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Thu, Jan 25, 2018 at 02:41:50PM +0000, Peter Maydell wrote:
> >> I'm not sure if we actually support command line setting/unsetting
> >> of features for Arm CPUs -- is there a command line option to
> >> get QEMU to print the features it thinks can be set this way?
> >
> > Unfortunately -cpu command-line parsing is still a mess (we
> > currently have lots of arch-specific parsing hooks).  Once we
> > make this uniform across targets, we could make "-cpu ?" print
> > all known properties.
> >
> > But you can look at the list of QOM properties for your CPU
> > classes (-cpu options are simply translated to QOM properties).
> > e.g.:
> >
> >   (QEMU) device-list-properties typename=pxa270-a0-arm-cpu
> >   {"return": [{"type": "uint32", "name": "midr"}, {"type": "uint64", "name": "mp-affinity"}, {"type": "child<irq>", "name": "unnamed-gpio-in[0]"}, {"type": "uint32", "name": "psci-conduit"}, {"type": "bool", "name": "reset-hivecs"}, {"type": "link<qemu:memory-region>", "name": "memory"}, {"type": "link<irq>", "name": "unnamed-gpio-out[2]"}, {"type": "link<irq>", "name": "unnamed-gpio-out[3]"}, {"type": "int32", "name": "node-id"}, {"type": "bool", "name": "start-powered-off"}, {"type": "link<irq>", "name": "unnamed-gpio-out[1]"}, {"type": "link<irq>", "name": "unnamed-gpio-out[0]"}, {"type": "link<irq>", "name": "gicv3-maintenance-interrupt[0]"}, {"type": "bool", "name": "cfgend"}, {"type": "child<irq>", "name": "unnamed-gpio-in[2]"}, {"type": "child<irq>", "name": "unnamed-gpio-in[3]"}, {"type": "child<irq>", "name": "unnamed-gpio-in[1]"}]}
> 
> None of those are things we'd want to expose to the user, really
> (except maybe 'cfgend'): they're all intended for the QEMU board
> or SoC code that needs to configure and wire the CPU up. Ideally
> there'd be a mechanism for screening them out of the -cpu option
> list.
> 

Yeah, it's becoming clearer to me that we need to address this
better than with a simple "x-" prefix convention.

If we remove the link and child properties, we have:

midr (uint32)
mp-affinity (uint64)
psci-conduit (uint32)
reset-hivecs (bool)
node-id (int32)
start-powered-off (bool)
cfgend (bool)

I wonder how many of them aren't useful with -cpu but might be
useful with -device in the future.


> There are some things that we could in theory have as user
> settable properties (like "does this CPU have an FPU"), but
> we don't currently have QOM properties for them (each CPU
> just hardcodes which ARM_FEATURE_* flags it has).
> 
> In your other email you write:
> > I wrote:
> >> Given that the type names don't appear to the user, I think
> >> we can go ahead with implementing "-cpu max" for Arm without
> >> having to first disentangle this? "max" isn't in any worse
> >> a position than the existing "host" and "any" types.
> >
> >Sounds reasonable to me.
> 
> Cool. I think that means that patches 2-6 here don't need
> any changes, but I'll rebase, retest and resend just to
> avoid confusion.
> 
> thanks
> -- PMM

-- 
Eduardo
