Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAF9C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F29020B80
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jjnbt07/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F29020B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnUb-0002YH-Jz
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTnT2-0008RM-1z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTnT1-00058d-5w
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:13:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTnT0-00057o-M7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588169617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5KJj0/IEeIDfSeMUgMfCAULVkkEU1Ysj/D3ASB/G5k=;
 b=Jjnbt07/xHr9MSmwaGkRW+SU9zwLeg+tWBLDpcyaJ8kdFqzNXqs+sEv7dMEg25VtatmkQP
 KVHYYUzXoJ3iF5ofIjcdAIOwebO1HzafF3GsApowtIdeKuzToBlhJ2YJteqXue17tRnISt
 8uaRc+dwGmPPJEWBnZpxUSI2MkpKONY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-eJjW36AfMLWIeaVqCQ_XUQ-1; Wed, 29 Apr 2020 10:13:23 -0400
X-MC-Unique: eJjW36AfMLWIeaVqCQ_XUQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C31EF108BD0F;
 Wed, 29 Apr 2020 14:13:19 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 998945D9E5;
 Wed, 29 Apr 2020 14:13:02 +0000 (UTC)
Subject: Re: [PATCH v5 0/4] introduction of migration_version attribute for
 VFIO live migration
To: Yan Zhao <yan.y.zhao@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200421023718.GA12111@joy-OptiPlex-7040>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D86DF06@SHSMSX104.ccr.corp.intel.com>
 <20200422073628.GA12879@joy-OptiPlex-7040> <20200424191049.GU3106@work-vm>
 <20200426013628.GC12879@joy-OptiPlex-7040> <20200427153743.GK2923@work-vm>
 <20200428005429.GJ12879@joy-OptiPlex-7040> <20200428141437.GG2794@work-vm>
 <20200429072616.GL12879@joy-OptiPlex-7040> <20200429082201.GA2834@work-vm>
 <20200429093555.GM12879@joy-OptiPlex-7040>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <94cd58d2-0580-53cd-6ca2-2c33146e0f2c@redhat.com>
Date: Wed, 29 Apr 2020 09:13:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429093555.GM12879@joy-OptiPlex-7040>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Yang, Ziye" <ziye.yang@intel.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Zeng, Xin" <xin.zeng@intel.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "dinechin@redhat.com" <dinechin@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He,
 Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[meta-comment]

On 4/29/20 4:35 AM, Yan Zhao wrote:
> On Wed, Apr 29, 2020 at 04:22:01PM +0800, Dr. David Alan Gilbert wrote:
[...]
>>>>>>>>>>>>>>>>> This patchset introduces a migration_version attribute under sysfs
>>>>>>>>>>> of VFIO
>>>>>>>>>>>>>>>>> Mediated devices.

Hmm, several pages with up to 16 levels of quoting, with editors making 
the lines ragged, all before I get to the real meat of the email. 
Remember, it's okay to trim content,...

>> So why don't we split the difference; lets say that it should start with
>> the hex PCI Vendor ID.
>>
> The problem is for mdev devices, if the parent devices are not PCI devices,
> they don't have PCI vendor IDs.

...to just what you are replying to.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


