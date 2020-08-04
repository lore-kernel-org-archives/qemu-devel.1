Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55154C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE962064B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmEki7eP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE962064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k301q-0006Bx-8V
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k300m-0004gE-Ly
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:42:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45111
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k300k-0002aE-0d
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596559316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVKPZjD+nqawWUht3msA2tjd8QOSfxMbQgsYbiHL9vc=;
 b=bmEki7ePIEzBhOPtalq5wmQ9DZD5OJvqDwMI6gmwjZnbXMzqXhoHCC6CvWu+Bkk5FhMvbf
 F9QHIr+E1iaMt2WLBe6kFQu8m03N71QLK+t/On4l8d3iXa33+2SVLJGjaG7H9i3Aw6qnqp
 faS6HxqyWqIUFBnSumEhxU4bk2Nghb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-ylVZJniGNg6PzblW4k6ERA-1; Tue, 04 Aug 2020 12:41:54 -0400
X-MC-Unique: ylVZJniGNg6PzblW4k6ERA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F1D61DE0;
 Tue,  4 Aug 2020 16:41:52 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EB445FC36;
 Tue,  4 Aug 2020 16:41:38 +0000 (UTC)
Date: Tue, 4 Aug 2020 18:35:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200804183503.39f56516.cohuck@redhat.com>
In-Reply-To: <20200729080503.GB28676@joy-OptiPlex-7040>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <9bfa8700-91f5-ebb4-3977-6321f0487a63@redhat.com>
 <20200716083230.GA25316@joy-OptiPlex-7040>
 <20200717101258.65555978@x1.home>
 <20200721005113.GA10502@joy-OptiPlex-7040>
 <20200727072440.GA28676@joy-OptiPlex-7040>
 <20200727162321.7097070e@x1.home>
 <20200729080503.GB28676@joy-OptiPlex-7040>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, jian-feng.ding@intel.com, dgilbert@redhat.com,
 zhenyuw@linux.intel.com, hejie.xu@intel.com, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>, smooney@redhat.com,
 intel-gvt-dev@lists.freedesktop.org, berrange@redhat.com, eskultet@redhat.com,
 dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[sorry about not chiming in earlier]

On Wed, 29 Jul 2020 16:05:03 +0800
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Mon, Jul 27, 2020 at 04:23:21PM -0600, Alex Williamson wrote:

(...)

> > Based on the feedback we've received, the previously proposed interface
> > is not viable.  I think there's agreement that the user needs to be
> > able to parse and interpret the version information.  Using json seems
> > viable, but I don't know if it's the best option.  Is there any
> > precedent of markup strings returned via sysfs we could follow?  

I don't think encoding complex information in a sysfs file is a viable
approach. Quoting Documentation/filesystems/sysfs.rst:

"Attributes should be ASCII text files, preferably with only one value            
per file. It is noted that it may not be efficient to contain only one           
value per file, so it is socially acceptable to express an array of              
values of the same type.                                                         
                                                                                 
Mixing types, expressing multiple lines of data, and doing fancy                 
formatting of data is heavily frowned upon."

Even though this is an older file, I think these restrictions still
apply.

> I found some examples of using formatted string under /sys, mostly under
> tracing. maybe we can do a similar implementation.
> 
> #cat /sys/kernel/debug/tracing/events/kvm/kvm_mmio/format

Note that this is *not* sysfs (anything under debug/ follows different
rules anyway!)

> 
> name: kvm_mmio
> ID: 32
> format:
>         field:unsigned short common_type;       offset:0;       size:2; signed:0;
>         field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>         field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
> 
>         field:u32 type; offset:8;       size:4; signed:0;
>         field:u32 len;  offset:12;      size:4; signed:0;
>         field:u64 gpa;  offset:16;      size:8; signed:0;
>         field:u64 val;  offset:24;      size:8; signed:0;
> 
> print fmt: "mmio %s len %u gpa 0x%llx val 0x%llx", __print_symbolic(REC->type, { 0, "unsatisfied-read" }, { 1, "read" }, { 2, "write" }), REC->len, REC->gpa, REC->val
> 
> 
> #cat /sys/devices/pci0000:00/0000:00:02.0/uevent

'uevent' can probably be considered a special case, I would not really
want to copy it.

> DRIVER=vfio-pci
> PCI_CLASS=30000
> PCI_ID=8086:591D
> PCI_SUBSYS_ID=8086:2212
> PCI_SLOT_NAME=0000:00:02.0
> MODALIAS=pci:v00008086d0000591Dsv00008086sd00002212bc03sc00i00
> 

(...)

> what about a migration_compatible attribute under device node like
> below?
> 
> #cat /sys/bus/pci/devices/0000\:00\:02.0/UUID1/migration_compatible
> SELF:
> 	device_type=pci
> 	device_id=8086591d
> 	mdev_type=i915-GVTg_V5_2
> 	aggregator=1
> 	pv_mode="none+ppgtt+context"
> 	interface_version=3
> COMPATIBLE:
> 	device_type=pci
> 	device_id=8086591d
> 	mdev_type=i915-GVTg_V5_{val1:int:1,2,4,8}
> 	aggregator={val1}/2
> 	pv_mode={val2:string:"none+ppgtt","none+context","none+ppgtt+context"} 
> 	interface_version={val3:int:2,3}
> COMPATIBLE:
> 	device_type=pci
> 	device_id=8086591d
> 	mdev_type=i915-GVTg_V5_{val1:int:1,2,4,8}
> 	aggregator={val1}/2
> 	pv_mode=""  #"" meaning empty, could be absent in a compatible device
> 	interface_version=1

I'd consider anything of a comparable complexity to be a big no-no. If
anything, this needs to be split into individual files (with many of
them being vendor driver specific anyway.)

I think we can list compatible versions in a range/list format, though.
Something like

cat interface_version 
2.1.3

cat interface_version_compatible
2.0.2-2.0.4,2.1.0-

(indicating that versions 2.0.{2,3,4} and all versions after 2.1.0 are
compatible, considering versions <2 and >2 incompatible by default)

Possible compatibility between different mdev types feels a bit odd to
me, and should not be included by default (only if it makes sense for a
particular vendor driver.)


