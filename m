Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA7FC2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BEB20838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asJVKsbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BEB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJICG-0002c2-9Y
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJIAJ-0000Ca-IX
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJIAI-0005zo-9X
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:46:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43479
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJIAI-0005yx-6R
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aR6cvnWLu05ULYQ/Ai/AaZ1JX2lXZruVvGEPtpVVXrM=;
 b=asJVKsbP3Xvmdgc6ESObiMn+Sw29K9MXsYtXcl143sD3YqTRge9zoHCr9I8K5TMCfVrY0x
 vWvmV4QfUFgP0AUcDgZ4TPwH3SHqyeP2bv0eOUlmzhJ4Gxy27NENK0ERlYEMSsqvJmZIpR
 jL75r8kAdWbtq2tgz0HgnzqDpMk5b4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-s1Efpet4NfqTGy1fGW0S0Q-1; Tue, 31 Mar 2020 10:46:48 -0400
X-MC-Unique: s1Efpet4NfqTGy1fGW0S0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57E8B800D5B;
 Tue, 31 Mar 2020 14:46:47 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B6D760BEC;
 Tue, 31 Mar 2020 14:46:44 +0000 (UTC)
Message-ID: <75f5b9944628f08554afa40d7762f91ef8f06716.camel@redhat.com>
Subject: Re: [PATCH v6 07/42] nvme: refactor nvme_addr_read
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 17:46:43 +0300
In-Reply-To: <20200331124847.wbax7webzl4grv6f@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-8-its@irrelevant.dk>
 <1fb18481dfcfa17c2395f3bcded0aef787badfc7.camel@redhat.com>
 <20200331053948.ompv75njpyhlti7i@apples.localdomain>
 <b46394ffa1e522bc7e0d3dcc5ab4762dfe16866c.camel@redhat.com>
 <20200331124847.wbax7webzl4grv6f@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-31 at 14:48 +0200, Klaus Birkelund Jensen wrote:
> On Mar 31 13:41, Maxim Levitsky wrote:
> > On Tue, 2020-03-31 at 07:39 +0200, Klaus Birkelund Jensen wrote:
> > > On Mar 25 12:38, Maxim Levitsky wrote:
> > > > Note that this patch still contains a bug that it removes the check against the accessed
> > > > size, which you fix in later patch.
> > > > I prefer to not add a bug in first place
> > > > However if you have a reason for this, I won't mind.
> > > > 
> > > 
> > > So yeah. The resons is that there is actually no bug at this point
> > > because the controller only supports PRPs. I actually thought there was
> > > a bug as well and reported it to qemu-security some months ago as a
> > > potential out of bounds access. I was then schooled by Keith on how PRPs
> > > work ;) Below is a paraphrased version of Keiths analysis.
> > > 
> > > The PRPs does not cross page boundaries:
> > 
> > True
> > 
> > > 
> > >     trans_len = n->page_size - (prp1 % n->page_size);
> > > 
> > > The PRPs are always verified to be page aligned:
> > 
> > True
> > > 
> > >     if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
> > > 
> > > and the transfer length wont go above page size. So, since the beginning
> > > of the address is within the CMB and considering that the CMB is of an
> > > MB aligned and sized granularity, then we can never cross outside it
> > > with PRPs.
> > 
> > I understand now, however the reason I am arguing about this is
> > that this patch actually _removes_ the size bound check
> > 
> > It was before the patch:
> > 
> > n->cmbsz && addr >= n->ctrl_mem.addr &&
> >       addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)
> > 
> 
> I don't think it does - the check is just moved to nvme_addr_is_cmb:
> 
>     static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>     {
>         hwaddr low = n->ctrl_mem.addr;
>         hwaddr hi  = n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);
> 
>         return addr >= low && addr < hi;
>     }
> 
> We check that `addr` is less than `hi`. Maybe the name is unfortunate...
> 
> 
Oh, I am just blind! sorry about that.
You are 100% right.

Best regards,
	Maxim Levitsky


