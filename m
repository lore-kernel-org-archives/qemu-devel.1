Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68B320814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L01b3o3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68B320814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqw3-0003Qs-2r
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqgT-00035u-3C
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42102
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqgR-0000VR-EV
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590088606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C4QCeENzm6ecNV8ImcVo1IFgka2xl/bcAN3grF9GRKk=;
 b=L01b3o3lLPqupd9KmUEg56TzjP4tkASdxRQgA3TrQ2ezsPoAfn35w9OrG8XyrX54jblyHY
 +N6748zdqW5AeQvSj4Ayt6qvd/c6K5NByhbwoFIDZYMk2K8tk/7Np++bZuxMxKEX1Rrg88
 fuvKiCNVpFZ/uJGYB1YiItlt5nmdDrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-7_a73cBjMCKzLSJyxVTLfQ-1; Thu, 21 May 2020 15:16:42 -0400
X-MC-Unique: 7_a73cBjMCKzLSJyxVTLfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 284C51008301;
 Thu, 21 May 2020 19:16:40 +0000 (UTC)
Received: from work-vm (ovpn-113-115.ams2.redhat.com [10.36.113.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3562E5C578;
 Thu, 21 May 2020 19:16:12 +0000 (UTC)
Date: Thu, 21 May 2020 20:16:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 17/18] vfio: Make vfio-pci device migration
 capable
Message-ID: <20200521191609.GO2752@work-vm>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-18-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1589999088-31477-18-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> If device is not failover primary device call vfio_migration_probe()
> and vfio_migration_finalize() functions for vfio-pci device to enable
> migration for vfio PCI device which support migration.
> Removed vfio_pci_vmstate structure.
> Removed migration blocker from VFIO PCI device specific structure and use
> migration blocker from generic structure of  VFIO device.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/pci.c | 32 +++++++++++---------------------
>  hw/vfio/pci.h |  1 -
>  2 files changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 94535f0e27cd..573b28753bfd 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2916,22 +2916,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          return;
>      }
>  
> -    if (!pdev->failover_pair_id) {
> -        error_setg(&vdev->migration_blocker,
> -                "VFIO device doesn't support migration");
> -        ret = migrate_add_blocker(vdev->migration_blocker, &err);
> -        if (ret) {
> -            error_propagate(errp, err);
> -            error_free(vdev->migration_blocker);
> -            vdev->migration_blocker = NULL;
> -            return;
> -        }
> -    }
> -
>      vdev->vbasedev.name = g_path_get_basename(vdev->vbasedev.sysfsdev);
>      vdev->vbasedev.ops = &vfio_pci_ops;
>      vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
>      vdev->vbasedev.dev = DEVICE(vdev);
> +    vdev->vbasedev.device_state = 0;
>  
>      tmp = g_strdup_printf("%s/iommu_group", vdev->vbasedev.sysfsdev);
>      len = readlink(tmp, group_path, sizeof(group_path));
> @@ -3195,6 +3184,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          }
>      }
>  
> +    if (!pdev->failover_pair_id) {
> +        ret = vfio_migration_probe(&vdev->vbasedev, errp);

OK, and I can see vfio_migration_probe adds a blocker if the device
doesn't support migration.

> +        if (ret) {
> +            error_report("%s: Failed to setup for migration",
> +                         vdev->vbasedev.name);
> +        }
> +    }
> +
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> @@ -3209,11 +3206,6 @@ out_teardown:
>      vfio_bars_exit(vdev);
>  error:
>      error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> -    if (vdev->migration_blocker) {
> -        migrate_del_blocker(vdev->migration_blocker);
> -        error_free(vdev->migration_blocker);
> -        vdev->migration_blocker = NULL;
> -    }
>  }
>  
>  static void vfio_instance_finalize(Object *obj)
> @@ -3225,10 +3217,7 @@ static void vfio_instance_finalize(Object *obj)
>      vfio_bars_finalize(vdev);
>      g_free(vdev->emulated_config_bits);
>      g_free(vdev->rom);
> -    if (vdev->migration_blocker) {
> -        migrate_del_blocker(vdev->migration_blocker);
> -        error_free(vdev->migration_blocker);
> -    }
> +
>      /*
>       * XXX Leaking igd_opregion is not an oversight, we can't remove the
>       * fw_cfg entry therefore leaking this allocation seems like the safest
> @@ -3256,6 +3245,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>      }
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);
> +    vfio_migration_finalize(&vdev->vbasedev);

Which this removes at the end.
So,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  }
>  
>  static void vfio_pci_reset(DeviceState *dev)
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 0da7a20a7ec2..b148c937ef72 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -168,7 +168,6 @@ typedef struct VFIOPCIDevice {
>      bool no_vfio_ioeventfd;
>      bool enable_ramfb;
>      VFIODisplay *dpy;
> -    Error *migration_blocker;
>      Notifier irqchip_change_notifier;
>  } VFIOPCIDevice;
>  
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


