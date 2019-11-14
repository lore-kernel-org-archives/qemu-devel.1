Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F8C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DBD205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asocK2Uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DBD205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV7Lk-0000XF-Or
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 00:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7K0-0007bd-GM
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7Jy-0005lj-QS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:05:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32999
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iV7Jy-0005ko-JY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573707930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xju6/LHK7cg1llGg3H1tqYKFFgDIGbZ6M/w2nZ4ZT1g=;
 b=asocK2Uz9Q7HAYQTgnvwgax8fHkm5SScH4WdYRIwdt5fT03fpYKfIn5vqt/gZ9LhdE3v+N
 taIXC28fqWT4b8eGDkqImyJb426uX9JY55WnX5PKfq1lRG/QSJBH/+ElyQ+5BtYFGVTVr6
 QcyRLHFyFDufpk88aIiYIRg6a0kPhbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-ec35bA9iP4WMubd1z6v8SQ-1; Thu, 14 Nov 2019 00:05:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12E90107ACC5;
 Thu, 14 Nov 2019 05:05:24 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6C2B1059FDF;
 Thu, 14 Nov 2019 05:05:21 +0000 (UTC)
Date: Wed, 13 Nov 2019 22:05:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 QEMU 12/15] vfio: Add load state functions to
 SaveVMHandlers
Message-ID: <20191113220521.21df2ec1@x1.home>
In-Reply-To: <1573578324-8389-13-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
 <1573578324-8389-13-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ec35bA9iP4WMubd1z6v8SQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 22:35:21 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Sequence  during _RESUMING device state:
> While data for this device is available, repeat below steps:
> a. read data_offset from where user application should write data.
> b. write data of data_size to migration region from data_offset.
> c. write data_size which indicates vendor driver that data is written in
>    staging buffer.
>=20
> For user, data is opaque. User should write data in the same order as
> received.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c  | 170 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/vfio/trace-events |   3 +
>  2 files changed, 173 insertions(+)
>=20
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index f890e864e174..16e12586fe8b 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -251,6 +251,33 @@ static int vfio_save_device_config_state(QEMUFile *f=
, void *opaque)
>      return qemu_file_get_error(f);
>  }
> =20
> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev =3D opaque;
> +    uint64_t data;
> +
> +    if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
> +        int ret;
> +
> +        ret =3D vbasedev->ops->vfio_load_config(vbasedev, f);
> +        if (ret) {
> +            error_report("%s: Failed to load device config space",
> +                         vbasedev->name);
> +            return ret;
> +        }
> +    }
> +
> +    data =3D qemu_get_be64(f);
> +    if (data !=3D VFIO_MIG_FLAG_END_OF_STATE) {
> +        error_report("%s: Failed loading device config space, "
> +                     "end flag incorrect 0x%"PRIx64, vbasedev->name, dat=
a);
> +        return -EINVAL;
> +    }
> +
> +    trace_vfio_load_device_config_state(vbasedev->name);
> +    return qemu_file_get_error(f);
> +}
> +
>  /* ---------------------------------------------------------------------=
- */
> =20
>  static int vfio_save_setup(QEMUFile *f, void *opaque)
> @@ -410,12 +437,155 @@ static int vfio_save_complete_precopy(QEMUFile *f,=
 void *opaque)
