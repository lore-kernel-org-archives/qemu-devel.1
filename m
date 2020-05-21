Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD457C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609B0207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zg9rGeo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609B0207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqvN-0002UO-HE
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqnA-0000ih-Hd
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:23:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51142
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqn9-00026v-A3
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590089022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eV7kx6uWwAjz7sghgf8RSGSrat15H3jlax1fXIgevFw=;
 b=Zg9rGeo188HEqWZ1m+GTJS3ji6Q2sPQJjVI4eGOqG3Sv0dgLxwICPBQRbzeDki8tK5dbAw
 Fi01rGyltTKMsB4BSivyAWZyWoaq9CJiq3G0j/kOJHZ0ctJ1/UyKD1SvrL7gSuMsV15gpZ
 4jhloSeVhwpO+bNVCbu/GmbtE7JefMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-eGOo5sMJNBqckf6RtwR8bA-1; Thu, 21 May 2020 15:23:38 -0400
X-MC-Unique: eGOo5sMJNBqckf6RtwR8bA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 161CB835B44;
 Thu, 21 May 2020 19:23:36 +0000 (UTC)
Received: from work-vm (ovpn-113-115.ams2.redhat.com [10.36.113.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24B6E5D9C9;
 Thu, 21 May 2020 19:23:23 +0000 (UTC)
Date: Thu, 21 May 2020 20:23:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 18/18] qapi: Add VFIO devices migration stats in
 Migration stats
Message-ID: <20200521192321.GP2752@work-vm>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-19-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1589999088-31477-19-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, alex.williamson@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> Added amount of bytes transferred to the target VM by all VFIO devices
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---
>  hw/vfio/common.c            | 20 ++++++++++++++++++++
>  hw/vfio/migration.c         | 10 +++++++++-
>  include/qemu/vfio-helpers.h |  3 +++
>  migration/migration.c       | 18 ++++++++++++++++++
>  monitor/hmp-cmds.c          |  6 ++++++
>  qapi/migration.json         | 19 ++++++++++++++++++-
>  6 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 2dd9e8b24788..e1ad426a6d78 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -40,6 +40,7 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "migration/migration.h"
> +#include "qemu/vfio-helpers.h"
>  
>  VFIOGroupList vfio_group_list =
>      QLIST_HEAD_INITIALIZER(vfio_group_list);
> @@ -293,6 +294,25 @@ const MemoryRegionOps vfio_region_ops = {
>   * Device state interfaces
>   */
>  
> +bool vfio_mig_active(void)
> +{
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    if (QLIST_EMPTY(&vfio_group_list)) {
> +        return false;
> +    }
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if (vbasedev->migration_blocker) {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
>  static bool vfio_devices_are_stopped_and_saving(void)
>  {
>      VFIOGroup *group;
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 7729c90782bd..2eef38fe5c65 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -26,7 +26,7 @@
>  #include "exec/ram_addr.h"
>  #include "pci.h"
>  #include "trace.h"
> -
> +#include "qemu/vfio-helpers.h"
>  /*
>   * Flags used as delimiter:
>   * 0xffffffff => MSB 32-bit all 1s
> @@ -38,6 +38,8 @@
>  #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>  #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>  
> +static int64_t bytes_transferred;
> +

eww global; but if there's no where else OK.
I think you need to initialise this somewhere at the start of each
migration;  you can get a migration that fails or is cancelled and then
start a second one, if you don't zero it then the second time will be
wrong.

>  static void vfio_migration_region_exit(VFIODevice *vbasedev)
>  {
>      VFIOMigration *migration = vbasedev->migration;
> @@ -229,6 +231,7 @@ static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
>          return ret;
>      }
>  
> +    bytes_transferred += data_size;
>      return data_size;
>  }
>  
> @@ -744,6 +747,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>  
>  /* ---------------------------------------------------------------------- */
>  
> +int64_t vfio_mig_bytes_transferred(void)
> +{
> +    return bytes_transferred;
> +}
> +
>  int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
>  {
>      struct vfio_region_info *info;
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index 1f057c2b9e40..26a7df0767b1 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -29,4 +29,7 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>  int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>                             int irq_type, Error **errp);
>  
> +bool vfio_mig_active(void);
> +int64_t vfio_mig_bytes_transferred(void);
> +
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 0bb042a0f78b..bcdc880e9a76 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -54,6 +54,7 @@
>  #include "net/announce.h"
>  #include "qemu/queue.h"
>  #include "multifd.h"
> +#include "qemu/vfio-helpers.h"
>  
>  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
>  
> @@ -970,6 +971,17 @@ static void populate_disk_info(MigrationInfo *info)
>      }
>  }
>  
> +#ifdef CONFIG_LINUX

If you put the ifdef inside this function then you can avoid all the
others below.

> +static void populate_vfio_info(MigrationInfo *info)
> +{
> +    if (vfio_mig_active()) {
> +        info->has_vfio = true;
> +        info->vfio = g_malloc0(sizeof(*info->vfio));
> +        info->vfio->bytes = vfio_mig_bytes_transferred();
> +    }
> +}
> +#endif
> +
>  static void fill_source_migration_info(MigrationInfo *info)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -995,6 +1007,9 @@ static void fill_source_migration_info(MigrationInfo *info)
>          populate_time_info(info, s);
>          populate_ram_info(info, s);
>          populate_disk_info(info);
> +#ifdef CONFIG_LINUX
> +        populate_vfio_info(info);
> +#endif
>          break;
>      case MIGRATION_STATUS_COLO:
>          info->has_status = true;
> @@ -1003,6 +1018,9 @@ static void fill_source_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_COMPLETED:
>          populate_time_info(info, s);
>          populate_ram_info(info, s);
> +#ifdef CONFIG_LINUX
> +        populate_vfio_info(info);
> +#endif
>          break;
>      case MIGRATION_STATUS_FAILED:
>          info->has_status = true;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 9c61e769ca9a..396c195263c2 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -355,6 +355,12 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>          }
>          monitor_printf(mon, "]\n");
>      }
> +
> +    if (info->has_vfio) {
> +        monitor_printf(mon, "vfio device bytes: %" PRIu64 " kbytes\n",
> +                       info->vfio->bytes >> 10);
> +    }
> +
>      qapi_free_MigrationInfo(info);
>  }
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d5000558c6c9..acbc42a1efe8 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -146,6 +146,18 @@
>              'active', 'postcopy-active', 'postcopy-paused',
>              'postcopy-recover', 'completed', 'failed', 'colo',
>              'pre-switchover', 'device', 'wait-unplug' ] }
> +##
> +# @VfioStats:
> +#
> +# Detailed VFIO devices migration statistics
> +#
> +# @bytes: amount of bytes transferred to the target VM by VFIO devices
> +#
> +# Since: 5.1
> +#
> +##
> +{ 'struct': 'VfioStats',
> +  'data': {'bytes': 'int' } }
>  
>  ##
>  # @MigrationInfo:
> @@ -207,6 +219,10 @@
>  #
>  # @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
>  #
> +# @vfio: @VfioStats containing detailed VFIO devices migration statistics,
> +#        only returned if VFIO device is present, migration is supported by all
> +#         VFIO devices and status is 'active' or 'completed' (since 5.1)
> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationInfo',
> @@ -222,7 +238,8 @@
>             '*postcopy-blocktime' : 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
>             '*compression': 'CompressionStats',
> -           '*socket-address': ['SocketAddress'] } }
> +           '*socket-address': ['SocketAddress'],
> +           '*vfio': 'VfioStats' } }

Is there anyway you can provide stats on the amount of main memory
that's been marked as dirty because it's mapped by the device?

Dave

>  ##
>  # @query-migrate:
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


