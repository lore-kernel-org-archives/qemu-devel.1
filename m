Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46409C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6302222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrJM/CIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6302222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUopm-00054l-C5
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUony-00042b-7s
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUonv-0001Lf-9l
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603189420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wkp/tPd3+FUnb+xRDeagskgJEWxxuH/qn2NHBEzbJRw=;
 b=FrJM/CIB19BIoK3mowARpiu5demv1Yk6rSlaBdF1uMnsOoTZSOip0kYQ/YIRCSt16TEJin
 kX1Y/OGkx3iUbJ3/KbNlNUXeEdBiYqsUmZpiWy6wX0gHGNzhPnBCPOaJyzgFBFZkC+vpQS
 P+HgDBGczPSOstoD9iZQE/0NVsTVpPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-KqhPuz2EN0KIhM1Xqfq0xg-1; Tue, 20 Oct 2020 06:23:38 -0400
X-MC-Unique: KqhPuz2EN0KIhM1Xqfq0xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C56803F4E;
 Tue, 20 Oct 2020 10:23:36 +0000 (UTC)
Received: from gondolin (ovpn-114-95.ams2.redhat.com [10.36.114.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F14AE60BF3;
 Tue, 20 Oct 2020 10:23:22 +0000 (UTC)
Date: Tue, 20 Oct 2020 12:23:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v26 05/17] vfio: Add VM state change handler to know
 state of VM
Message-ID: <20201020122320.675dbcd4.cohuck@redhat.com>
In-Reply-To: <20201019115136.70c96820@w520.home>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-6-git-send-email-kwankhede@nvidia.com>
 <20200925142023.54e2c7c0@x1.home>
 <0fd89808-74b2-49de-da79-ea034d83a5de@nvidia.com>
 <20201017174437.2fb6b699@x1.home>
 <c33278af-ab58-5786-9b70-d4f82b75cf96@nvidia.com>
 <20201019115136.70c96820@w520.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
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

On Mon, 19 Oct 2020 11:51:36 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Sun, 18 Oct 2020 23:13:39 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > <snip>
> >   
> > >>>> +vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
> > >>>> +vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> > >>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> > >>>> index 8275c4c68f45..25e3b1a3b90a 100644
> > >>>> --- a/include/hw/vfio/vfio-common.h
> > >>>> +++ b/include/hw/vfio/vfio-common.h
> > >>>> @@ -29,6 +29,7 @@
> > >>>>    #ifdef CONFIG_LINUX
> > >>>>    #include <linux/vfio.h>
> > >>>>    #endif
> > >>>> +#include "sysemu/sysemu.h"
> > >>>>    
> > >>>>    #define VFIO_MSG_PREFIX "vfio %s: "
> > >>>>    
> > >>>> @@ -119,6 +120,9 @@ typedef struct VFIODevice {
> > >>>>        unsigned int flags;
> > >>>>        VFIOMigration *migration;
> > >>>>        Error *migration_blocker;
> > >>>> +    VMChangeStateEntry *vm_state;
> > >>>> +    uint32_t device_state;
> > >>>> +    int vm_running;    
> > >>>
> > >>> Could these be placed in VFIOMigration?  Thanks,
> > >>>       
> > >>
> > >> I think device_state should be part of VFIODevice since its about device
> > >> rather than only related to migration, others can be moved to VFIOMigration.    
> > > 
> > > But these are only valid when migration is supported and thus when
> > > VFIOMigration exists.  Thanks,
> > >     
> > 
> > Even though it is used when migration is supported, its device's attribute.  
> 
> device_state is a local copy of the migration region register, so it
> serves no purpose when a migration region is not present.  In fact the
> initial value would indicate the device is stopped, which is incorrect.
> vm_running is never initialized and cannot be set other than through a
> migration region update of device_state, so at least two of these
> values show incorrect state when migration is not supported by the
> device.  vm_state is unused when migration isn't present, so if nothing
> else the pointer here is wasteful.  It's not clear to me what
> justification is being presented here as a "device's attribute",
> supporting migration as indicated by a non-NULL migration pointer is
> also a device attribute and these are attributes further defining the
> state of that support.

Agreed. Also, it is not obvious from the naming that 'device_state' is
related to migration, and it is easy to assume that this field is
useful even in the non-migration case. Moving it would solve that
problem.


