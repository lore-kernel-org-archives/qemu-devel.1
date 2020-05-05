Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B616C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605F520675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWSdrMBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605F520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVu6Z-0006pr-K0
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 05:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVu60-0006M8-JG
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:42:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29824
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVu5z-00050u-NO
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588671754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGQEU5+7JurZ0RC6WQaKDJ8xcHgdhhgIoYSUkJF16HY=;
 b=DWSdrMBJGZOcjvOImJauwhB7/P9L5I5i5kpt9q7W4g99V/rElviVoGGY2PpvcuptekJ1JJ
 Utet1rU7Apfg2E8+D+gXqaVL7uSfy8Mx4jCuXBuAxtJcnULMdRzvRoKFwDrIC+Q91DDo7M
 7XJwIxDklaL2nRC3V3WtXnIB5152vUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-vBt-DCLwPfyPFOY38OPBxA-1; Tue, 05 May 2020 05:42:30 -0400
X-MC-Unique: vBt-DCLwPfyPFOY38OPBxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED74C80183C;
 Tue,  5 May 2020 09:42:27 +0000 (UTC)
Received: from gondolin (ovpn-112-219.ams2.redhat.com [10.36.112.219])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21C825D9D3;
 Tue,  5 May 2020 09:42:16 +0000 (UTC)
Date: Tue, 5 May 2020 11:42:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v18 QEMU 05/18] vfio: Add migration region
 initialization and finalize function
Message-ID: <20200505114214.1a9850aa.cohuck@redhat.com>
In-Reply-To: <1588632293-18932-6-git-send-email-kwankhede@nvidia.com>
References: <1588632293-18932-1-git-send-email-kwankhede@nvidia.com>
 <1588632293-18932-6-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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

On Tue, 5 May 2020 04:14:40 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> - Migration functions are implemented for VFIO_DEVICE_TYPE_PCI device in this
>   patch series.

I would drop this sentence; people looking at this patch in the future
are unlikely to care.

> - VFIO device supports migration or not is decided based of migration region

"Whether the VFIO device..."

s/based of/based on/

>   query. If migration region query is successful and migration region
>   initialization is successful then migration is supported else migration is
>   blocked.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/Makefile.objs         |   2 +-
>  hw/vfio/migration.c           | 138 ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |   3 +
>  include/hw/vfio/vfio-common.h |   9 +++
>  4 files changed, 151 insertions(+), 1 deletion(-)
>  create mode 100644 hw/vfio/migration.c


> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
> +{
> +    struct vfio_region_info *info;
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
> +                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
> +    if (ret) {
> +        goto add_blocker;
> +    }
> +
> +    ret = vfio_migration_init(vbasedev, info);
> +    if (ret) {
> +        goto add_blocker;
> +    }
> +
> +    trace_vfio_migration_probe(vbasedev->name, info->index);
> +    return 0;
> +
> +add_blocker:
> +    error_setg(&vbasedev->migration_blocker,
> +               "VFIO device doesn't support migration");
> +    ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
> +    if (local_err) {

Rather check for ret?

> +        error_propagate(errp, local_err);
> +        error_free(vbasedev->migration_blocker);

vbasedev->migration_blocker = NULL; ?

> +    }
> +    return ret;

I think you also need to free info somewhere?

> +}


