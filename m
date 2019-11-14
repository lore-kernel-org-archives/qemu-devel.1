Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB85C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D008206E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IW8RKRWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D008206E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV7K3-0007JV-KA
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 00:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7J1-0006Pf-Qh
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7Iz-0004GS-KD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:04:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51100
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iV7Iz-0004FT-FE
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573707868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsjrsuILU7z08vjaqiiSVT5hqKnzgr53t+45JTsReaI=;
 b=IW8RKRWWW3uA9UoYQLxbUfzeW6YbDZuNpi3HtzG9lviufarz73JXvEw2liOL8xNkv6BP0V
 DBQ98wM5ehzv7jyKeEAyzr2GHWvT6RbZPl4bYvAquR5M5dPw3/Q8pv7TUY2cMasf1Ovt2w
 tb1JjBPFdlfW/CPjRs4HtcwpTQzThYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-hNRNs5-fP3mqSN4ABK0qIQ-1; Thu, 14 Nov 2019 00:04:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06D51800A1A;
 Thu, 14 Nov 2019 05:04:20 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B4545F77D;
 Thu, 14 Nov 2019 05:04:18 +0000 (UTC)
Date: Wed, 13 Nov 2019 22:04:18 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 QEMU 11/15] vfio: Add save state functions to
 SaveVMHandlers
Message-ID: <20191113220418.081244d6@x1.home>
In-Reply-To: <1573578324-8389-12-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
 <1573578324-8389-12-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: hNRNs5-fP3mqSN4ABK0qIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Tue, 12 Nov 2019 22:35:20 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Added .save_live_pending, .save_live_iterate and .save_live_complete_prec=
