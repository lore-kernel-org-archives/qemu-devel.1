Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74FBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10B420767
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zz/rrCoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10B420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnPg2-000155-V0
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 12:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jnPfL-0000W4-Ev
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:51:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60037
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jnPfJ-0000nA-Ht
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592844684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AeQIi4SaUy3e36krd8x9Wi0OL8VRoMUfofViO8y+7Y=;
 b=Zz/rrCohbNG9AnIqyBY8QnOtDD4J8Fk7ChpPzWBSC2nwWR7sOMrY+wgQzOh9Z/2/fQkwLf
 +WdB6ZxmtEwl2zKQ/PXitff9wjgNXlQ9NElXqQDtCqBCayb4HhQGYVrKh77gm7d9bTMnbt
 SY3nzjGYMg7j78gwzw8fNcVcalVtuIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-lX4ohBUQMW-U3Af1Gj5WMw-1; Mon, 22 Jun 2020 12:51:21 -0400
X-MC-Unique: lX4ohBUQMW-U3Af1Gj5WMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90387EC1B5;
 Mon, 22 Jun 2020 16:51:11 +0000 (UTC)
Received: from gondolin (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16CE660BEC;
 Mon, 22 Jun 2020 16:51:05 +0000 (UTC)
Date: Mon, 22 Jun 2020 18:51:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v25 16/17] vfio: Make vfio-pci device migration
 capable
Message-ID: <20200622185103.2e45c4fe.cohuck@redhat.com>
In-Reply-To: <1592684486-18511-17-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-17-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 21 Jun 2020 01:51:25 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> If device is not failover primary device call vfio_migration_probe()
> and vfio_migration_finalize() functions for vfio-pci device to enable
> migration for vfio PCI device which support migration.

"If the device is not a failover primary device, call
vfio_migration_probe() and vfio_migration_finalize() to enable
migration support for those devices that support it respectively to
tear it down again."

?

> Removed vfio_pci_vmstate structure.
> Removed migration blocker from VFIO PCI device specific structure and use
> migration blocker from generic structure of  VFIO device.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/vfio/pci.c | 32 +++++++++++---------------------
>  hw/vfio/pci.h |  1 -
>  2 files changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 5ba340aee1d4..9dc2868993fb 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2841,22 +2841,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
> @@ -3120,6 +3109,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          }
>      }
>  
> +    if (!pdev->failover_pair_id) {
> +        ret = vfio_migration_probe(&vdev->vbasedev, errp);
> +        if (ret) {
> +            error_report("%s: Failed to setup for migration",

"%s: migration not enabled" ?

(Although I wonder how often we need to moan here, given that the
called function already prints error reports.)

> +                         vdev->vbasedev.name);
> +        }
> +    }
> +
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);

LGTM.


