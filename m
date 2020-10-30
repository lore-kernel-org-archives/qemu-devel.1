Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6B3C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA66206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvHl04ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA66206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYad3-0002c7-Ue
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 16:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kYabM-0001sP-7X
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kYabI-00057u-PO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604088133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bHl21Z7sG4nypwLIfEu22dhTq1cpEIBlU9pBBsxEzlA=;
 b=FvHl04ieE7ilotzvJQlublYMDE6vVlf96qZr5DYrUSyaKUG6a+HHm2T9okzmq8+xtwj9JJ
 EEX+d3HM+DRIP4HsUViwFq16tvqGPRhPFnkrHWBT9iUZGQ1RUD3PZFtGYqbmU6qwlZf+Lv
 uFsRBtjXpcOeHjUBq2O+QM1OJ/4Zbws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-OY0WqwL4MLiA3yHOXZFfhw-1; Fri, 30 Oct 2020 16:02:09 -0400
X-MC-Unique: OY0WqwL4MLiA3yHOXZFfhw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08D268015FA;
 Fri, 30 Oct 2020 20:02:08 +0000 (UTC)
Received: from work-vm (ovpn-114-198.ams2.redhat.com [10.36.114.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C92825B4D5;
 Fri, 30 Oct 2020 20:02:05 +0000 (UTC)
Date: Fri, 30 Oct 2020 20:02:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
Subject: Re: RFC: Fast Migration for SEV and SEV-ES - blueprint and proof of
 concept
Message-ID: <20201030200202.GA19776@work-vm>
References: <8b824c44-6a51-c3a7-6596-921dc47fea39@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <8b824c44-6a51-c3a7-6596-921dc47fea39@linux.ibm.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Cc: ashish.kalra@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 jon.grimm@amd.com, tobin@ibm.com, qemu-devel@nongnu.org,
 dovmurik@linux.vnet.ibm.com, Dov.Murik1@il.ibm.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Tobin Feldman-Fitzthum (tobin@linux.ibm.com) wrote:
> Hello,
> 
> Dov Murik, James Bottomley, Hubertus Franke, and I have been working on a
> plan for fast live migration with SEV and SEV-ES. We just posted an RFC
> about it to the edk2 list. It includes a proof-of-concept for what we feel
> to be the most difficult part of fast live migration with SEV-ES.
> 
> https://edk2.groups.io/g/devel/topic/77875297
> 
> This was posted to the edk2 list because OVMF is one of the main components
> of our approach to live migration. With SEV/SEV-ES the hypervisor generally
> does not have access to guest memory/CPU state. We propose a Migration
> Handler in OVMF that runs inside the guest and assists the hypervisor with
> migration. One major challenge to this approach is that for SEV-ES this
> Migration Handler must be able to set the CPU state of the target to the CPU
> state of the source while the target is running. Our demo shows that this is
> feasible.
> 
> While OVMF is a major component of our approach, QEMU obviously has a huge
> part to play as well. We want to start thinking about the best way to
> support fast live migration for SEV and for encrypted VMs in general. A
> handful of issues are starting to come into focus. For instance, the target
> VM needs to be started before we begin receiving pages from the source VM.

That might not be that hard to fudge; we already start the VM in
postcopy mode before we have all of RAM; now in that we have to do stuff
to protect the RAM because we expect the guest to access it; in this
case you possibly don't need to.

> We will also need to start an extra vCPU for the Migration Handler to run
> on. We are currently working on a demo of end-to-end live migration for SEV
> (non-ES) VMs that should help crystallize these issues. It should be on the
> list around the end of the year. For now, check out our other post, which
> has a lot more information and let me know if you have any thoughts.

I don't think I understood why you'd want to map the VMSA, or why it
would be encrypted in such a way it was useful to you.

Dave


> -Tobin
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