opy
> functions. These functions handles pre-copy and stop-and-copy phase.
>=20
> In _SAVING|_RUNNING device state or pre-copy phase:
> - read pending_bytes. If pending_bytes > 0, go through below steps.
> - read data_offset - indicates kernel driver to write data to staging
>   buffer.
> - read data_size - amount of data in bytes written by vendor driver in
>   migration region.
> - read data_size bytes of data from data_offset in the migration region.
> - Write data packet to file stream as below:
> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
> VFIO_MIG_FLAG_END_OF_STATE }
>=20
> In _SAVING device state or stop-and-copy phase
> a. read config space of device and save to migration file stream. This
>    doesn't need to be from vendor driver. Any other special config state
>    from driver can be saved as data in following iteration.
> b. read pending_bytes. If pending_bytes > 0, go through below steps.
> c. read data_offset - indicates kernel driver to write data to staging
>    buffer.
> d. read data_size - amount of data in bytes written by vendor driver in
>    migration region.
> e. read data_size bytes of data from data_offset in the migration region.
> f. Write data packet as below:
>    {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
> g. iterate through steps b to f while (pending_bytes > 0)
> h. Write {VFIO_MIG_FLAG_END_OF_STATE}
>=20
> When data region is mapped, its user's responsibility to read data from

s/mapped/made available/

"mapped" is confusing given the mmap'd features.

> data_offset of data_size before moving to next steps.
>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c  | 245 +++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  hw/vfio/trace-events |   6 ++
>  2 files changed, 250 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 48aac6d29876..f890e864e174 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -120,6 +120,137 @@ static int vfio_migration_set_state(VFIODevice *vba=
sedev, uint32_t set_flags,
>      return 0;
>  }
> =20
> +static void *find_data_region(VFIORegion *region,
> +                              uint64_t data_offset,
> +                              uint64_t data_size)
> +{
> +    void *ptr =3D NULL;
> +    int i;
> +
> +    for (i =3D 0; i < region->nr_mmaps; i++) {
> +        if ((data_offset >=3D region->mmaps[i].offset) &&
> +            (data_offset < region->mmaps[i].offset + region->mmaps[i].si=
ze) &&
> +            (data_size <=3D region->mmaps[i].size)) {

data_offset is determined to live somewhere within the mmap and
data_size is independently determined to be smaller than the entire
mmaps size.  This is broken.

> +            ptr =3D region->mmaps[i].mmap + (data_offset -
> +                                           region->mmaps[i].offset);

If the data offset is mmap'd, this gives us a pointer to the start, but
we have no idea if the entire range is accessible via this pointer, nor
does the API require it to be.

> +            break;
> +        }
> +    }
> +    return ptr;
> +}
> +
> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration =3D vbasedev->migration;
> +    VFIORegion *region =3D &migration->region;
> +    uint64_t data_offset =3D 0, data_size =3D 0;
> +    int ret;
> +
> +    ret =3D pread(vbasedev->fd, &data_offset, sizeof(data_offset),
> +                region->fd_offset + offsetof(struct vfio_device_migratio=
n_info,
> +                                             data_offset));
> +    if (ret !=3D sizeof(data_offset)) {
> +        error_report("%s: Failed to get migration buffer data offset %d"=
,
> +                     vbasedev->name, ret);
> +        return -EINVAL;
> +    }
> +
> +    ret =3D pread(vbasedev->fd, &data_size, sizeof(data_size),
> +                region->fd_offset + offsetof(struct vfio_device_migratio=
n_info,
> +                                             data_size));
> +    if (ret !=3D sizeof(data_size)) {
> +        error_report("%s: Failed to get migration buffer data size %d",
> +                     vbasedev->name, ret);
> +        return -EINVAL;
> +    }
> +
> +    if (data_size > 0) {
> +        void *buf =3D NULL;
> +        bool buffer_mmaped;
> +
> +        if (region->mmaps) {
> +            buf =3D find_data_region(region, data_offset, data_size);
> +        }
> +
> +        buffer_mmaped =3D (buf !=3D NULL) ? true : false;
> +
> +        if (!buffer_mmaped) {
> +            buf =3D g_try_malloc0(data_size);
> +            if (!buf) {
> +                error_report("%s: Error allocating buffer ", __func__);
> +                return -ENOMEM;
> +            }
> +
> +            ret =3D pread(vbasedev->fd, buf, data_size,
> +                        region->fd_offset + data_offset);
> +            if (ret !=3D data_size) {
> +                error_report("%s: Failed to get migration data %d",
> +                             vbasedev->name, ret);
> +                g_free(buf);
> +                return -EINVAL;
> +            }

Seems like this needs to be bound and chunked to some "reasonable"
size, the vendor driver could be exposing gigabytes of data at a time.
Do we have a quota for this phase?

> +        }
> +
> +        qemu_put_be64(f, data_size);
> +        qemu_put_buffer(f, buf, data_size);
> +
> +        if (!buffer_mmaped) {
> +            g_free(buf);
> +        }
> +    } else {
> +        qemu_put_be64(f, data_size);

Why would we stuff zero or <0 into the data stream here?

> +    }

There's clearly an assumption here that a chunk of data from the device
is entirely mmap'd or not.  That's not a requirement of the API and I
believe we've discussed cases where a vendor driver could have
partially mapped and partially emulated data chunks.

> +
> +    trace_vfio_save_buffer(vbasedev->name, data_offset, data_size,
> +                           migration->pending_bytes);
> +
> +    ret =3D qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return data_size;

AIUI, it's required to read pending_bytes to indicate the data has been
consumed, I don't see that done here.

> +}
> +
> +static int vfio_update_pending(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration =3D vbasedev->migration;
> +    VFIORegion *region =3D &migration->region;
> +    uint64_t pending_bytes =3D 0;
> +    int ret;
> +
> +    ret =3D pread(vbasedev->fd, &pending_bytes, sizeof(pending_bytes),
> +                region->fd_offset + offsetof(struct vfio_device_migratio=
n_info,
> +                                             pending_bytes));
> +    if ((ret < 0) || (ret !=3D sizeof(pending_bytes))) {

Two tests for the same thing.

> +        error_report("%s: Failed to get pending bytes %d",
> +                     vbasedev->name, ret);
> +        migration->pending_bytes =3D 0;
> +        return (ret < 0) ? ret : -EINVAL;

pread returns -1 on error and sets errno, the ret value isn't very
interesting.

> +    }
> +
> +    migration->pending_bytes =3D pending_bytes;
> +    trace_vfio_update_pending(vbasedev->name, pending_bytes);
> +    return 0;
> +}
> +
> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev =3D opaque;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
> +
> +    if (vbasedev->ops && vbasedev->ops->vfio_save_config) {

A vbasedev w/o ops doesn't seem possible.

> +        vbasedev->ops->vfio_save_config(vbasedev, f);
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);

Is it worthwhile to include these markers w/o vfio_save_config?
Couldn't we simply move them into the conditional section?

