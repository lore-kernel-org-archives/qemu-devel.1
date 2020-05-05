Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8BFC47256
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 04:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647F3206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 04:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ei+0GjBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647F3206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVpLQ-0003Tt-GS
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 00:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jVpKd-0002pv-Ja
 for qemu-devel@nongnu.org; Tue, 05 May 2020 00:37:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28365
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jVpKb-0003id-9H
 for qemu-devel@nongnu.org; Tue, 05 May 2020 00:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588653439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxY+IxHGqZyOS9mSSQdKMt+rSd7Hf6xv6umXi03vEnc=;
 b=ei+0GjBTIpy5ma+jw5eRsDnZatH/iKpUpyslCCFkBRPN4LUfmzqmUgWd8Hcnx+VH5+awGC
 VIbtJeaAeLxGXktpA6cB4+3OTbUnUfqd0jpUxJv62G3WCA/lw9j/iom972zhbQ20QPwYHr
 tDfJKohnfPI3oKrXIPGm5IGpf/uj2zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-If1Ji--OM8i_p7Lxm_tMaA-1; Tue, 05 May 2020 00:37:14 -0400
X-MC-Unique: If1Ji--OM8i_p7Lxm_tMaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FB1480183C;
 Tue,  5 May 2020 04:37:11 +0000 (UTC)
Received: from x1.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 597B97052F;
 Tue,  5 May 2020 04:37:09 +0000 (UTC)
Date: Mon, 4 May 2020 22:37:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 09/16] vfio: Add save state functions to
 SaveVMHandlers
Message-ID: <20200504223708.6d8c94bf@x1.home>
In-Reply-To: <b57322be-a337-ccb8-19e3-6c6bc3343119@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-10-git-send-email-kwankhede@nvidia.com>
 <20200325160311.265ca037@w520.home>
 <b57322be-a337-ccb8-19e3-6c6bc3343119@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On Tue, 5 May 2020 04:48:14 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 3/26/2020 3:33 AM, Alex Williamson wrote:
