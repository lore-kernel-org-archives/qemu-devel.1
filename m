Received: from eggs.gnu.org ([2001:4830:134:3::10]:52140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ579-00080o-A3
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 21:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ573-0007N0-HA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 21:28:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZ573-0007LP-4E
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 21:28:01 -0500
Date: Mon, 17 Dec 2018 21:27:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181217212733-mutt-send-email-mst@kernel.org>
References: <154464279386.9828.10219496338109023342.stgit@gimli.home>
	<154464358344.9828.234735873419417928.stgit@gimli.home>
	<20181217202850-mutt-send-email-mst@kernel.org>
	<20181217184404.2aaedd34@x1.home>
	<20181217204619-mutt-send-email-mst@kernel.org>
	<20181217185432.0c379928@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217185432.0c379928@x1.home>
Subject: Re: [Qemu-devel] [PATCH v5 6/8] pcie: Allow generic PCIe root port
 to specify link speed and width
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Geoffrey McRae <geoff@hostfission.com>, Eric Auger <eric.auger@redhat.com>

On Mon, Dec 17, 2018 at 06:54:32PM -0700, Alex Williamson wrote:
> On Mon, 17 Dec 2018 20:47:26 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Dec 17, 2018 at 06:44:04PM -0700, Alex Williamson wrote:
> > > On Mon, 17 Dec 2018 20:29:37 -0500
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Wed, Dec 12, 2018 at 12:39:43PM -0700, Alex Williamson wrote:  
> > > > > Allow users to experimentally specify speed and width values for the
> > > > > generic PCIe root port.  Defaults remain at 2.5GT/s & x1 for
> > > > > compatiblity with the intent to only support changing defaults via
> > > > > machine types for now.
> > > > > 
> > > > > Note for libvirt testing that pcie-root-port controllers are given
> > > > > default names like "pci.7" which don't play well with using the
> > > > > "-set device.$name.$prop=$value" options accessible to us via
> > > > > <qemu:commandline> options.  The solution is to add an <alias> to the
> > > > > pcie-root-port <controller>, for example:
> > > > > 
> > > > >     <controller type='pci' index='7' model='pcie-root-port'>
> > > > >       <model name='pcie-root-port'/>
> > > > >       <target chassis='7' port='0x15'/>
> > > > >       <alias name='ua-gfx0'/>
> > > > >       <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x5'/>
> > > > >     </controller>
> > > > > 
> > > > > The "ua-" here is a mandatory prefix.  We can then use:
> > > > > 
> > > > >   <qemu:commandline>
> > > > >     <qemu:arg value='-set'/>
> > > > >     <qemu:arg value='device.ua-gfx0.x-speed=8'/>
> > > > >     <qemu:arg value='-set'/>
> > > > >     <qemu:arg value='device.ua-gfx0.x-width=16'/>
> > > > >   </qemu:commandline>
> > > > > 
> > > > > or, without an alias, set globals such as:
> > > > > 
> > > > >   <qemu:commandline>
> > > > >     <qemu:arg value='-global'/>
> > > > >     <qemu:arg value='pcie-root-port.x-speed=8'/>
> > > > >     <qemu:arg value='-global'/>
> > > > >     <qemu:arg value='pcie-root-port.x-width=16'/>
> > > > >   </qemu:commandline>
> > > > > 
> > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > > > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > > > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > ---
> > > > >  hw/pci-bridge/gen_pcie_root_port.c |    4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > > 
> > > > > diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> > > > > index 299de429ec1e..ca5418a89dd2 100644
> > > > > --- a/hw/pci-bridge/gen_pcie_root_port.c
> > > > > +++ b/hw/pci-bridge/gen_pcie_root_port.c
> > > > > @@ -124,6 +124,10 @@ static Property gen_rp_props[] = {
> > > > >                       res_reserve.mem_pref_32, -1),
> > > > >      DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,
> > > > >                       res_reserve.mem_pref_64, -1),
> > > > > +    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
> > > > > +                                speed, PCIE_LINK_SPEED_2_5),
> > > > > +    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> > > > > +                                width, PCIE_LINK_WIDTH_1),
> > > > >      DEFINE_PROP_END_OF_LIST()
> > > > >  };
> > > > >      
> > > > 
> > > > Doesn't seem to build.
> > > > Just where is DEFINE_PROP_PCIE_LINK_SPEED defined?  
> > > 
> > > In 3/8:
> > > 
> > > diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> > > index 3ab9cd2eb69f..b6758c852e11 100644
> > > --- a/include/hw/qdev-properties.h
> > > +++ b/include/hw/qdev-properties.h
> > > @@ -36,6 +36,8 @@ extern const PropertyInfo qdev_prop_uuid;
> > >  extern const PropertyIn qdev_prop_arraylen;
> > >  extern const PropertyInfo qdev_prop_link;
> > >  extern const PropertyInfo qdev_prop_off_auto_pcibar;
> > > +extern const PropertyInfo qdev_prop_pcie_link_speed;
> > > +extern const PropertyInfo qdev_prop_pcie_link_width;
> > >  
> > >  #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
> > >          .name      = (_name),                                    \
> > > @@ -217,6 +219,12 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar;
> > >  #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
> > >      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
> > >                          OffAutoPCIBAR)
> > > +#define DEFINE_PROP_PCIE_LINK_SPEED(_n, _s, _f, _d) \
> > > +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_speed, \
> > > +                        PCIExpLinkSpeed)
> > > +#define DEFINE_PROP_PCIE_LINK_WIDTH(_n, _s, _f, _d) \
> > > +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_width, \
> > > +                        PCIExpLinkWidth)
> > >  
> > >  #define DEFINE_PROP_UUID(_name, _state, _field) {                  \
> > >          .name      = (_name),                                      \
> > > 
> > > Did something go wrong applying that patch?  I'll double check on my
> > > end.  Thanks,
> > > 
> > > Alex  
> > 
> > Oh I just wasn't copied. So I missed this patch when applying.
> 
> Ah, sorry, I should have forced your Cc on all the patches.  I'd also
> welcome you to include 7/8 in the series to keep things altogether,
> you're directly copied on all the others.  Thanks,
> 
> Alex

Done.

-- 
MST
