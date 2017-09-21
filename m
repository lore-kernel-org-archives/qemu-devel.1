Received: from eggs.gnu.org ([2001:4830:134:3::10]:34764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duy1z-0003HG-Te
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duy1u-0004mg-VC
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:44:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1duy1u-0004lA-MQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:44:22 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8L9iC53122006
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:44:21 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d48b58fx9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:44:20 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 10:44:18 +0100
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-4-pasic@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 11:44:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170919182745.90280-4-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <de7b0939-df06-333f-28ce-cd9d3fe58eb2@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/5] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 19/09/2017 20:27, Halil Pasic wrote:
> Replace direct access which implicitly assumes no IDA
> or MIDA with the new ccw data stream interface which should
> cope with these transparently in the future.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
> ---
>   hw/s390x/virtio-ccw.c | 157 +++++++++++++++--------------------------=
---------
>   1 file changed, 46 insertions(+), 111 deletions(-)
>=20
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index b1976fdd19..d024f8b2d3 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -287,49 +287,19 @@ static int virtio_ccw_handle_set_vq(SubchDev *sch=
, CCW1 ccw, bool check_len,
>           return -EFAULT;
>       }
>       if (is_legacy) {
> -        linfo.queue =3D address_space_ldq_be(&address_space_memory, cc=
w.cda,
> -                                           MEMTXATTRS_UNSPECIFIED, NUL=
L);
> -        linfo.align =3D address_space_ldl_be(&address_space_memory,
> -                                           ccw.cda + sizeof(linfo.queu=
e),
> -                                           MEMTXATTRS_UNSPECIFIED,
> -                                           NULL);
> -        linfo.index =3D address_space_lduw_be(&address_space_memory,
> -                                            ccw.cda + sizeof(linfo.que=
ue)
> -                                            + sizeof(linfo.align),
> -                                            MEMTXATTRS_UNSPECIFIED,
> -                                            NULL);
> -        linfo.num =3D address_space_lduw_be(&address_space_memory,
> -                                          ccw.cda + sizeof(linfo.queue=
)
> -                                          + sizeof(linfo.align)
> -                                          + sizeof(linfo.index),
> -                                          MEMTXATTRS_UNSPECIFIED,
> -                                          NULL);

Here again, I oversaw this.
Sorry.

> +        ccw_dstream_read(&sch->cds, linfo);

Same as for patch 2/5:
Shouldn't you test the return value here?

> +        be64_to_cpus(&linfo.queue);
> +        be32_to_cpus(&linfo.align);
> +        be16_to_cpus(&linfo.index);
> +        be16_to_cpus(&linfo.num);
>           ret =3D virtio_ccw_set_vqs(sch, NULL, &linfo);
>       } else {
> -        info.desc =3D address_space_ldq_be(&address_space_memory, ccw.=
cda,
> -                                           MEMTXATTRS_UNSPECIFIED, NUL=
L);
> -        info.index =3D address_space_lduw_be(&address_space_memory,
> -                                           ccw.cda + sizeof(info.desc)
> -                                           + sizeof(info.res0),
> -                                           MEMTXATTRS_UNSPECIFIED, NUL=
L);
> -        info.num =3D address_space_lduw_be(&address_space_memory,
> -                                         ccw.cda + sizeof(info.desc)
> -                                         + sizeof(info.res0)
> -                                         + sizeof(info.index),
> -                                         MEMTXATTRS_UNSPECIFIED, NULL)=
;
> -        info.avail =3D address_space_ldq_be(&address_space_memory,
> -                                          ccw.cda + sizeof(info.desc)
> -                                          + sizeof(info.res0)
> -                                          + sizeof(info.index)
> -                                          + sizeof(info.num),
> -                                          MEMTXATTRS_UNSPECIFIED, NULL=
);
> -        info.used =3D address_space_ldq_be(&address_space_memory,
> -                                         ccw.cda + sizeof(info.desc)
> -                                         + sizeof(info.res0)
> -                                         + sizeof(info.index)
> -                                         + sizeof(info.num)
> -                                         + sizeof(info.avail),
> -                                         MEMTXATTRS_UNSPECIFIED, NULL)=
;
> +        ccw_dstream_read(&sch->cds, info);

and here

> +        be64_to_cpus(&info.desc);
> +        be16_to_cpus(&info.index);
> +        be16_to_cpus(&info.num);
> +        be64_to_cpus(&info.avail);
> +        be64_to_cpus(&info.used);
>           ret =3D virtio_ccw_set_vqs(sch, &info, NULL);
>       }
>       sch->curr_status.scsw.count =3D 0;
> @@ -342,15 +312,13 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>       VirtioRevInfo revinfo;
>       uint8_t status;
>       VirtioFeatDesc features;
> -    void *config;
>       hwaddr indicators;
>       VqConfigBlock vq_config;
>       VirtioCcwDevice *dev =3D sch->driver_data;
>       VirtIODevice *vdev =3D virtio_ccw_get_vdev(sch);
>       bool check_len;
>       int len;
> -    hwaddr hw_len;
> -    VirtioThinintInfo *thinint;
> +    VirtioThinintInfo thinint;
>=20
>       if (!dev) {
>           return -EINVAL;
> @@ -394,11 +362,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>           } else {
>               VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>=20
> -            features.index =3D address_space_ldub(&address_space_memor=
y,
> -                                                ccw.cda
> -                                                + sizeof(features.feat=
ures),
> -                                                MEMTXATTRS_UNSPECIFIED=
,
> -                                                NULL);
> +            ccw_dstream_advance(&sch->cds, sizeof(features.features));
> +            ccw_dstream_read(&sch->cds, features.index);

here again

>               if (features.index =3D=3D 0) {
>                   if (dev->revision >=3D 1) {
>                       /* Don't offer legacy features for modern devices=
. */
> @@ -417,9 +382,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>                   /* Return zeroes if the guest supports more feature b=
its. */
>                   features.features =3D 0;
>               }
> -            address_space_stl_le(&address_space_memory, ccw.cda,
> -                                 features.features, MEMTXATTRS_UNSPECI=
FIED,
> -                                 NULL);
> +            ccw_dstream_rewind(&sch->cds);
> +            cpu_to_le32s(&features.features);
> +            ccw_dstream_write(&sch->cds, features.features);
>               sch->curr_status.scsw.count =3D ccw.count - sizeof(featur=
es);
>               ret =3D 0;
>           }
> @@ -438,15 +403,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>           if (!ccw.cda) {
>               ret =3D -EFAULT;
>           } else {
> -            features.index =3D address_space_ldub(&address_space_memor=
y,
> -                                                ccw.cda
> -                                                + sizeof(features.feat=
ures),
> -                                                MEMTXATTRS_UNSPECIFIED=
,
> -                                                NULL);
> -            features.features =3D address_space_ldl_le(&address_space_=
memory,
> -                                                     ccw.cda,
> -                                                     MEMTXATTRS_UNSPEC=
IFIED,
> -                                                     NULL);
> +            ccw_dstream_read(&sch->cds, features);

... and everywhere where you use the IDA stream...

Pierre


> +            le32_to_cpus(&features.features);
>               if (features.index =3D=3D 0) {
>                   virtio_set_features(vdev,
>                                       (vdev->guest_features & 0xfffffff=
f00000000ULL) |
> @@ -487,8 +445,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>               ret =3D -EFAULT;
>           } else {
>               virtio_bus_get_vdev_config(&dev->bus, vdev->config);
> -            /* XXX config space endianness */
> -            cpu_physical_memory_write(ccw.cda, vdev->config, len);
> +            ccw_dstream_write_buf(&sch->cds, vdev->config, len);
>               sch->curr_status.scsw.count =3D ccw.count - len;
>               ret =3D 0;
>           }
> @@ -501,21 +458,13 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>               }
>           }
>           len =3D MIN(ccw.count, vdev->config_len);
> -        hw_len =3D len;
>           if (!ccw.cda) {
>               ret =3D -EFAULT;
>           } else {
> -            config =3D cpu_physical_memory_map(ccw.cda, &hw_len, 0);
> -            if (!config) {
> -                ret =3D -EFAULT;
> -            } else {
> -                len =3D hw_len;
> -                /* XXX config space endianness */
> -                memcpy(vdev->config, config, len);
> -                cpu_physical_memory_unmap(config, hw_len, 0, hw_len);
> +            ret =3D ccw_dstream_read_buf(&sch->cds, vdev->config, len)=
;
> +            if (!ret) {
>                   virtio_bus_set_vdev_config(&dev->bus, vdev->config);
>                   sch->curr_status.scsw.count =3D ccw.count - len;
> -                ret =3D 0;
>               }
>           }
>           break;
> @@ -553,8 +502,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>           if (!ccw.cda) {
>               ret =3D -EFAULT;
>           } else {
> -            status =3D address_space_ldub(&address_space_memory, ccw.c=
da,
> -                                        MEMTXATTRS_UNSPECIFIED, NULL);
> +            ccw_dstream_read(&sch->cds, status);
>               if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>                   virtio_ccw_stop_ioeventfd(dev);
>               }
> @@ -597,8 +545,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>           if (!ccw.cda) {
>               ret =3D -EFAULT;
>           } else {
> -            indicators =3D address_space_ldq_be(&address_space_memory,=
 ccw.cda,
> -                                              MEMTXATTRS_UNSPECIFIED, =
NULL);
> +            ccw_dstream_read(&sch->cds, indicators);
> +            be64_to_cpus(&indicators);
>               dev->indicators =3D get_indicator(indicators, sizeof(uint=
64_t));
>               sch->curr_status.scsw.count =3D ccw.count - sizeof(indica=
tors);
>               ret =3D 0;
> @@ -618,8 +566,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>           if (!ccw.cda) {
>               ret =3D -EFAULT;
>           } else {
> -            indicators =3D address_space_ldq_be(&address_space_memory,=
 ccw.cda,
> -                                              MEMTXATTRS_UNSPECIFIED, =
NULL);
> +            ccw_dstream_read(&sch->cds, indicators);
> +            be64_to_cpus(&indicators);
>               dev->indicators2 =3D get_indicator(indicators, sizeof(uin=
t64_t));
>               sch->curr_status.scsw.count =3D ccw.count - sizeof(indica=
tors);
>               ret =3D 0;
> @@ -639,67 +587,58 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>           if (!ccw.cda) {
>               ret =3D -EFAULT;
>           } else {
> -            vq_config.index =3D address_space_lduw_be(&address_space_m=
emory,
> -                                                    ccw.cda,
> -                                                    MEMTXATTRS_UNSPECI=
FIED,
> -                                                    NULL);
> +            ccw_dstream_read(&sch->cds, vq_config.index);
> +            be16_to_cpus(&vq_config.index);
>               if (vq_config.index >=3D VIRTIO_QUEUE_MAX) {
>                   ret =3D -EINVAL;
>                   break;
>               }
>               vq_config.num_max =3D virtio_queue_get_num(vdev,
>                                                        vq_config.index)=
;
> -            address_space_stw_be(&address_space_memory,
> -                                 ccw.cda + sizeof(vq_config.index),
> -                                 vq_config.num_max,
> -                                 MEMTXATTRS_UNSPECIFIED,
> -                                 NULL);
> +            cpu_to_be16s(&vq_config.num_max);
> +            ccw_dstream_write(&sch->cds, vq_config.num_max);
>               sch->curr_status.scsw.count =3D ccw.count - sizeof(vq_con=
fig);
>               ret =3D 0;
>           }
>           break;
>       case CCW_CMD_SET_IND_ADAPTER:
>           if (check_len) {
> -            if (ccw.count !=3D sizeof(*thinint)) {
> +            if (ccw.count !=3D sizeof(thinint)) {
>                   ret =3D -EINVAL;
>                   break;
>               }
> -        } else if (ccw.count < sizeof(*thinint)) {
> +        } else if (ccw.count < sizeof(thinint)) {
>               /* Can't execute command. */
>               ret =3D -EINVAL;
>               break;
>           }
> -        len =3D sizeof(*thinint);
> -        hw_len =3D len;
>           if (!ccw.cda) {
>               ret =3D -EFAULT;
>           } else if (dev->indicators && !sch->thinint_active) {
>               /* Trigger a command reject. */
>               ret =3D -ENOSYS;
>           } else {
> -            thinint =3D cpu_physical_memory_map(ccw.cda, &hw_len, 0);
> -            if (!thinint) {
> +            if (ccw_dstream_read(&sch->cds, thinint)) {
>                   ret =3D -EFAULT;
>               } else {
> -                uint64_t ind_bit =3D ldq_be_p(&thinint->ind_bit);
> +                be64_to_cpus(&thinint.ind_bit);
> +                be64_to_cpus(&thinint.summary_indicator);
> +                be64_to_cpus(&thinint.device_indicator);
>=20
> -                len =3D hw_len;
>                   dev->summary_indicator =3D
> -                    get_indicator(ldq_be_p(&thinint->summary_indicator=
),
> -                                  sizeof(uint8_t));
> +                    get_indicator(thinint.summary_indicator, sizeof(ui=
nt8_t));
>                   dev->indicators =3D
> -                    get_indicator(ldq_be_p(&thinint->device_indicator)=
,
> -                                  ind_bit / 8 + 1);
> -                dev->thinint_isc =3D thinint->isc;
> -                dev->routes.adapter.ind_offset =3D ind_bit;
> +                    get_indicator(thinint.device_indicator,
> +                                  thinint.ind_bit / 8 + 1);
> +                dev->thinint_isc =3D thinint.isc;
> +                dev->routes.adapter.ind_offset =3D thinint.ind_bit;
>                   dev->routes.adapter.summary_offset =3D 7;
> -                cpu_physical_memory_unmap(thinint, hw_len, 0, hw_len);
>                   dev->routes.adapter.adapter_id =3D css_get_adapter_id=
(
>                                                    CSS_IO_ADAPTER_VIRTI=
O,
>                                                    dev->thinint_isc);
>                   sch->thinint_active =3D ((dev->indicators !=3D NULL) =
&&
>                                          (dev->summary_indicator !=3D N=
ULL));
> -                sch->curr_status.scsw.count =3D ccw.count - len;
> +                sch->curr_status.scsw.count =3D ccw.count - sizeof(thi=
nint);
>                   ret =3D 0;
>               }
>           }
> @@ -714,13 +653,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>               ret =3D -EFAULT;
>               break;
>           }
> -        revinfo.revision =3D
> -            address_space_lduw_be(&address_space_memory, ccw.cda,
> -                                  MEMTXATTRS_UNSPECIFIED, NULL);
> -        revinfo.length =3D
> -            address_space_lduw_be(&address_space_memory,
> -                                  ccw.cda + sizeof(revinfo.revision),
> -                                  MEMTXATTRS_UNSPECIFIED, NULL);
> +        ccw_dstream_read_buf(&sch->cds, &revinfo, 4);
> +        be16_to_cpus(&revinfo.revision);
> +        be16_to_cpus(&revinfo.length);
>           if (ccw.count < len + revinfo.length ||
>               (check_len && ccw.count > len + revinfo.length)) {
>               ret =3D -EINVAL;
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