> > On Wed, 25 Mar 2020 02:39:07 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
> >> functions. These functions handles pre-copy and stop-and-copy phase.
> >>
> >> In _SAVING|_RUNNING device state or pre-copy phase:
> >> - read pending_bytes. If pending_bytes > 0, go through below steps.
> >> - read data_offset - indicates kernel driver to write data to staging
> >>    buffer.
> >> - read data_size - amount of data in bytes written by vendor driver in
> >>    migration region.
> >> - read data_size bytes of data from data_offset in the migration region.
> >> - Write data packet to file stream as below:
> >> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
> >> VFIO_MIG_FLAG_END_OF_STATE }
> >>
> >> In _SAVING device state or stop-and-copy phase
> >> a. read config space of device and save to migration file stream. This
> >>     doesn't need to be from vendor driver. Any other special config state
> >>     from driver can be saved as data in following iteration.
> >> b. read pending_bytes. If pending_bytes > 0, go through below steps.
> >> c. read data_offset - indicates kernel driver to write data to staging
> >>     buffer.
> >> d. read data_size - amount of data in bytes written by vendor driver in
> >>     migration region.
> >> e. read data_size bytes of data from data_offset in the migration region.
> >> f. Write data packet as below:
> >>     {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
> >> g. iterate through steps b to f while (pending_bytes > 0)
> >> h. Write {VFIO_MIG_FLAG_END_OF_STATE}
> >>
> >> When data region is mapped, its user's responsibility to read data from
> >> data_offset of data_size before moving to next steps.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>   hw/vfio/migration.c           | 245 +++++++++++++++++++++++++++++++++++++++++-
> >>   hw/vfio/trace-events          |   6 ++
> >>   include/hw/vfio/vfio-common.h |   1 +
> >>   3 files changed, 251 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> index 033f76526e49..ecbeed5182c2 100644
> >> --- a/hw/vfio/migration.c
> >> +++ b/hw/vfio/migration.c
> >> @@ -138,6 +138,137 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> >>       return 0;
> >>   }
> >>   
> >> +static void *find_data_region(VFIORegion *region,
> >> +                              uint64_t data_offset,
> >> +                              uint64_t data_size)
> >> +{
> >> +    void *ptr = NULL;
> >> +    int i;
> >> +
> >> +    for (i = 0; i < region->nr_mmaps; i++) {
> >> +        if ((data_offset >= region->mmaps[i].offset) &&
> >> +            (data_offset < region->mmaps[i].offset + region->mmaps[i].size) &&
> >> +            (data_size <= region->mmaps[i].size)) {  
> > 
> > (data_offset - region->mmaps[i].offset) can be non-zero, so this test
> > is invalid.  Additionally the uapi does not require that a give data
> > chunk fits exclusively within an mmap'd area, it may overlap one or
> > more mmap'd sections of the region, possibly with non-mmap'd areas
> > included.
> >   
> 
> What's the advantage of having mmap and non-mmap overlapped regions?
> Isn't it better to have data section either mapped or trapped?

The spec allows for it, therefore we need to support it.  A vendor
driver might choose to include a header with sequence and checksum
information for each transaction, they might accomplish this by setting
data_offset to a trapped area backed by kernel memory followed by an
area supporting direct mmap to the device.  The target end could then
fault on writing the header if the sequence information is incorrect.
A trapped area at the end of the transaction could allow the vendor
driver to validate a checksum.

> >> +            ptr = region->mmaps[i].mmap + (data_offset -
> >> +                                           region->mmaps[i].offset);
> >> +            break;
> >> +        }
> >> +    }
> >> +    return ptr;
> >> +}
> >> +
> >> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
> >> +{
> >> +    VFIOMigration *migration = vbasedev->migration;
> >> +    VFIORegion *region = &migration->region;
> >> +    uint64_t data_offset = 0, data_size = 0;
> >> +    int ret;
> >> +
> >> +    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
> >> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> >> +                                             data_offset));
> >> +    if (ret != sizeof(data_offset)) {
> >> +        error_report("%s: Failed to get migration buffer data offset %d",
> >> +                     vbasedev->name, ret);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    ret = pread(vbasedev->fd, &data_size, sizeof(data_size),
> >> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> >> +                                             data_size));
> >> +    if (ret != sizeof(data_size)) {
> >> +        error_report("%s: Failed to get migration buffer data size %d",
> >> +                     vbasedev->name, ret);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    if (data_size > 0) {
> >> +        void *buf = NULL;
> >> +        bool buffer_mmaped;
> >> +
> >> +        if (region->mmaps) {
> >> +            buf = find_data_region(region, data_offset, data_size);
> >> +        }
> >> +
> >> +        buffer_mmaped = (buf != NULL) ? true : false;  
> > 
> > The ternary is unnecessary, "? true : false" is redundant.
> >   
> 
> Removing it.
> 
> >> +
> >> +        if (!buffer_mmaped) {
> >> +            buf = g_try_malloc0(data_size);  
> > 
> > Why do we need zero'd memory?
> >   
> 
> Zeroed memory not required, removing 0
> 
> >> +            if (!buf) {
> >> +                error_report("%s: Error allocating buffer ", __func__);
> >> +                return -ENOMEM;
> >> +            }
> >> +
> >> +            ret = pread(vbasedev->fd, buf, data_size,
> >> +                        region->fd_offset + data_offset);
> >> +            if (ret != data_size) {
> >> +                error_report("%s: Failed to get migration data %d",
> >> +                             vbasedev->name, ret);
> >> +                g_free(buf);
> >> +                return -EINVAL;
> >> +            }
> >> +        }
> >> +
> >> +        qemu_put_be64(f, data_size);
> >> +        qemu_put_buffer(f, buf, data_size);  
> > 
> > This can segfault when mmap'd given the above assumptions about size
> > and layout.
> >   
> >> +
> >> +        if (!buffer_mmaped) {
> >> +            g_free(buf);
> >> +        }
> >> +    } else {
> >> +        qemu_put_be64(f, data_size);  
> > 
> > We insert a zero?  Couldn't we add the section header and end here and
> > skip it entirely?
> >   
> 
> This is used during resuming, data_size 0 indicates end of data.
> 
> >> +    }
> >> +
> >> +    trace_vfio_save_buffer(vbasedev->name, data_offset, data_size,
> >> +                           migration->pending_bytes);
> >> +
> >> +    ret = qemu_file_get_error(f);
> >> +    if (ret) {
> >> +        return ret;
> >> +    }
> >> +
> >> +    return data_size;
> >> +}
> >> +
> >> +static int vfio_update_pending(VFIODevice *vbasedev)
> >> +{
> >> +    VFIOMigration *migration = vbasedev->migration;
> >> +    VFIORegion *region = &migration->region;
> >> +    uint64_t pending_bytes = 0;
> >> +    int ret;
> >> +
> >> +    ret = pread(vbasedev->fd, &pending_bytes, sizeof(pending_bytes),
> >> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> >> +                                             pending_bytes));
> >> +    if ((ret < 0) || (ret != sizeof(pending_bytes))) {
> >> +        error_report("%s: Failed to get pending bytes %d",
> >> +                     vbasedev->name, ret);
> >> +        migration->pending_bytes = 0;
> >> +        return (ret < 0) ? ret : -EINVAL;
> >> +    }
> >> +
> >> +    migration->pending_bytes = pending_bytes;
> >> +    trace_vfio_update_pending(vbasedev->name, pending_bytes);
> >> +    return 0;
> >> +}
> >> +
> >> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> >> +{
> >> +    VFIODevice *vbasedev = opaque;
> >> +
> >> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
> >> +
> >> +    if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
> >> +        vbasedev->ops->vfio_save_config(vbasedev, f);
> >> +    }
> >> +
> >> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> >> +
> >> +    trace_vfio_save_device_config_state(vbasedev->name);
> >> +
> >> +    return qemu_file_get_error(f);
> >> +}
> >> +
> >>   /* ---------------------------------------------------------------------- */
> >>   
> >>   static int vfio_save_setup(QEMUFile *f, void *opaque)
> >> @@ -154,7 +285,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
> >>           qemu_mutex_unlock_iothread();
> >>           if (ret) {
> >>               error_report("%s: Failed to mmap VFIO migration region %d: %s",
> >> -                         vbasedev->name, migration->region.index,
> >> +                         vbasedev->name, migration->region.nr,
> >>                            strerror(-ret));
> >>               return ret;
> >>           }
> >> @@ -194,9 +325,121 @@ static void vfio_save_cleanup(void *opaque)
> >>       trace_vfio_save_cleanup(vbasedev->name);
> >>   }
> >>   
> >> +static void vfio_save_pending(QEMUFile *f, void *opaque,
> >> +                              uint64_t threshold_size,
> >> +                              uint64_t *res_precopy_only,
> >> +                              uint64_t *res_compatible,
> >> +                              uint64_t *res_postcopy_only)
> >> +{
> >> +    VFIODevice *vbasedev = opaque;
> >> +    VFIOMigration *migration = vbasedev->migration;
> >> +    int ret;
> >> +
> >> +    ret = vfio_update_pending(vbasedev);
> >> +    if (ret) {
> >> +        return;
> >> +    }
> >> +
> >> +    *res_precopy_only += migration->pending_bytes;
> >> +
> >> +    trace_vfio_save_pending(vbasedev->name, *res_precopy_only,
> >> +                            *res_postcopy_only, *res_compatible);
> >> +}
> >> +
> >> +static int vfio_save_iterate(QEMUFile *f, void *opaque)
> >> +{
> >> +    VFIODevice *vbasedev = opaque;
> >> +    int ret, data_size;
> >> +
> >> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
> >> +
> >> +    data_size = vfio_save_buffer(f, vbasedev);
> >> +
> >> +    if (data_size < 0) {
> >> +        error_report("%s: vfio_save_buffer failed %s", vbasedev->name,
> >> +                     strerror(errno));
> >> +        return data_size;
> >> +    }
> >> +
> >> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> >> +
> >> +    ret = qemu_file_get_error(f);
> >> +    if (ret) {
> >> +        return ret;
> >> +    }
> >> +
> >> +    trace_vfio_save_iterate(vbasedev->name, data_size);
> >> +    if (data_size == 0) {
> >> +        /* indicates data finished, goto complete phase */
> >> +        return 1;  
> > 
> > But it's pending_bytes not data_size that indicates we're done.  How do
> > we get away with ignoring pending_bytes for the save_live_iterate phase?
> >   
> 
> This is requirement mentioned above qemu_savevm_state_iterate() which 
> calls .save_live_iterate.
> 
> /*	
>   * this function has three return values:
>   *   negative: there was one error, and we have -errno.
>   *   0 : We haven't finished, caller have to go again
>   *   1 : We have finished, we can go to complete phase
>   */
> int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
> 
> This is to serialize savevm_state.handlers (or in other words devices).

I've lost all context on this question in the interim, but I think this
highlights my question.  We use pending_bytes to know how close we are
to the end of the stream and data_size to iterate each transaction
within that stream.  So how does data_size == 0 indicate we've
completed the current phase?  It seems like pending_bytes should
indicate that.  Thanks,

Alex


