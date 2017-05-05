Received: from eggs.gnu.org ([2001:4830:134:3::10]:43648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6c5d-0003Ox-Ku
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6c5a-0002Io-EA
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:12:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d6c5a-0002IV-57
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:12:02 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45C4WI7070185
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 08:12:00 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8r1y38x1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:12:00 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 5 May 2017 13:11:58 +0100
Date: Fri, 5 May 2017 14:11:53 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170505020352.8984-6-bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-6-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170505141153.60d0d0bf.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 05/13] s390x/css: realize css_create_sch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com

On Fri,  5 May 2017 04:03:44 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> The S390 virtual css support already has a mechanism to create a
> virtual subchannel and provide it to the guest. However, to
> pass-through subchannels to a guest, we need to introduce a new
> mechanism to create the subchannel according to the real device
> information. Thus we reconstruct css_create_virtual_sch to a new
> css_create_sch function to handl all these cases and do allocation

s/handl/handle/

> and initialization of the subchannel according to the device type
> and machine configuration.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  hw/s390x/css-bridge.c         |  2 ++
>  hw/s390x/css.c                | 45 ++++++++++++++++++++++++++++++++++++-------
>  hw/s390x/s390-virtio-ccw.c    | 12 +++++++++---
>  hw/s390x/virtio-ccw.c         |  6 +++++-
>  include/hw/s390x/css-bridge.h |  1 +
>  include/hw/s390x/css.h        | 25 ++++++++++++++++--------
>  6 files changed, 72 insertions(+), 19 deletions(-)
> 

> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 748e2ad..1052eea 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1924,28 +1924,59 @@ PropertyInfo css_devid_ro_propinfo = {
>      .get = get_css_devid,
>  };
> 
> -SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp)
> +SubchDev *css_create_sch(CssDevId bus_id, bool is_virtio, bool squash_mcss,
> +                         Error **errp)
>  {
>      uint16_t schid = 0;
>      SubchDev *sch;
> 
>      if (bus_id.valid) {
> -        /* Enforce use of virtual cssid. */
> -        if (bus_id.cssid != VIRTUAL_CSSID) {
> -            error_setg(errp, "cssid %hhx not valid for virtual devices",
> -                       bus_id.cssid);
> +        if (is_virtio != (bus_id.cssid == VIRTUAL_CSSID)) {
> +            error_setg(errp, "cssid %hhx not valid for %s devices",
> +                       bus_id.cssid,
> +                       (is_virtio ? "virtio" : "non-virtio"));

This reminds me of something else: virtual 3270 devices will use the
virtual channel subsystem by default. I think this is fine: Even though
they are not virtio devices, they are fully virtual constructs, and it
does not make sense to artificially shove them into another css.

But this means the distinction should be virtual vs. non-virtual and
not virtio vs. non-virtio, and the squashing is only applicable to
non-virtual devices. Mainly a naming thing.


>              return NULL;
>          }
> +    }
> +
> +    if (bus_id.valid) {
> +        if (squash_mcss) {
> +            bus_id.cssid = channel_subsys.default_cssid;
> +        } else if (!channel_subsys.css[bus_id.cssid]) {
> +            css_create_css_image(bus_id.cssid, false);
> +        }
> +
>          if (!css_find_free_subch_for_devno(bus_id.cssid, bus_id.ssid,
>                                             bus_id.devid, &schid, errp)) {
>              return NULL;
>          }
> -    } else {
> -        bus_id.cssid = VIRTUAL_CSSID;
> +    } else if (squash_mcss || is_virtio) {
> +        bus_id.cssid = channel_subsys.default_cssid;
> +
>          if (!css_find_free_subch_and_devno(bus_id.cssid, &bus_id.ssid,
>                                             &bus_id.devid, &schid, errp)) {
>              return NULL;
>          }
> +    } else {
> +        for (bus_id.cssid = 0; bus_id.cssid < MAX_CSSID; ++bus_id.cssid) {
> +            if (bus_id.cssid == VIRTUAL_CSSID) {
> +                continue;
> +            }
> +
> +            if (!channel_subsys.css[bus_id.cssid]) {
> +                css_create_css_image(bus_id.cssid, false);
> +            }
> +
> +            if   (css_find_free_subch_and_devno(bus_id.cssid, &bus_id.ssid,
> +                                                &bus_id.devid, &schid,
> +                                                NULL)) {
> +                break  ;

extra blanks

> +            }
> +            if (bus_id.cssid == MAX_CSSID) {
> +                error_setg(errp, "Virtual channel subsystem is full!");
> +                return NULL;
> +            }
> +        }
>      }
> 
>      sch = g_malloc0(sizeof(*sch));
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index cd007ca..735d66d 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -136,10 +136,16 @@ static void ccw_init(MachineState *machine)
>          kvm_s390_enable_css_support(s390_cpu_addr2state(0));
>      }
>      /*
> -     * Create virtual css and set it as default so that non mcss-e
> -     * enabled guests only see virtio devices.
> +     * Non mcss-e enabled guests only see the devices from the default
> +     * css, which is determined by the value of the squash_mcss property.
> +     * Note: we must not squash non virtio devices to css 0xFE, since
> +     * it's reserved for virtio devices only.

See my virtio vs. virtual argument above.

>       */
> -    ret = css_create_css_image(VIRTUAL_CSSID, true);
> +    if (css_bus->squash_mcss) {
> +        ret = css_create_css_image(0, true);
> +    } else {
> +        ret = css_create_css_image(VIRTUAL_CSSID, true);
> +    }
>      assert(ret == 0);
> 
>      /* Create VirtIO network adapters */
