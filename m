Received: from eggs.gnu.org ([2001:4830:134:3::10]:33618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLoe0-0004Rr-7k
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 06:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLodt-0005Dp-RV
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 06:10:40 -0500
Date: Mon, 4 Dec 2017 12:10:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171204121027.3acec545.cohuck@redhat.com>
In-Reply-To: <20171201143136.62497-2-pasic@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] s390x/css: unrestrict cssids
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

On Fri,  1 Dec 2017 15:31:34 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> The default css 0xfe is currently restricted to virtual subchannel
> devices. The hope when the decision was made was, that non-virtual
> subchannel devices will come around when guests can exploit multiple
> channel subsystems. Since current guests don't do that, the pain of the
> partitioned (cssid) namespace outweighs the gain.
> 
> The default css 0xfe is currently restricted to virtual subchannel
> devices. The hope when the decision was made was, that non-virtual
> subchannel devices will come around when guest can exploit multiple
> channel subsystems. Since the guests generally don't do, the pain
> of the partitioned (cssid) namespace outweighs the gain.

Doubled paragraph?

> 
> Let us remove the corresponding restrictions (virtual devices
> can be put only in 0xfe and non-virtual devices in any css except
> the 0xfe -- while s390-squash-mcss then remaps everything to cssid 0).
> 
> At the same time, change our schema for generating css bus ids to put
> both virtual and non-virtual devices into the default css (spilling over
> into other css images, if needed). The intention is to deprecate
> s390-squash-mcss. Whit this change devices without a specified devno

s/Whit/With/

> won't end up hidden to guests not supporting multiple channel subsystems,
> unless this can not be avoided (default css full).
> 
> Deprecaton of s390-squash-mcss and indicating the changes via QMP is
> expected to follow soon (as separate commits).

Let's drop this paragraph (the qmp interface should be squashed in, and
you mention the deprecation right above.)

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

Should we document somewhere that guests supposed to be migrated should
make sure that they use explicit devnos?

> 
> Another pain-point is down- or upgrade of QEMU for command line users.
> The old way and the new way of doing vfio-ccw are mutually incompatible.
> Libvirt is only going to support the new way, so for libvirt users, the
> possible problems at QEMU downgrade are the following. If a domain
> contains virtual devices placed into a css different than 0xfe the domain
> will refuse to start with a QEMU not having this patch. Putting devices
> into a css different that 0xfe however won't make much sense in the near
> future (guest support). Libvirt will refuse to do vfio-ccw with a QEMU
> not having this patch. This is business as usual.

My writing style would be to have this as a shorter, bulleted list -
but no need to rewrite this if this is understandable to the others on
cc:

> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> ---
> Hi!
> 
> I've factored out the announcing via QMP interface stuff to ease review.
> I would not mind the two being squashed together before this hits main,
> as I would much prefer having the two as one (atomic) change. But the
> second part turned out so controversial, that splitting is expected to
> benefit the review process.
> 
> v2 -> v3:
> * factored out announcing into a separate patch
> * reworded commit message
> * removed outdated comment about squash
> 
> v1 -> v2:
> * changed ccw bus id generation too (see commit message)
> * moved the property to the machine (see cover letter)
> * added a description to the property
> ---
>  hw/s390x/3270-ccw.c        |  2 +-
>  hw/s390x/css.c             | 28 ++++------------------------
>  hw/s390x/s390-ccw.c        |  2 +-
>  hw/s390x/s390-virtio-ccw.c |  1 -
>  hw/s390x/virtio-ccw.c      |  2 +-
>  include/hw/s390x/css.h     | 12 ++++--------
>  6 files changed, 11 insertions(+), 36 deletions(-)
> 

> @@ -2396,19 +2386,8 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
>                                             bus_id.devid, &schid, errp)) {
>              return NULL;
>          }
> -    } else if (squash_mcss || is_virtual) {
> -        bus_id.cssid = channel_subsys.default_cssid;
> -
> -        if (!css_find_free_subch_and_devno(bus_id.cssid, &bus_id.ssid,
> -                                           &bus_id.devid, &schid, errp)) {
> -            return NULL;
> -        }
>      } else {
> -        for (bus_id.cssid = 0; bus_id.cssid < MAX_CSSID; ++bus_id.cssid) {
> -            if (bus_id.cssid == VIRTUAL_CSSID) {
> -                continue;
> -            }
> -
> +        for (bus_id.cssid = channel_subsys.default_cssid;;) {

This looks a bit ugly, but I don't see another compact way to do this.

>              if (!channel_subsys.css[bus_id.cssid]) {
>                  css_create_css_image(bus_id.cssid, false);
>              }
> @@ -2418,7 +2397,8 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
>                                                  NULL)) {
>                  break;
>              }
> -            if (bus_id.cssid == MAX_CSSID) {
> +            bus_id.cssid = (bus_id.cssid + 1) % MAX_CSSID;
> +            if (bus_id.cssid == channel_subsys.default_cssid) {
>                  error_setg(errp, "Virtual channel subsystem is full!");
>                  return NULL;
>              }

The interface exposing this change definitely needs to be squashed into
this patch, but else looks good.
