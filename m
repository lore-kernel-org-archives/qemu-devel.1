Received: from eggs.gnu.org ([2001:4830:134:3::10]:32885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK1cW-0008Gs-V5
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK1cR-0002nw-Th
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:37:45 -0500
Date: Wed, 29 Nov 2017 13:37:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171129133733.7fc11968.cohuck@redhat.com>
In-Reply-To: <20171128130758.67556-1-pasic@linux.vnet.ibm.com>
References: <20171128130758.67556-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/1] s390x/css: unrestrict cssids
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

On Tue, 28 Nov 2017 14:07:58 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> The default css 0xfe is currently restricted to virtual subchannel
> devices. The hope when the decision was made was, that non-virtual
> subchannel devices will come around when guest can exploit multiple

s/guest/guests/

> channel subsystems. Since the guests generally don't do, the pain

s/the guests generally don't do/current guests don't do that/

> of the partitioned (cssid) namespace outweighs the gain.
> 
> Let us remove the corresponding restrictions (virtual devices
> can be put only in 0xfe and non-virtual devices in any css except
> the 0xfe -- while s390-squash-mcss then remaps everything to cssid 0).
> 
> With this change, however, our schema for generating a css bus ids, if
> none is specified does not make much sense. Currently we start at cssid
> 0x0 for non-virtual devices and use the default css (without
> s390-squash-mcss exclusively) for virtual devices.  That means for
> non-virtual device the device would auto-magically end up non-visible for
> guests (which can't use the other channel subsystems).
> 
> Thus let us also change the css bus id auto assignment algorithm,
> so that we first fill the default css, and then proceed to the
> next one (modulo MAX_CSSID).

Let's reword the previous two paragraphs:

"At the same time, change our schema for generating css bus ids to put
both virtual and non-virtual devices into the default css (spilling
over into other css images, if needed) so that devices without a
specified id don't end up hidden to guests not supporting multiple
channel subsystems."

> 
> The adverse effect of getting rid of the restriction on migration should
> not be too severe.  Vfio-ccw devices are not live-migratable yet, and for
> virtual devices using the extra freedom would only make sense with the
> aforementioned guest support in place.
> 
> The auto-generated bus ids are affected by both changes. We hope to not
> encounter any auto-generated bus ids in production as Libvirt is always
> explicit about the bus id.  Since 8ed179c937 ("s390x/css: catch section
> mismatch on load", 2017-05-18) the worst that can happen because the same
> device ended up having a different bus id is a cleanly failed migration.
> I find it hard to reason about the impact of changed auto-generated bus
> ids on migration for command line users as I don't know which rules is
> such an user supposed to follow.
> 
> Another pain-point is down- or upgrade of QEMU for command line users.
> The old way and the new way of doing vfio-ccw are mutually incompatible.
> Libvirt is only going to support the new way, so for libvirt users, the
> possible problems at QEMU downgrade are the following. If a domain
> contains virtual devices placed into a css different than 0xfe the domain
> wil refuse to start with a QEMU not having this patch. Putting devices
> into a css different that 0xfe however won't make much sense in the
> near future (guest support). Libvirt will refuse to do vfio-ccw with
> a QEMU not having this patch. This is business as usual.

All of this is valuable information, but I don't think a changelog is
the right place for it. We should really have a place where we can also
save things like Dong Jia's writeup downthread. In the documentation
folder or on the QEMU wiki (or both). We can be much more verbose there
(including examples, which make this stuff way easier to understand).
I'd recommend adding a documentation file with this patch (or patch
series, as I'd also like to see a squash-mcss deprecation patch).

> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> ---
> Hi all!
> 
> Moving the property to the machine turned out very ugly (IMHO).  Libvirt
> detects machine properties via query-command-line-options.  This is
> however decoupled from the existence of the actual property: one needs to
> touch util/qemu-config.c (see patch) so the property shows up.
> Furthermore this stuff is global. I've also noticed that the infamous
> s390-squash-mcss does not show up.

s390x-softmmu/qemu-system-s390x -machine s390-ccw-virtio,help

shows it, as does qom-list on /machine.

Output of <qemu binary> --help is very haphazard anyway and you should
rely on the interfaces above.

> 
> On the other hand to get the property displayed by -machine
> s390-ccw-virtio,help one needs a setter on the property. So I have
> created a fake setter which produces an error each time called.

Yes, this is fugly. A css object would be a better place, but way too
much work for now.

> 
> I would strongly prefer putting back the property to the device level!

I continue to strongly oppose that. The device is entirely the wrong
level.

> 
> v1 -> v2:
> * changed ccw bus id generation too (see commit message)
> * moved the property to the machine (see cover letter)
> * added a description to the property
> ---
>  hw/s390x/3270-ccw.c        |  2 +-
>  hw/s390x/css.c             | 28 ++++------------------------
>  hw/s390x/s390-ccw.c        |  2 +-
>  hw/s390x/s390-virtio-ccw.c | 21 +++++++++++++++++++++
>  hw/s390x/virtio-ccw.c      |  2 +-
>  include/hw/s390x/css.h     | 12 ++++--------
>  util/qemu-config.c         |  6 ++++++
>  7 files changed, 38 insertions(+), 35 deletions(-)
> 

> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 6a57f94197..b558b2adad 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -556,6 +556,21 @@ static inline void machine_set_squash_mcss(Object *obj, bool value,
>      ms->s390_squash_mcss = value;
>  }
>  
> +static bool prop_get_true(Object *obj, Error **errp)
> +{
> +    return true;
> +}

I'd prefer to have something with 'cssid' in the name. An always-true
property should be rather the exception.

> +
> +/*
> + * This is a fake setter so the device shows up in the output of
> + * --machine s390-ccw-virtio,help.

Having a required setter is ugly. I wonder whether there's a better way
for non-modifiable properties. I doubt it, though.

> + */
> +static inline void prop_set_bool_fail(Object *obj, bool value,
> +                                           Error **errp)
> +{
> +    error_setg(errp, "Tried to set non-settable property!");
> +}
> +
>  static inline void s390_machine_initfn(Object *obj)
>  {
>      object_property_add_bool(obj, "aes-key-wrap",
> @@ -587,6 +602,12 @@ static inline void s390_machine_initfn(Object *obj)
>              "enable/disable squashing subchannels into the default css",
>              NULL);
>      object_property_set_bool(obj, false, "s390-squash-mcss", NULL);
> +    object_property_add_bool(obj, "cssid-unrestricted",
> +                                   prop_get_true, prop_set_bool_fail, NULL);
> +    object_property_set_description(obj, "cssid-unrestricted",
> +            "can use any cssid with any css device (the restriction,"
> +            " 0xfe for virtual and 0x00-0xfd for non-virtual, is no more)",
> +            NULL);
>  }
>  
>  static const TypeInfo ccw_machine_info = {

I suggest that you also update the comment for the squash-mcss
dependent css image creation in ccw_init().

> diff --git a/util/qemu-config.c b/util/qemu-config.c
> index 99b0e46fa3..acfc452fc2 100644
> --- a/util/qemu-config.c
> +++ b/util/qemu-config.c
> @@ -233,6 +233,12 @@ static QemuOptsList machine_opts = {
>              .help = "Up to 8 chars in set of [A-Za-z0-9. ](lower case chars"
>                      " converted to upper case) to pass to machine"
>                      " loader, boot manager, and guest kernel",
> +        },{
> +            /* TODO: Consider device property. This is way too ugly. */

It is ugly, but a device property is worse.

> +            .name = "cssid-unrestricted",
> +            .type = QEMU_OPT_BOOL,
> +            .help = "can use any cssid with any css device (the restriction,"
> +            " 0xfe for virtual and 0x00-0xfd for non-virtual, is no more)",

"Always true (a css device can use any cssid, regardless whether
virtual or not)"

?

>          },
>          { /* End of list */ }
>      }
