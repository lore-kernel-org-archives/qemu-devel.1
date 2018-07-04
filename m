Received: from eggs.gnu.org ([2001:4830:134:3::10]:40801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1faoxc-0002z9-44
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 17:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1faoxZ-00082p-Fn
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 17:05:12 -0400
Date: Wed, 4 Jul 2018 17:52:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180704205206.GG7451@localhost.localdomain>
References: <20180704112859.20146-1-kraxel@redhat.com>
	<20180704185321.GZ7451@localhost.localdomain>
	<6a0aba7b46b168360fb291eaec769eb0@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a0aba7b46b168360fb291eaec769eb0@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] vga: make stdvga the global default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Jul 04, 2018 at 10:21:19PM +0200, Sebastian Bauer wrote:
> Am 2018-07-04 20:53, schrieb Eduardo Habkost:
> > >      mc->kvm_type = spapr_kvm_type;
> > >      machine_class_allow_dynamic_sysbus_dev(mc,
> > > TYPE_SPAPR_PCI_HOST_BRIDGE);
> > >      mc->pci_allow_0_address = true;
> > > diff --git a/vl.c b/vl.c
> > > index 16b913f9d5..e60bf2d6cd 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -4475,10 +4475,10 @@ int main(int argc, char **argv, char **envp)
> > >      if (default_vga) {
> > >          if (machine_class->default_display) {
> > >              vga_model = machine_class->default_display;
> > > -        } else if (vga_interface_available(VGA_CIRRUS)) {
> > > -            vga_model = "cirrus";
> > >          } else if (vga_interface_available(VGA_STD)) {
> > >              vga_model = "std";
> > > +        } else if (vga_interface_available(VGA_CIRRUS)) {
> > > +            vga_model = "cirrus";
> > 
> > If we don't make the machines above have default_display=NULL, we
> > won't need this hunk, right?  In either case, I suggest doing
> > this change on a separate patch.
> 
> An alternative would be to define the default always to VGA_STD if the
> machine does not override it. This is from the observation that the majority
> would chose std. Obviously, having default values always has pro and cons. I
> would not consider it harmful here.

That would be my preference: not having any machine with
default_display==NULL.  I just don't want to make this a
requirement for fixing the current bug.

> 
> Is there any configuration that includes VGA_CIRRUS but not VGA_STD?

Not sure, I'll check.

-- 
Eduardo
