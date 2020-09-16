Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035C5C2BB84
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6DE21D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFdoltyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6DE21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVfW-0007wJ-Gq
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIVdj-0007Ew-2u
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIVdg-0005Zz-79
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600255815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CLMDr0I82qDNenqvpoxtIAcZBgkokDUzKrJ+7RU7h6E=;
 b=LFdoltyQ4Xb/bLvR1Auk+/tJjT/20M0P/4IhhGhfYtSNFoyB6e/E9A7x8d7Q1Ei+yHU1I8
 tqmB8D1OWRFzeN/fYgTu0la/Yoa3itKJHKfntyNxd20ijd56imXyVFIMbRIXmX/1BJoU4l
 RoHhqrvhCFmR5PSmEbnK0WzTVHsrMJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-ddu9Z7AZMWGz9GlQGWIPbw-1; Wed, 16 Sep 2020 07:30:13 -0400
X-MC-Unique: ddu9Z7AZMWGz9GlQGWIPbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C3CF890E7A;
 Wed, 16 Sep 2020 11:30:12 +0000 (UTC)
Received: from work-vm (ovpn-114-237.ams2.redhat.com [10.36.114.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7DFC5DE8D;
 Wed, 16 Sep 2020 11:29:58 +0000 (UTC)
Date: Wed, 16 Sep 2020 12:29:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Antoine Damhet <antoine.damhet@blade-group.com>, vkuznets@redhat.com
Subject: Re: [BUG] Migration hv_time rollback
Message-ID: <20200916112956.GE2833@work-vm>
References: <20200916090602.blkm7eym6g5bnvvk@tartarus>
MIME-Version: 1.0
In-Reply-To: <20200916090602.blkm7eym6g5bnvvk@tartarus>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cc'ing in Vitaly who knows about the hv stuff.

* Antoine Damhet (antoine.damhet@blade-group.com) wrote:
> Hi,
> 
> We are experiencing timestamp rollbacks during live-migration of
> Windows 10 guests with the following qemu configuration (linux 5.4.46
> and qemu master):
> ```
> $ qemu-system-x86_64 -enable-kvm -cpu host,kvm=off,hv_time [...]
> ```

How big a jump are you seeing, and how did you notice it in the guest?

Dave

> I have tracked the bug to the fact that `kvmclock` is not exposed and
> disabled from qemu PoV but is in fact used by `hv-time` (in KVM).
> 
> I think we should enable the `kvmclock` (qemu device) if `hv-time` is
> present and add Hyper-V support for the `kvmclock_current_nsec`
> function.
> 
> I'm asking for advice because I am unsure this is the _right_ approach
> and how to keep migration compatibility between qemu versions.
> 
> Thank you all,
> 
> -- 
> Antoine 'xdbob' Damhet


-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


