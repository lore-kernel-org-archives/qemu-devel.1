Received: from eggs.gnu.org ([2001:4830:134:3::10]:59695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eM63r-00084e-2L
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eM63n-00067H-Py
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:46:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42098
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eM63n-000670-JU
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:46:27 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB55iBNh013517
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 00:46:24 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ene0qqdth-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 00:46:23 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 00:46:22 -0500
Date: Tue, 5 Dec 2017 13:46:15 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201143136.62497-2-pasic@linux.vnet.ibm.com>
Message-Id: <20171205054615.GX5859@bjsdjshi@linux.vnet.ibm.com>
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
Cc: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-12-01 15:31:34 +0100]:

[...]

No comment for the message part.

The code looks good to me. So after squashing with patch #2:
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

> ---
>  hw/s390x/3270-ccw.c        |  2 +-
>  hw/s390x/css.c             | 28 ++++------------------------
>  hw/s390x/s390-ccw.c        |  2 +-
>  hw/s390x/s390-virtio-ccw.c |  1 -
>  hw/s390x/virtio-ccw.c      |  2 +-
>  include/hw/s390x/css.h     | 12 ++++--------
>  6 files changed, 11 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
> index 081e3ef6f4..3af13ea027 100644
> --- a/hw/s390x/3270-ccw.c
> +++ b/hw/s390x/3270-ccw.c
> @@ -104,7 +104,7 @@ static void emulated_ccw_3270_realize(DeviceState *ds, Error **errp)
>      SubchDev *sch;
>      Error *err = NULL;
> 
> -    sch = css_create_sch(cdev->devno, true, cbus->squash_mcss, errp);
> +    sch = css_create_sch(cdev->devno, cbus->squash_mcss, errp);
>      if (!sch) {
>          return;
>      }
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index f6b5c807cd..cd26f32050 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -2370,22 +2370,12 @@ const PropertyInfo css_devid_ro_propinfo = {
>      .get = get_css_devid,
>  };
> 
> -SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
> -                         Error **errp)
> +SubchDev *css_create_sch(CssDevId bus_id, bool squash_mcss, Error **errp)
>  {
>      uint16_t schid = 0;
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
> -
> -    if (bus_id.valid) {
>          if (squash_mcss) {
>              bus_id.cssid = channel_subsys.default_cssid;
>          } else if (!channel_subsys.css[bus_id.cssid]) {
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
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index 0ef232ec27..4a9d4d2534 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -77,7 +77,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
>          goto out_err_propagate;
>      }
> 
> -    sch = css_create_sch(ccw_dev->devno, false, cbus->squash_mcss, &err);
> +    sch = css_create_sch(ccw_dev->devno, cbus->squash_mcss, &err);
>      if (!sch) {
>          goto out_mdevid_free;
>      }
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 6a57f94197..4d65a50334 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -302,7 +302,6 @@ static void ccw_init(MachineState *machine)
>      /*
>       * Non mcss-e enabled guests only see the devices from the default
>       * css, which is determined by the value of the squash_mcss property.
> -     * Note: we must not squash non virtual devices to css 0xFE.
>       */
>      if (css_bus->squash_mcss) {
>          ret = css_create_css_image(0, true);
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 184515ce94..3dd902a664 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -701,7 +701,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
>      SubchDev *sch;
>      Error *err = NULL;
> 
> -    sch = css_create_sch(ccw_dev->devno, true, cbus->squash_mcss, errp);
> +    sch = css_create_sch(ccw_dev->devno, cbus->squash_mcss, errp);
>      if (!sch) {
>          return;
>      }
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index ab6ebe66b5..53c270a216 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -272,12 +272,9 @@ extern const PropertyInfo css_devid_ro_propinfo;
>   * default css image for it.
>   * If @p bus_id is valid, and @p squash_mcss is false, verify that it is
>   * not already in use, and find a free devno for it.
> - * If @p bus_id is not valid, and if either @p squash_mcss or @p is_virtual
> - * is true, find a free subchannel id and device number across all
> - * subchannel sets from the default css image.
> - * If @p bus_id is not valid, and if both @p squash_mcss and @p is_virtual
> - * are false, find a non-full css image and find a free subchannel id and
> - * device number across all subchannel sets from it.
> + * If @p bus_id is not valid find a free subchannel id and device number
> + * across all subchannel sets and all css images starting from the default
> + * css image.
>   *
>   * If either of the former actions succeed, allocate a subchannel structure,
>   * initialise it with the bus id, subchannel id and device number, register
> @@ -286,8 +283,7 @@ extern const PropertyInfo css_devid_ro_propinfo;
>   * The caller becomes owner of the returned subchannel structure and
>   * is responsible for unregistering and freeing it.
>   */
> -SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
> -                         Error **errp);
> +SubchDev *css_create_sch(CssDevId bus_id, bool squash_mcss, Error **errp);
> 
>  /** Turn on css migration */
>  void css_register_vmstate(void);
> -- 
> 2.13.5
> 

-- 
Dong Jia Shi
