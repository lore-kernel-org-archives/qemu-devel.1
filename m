Received: from eggs.gnu.org ([209.51.188.92]:35113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwsFY-0004S3-1Y
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwsFW-0002RL-O2
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:35:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gwsFW-0002Kk-Dm
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:35:06 -0500
Date: Thu, 21 Feb 2019 10:34:50 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190221103450.4f37e60f@w520.home>
In-Reply-To: <20190221073850.rgygkl3uyn4rxswl@sirius.home.kraxel.org>
References: <20190220084753.9130-1-kraxel@redhat.com>
	<20190220084753.9130-2-kraxel@redhat.com>
	<20190220145435.1881d7a8@w520.home>
	<20190221073850.rgygkl3uyn4rxswl@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] vfio/display: add edid support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org

On Thu, 21 Feb 2019 08:38:50 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Wed, Feb 20, 2019 at 02:54:35PM -0700, Alex Williamson wrote:
> > On Wed, 20 Feb 2019 09:47:51 +0100
> > Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   
> > > This patch adds EDID support to the vfio display (aka vgpu) code.
> > > When supported by the mdev driver qemu will generate a EDID blob
> > > and pass it on using the new vfio edid region.  The EDID blob will
> > > be updated on UI changes (i.e. window resize), so the guest can
> > > adapt.  
> > 
> > What are the requirements to enable this resizing feature?  I grabbed
> > the gvt-next-2019-02-01 branch and my ever expanding qemu:commandline
> > now looks like this:
> > 
> >   <qemu:commandline>
> >     <qemu:arg value='-set'/>
> >     <qemu:arg value='device.hostdev0.x-igd-opregion=on'/>
> >     <qemu:arg value='-set'/>
> >     <qemu:arg value='device.hostdev0.ramfb=on'/>
> >     <qemu:arg value='-set'/>
> >     <qemu:arg value='device.hostdev0.driver=vfio-pci-nohotplug'/>
> >     <qemu:arg value='-set'/>
> >     <qemu:arg value='device.hostdev0.xres=1600'/>
> >     <qemu:arg value='-set'/>
> >     <qemu:arg value='device.hostdev0.yres=900'/>
> >   </qemu:commandline>
> > 
> > Other relevant sections:
> > 
> >     <graphics type='spice'>
> >       <listen type='none'/>
> >       <gl enable='yes' rendernode='/dev/dri/by-path/pci-0000:00:02.0-render'/>
> >     </graphics>  
> 
> When using spice you also need the spicevmc channel and the spice agent
> being installed and active in the guest.

This is the vdagent using installation like this:

https://www.ovirt.org/develop/infra/testing/spice.html

ie. vdservice install, net start vdservice?

I'm not seeing anything magically change when I do that.  I do have the
default serial and redirection devices installed by virt-manager:

     <serial type='pty'>
      <source path='/dev/pts/4'/>
      <target type='isa-serial' port='0'>
        <model name='isa-serial'/>
      </target>
      <alias name='serial0'/>
    </serial>
    <console type='pty' tty='/dev/pts/4'>
      <source path='/dev/pts/4'/>
      <target type='serial' port='0'/>
      <alias name='serial0'/>
    </console>
    <redirdev bus='usb' type='spicevmc'>
      <alias name='redir0'/>
      <address type='usb' bus='0' port='2'/>
    </redirdev>
    <redirdev bus='usb' type='spicevmc'>
      <alias name='redir1'/>
      <address type='usb' bus='0' port='3'/>
    </redirdev>

I believe I have drivers installed, but it's a bit difficult to verify
given the Intel graphics glitches I copied you on.

> > > +    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
> > > +    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
> > > +    trace_vfio_display_edid_link_up();
> > > +    return;
> > > +
> > > +err:
> > > +    trace_vfio_display_edid_write_error();
> > > +    return;  
> > 
> > nit, no unwind and only one call point, could probably do without the
> > goto.  
> 
> Not that easily due to the goto being hidden in the pwrite_field()
> macro.

Ah, I knew those macros were going to be tricky, but I fell for it
anyway.  Sorry.

> > > +    trace_vfio_display_edid_available();
> > > +    dpy->edid_regs = g_new0(struct vfio_region_gfx_edid, 1);
> > > +    pread_field(fd, dpy->edid_info, dpy->edid_regs, edid_offset);
> > > +    pread_field(fd, dpy->edid_info, dpy->edid_regs, edid_max_size);
> > > +    pread_field(fd, dpy->edid_info, dpy->edid_regs, max_xres);
> > > +    pread_field(fd, dpy->edid_info, dpy->edid_regs, max_yres);
> > > +    dpy->edid_blob = g_malloc0(dpy->edid_regs->edid_max_size);
> > > +
> > > +    vfio_display_edid_update(vdev, true, 0, 0);
> > > +    return;
> > > +
> > > +err:
> > > +    fprintf(stderr, "%s: Oops, pread error\n", __func__);
> > > +    g_free(dpy->edid_regs);
> > > +    dpy->edid_regs = NULL;
> > > +    return;  
> > 
> > This code is unreachable.  
> 
> It's not.  Again, the goto is in pread_field.
> 
> But I just noticed I missed one fprintf which should be a
> trace_vfio_display_edid_write_error() ...

Yep.
