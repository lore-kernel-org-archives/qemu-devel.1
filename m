Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9E7C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26914206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26914206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJRz-0002FB-AY
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iBJR6-0001lG-D2
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iBJR3-0005tv-Lp
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iBJR3-0005tO-G3
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:58:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5509D800417
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 13:58:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40BAD5D6A7;
 Fri, 20 Sep 2019 13:58:52 +0000 (UTC)
Date: Fri, 20 Sep 2019 15:58:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 0/2] kvm: clear dirty bitmaps from all overlapping memslots
Message-ID: <20190920155851.7445cd2a@redhat.com>
In-Reply-To: <20190920121951.GI12858@xz-x1>
References: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
 <20190920121951.GI12858@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 20 Sep 2019 13:58:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 20:19:51 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Fri, Sep 20, 2019 at 12:21:20PM +0200, Paolo Bonzini wrote:
> > A single ram_addr (representing a host-virtual address) could be aliased
> > to multiple guest physical addresses.  Since the KVM dirty page reporting
> > works on guest physical addresses, we need to clear all of the aliases
> > when a page is migrated, or there is a risk of losing writes to the
> > aliases that were not cleared.  
> 
> (CCing Igor too so Igor would be aware of these changes that might
>  conflict with the recent memslot split work)
> 

Thanks Peter,
I'll rebase on top of this series and do some more testing

