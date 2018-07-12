Received: from eggs.gnu.org ([2001:4830:134:3::10]:46548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdfNs-0004KG-5S
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdfNp-0003jr-Ej
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:28:04 -0400
Date: Thu, 12 Jul 2018 14:27:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180712172745.GG31657@localhost.localdomain>
References: <20180705064348.3162-3-kraxel@redhat.com>
	<20180705163501.GN7451@localhost.localdomain>
	<20180706065342.pggd2qgd4nyv35ys@sirius.home.kraxel.org>
	<20180709210833.GC7451@localhost.localdomain>
	<20180709212319.GB22336@localhost.localdomain>
	<11c6f7d4364062c42df990364bf2c2de@sebastianbauer.info>
	<20180711154850.GT7451@localhost.localdomain>
	<2b7f5bdfd86278524b4540f512eecbc7@sebastianbauer.info>
	<20180711184311.GX7451@localhost.localdomain>
	<6f4a875e-a85f-1926-88af-91a260e334a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4a875e-a85f-1926-88af-91a260e334a7@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 2/2] vga: don't pick cirrus
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, Aleksandar Markovic <aleksandar.markovic@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu, Jul 12, 2018 at 06:57:46AM +0200, Thomas Huth wrote:
> On 11.07.2018 20:43, Eduardo Habkost wrote:
> > On Wed, Jul 11, 2018 at 07:00:54PM +0200, Sebastian Bauer wrote:
> >> Am 2018-07-11 17:48, schrieb Eduardo Habkost:
> >>> "none" looked like a false positive when I first looked, but now
> >>> I think it's not.  Shouldn't it set default_display="none"?
> >>
> >> I think that there is some other logic burried that these machine doesn't
> >> get a graphics display. But overall it is indeed not clearly defined.
> >>
> >> But see below.
> >>
> >>>> If the patch is applied to 3.1 then I think there is enough time to
> >>>> fix
> >>>> issues caused by the patch. Additionally, a warning could be put in
> >>>> the
> >>>> ChangeLog for 3.0 that in 3.1 that the default mode will be std unless
> >>>> machines define an own default. This is should be enough time for
> >>>> people to
> >>>> complain or to fix things.
> >>> I don't think we will really make user-visible changes: we can
> >>> simply work to keep existing behavior, but the difference is that
> >>> this will be implemented by setting default_display explicitly on
> >>> all machines.
> >>
> >> Even if all machines were using explicit default settings the patch will
> >> affect machines that are not inside the QEMU tree. If the patch is to be
> >> applied as it is these are affected. To warn users (or devs in this case)
> >> about this, an entry in the ChangeLog would be appropriate.
> > 
> > What do you mean by "machines that are not inside the QEMU tree"?
> > MachineClass registration is not an API for external use.
> > 
> >>
> >>>> If the patch is to be applied to 3.0 then all non-ppc ones need to be
> >>>> reconsidered.
> >>>> The "important" ppc machines have been fixed already. I can do the
> >>>> remaining
> >>>> if this is wanted.
> >>> This part worries me: do we have other machines that are broken
> >>> right now?
> >>
> >> I don't know which of them are broken or how this can be elaborated, but
> >> they are potentially affected. For instance, the sam460ex platform doesn't
> >> care about this setting, I can say that it is not broken. Other platforms
> >> like the mac apparently were broken (and fixed in the meantime). It is hard
> >> to tell which of them are really broken without someone that knows the
> >> platform trying it and telling it. 'Make check' did catch only one single
> >> case. It could also be that nobody cares about other affected machines.
> >>
> >> Overall I think the patch is an improvement over the previous state as
> >> preferring the Cirrus doesn't make much sense if most machines don't prefer
> >> it. The more I think over it, the more I think that the concept needs
> >> further fine-tuning though (not necessarily in this patch).
> > 
> > I'm not sure yet if most machines with default_display==NULL
> > don't want Cirrus.  I'm also unsure if any of the machines from
> > that list will break if we start using VGA by default.
> 
> I think most machines with default_display == NULL simply do not want
> any graphic cards at all. So we likely document that default_display ==
> NULL means no graphic card, and fix the machines that have other
> assumptions if necessary.

We already have a value meaning "no graphics card": "none".

But like with the "cirrus" and "vga" options, I also don't know
if any of the existing machines with default_display==NULL will
break if we start using "none" by default.

> 
> >>                     [...]  I still think that the most common value can be a
> >> default (strictly bailing out when it is not available unlike it is done
> >> now), but this is a matter of taste I guess.
> > 
> > This is doable too, if we have a clear consensus on what would be
> > a reasonable default on TYPE_MACHINE.  Personally I prefer the
> > default on TYPE_MACHINE to be "none".
> 
> Yes, please, no magic default hardware for all machines. That will only
> cause confusion and problems in the future. People who add new boards
> will keep forgetting to set a value in their new boards and then you
> later wonder whether that was on purpose or by accident ==> If there is
> no default display set, this should simply mean "no display".

Agreed.

-- 
Eduardo
