Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0422AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5306E2224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFeGvsUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5306E2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUZL6-0000EW-6z
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 13:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kUZK3-0007y3-Es
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kUZK1-00087h-5L
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603129906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eo21jisbshZf5T/V88v75wikjrrNhXPGnz2qkzN0ULI=;
 b=jFeGvsUvMdbNVveRQBH8A4k1MPbFzywtayBKMsQRbj+QeQWqlx4v7MLbJt6yCgYpf5Uv9X
 zz28/3If8omQyT775XP6zT3JlvqPVdBd/JRuAcKgIcaeoEI9RfApkzkLMuFgyJrrGjeT8f
 OwZOVa84EGkrygy3ungrbaLJYor9jOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-0bV0Q-dhMGqvua88d1ZWYg-1; Mon, 19 Oct 2020 13:51:44 -0400
X-MC-Unique: 0bV0Q-dhMGqvua88d1ZWYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2203F8049C7;
 Mon, 19 Oct 2020 17:51:42 +0000 (UTC)
Received: from w520.home (ovpn-112-77.phx2.redhat.com [10.3.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2E3060C13;
 Mon, 19 Oct 2020 17:51:36 +0000 (UTC)
Date: Mon, 19 Oct 2020 11:51:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 05/17] vfio: Add VM state change handler to know
 state of VM
Message-ID: <20201019115136.70c96820@w520.home>
In-Reply-To: <c33278af-ab58-5786-9b70-d4f82b75cf96@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-6-git-send-email-kwankhede@nvidia.com>
 <20200925142023.54e2c7c0@x1.home>
 <0fd89808-74b2-49de-da79-ea034d83a5de@nvidia.com>
 <20201017174437.2fb6b699@x1.home>
 <c33278af-ab58-5786-9b70-d4f82b75cf96@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 18 Oct 2020 23:13:39 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> <snip>
> 
> >>>> +vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
> >>>> +vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> >>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> >>>> index 8275c4c68f45..25e3b1a3b90a 100644
> >>>> --- a/include/hw/vfio/vfio-common.h
> >>>> +++ b/include/hw/vfio/vfio-common.h
> >>>> @@ -29,6 +29,7 @@
> >>>>    #ifdef CONFIG_LINUX
> >>>>    #include <linux/vfio.h>
> >>>>    #endif
> >>>> +#include "sysemu/sysemu.h"
> >>>>    
> >>>>    #define VFIO_MSG_PREFIX "vfio %s: "
> >>>>    
> >>>> @@ -119,6 +120,9 @@ typedef struct VFIODevice {
> >>>>        unsigned int flags;
> >>>>        VFIOMigration *migration;
> >>>>        Error *migration_blocker;
> >>>> +    VMChangeStateEntry *vm_state;
> >>>> +    uint32_t device_state;
> >>>> +    int vm_running;  
> >>>
> >>> Could these be placed in VFIOMigration?  Thanks,
> >>>     
> >>
> >> I think device_state should be part of VFIODevice since its about device
> >> rather than only related to migration, others can be moved to VFIOMigration.  
> > 
> > But these are only valid when migration is supported and thus when
> > VFIOMigration exists.  Thanks,
> >   
> 
> Even though it is used when migration is supported, its device's attribute.

device_state is a local copy of the migration region register, so it
serves no purpose when a migration region is not present.  In fact the
initial value would indicate the device is stopped, which is incorrect.
vm_running is never initialized and cannot be set other than through a
migration region update of device_state, so at least two of these
values show incorrect state when migration is not supported by the
device.  vm_state is unused when migration isn't present, so if nothing
else the pointer here is wasteful.  It's not clear to me what
justification is being presented here as a "device's attribute",
supporting migration as indicated by a non-NULL migration pointer is
also a device attribute and these are attributes further defining the
state of that support.

BTW, device_state is used in patch 03/ but only defined here in 05/, so
the series would fail to compile on bisect.  Thanks,

Alex


