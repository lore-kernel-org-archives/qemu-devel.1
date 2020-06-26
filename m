Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260C1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D439620775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2zcbjay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D439620775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jopkp-00047I-09
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jopkG-0003fM-F1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:54:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jopkE-00054n-3T
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593183260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sYlEFxBeJocIRhZr1JHEZXAuCklCWAKq2OP1HptvNcU=;
 b=R2zcbjayCoDsGljL2HQ9hxd844Ce5vfrjvg+foSiOHwpqPwvVug9jLhJ+IWRaItHTH7fAR
 3beBAB/SVceMtkzitli0NvubPaQG2NJMQJ3AV19400ejov9B0uLsWoedKgGqjoQ8M7VrsU
 dnuizkKr/REcPIfniAjSAoeXHLhFplI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-ddKFdQ-9MUuNdO8mcfLwgg-1; Fri, 26 Jun 2020 10:54:15 -0400
X-MC-Unique: ddKFdQ-9MUuNdO8mcfLwgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 255091B18BF0;
 Fri, 26 Jun 2020 14:54:13 +0000 (UTC)
Received: from work-vm (ovpn-113-27.ams2.redhat.com [10.36.113.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 778F110013D2;
 Fri, 26 Jun 2020 14:54:02 +0000 (UTC)
Date: Fri, 26 Jun 2020 15:54:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH QEMU v25 09/17] vfio: Add load state functions to
 SaveVMHandlers
Message-ID: <20200626145400.GM3087@work-vm>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-10-git-send-email-kwankhede@nvidia.com>
 <20200624125437.664869ce@x1.home>
MIME-Version: 1.0
In-Reply-To: <20200624125437.664869ce@x1.home>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Williamson (alex.williamson@redhat.com) wrote:
> On Sun, 21 Jun 2020 01:51:18 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > Sequence  during _RESUMING device state:
> > While data for this device is available, repeat below steps:
> > a. read data_offset from where user application should write data.
> > b. write data of data_size to migration region from data_offset.
> > c. write data_size which indicates vendor driver that data is written in
> >    staging buffer.
> > 
> > For user, data is opaque. User should write data in the same order as
> > received.
> > 
> > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/vfio/migration.c  | 177 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  hw/vfio/trace-events |   3 +
> >  2 files changed, 180 insertions(+)
> > 
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index ef1150c1ff02..faacea5327cb 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -302,6 +302,33 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> >      return qemu_file_get_error(f);
> >  }
> >  
> > +static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> > +{
> > +    VFIODevice *vbasedev = opaque;
> > +    uint64_t data;
> > +
> > +    if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
> > +        int ret;
> > +
> > +        ret = vbasedev->ops->vfio_load_config(vbasedev, f);
> > +        if (ret) {
> > +            error_report("%s: Failed to load device config space",
> > +                         vbasedev->name);
> > +            return ret;
> > +        }
> > +    }
> > +
> > +    data = qemu_get_be64(f);
> > +    if (data != VFIO_MIG_FLAG_END_OF_STATE) {
> > +        error_report("%s: Failed loading device config space, "
> > +                     "end flag incorrect 0x%"PRIx64, vbasedev->name, data);
> > +        return -EINVAL;
> > +    }
> > +
> > +    trace_vfio_load_device_config_state(vbasedev->name);
> > +    return qemu_file_get_error(f);
> > +}
> > +
> >  /* ---------------------------------------------------------------------- */
> >  
> >  static int vfio_save_setup(QEMUFile *f, void *opaque)
> > @@ -472,12 +499,162 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> >      return ret;
> >  }
> >  
> > +static int vfio_load_setup(QEMUFile *f, void *opaque)
> > +{
> > +    VFIODevice *vbasedev = opaque;
> > +    VFIOMigration *migration = vbasedev->migration;
> > +    int ret = 0;
> > +
> > +    if (migration->region.mmaps) {
> > +        ret = vfio_region_mmap(&migration->region);
> > +        if (ret) {
> > +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> > +                         vbasedev->name, migration->region.nr,
> > +                         strerror(-ret));
> > +            return ret;
> 
> 
> Not fatal.
> 
> 
> > +        }
> > +    }
> > +
> > +    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_MASK,
> > +                                   VFIO_DEVICE_STATE_RESUMING);
> > +    if (ret) {
> > +        error_report("%s: Failed to set state RESUMING", vbasedev->name);
> > +    }
> > +    return ret;
> > +}
> > +
> > +static int vfio_load_cleanup(void *opaque)
> > +{
> > +    vfio_save_cleanup(opaque);
> > +    return 0;
> > +}
> > +
> > +static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> > +{
> > +    VFIODevice *vbasedev = opaque;
> > +    VFIOMigration *migration = vbasedev->migration;
> > +    int ret = 0;
> > +    uint64_t data, data_size;
> > +
> > +    data = qemu_get_be64(f);
> > +    while (data != VFIO_MIG_FLAG_END_OF_STATE) {
> > +
> > +        trace_vfio_load_state(vbasedev->name, data);
> > +
> > +        switch (data) {
> > +        case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
> > +        {
> > +            ret = vfio_load_device_config_state(f, opaque);
> > +            if (ret) {
> > +                return ret;
> > +            }
> > +            break;
> > +        }
> > +        case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> > +        {
> > +            data = qemu_get_be64(f);
> > +            if (data == VFIO_MIG_FLAG_END_OF_STATE) {
> > +                return ret;
> > +            } else {
> > +                error_report("%s: SETUP STATE: EOS not found 0x%"PRIx64,
> > +                             vbasedev->name, data);
> > +                return -EINVAL;
> 
> This is essentially just a compatibility failure, right?  For instance
> some future version of QEMU might include additional data between these
> markers that we don't understand and therefore we fail the migration.

Or any other screwup in data layout;  we've found having a canary at the
end of state is quite useful for when we screwup for one reason or
another.

Dave

> Thanks,
> 
> Alex
> 
> > +            }
> > +            break;
> > +        }
> > +        case VFIO_MIG_FLAG_DEV_DATA_STATE:
> > +        {
> > +            VFIORegion *region = &migration->region;
> > +            uint64_t data_offset = 0, size;
> > +
> > +            data_size = size = qemu_get_be64(f);
> > +            if (data_size == 0) {
> > +                break;
> > +            }
> > +
> > +            ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
> > +                        region->fd_offset +
> > +                        offsetof(struct vfio_device_migration_info,
> > +                        data_offset));
> > +            if (ret != sizeof(data_offset)) {
> > +                error_report("%s:Failed to get migration buffer data offset %d",
> > +                             vbasedev->name, ret);
> > +                return -EINVAL;
> > +            }
> > +
> > +            trace_vfio_load_state_device_data(vbasedev->name, data_offset,
> > +                                              data_size);
> > +
> > +            while (size) {
> > +                void *buf = NULL;
> > +                uint64_t sec_size;
> > +                bool buffer_mmaped;
> > +
> > +                buf = get_data_section_size(region, data_offset, size,
> > +                                            &sec_size);
> > +
> > +                buffer_mmaped = (buf != NULL);
> > +
> > +                if (!buffer_mmaped) {
> > +                    buf = g_try_malloc(sec_size);
> > +                    if (!buf) {
> > +                        error_report("%s: Error allocating buffer ", __func__);
> > +                        return -ENOMEM;
> > +                    }
> > +                }
> > +
> > +                qemu_get_buffer(f, buf, sec_size);
> > +
> > +                if (!buffer_mmaped) {
> > +                    ret = pwrite(vbasedev->fd, buf, sec_size,
> > +                                 region->fd_offset + data_offset);
> > +                    g_free(buf);
> > +
> > +                    if (ret != sec_size) {
> > +                        error_report("%s: Failed to set migration buffer %d",
> > +                                vbasedev->name, ret);
> > +                        return -EINVAL;
> > +                    }
> > +                }
> > +                size -= sec_size;
> > +                data_offset += sec_size;
> > +            }
> > +
> > +            ret = pwrite(vbasedev->fd, &data_size, sizeof(data_size),
> > +                         region->fd_offset +
> > +                       offsetof(struct vfio_device_migration_info, data_size));
> > +            if (ret != sizeof(data_size)) {
> > +                error_report("%s: Failed to set migration buffer data size %d",
> > +                             vbasedev->name, ret);
> > +                return -EINVAL;
> > +            }
> > +            break;
> > +        }
> > +
> > +        default:
> > +            error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
> > +            return -EINVAL;
> > +        }
> > +
> > +        data = qemu_get_be64(f);
> > +        ret = qemu_file_get_error(f);
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> >  static SaveVMHandlers savevm_vfio_handlers = {
> >      .save_setup = vfio_save_setup,
> >      .save_cleanup = vfio_save_cleanup,
> >      .save_live_pending = vfio_save_pending,
> >      .save_live_iterate = vfio_save_iterate,
> >      .save_live_complete_precopy = vfio_save_complete_precopy,
> > +    .load_setup = vfio_load_setup,
> > +    .load_cleanup = vfio_load_cleanup,
> > +    .load_state = vfio_load_state,
> >  };
> >  
> >  /* ---------------------------------------------------------------------- */
> > diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> > index 9a1c5e17d97f..4a4bd3ba9a2a 100644
> > --- a/hw/vfio/trace-events
> > +++ b/hw/vfio/trace-events
> > @@ -157,3 +157,6 @@ vfio_save_device_config_state(const char *name) " (%s)"
> >  vfio_save_pending(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64
> >  vfio_save_iterate(const char *name, int data_size) " (%s) data_size %d"
> >  vfio_save_complete_precopy(const char *name) " (%s)"
> > +vfio_load_device_config_state(const char *name) " (%s)"
> > +vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
> > +vfio_load_state_device_data(const char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


