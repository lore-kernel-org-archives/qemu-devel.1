Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2C7C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5E821D95
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwYOr/nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5E821D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpel-0000ft-RN
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kMpdo-0008SH-Ia
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kMpdm-0005Mc-21
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:40:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601286012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3sgWirXt0XwvzfTJzWs5tRHhds1gDxWEEEa0ORVy/F0=;
 b=HwYOr/nhPK6DfXjle25GfbCjZXWaWEuGoQZWjmJck1c92GamWgMsABUpJnRy7O1CrBcD59
 MLHNAvIDwd3vtdQ/riAya39e1Vj9sdZ3WfLJwiTOMlqcHu0RI3Bq9qEhgKZc0wtSuYAl0b
 CDqsPUjgqFrNku1x+1tG9XESnkCguvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-b2OCJkcyMvi2BP3K_cCyoQ-1; Mon, 28 Sep 2020 05:40:08 -0400
X-MC-Unique: b2OCJkcyMvi2BP3K_cCyoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8E6E85C705;
 Mon, 28 Sep 2020 09:40:03 +0000 (UTC)
Received: from gondolin (ovpn-113-21.ams2.redhat.com [10.36.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 310B227BDC;
 Mon, 28 Sep 2020 09:39:52 +0000 (UTC)
Date: Mon, 28 Sep 2020 11:39:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v26 04/17] vfio: Add migration region initialization and
 finalize function
Message-ID: <20200928113949.43844e9b.cohuck@redhat.com>
In-Reply-To: <20200925142006.2b62f856@x1.home>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-5-git-send-email-kwankhede@nvidia.com>
 <20200925142006.2b62f856@x1.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Sep 2020 14:20:06 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 23 Sep 2020 04:54:06 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:

> > +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
> > +{
> > +    struct vfio_region_info *info = NULL;  
> 
> Not sure this initialization is strictly necessary either, but it also
> seems to be a common convention for this function, so either way.
> 
> Connie, does vfio_ccw_get_region() leak this?  It appears to call
> vfio_get_dev_region_info() and vfio_get_region_info() several times with
> the same pointer without freeing it between uses.

Ugh, indeed, info is reallocated without freeing it inbetween. I'll
cook up a patch, thanks for spotting.


