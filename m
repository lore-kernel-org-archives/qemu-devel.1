Received: from eggs.gnu.org ([2001:4830:134:3::10]:56045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHB4e-0003yh-SV
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:07:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHB4Z-0006bq-Tc
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:07:00 -0500
Date: Tue, 21 Nov 2017 17:06:50 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171121170650.323c6959.cohuck@redhat.com>
In-Reply-To: <66e1c5e3-575f-ec7c-d88c-4ada23f358fa@de.ibm.com>
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<66e1c5e3-575f-ec7c-d88c-4ada23f358fa@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 21 Nov 2017 15:45:17 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 11/21/2017 02:44 PM, Cornelia Huck wrote:
> > On Tue, 21 Nov 2017 12:18:25 +0100
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > 
> > Subject: s/unresrict/unrestrict/
> >   
> >> The default css 0xFE is currently restricted to virtual subchannel
> >> devices. The hope when the decision was made was, that non-virtual
> >> subchannel devices will come around when guest can exploit multiple
> >> channel subsystems. Since the guests generally don't do, the pain
> >> of the partitioned (cssid) namespace outweighs the gain.
> >>
> >> Let us remove the corresponding restrictions (virtual devices
> >> can be put only in 0xFE and non-virtual devices in any css except
> >> the 0xFE), and inform management software property on all ccw
> >> devices.  
> > 
> > I do not really like dropping the restrictions while still keeping the
> > default cssid as 0xfe. Putting virtual devices into css 0 seems
> > completely fine, but putting non-virtual devices into css 0xfe still
> > feels a bit wrong. What about:
> > 
> > - Add a property to specify the default cssid. Compat machines use a
> >   default cssid of 0xfe.
> > - Default to a cssid of 0.
> > - (optional) Warn when putting a non-virtual device into css 0xfe,
> >   unless it is the default css.  
> 
> To make it more clear, I think the most compatible solution would be to allow
> vfio-ccw also in FE. (But continue to force virtual devices in FE as well).
> This was more or less the first proposal that we had. Then we asked ourselves
> why not also allow virtual devices in 0?
> 
> I think your proposal of specifying a default css (and then allowing
> all devices in that) is actually pretty close to Halils proposal. The only
> difference is that Halils variant keeps fe as default css. 
> So I think we could even combine both approaches. Use Halils patch as a base
> and in addition provide a way to change the default css away from fe. Have to
> think about that.

If keeping the default of 0xfe makes the life of management software
easier, sure. As it is, we seem to be far more entrenched with
paravirtual devices than I had expected when I first wrote this, so
0xfe might be the sensible choice even if mcss-e is available in the
future. In this case, I think we should lift all cssid restrictions.

> 
> 
> [...]
> >>
> >> ---
> >>  hw/s390x/ccw-device.c | 6 ++++++
> >>  hw/s390x/css.c        | 9 ---------
> >>  2 files changed, 6 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> >> index f9bfa154d6..2167ccea5d 100644
> >> --- a/hw/s390x/ccw-device.c
> >> +++ b/hw/s390x/ccw-device.c
> >> @@ -40,6 +40,10 @@ static Property ccw_device_properties[] = {
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >>  
> >> +static bool prop_get_true(Object *obj, Error **errp)
> >> +{
> >> +    return true;
> >> +}
> >>  static void ccw_device_class_init(ObjectClass *klass, void *data)
> >>  {
> >>      DeviceClass *dc = DEVICE_CLASS(klass);
> >> @@ -48,6 +52,8 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
> >>      k->realize = ccw_device_realize;
> >>      k->refill_ids = ccw_device_refill_ids;
> >>      dc->props = ccw_device_properties;
> >> +    object_class_property_add_bool(klass, "cssid-unrestricted",
> >> +                                   prop_get_true, NULL, NULL);  
> > 
> > This looks really, really strange. This is a property that is always
> > true if it exists.
> > 
> > What about compat machines? This qemu won't have the restriction, but
> > old qemus will.
> > 
> > Also, I'd consider this a property of the machine, not of the
> > individual devices. Or of the ChannelSubsystem structure, which is not
> > qom'ified.  
> 
> A property per device allow to put restrictions on specific devices if necessary.
> Not sure if we need it.

If we would need restrictions, putting in the valid cssids (or
forbidding ids) would make more sense. But frankly, I don't really see
a use case for that.

> I think for libvirt several variants would work out
> (a property as seen here, a new object, the default_css machine option)

If so, I'd vote for either a new css object or a machine option.

> 
> > 
> > As an alternative, I think providing a machine default_cssid parameter
> > makes more sense: It is understandable, and you keep compatibility. I
> > think we want this in the long run anyway.
> >   
> >>  }
> >>  
> >>  const VMStateDescription vmstate_ccw_dev = {
> >> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >> index f6b5c807cd..957cb9ec90 100644
> >> --- a/hw/s390x/css.c
> >> +++ b/hw/s390x/css.c
> >> @@ -2377,15 +2377,6 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
> >>      SubchDev *sch;
> >>  
> >>      if (bus_id.valid) {
> >> -        if (is_virtual != (bus_id.cssid == VIRTUAL_CSSID)) {
> >> -            error_setg(errp, "cssid %hhx not valid for %s devices",
> >> -                       bus_id.cssid,
> >> -                       (is_virtual ? "virtual" : "non-virtual"));
> >> -            return NULL;
> >> -        }
> >> -    }  
> > 
> > This allows building a commandline in a compat machine that will not
> > work with old qemus, no?  
> 
> I think this is pretty common to have new devices and things that will not
> work on old QEMUs but are allowed on compat machines, e.g. virtio-gpu was
> added in 2.4 but
> 
> [cborntra@oc7330422307 qemu]$ build/i386-softmmu/qemu-system-i386 -device virtio-gpu-pci -M pc-i440fx-2.2
> VNC server running on ::1:5900
> 
> works fine

It seems a bit more unexpected, though.

(And I'm still not quite sure how all of this interacts with the squash
option.)