> +
> +    trace_vfio_save_device_config_state(vbasedev->name);
> +
> +    return qemu_file_get_error(f);
> +}
> +
>  /* ---------------------------------------------------------------------=
- */
> =20
>  static int vfio_save_setup(QEMUFile *f, void *opaque)
> @@ -136,7 +267,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>          qemu_mutex_unlock_iothread();
>          if (ret) {
>              error_report("%s: Failed to mmap VFIO migration region %d: %=
s",
> -                         vbasedev->name, migration->region.index,
> +                         vbasedev->name, migration->region.nr,

Fix this in patch that introduced it, looks like this wouldn't even
compile previously.

>                           strerror(-ret));
>              return ret;
>          }
> @@ -170,9 +301,121 @@ static void vfio_save_cleanup(void *opaque)
>      trace_vfio_save_cleanup(vbasedev->name);
>  }
> =20
> +static void vfio_save_pending(QEMUFile *f, void *opaque,
> +                              uint64_t threshold_size,
> +                              uint64_t *res_precopy_only,
> +                              uint64_t *res_compatible,
> +                              uint64_t *res_postcopy_only)
> +{
> +    VFIODevice *vbasedev =3D opaque;
> +    VFIOMigration *migration =3D vbasedev->migration;
> +    int ret;
> +
> +    ret =3D vfio_update_pending(vbasedev);
> +    if (ret) {
> +        return;
> +    }
> +
> +    *res_precopy_only +=3D migration->pending_bytes;
> +
> +    trace_vfio_save_pending(vbasedev->name, *res_precopy_only,
> +                            *res_postcopy_only, *res_compatible);
> +}
> +
> +static int vfio_save_iterate(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev =3D opaque;
> +    int ret, data_size;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
> +
> +    data_size =3D vfio_save_buffer(f, vbasedev);
> +
> +    if (data_size < 0) {
> +        error_report("%s: vfio_save_buffer failed %s", vbasedev->name,
> +                     strerror(errno));
> +        return data_size;
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    ret =3D qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    trace_vfio_save_iterate(vbasedev->name, data_size);
> +    if (data_size =3D=3D 0) {
> +        /* indicates data finished, goto complete phase */
> +        return 1;
> +    }

I don't think this matches our spec, pending_bytes seems to indicate
we've finished, data_size of zero does not have a defined meaning.

> +
> +    return 0;
> +}
> +
> +static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev =3D opaque;
> +    VFIOMigration *migration =3D vbasedev->migration;
> +    int ret;
> +
> +    ret =3D vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING,
> +                                   VFIO_DEVICE_STATE_RUNNING);
> +    if (ret) {
> +        error_report("%s: Failed to set state STOP and SAVING",
> +                     vbasedev->name);
> +        return ret;
> +    }
> +
> +    ret =3D vfio_save_device_config_state(f, opaque);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret =3D vfio_update_pending(vbasedev);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    while (migration->pending_bytes > 0) {
> +        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
> +        ret =3D vfio_save_buffer(f, vbasedev);
> +        if (ret < 0) {
> +            error_report("%s: Failed to save buffer", vbasedev->name);
> +            return ret;
> +        } else if (ret =3D=3D 0) {
> +            break;
> +        }
> +
> +        ret =3D vfio_update_pending(vbasedev);
> +        if (ret) {
> +            return ret;
> +        }
> +    }

Here we use pending_bytes for the stop condition and update
pending_bytes per loop, which is different than the above save iterate
function.

> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    ret =3D qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret =3D vfio_migration_set_state(vbasedev, 0, VFIO_DEVICE_STATE_SAVI=
NG);
> +    if (ret) {
> +        error_report("%s: Failed to set state STOPPED", vbasedev->name);
> +        return ret;
> +    }
> +
> +    trace_vfio_save_complete_precopy(vbasedev->name);
> +    return ret;
> +}
> +
>  static SaveVMHandlers savevm_vfio_handlers =3D {
>      .save_setup =3D vfio_save_setup,
>      .save_cleanup =3D vfio_save_cleanup,
> +    .save_live_pending =3D vfio_save_pending,
> +    .save_live_iterate =3D vfio_save_iterate,
> +    .save_live_complete_precopy =3D vfio_save_complete_precopy,
>  };
> =20
>  /* ---------------------------------------------------------------------=
- */
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 4bb43f18f315..bdf40ba368c7 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -151,3 +151,9 @@ vfio_vmstate_change(char *name, int running, const ch=
ar *reason, uint32_t dev_st
>  vfio_migration_state_notifier(char *name, int state) " (%s) state %d"
>  vfio_save_setup(char *name) " (%s)"
>  vfio_save_cleanup(char *name) " (%s)"
> +vfio_save_buffer(char *name, uint64_t data_offset, uint64_t data_size, u=
int64_t pending) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64" pending 0x%"PRI=
x64
> +vfio_update_pending(char *name, uint64_t pending) " (%s) pending 0x%"PRI=
x64
> +vfio_save_device_config_state(char *name) " (%s)"
> +vfio_save_pending(char *name, uint64_t precopy, uint64_t postcopy, uint6=
4_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible =
0x%"PRIx64
> +vfio_save_iterate(char *name, int data_size) " (%s) data_size %d"
> +vfio_save_complete_precopy(char *name) " (%s)"


