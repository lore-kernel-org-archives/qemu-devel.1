Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561B0C47259
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2481B206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIRWWWCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2481B206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVv7G-0002zQ-9A
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVv6K-00028r-5i
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:47:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59532
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVv6I-0006Su-TF
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588675617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3PBXlwcAwgmvfl9quRjTguvwTUCKxMW9LIm0GF7wT0=;
 b=XIRWWWCV8u47rHeVQBjkN0vy8YZDjCvZgRFLHHNO3AozLS0Kimnc00+jNrTHin8jBw6t38
 ppqWEKSvo8h3msx3HWZcHjdGyG+2CKuck85yIu0/LTxl9Pi+By4y36LWSjS5inHx5eYXh5
 wwhzgsIAkB3vD8jcLIkI2NiKfDu+XFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-onKmB-XbNaC9y-_u7nbHdg-1; Tue, 05 May 2020 06:46:55 -0400
X-MC-Unique: onKmB-XbNaC9y-_u7nbHdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFDAD460;
 Tue,  5 May 2020 10:46:52 +0000 (UTC)
Received: from gondolin (ovpn-112-219.ams2.redhat.com [10.36.112.219])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD1F719C58;
 Tue,  5 May 2020 10:46:41 +0000 (UTC)
Date: Tue, 5 May 2020 12:46:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v18 QEMU 07/18] vfio: Add migration state change notifier
Message-ID: <20200505124639.56531df8.cohuck@redhat.com>
In-Reply-To: <1588632293-18932-8-git-send-email-kwankhede@nvidia.com>
References: <1588632293-18932-1-git-send-email-kwankhede@nvidia.com>
 <1588632293-18932-8-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

On Tue, 5 May 2020 04:14:42 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Added migration state change notifier to get notification on migration state
> change. These states are translated to VFIO device state and conveyed to vendor
> driver.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
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

What is the actually desired state transition here? Again, I find the
interface hard to read... and my comments regarding state propagation
and error states from the previous patch apply here as well.


> +    }
> +}
> +


