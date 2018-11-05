Received: from eggs.gnu.org ([2001:4830:134:3::10]:53182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gJfGg-0005fR-JT
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gJfGb-0005q9-Ca
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:50:14 -0500
Date: Mon, 5 Nov 2018 11:49:40 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181105134940.GB12503@habkost.net>
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
	<8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
	<20181030140030.gh5aa7jcgszrfajs@sirius.home.kraxel.org>
	<6fd9e9f8-838a-a13c-e957-a8e6bcb74c42@redhat.com>
	<20181030164633.2c8f21d3.cohuck@redhat.com>
	<74a8ecef-18c0-d55d-4b29-7ed6c6b57537@redhat.com>
	<20181030231545.GY3902@habkost.net>
	<20181105073028.uauojn2lv2rvkotk@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105073028.uauojn2lv2rvkotk@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH 1/4] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Mon, Nov 05, 2018 at 08:30:28AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > - Maintainers can deprecate stuffs
> > > - Orphan code can become Supported
> > > - Once scheduled for removal, there is no way back
> > > - 'Unknown' seems pretty similar to 'Orphan'.
> > 
> > I'm still worried that the supported/unsupported distinction may
> > cause unnecessary hassle for every downstream distributor of
> > QEMU.  Do we really have a need to differentiate supported vs
> > unsupported device types at runtime?
> 
> How do you suggest to handle cirrus then?
> 
> Trying to deprecate it outright didn't work very well, kind of
> understandable given that it has been the default for a long time.
> 
> So I think we have to mark cirrus as "obsolete", printing a message for
> the users that they should switch to another display device (stdvga for
> example), but keep it working for a while.
> 
> There are also a bunch of devices where I suspect they are not used much
> if at all.  All those isa sound cards for example.  Playing old DOS
> games is pretty much the only use case I can think of.  But I'm
> wondering whenever people actually use qemu for that.  There are
> alternatives which probably handle that use case better, i.e. dosbox.
> 
> Simliar case is bluetooth emulation.  I can't remember having seen any
> message or patch for years.
> 
> Tagging such devices as "obsolete", with a message asking people to
> report their use cases, might help figuring if and why those devices are
> used in the wild.

Thanks for the more detailed description of the use case you have
in mind.  It makes sense to me.

Now, I have two questions:

1) What's more important: telling the user they are relying on an
   obsolete feature, or that they are relying on an unsupported
   feature?  What exactly is the difference?

2) Do we really need to differentiate between "obsolete" and
   "deprecated" features?  What exactly is the difference?


In either case, I believe a simple supported/obsolete (or
supported/unsupported) distinction is probably going to be more
useful than a detailed
supported/maintained/odd-fixes/orphan/obsolete model.

Reviewing a list of obsolete devices downstream (to decide if
they should be still compiled in downstream) sounds doable.
Fixing up detailed supported/maintained/odd-fixes/orphan data
downstream sounds like unnecessary extra work.


> 
> > I'd prefer to make support/unsupported differentiation to be a
> > build system feature (e.g. a CONFIG_UNSUPPORTED build-time
> > option) instead of a QMP/runtime feature.
> 
> That would be nice too, but I think we need kbuild first, otherwise
> it'll be pretty messy.

Agreed.

-- 
Eduardo