>      return ret;
>  }
> =20
> +static int vfio_load_setup(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev =3D opaque;
> +    VFIOMigration *migration =3D vbasedev->migration;
> +    int ret =3D 0;
> +
> +    if (migration->region.mmaps) {
> +        ret =3D vfio_region_mmap(&migration->region);
> +        if (ret) {
> +            error_report("%s: Failed to mmap VFIO migration region %d: %=
s",
> +                         vbasedev->name, migration->region.nr,
> +                         strerror(-ret));
> +            return ret;
> +        }
> +    }
> +
> +    ret =3D vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMIN=
G, 0);
> +    if (ret) {
> +        error_report("%s: Failed to set state RESUMING", vbasedev->name)=
;
> +    }
> +    return ret;
> +}
> +
> +static int vfio_load_cleanup(void *opaque)
> +{
> +    vfio_save_cleanup(opaque);
> +    return 0;
> +}
> +
> +static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> +{
> +    VFIODevice *vbasedev =3D opaque;
> +    VFIOMigration *migration =3D vbasedev->migration;
> +    int ret =3D 0;
> +    uint64_t data, data_size;
> +
> +    data =3D qemu_get_be64(f);
> +    while (data !=3D VFIO_MIG_FLAG_END_OF_STATE) {
> +
> +        trace_vfio_load_state(vbasedev->name, data);
> +
> +        switch (data) {
> +        case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
> +        {
> +            ret =3D vfio_load_device_config_state(f, opaque);
> +            if (ret) {
> +                return ret;
> +            }
> +            break;
> +        }
> +        case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> +        {
> +            data =3D qemu_get_be64(f);
> +            if (data =3D=3D VFIO_MIG_FLAG_END_OF_STATE) {
> +                return ret;
> +            } else {
> +                error_report("%s: SETUP STATE: EOS not found 0x%"PRIx64,
> +                             vbasedev->name, data);
> +                return -EINVAL;
> +            }
> +            break;
> +        }
> +        case VFIO_MIG_FLAG_DEV_DATA_STATE:
> +        {
> +            VFIORegion *region =3D &migration->region;
> +            void *buf =3D NULL;
> +            bool buffer_mmaped =3D false;
> +            uint64_t data_offset =3D 0;
> +
> +            data_size =3D qemu_get_be64(f);
> +            if (data_size =3D=3D 0) {
> +                break;

We're not writing data_size =3D 0 to the migration region, so these
aren't used to synchronization, why are we writing them into the
migration stream?

> +            }
> +
> +            ret =3D pread(vbasedev->fd, &data_offset, sizeof(data_offset=
),
> +                        region->fd_offset +
> +                        offsetof(struct vfio_device_migration_info,
> +                        data_offset));
> +            if (ret !=3D sizeof(data_offset)) {
> +                error_report("%s:Failed to get migration buffer data off=
set %d",
> +                             vbasedev->name, ret);
> +                return -EINVAL;
> +            }
> +
> +            if (region->mmaps) {
> +                buf =3D find_data_region(region, data_offset, data_size)=
;
> +            }
> +
> +            buffer_mmaped =3D (buf !=3D NULL) ? true : false;
> +
> +            if (!buffer_mmaped) {
> +                buf =3D g_try_malloc0(data_size);
> +                if (!buf) {
> +                    error_report("%s: Error allocating buffer ", __func_=
_);
> +                    return -ENOMEM;
> +                }
> +            }
> +
> +            qemu_get_buffer(f, buf, data_size);
> +
> +            if (!buffer_mmaped) {
> +                ret =3D pwrite(vbasedev->fd, buf, data_size,
> +                             region->fd_offset + data_offset);
> +                g_free(buf);
> +
> +                if (ret !=3D data_size) {
> +                    error_report("%s: Failed to set migration buffer %d"=
,
> +                                 vbasedev->name, ret);
> +                    return -EINVAL;
> +                }
> +            }

Also assumes the entire data chunk with either mmap'd or not mmap'd,
which is not specified in our API.  Also susceptible to potentially
massive allocations.  The vendor driver can dictate the sequence of
writing data to the device, but it cannot dictate that QEMU sends an
arbitrarily sized contiguous chunk of data.  I think this gives the
vendor driver too much control of the migration responsiveness.  For
instance, QEMU should be able to say this device only gets a 100MB
chunk in the data stream at a time in order to play fairly with other
devices and have a deterministic iteration interval.

> +
> +            ret =3D pwrite(vbasedev->fd, &data_size, sizeof(data_size),
> +                         region->fd_offset +
> +                       offsetof(struct vfio_device_migration_info, data_=
size));
> +            if (ret !=3D sizeof(data_size)) {
> +                error_report("%s: Failed to set migration buffer data si=
ze %d",
> +                             vbasedev->name, ret);
> +                if (!buffer_mmaped) {
> +                    g_free(buf);
> +                }
> +                return -EINVAL;
> +            }
> +
> +            trace_vfio_load_state_device_data(vbasedev->name, data_offse=
t,
> +                                              data_size);
> +            break;
> +        }
> +        }
> +
> +        ret =3D qemu_file_get_error(f);
> +        if (ret) {
> +            return ret;
> +        }
> +        data =3D qemu_get_be64(f);
> +    }
> +
> +    return ret;
> +}
> +
>  static SaveVMHandlers savevm_vfio_handlers =3D {
>      .save_setup =3D vfio_save_setup,
>      .save_cleanup =3D vfio_save_cleanup,
>      .save_live_pending =3D vfio_save_pending,
>      .save_live_iterate =3D vfio_save_iterate,
>      .save_live_complete_precopy =3D vfio_save_complete_precopy,
> +    .load_setup =3D vfio_load_setup,
> +    .load_cleanup =3D vfio_load_cleanup,
> +    .load_state =3D vfio_load_state,
>  };
> =20
>  /* ---------------------------------------------------------------------=
- */
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index bdf40ba368c7..ac065b559f4e 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -157,3 +157,6 @@ vfio_save_device_config_state(char *name) " (%s)"
>  vfio_save_pending(char *name, uint64_t precopy, uint64_t postcopy, uint6=
4_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible =
0x%"PRIx64
>  vfio_save_iterate(char *name, int data_size) " (%s) data_size %d"
>  vfio_save_complete_precopy(char *name) " (%s)"
> +vfio_load_device_config_state(char *name) " (%s)"
> +vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
> +vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t d=
ata_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64


