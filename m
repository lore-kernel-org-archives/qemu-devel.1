Received: from eggs.gnu.org ([2001:4830:134:3::10]:60472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH8rN-0000pI-3N
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH8rH-0005ei-7j
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:45:09 -0500
Date: Tue, 21 Nov 2017 14:44:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171121144457.60adb0c3.cohuck@redhat.com>
In-Reply-To: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 21 Nov 2017 12:18:25 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

Subject: s/unresrict/unrestrict/

> The default css 0xFE is currently restricted to virtual subchannel
> devices. The hope when the decision was made was, that non-virtual
> subchannel devices will come around when guest can exploit multiple
> channel subsystems. Since the guests generally don't do, the pain
> of the partitioned (cssid) namespace outweighs the gain.
> 
> Let us remove the corresponding restrictions (virtual devices
> can be put only in 0xFE and non-virtual devices in any css except
> the 0xFE), and inform management software property on all ccw
> devices.

I do not really like dropping the restrictions while still keeping the
default cssid as 0xfe. Putting virtual devices into css 0 seems
completely fine, but putting non-virtual devices into css 0xfe still
feels a bit wrong. What about:

- Add a property to specify the default cssid. Compat machines use a
  default cssid of 0xfe.
- Default to a cssid of 0.
- (optional) Warn when putting a non-virtual device into css 0xfe,
  unless it is the default css.

> 
> The adverse effect on migration should not be too severe as
> vfio-ccw devices are not live-migratable yet, and for virtual
> devices using the extra freedom would only make sense with
> the aforementioned guest support in place.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 
> ---
> Hi!
> 
> About indicating this at the ccw devices instead of, e.g. as a machine
> property (or otherwise globally), was requested by our libvirt guys. I
> have no strong opinion regarding in this matter.

I would like to understand why. It feels very odd.

> 
> This patch is intended as a discussion starter. I would at least like to
> get a Tested-by by Shalini before promoting it to non-RFC (provided the
> discussion goes well).
> 
> TODOs:
> * Consider adding a description for the new property.

As it is, it is rather incomprehensible. But see below.

> * Consider renaming VIRTUAL_CSSID.

Why? This is still reserved for virtual devices in the architecture.
You just change qemu policy (and possibly what the default cssid is).

> * Consider changing the bus-id generation scheme (when
> devno is not specified by the user). his patch keep the current scheme in
> place: they won't go into the default css (but slots are filled up
> starting at cssid 0). This is theoretically good for migration
> compatibility same command line same addresses.  Practically since there
> is no migratable non-virtual ccw device, we should consider using the
> same bus-id generation scheme for virtual and non-virtual devices.

How does this interact with the squash parameter?

If we force the default css to 0xfe for compat machines, we should be
fine if we autogenerate to the default css. If you start at css 0
regardless of the default css, you might end up with a configuration
that the user did not expect at all.

> 
> ---
>  hw/s390x/ccw-device.c | 6 ++++++
>  hw/s390x/css.c        | 9 ---------
>  2 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index f9bfa154d6..2167ccea5d 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -40,6 +40,10 @@ static Property ccw_device_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static bool prop_get_true(Object *obj, Error **errp)
> +{
> +    return true;
> +}
>  static void ccw_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -48,6 +52,8 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
>      k->realize = ccw_device_realize;
>      k->refill_ids = ccw_device_refill_ids;
>      dc->props = ccw_device_properties;
> +    object_class_property_add_bool(klass, "cssid-unrestricted",
> +                                   prop_get_true, NULL, NULL);

This looks really, really strange. This is a property that is always
true if it exists.

What about compat machines? This qemu won't have the restriction, but
old qemus will.

Also, I'd consider this a property of the machine, not of the
individual devices. Or of the ChannelSubsystem structure, which is not
qom'ified.

As an alternative, I think providing a machine default_cssid parameter
makes more sense: It is understandable, and you keep compatibility. I
think we want this in the long run anyway.

>  }
>  
>  const VMStateDescription vmstate_ccw_dev = {
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index f6b5c807cd..957cb9ec90 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -2377,15 +2377,6 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
>      SubchDev *sch;
>  
>      if (bus_id.valid) {
> -        if (is_virtual != (bus_id.cssid == VIRTUAL_CSSID)) {
> -            error_setg(errp, "cssid %hhx not valid for %s devices",
> -                       bus_id.cssid,
> -                       (is_virtual ? "virtual" : "non-virtual"));
> -            return NULL;
> -        }
> -    }

This allows building a commandline in a compat machine that will not
work with old qemus, no?

> -
> -    if (bus_id.valid) {
>          if (squash_mcss) {
>              bus_id.cssid = channel_subsys.default_cssid;
>          } else if (!channel_subsys.css[bus_id.cssid]) {
