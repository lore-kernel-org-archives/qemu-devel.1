Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ED9C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 452C12071A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0ioJSQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452C12071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJiDT-0003ZP-CH
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 14:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jJiCc-0002le-E8
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jJiCa-0000Fl-9F
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:35:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26113
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jJiCa-0000Dc-3O
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585766098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJmy1c6r6CnadE2bkWwoTbRrEglgHM3xNT3Iu2DznQk=;
 b=L0ioJSQn1FJiVtkGVOz0LBy1L34mEhft7D0G395KkAjq/caSt2PquUPhkgbapJ4OXXAnzC
 0JITABZ9UvibczaJExLk69RzxMODPWQQLzYhoqfCw268k0W1bMlPNQKXH4zeIatSFB/hUS
 LiAyQr9DeKEO0xTjsioAOg3hjoCx1Yc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-y7pdWyOyMFGDD0SRQ5VB5A-1; Wed, 01 Apr 2020 14:34:54 -0400
X-MC-Unique: y7pdWyOyMFGDD0SRQ5VB5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1321A149C2;
 Wed,  1 Apr 2020 18:34:52 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD13CD768F;
 Wed,  1 Apr 2020 18:34:49 +0000 (UTC)
Date: Wed, 1 Apr 2020 12:34:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v16 QEMU 00/16] Add migration support for VFIO devices
Message-ID: <20200401123449.62e1a729@w520.home>
In-Reply-To: <20200401064153.GF6631@joy-OptiPlex-7040>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <20200331123424.3c28b30a@w520.home>
 <20200401064153.GF6631@joy-OptiPlex-7040>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Apr 2020 02:41:54 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Wed, Apr 01, 2020 at 02:34:24AM +0800, Alex Williamson wrote:
> > On Wed, 25 Mar 2020 02:38:58 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> > > Hi,
> > > 
> > > This Patch set adds migration support for VFIO devices in QEMU.  
> > 
> > Hi Kirti,
> > 
> > Do you have any migration data you can share to show that this solution
> > is viable and useful?  I was chatting with Dave Gilbert and there still
> > seems to be a concern that we actually have a real-world practical
> > solution.  We know this is inefficient with QEMU today, vendor pinned
> > memory will get copied multiple times if we're lucky.  If we're not
> > lucky we may be copying all of guest RAM repeatedly.  There are known
> > inefficiencies with vIOMMU, etc.  QEMU could learn new heuristics to
> > account for some of this and we could potentially report different
> > bitmaps in different phases through vfio, but let's make sure that
> > there are useful cases enabled by this first implementation.
> > 
> > With a reasonably sized VM, running a reasonable graphics demo or
> > workload, can we achieve reasonably live migration?  What kind of
> > downtime do we achieve and what is the working set size of the pinned
> > memory?  Intel folks, if you've been able to port to this or similar
> > code base, please report your results as well, open source consumers
> > are arguably even more important.  Thanks,
> >   
> hi Alex
> we're in the process of porting to this code, and now it's able to
> migrate successfully without dirty pages.
> 
> when there're dirty pages, we met several issues.
> one of them is reported here
> (https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg00004.html).
> dirty pages for some regions are not able to be collected correctly,
> especially for memory range from 3G to 4G.
> 
> even without this bug, qemu still got stuck in middle before
> reaching stop-and-copy phase and cannot be killed by admin.
> still in debugging of this problem.

Thanks, Yan.  So it seems we have various bugs, known limitations, and
we haven't actually proven that this implementation provides a useful
feature, at least for the open source consumer.  This doesn't give me
much confidence to consider the kernel portion ready for v5.7 given how
late we are already :-\  Thanks,

Alex


