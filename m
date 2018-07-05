Received: from eggs.gnu.org ([2001:4830:134:3::10]:44371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fb43b-0003eb-L3
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fb43X-0006EH-KN
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:12:23 -0400
Date: Thu, 5 Jul 2018 10:12:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180705131211.GJ7451@localhost.localdomain>
References: <20180704112859.20146-1-kraxel@redhat.com>
	<20180704185321.GZ7451@localhost.localdomain>
	<6a0aba7b46b168360fb291eaec769eb0@sebastianbauer.info>
	<20180704205206.GG7451@localhost.localdomain>
	<20180704210459.GH7451@localhost.localdomain>
	<e60e8b1220bd00040b5ae08f93095e28@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e60e8b1220bd00040b5ae08f93095e28@sebastianbauer.info>
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

On Thu, Jul 05, 2018 at 05:43:45AM +0200, Sebastian Bauer wrote:
> Am 2018-07-04 23:04, schrieb Eduardo Habkost:
> > On Wed, Jul 04, 2018 at 05:52:06PM -0300, Eduardo Habkost wrote:
> > > On Wed, Jul 04, 2018 at 10:21:19PM +0200, Sebastian Bauer wrote:
> > > > Am 2018-07-04 20:53, schrieb Eduardo Habkost:
> > > > > >      mc->kvm_type = spapr_kvm_type;
> > > > > >      machine_class_allow_dynamic_sysbus_dev(mc,
> > > > > > TYPE_SPAPR_PCI_HOST_BRIDGE);
> > > > > >      mc->pci_allow_0_address = true;
> > > > > > diff --git a/vl.c b/vl.c
> > > > > > index 16b913f9d5..e60bf2d6cd 100644
> > > > > > --- a/vl.c
> > > > > > +++ b/vl.c
> > > > > > @@ -4475,10 +4475,10 @@ int main(int argc, char **argv, char **envp)
> > > > > >      if (default_vga) {
> > > > > >          if (machine_class->default_display) {
> > > > > >              vga_model = machine_class->default_display;
> > > > > > -        } else if (vga_interface_available(VGA_CIRRUS)) {
> > > > > > -            vga_model = "cirrus";
> > > > > >          } else if (vga_interface_available(VGA_STD)) {
> > > > > >              vga_model = "std";
> > > > > > +        } else if (vga_interface_available(VGA_CIRRUS)) {
> > > > > > +            vga_model = "cirrus";
> > > > >
> > > > > If we don't make the machines above have default_display=NULL, we
> > > > > won't need this hunk, right?  In either case, I suggest doing
> > > > > this change on a separate patch.
> > > >
> > > > An alternative would be to define the default always to VGA_STD if the
> > > > machine does not override it. This is from the observation that the majority
> > > > would chose std. Obviously, having default values always has pro and cons. I
> > > > would not consider it harmful here.
> > > 
> > > That would be my preference: not having any machine with
> > > default_display==NULL.  I just don't want to make this a
> > > requirement for fixing the current bug.
> > > 
> > > >
> > > > Is there any configuration that includes VGA_CIRRUS but not VGA_STD?
> > > 
> > > Not sure, I'll check.
> > 
> > I couldn't find any:
> 
> Thanks for checking! In that case, the VGA_CIRRUS branch in the above hunk
> will never be executed (for any current config) after the proposed patch. So
> that branch could be eliminated.

I'd prefer to eliminate both vga_interface_available() checks.

> 
> I also checked the code, default values are used also for other fields in
> that struct (e.g., default_cpus). If default values are considered fragile,
> they must be changed as well in the middle term. However, given a solid
> documentation (which is currently missing for these fields) I still think
> that default values are acceptable.
> 
> Note that there seems also be the possibility to set != NULL default values
> in the machine_class_init() function.

I don't mind if the default value is defined at
machine_class_init() or main().  What bothers me is a default
value that depends on vga_interface_available(), because it can
be easily broken by a build config change (as demonstrated by the
bug fixed by this patch).

-- 
Eduardo
