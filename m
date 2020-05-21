Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C5CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BA02072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3Ybipe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BA02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbjRJ-0004f6-BQ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 07:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbjQV-0003md-OX
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:31:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26433
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbjQT-0006tE-P8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590060708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WeuSztdYdUTgC07oANbs/ZK+V0gW5+QKxDOS9FcYgpk=;
 b=K3Ybipe2H7X5eOOxu81zqh6VlV6HB5SPTm4vrfP0FbHLMX7opPdfjrkCg2PqlcXRyAVGDG
 nWRJTMohwJeTM8vzDATAQWLMr6vhaTZUfNtqgqdHz3LJtI1VCECkMu5WEKxAaVAIKwbDJz
 XSiSSN9YKQElr/KjR9zgJ+ZncfBl3qo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-cys8-kCtNAqvX-qSWCEZUg-1; Thu, 21 May 2020 07:31:46 -0400
X-MC-Unique: cys8-kCtNAqvX-qSWCEZUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAB508018AD;
 Thu, 21 May 2020 11:31:43 +0000 (UTC)
Received: from work-vm (ovpn-113-115.ams2.redhat.com [10.36.113.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A315360C05;
 Thu, 21 May 2020 11:31:33 +0000 (UTC)
Date: Thu, 21 May 2020 12:31:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 07/18] vfio: Add migration state change notifier
Message-ID: <20200521113131.GF2752@work-vm>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-8-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1589999088-31477-8-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
> Added migration state change notifier to get notification on migration state
> change. These states are translated to VFIO device state and conveyed to vendor
> driver.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/vfio/migration.c           | 30 ++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |  5 +++--
>  include/hw/vfio/vfio-common.h |  1 +
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index e79b34003079..c2f5564b51c3 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -154,6 +154,28 @@ static void vfio_vmstate_change(void *opaque, int running, RunState state)
>      }
>  }
>  
> +static void vfio_migration_state_notifier(Notifier *notifier, void *data)
> +{
> +    MigrationState *s = data;
> +    VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);
> +    int ret;
> +
> +    trace_vfio_migration_state_notifier(vbasedev->name,
> +                                        MigrationStatus_str(s->state));
> +
> +    switch (s->state) {
> +    case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_CANCELLED:
> +    case MIGRATION_STATUS_FAILED:
> +        ret = vfio_migration_set_state(vbasedev,
> +                      ~(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RESUMING),
> +                      VFIO_DEVICE_STATE_RUNNING);
> +        if (ret) {
> +            error_report("%s: Failed to set state RUNNING", vbasedev->name);
> +        }
> +    }
> +}
> +
>  static int vfio_migration_init(VFIODevice *vbasedev,
>                                 struct vfio_region_info *info)
>  {
> @@ -173,6 +195,9 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>      vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>                                                            vbasedev);
>  
> +    vbasedev->migration_state.notify = vfio_migration_state_notifier;
> +    add_migration_state_change_notifier(&vbasedev->migration_state);
> +
>      return 0;
>  }
>  
> @@ -211,6 +236,11 @@ add_blocker:
>  
>  void vfio_migration_finalize(VFIODevice *vbasedev)
>  {
> +
> +    if (vbasedev->migration_state.notify) {
> +        remove_migration_state_change_notifier(&vbasedev->migration_state);
> +    }
> +
>      if (vbasedev->vm_state) {
>          qemu_del_vm_change_state_handler(vbasedev->vm_state);
>      }
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 14b0a86c0035..bd3d47b005cb 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -146,5 +146,6 @@ vfio_display_edid_write_error(void) ""
>  
>  # migration.c
>  vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
> -vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
> -vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> +vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
> +vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> +vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 3d18eb146b33..28f55f66d019 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -123,6 +123,7 @@ typedef struct VFIODevice {
>      VMChangeStateEntry *vm_state;
>      uint32_t device_state;
>      int vm_running;
> +    Notifier migration_state;
>  } VFIODevice;
>  
>  struct VFIODeviceOps {
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


