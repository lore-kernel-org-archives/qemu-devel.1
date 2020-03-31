Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02871C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24A520784
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGv8azzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24A520784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJLjZ-0006eb-R9
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 14:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jJLih-0005os-NJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jJLif-0007Ka-Ky
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:34:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jJLie-0007IJ-49
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585679674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ao/j48l/9FWbSVogpHnLSdrqfngtlAzTIwORADrN/sU=;
 b=HGv8azziVEf0CkIhf2WzYOKb9kDTMDU2EdXfNiO4sG8P6YAFpEkQJJzCqTLhdkBaYpbCju
 E6RFw8IHPva7NfcVYMn763GNKp4Q2e5kPhtnnBK77gDfa/TOEkQp3nmu9o9qcbfj7n69cY
 hHTJqspdLNbEiVRNIAPpyeVlYMRx89o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-7UJ0r0yNMy-FYQ-LVjnSwg-1; Tue, 31 Mar 2020 14:34:30 -0400
X-MC-Unique: 7UJ0r0yNMy-FYQ-LVjnSwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FB79800D50;
 Tue, 31 Mar 2020 18:34:28 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35A0B60BE1;
 Tue, 31 Mar 2020 18:34:25 +0000 (UTC)
Date: Tue, 31 Mar 2020 12:34:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 00/16] Add migration support for VFIO devices
Message-ID: <20200331123424.3c28b30a@w520.home>
In-Reply-To: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 02:38:58 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Hi,
> 
> This Patch set adds migration support for VFIO devices in QEMU.

Hi Kirti,

Do you have any migration data you can share to show that this solution
is viable and useful?  I was chatting with Dave Gilbert and there still
seems to be a concern that we actually have a real-world practical
solution.  We know this is inefficient with QEMU today, vendor pinned
memory will get copied multiple times if we're lucky.  If we're not
lucky we may be copying all of guest RAM repeatedly.  There are known
inefficiencies with vIOMMU, etc.  QEMU could learn new heuristics to
account for some of this and we could potentially report different
bitmaps in different phases through vfio, but let's make sure that
there are useful cases enabled by this first implementation.

With a reasonably sized VM, running a reasonable graphics demo or
workload, can we achieve reasonably live migration?  What kind of
downtime do we achieve and what is the working set size of the pinned
memory?  Intel folks, if you've been able to port to this or similar
code base, please report your results as well, open source consumers
are arguably even more important.  Thanks,

Alex


