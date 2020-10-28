Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA22C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5271B2469F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVS8xL/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5271B2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXi3n-0006nK-15
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kXi1Z-0005pe-N7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kXi1X-0000C2-Mh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603878342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kluqitdk8MnQSNGDbj7PupNJGFcy8YFHvTQBgYrAtt0=;
 b=KVS8xL/3mLnGeONnqcMTv5C5BXLM1BIhFrzBivbL0k1vqwqYfValEFCAMwKbyHzSnLNcct
 2vTfESjSB+os9gS+T5sEiNFHRdB/SbiOHwBHPi61/fr7cHfas5fYRSvbyCuuhDYB47Nrvz
 jQTFU05WIo10CNjD+wD+/elCP37nNJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-9aM1Ru_UN3CeXIE3KE19HQ-1; Wed, 28 Oct 2020 05:45:40 -0400
X-MC-Unique: 9aM1Ru_UN3CeXIE3KE19HQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 888791005513;
 Wed, 28 Oct 2020 09:45:39 +0000 (UTC)
Received: from work-vm (ovpn-114-240.ams2.redhat.com [10.36.114.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD8342C31E;
 Wed, 28 Oct 2020 09:45:30 +0000 (UTC)
Date: Wed, 28 Oct 2020 09:45:28 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH] Revert series: virtiofsd: Announce submounts to the guest
Message-ID: <20201028094528.GC3701@work-vm>
References: <160385090886.20017.13382256442750027666.stgit@gimli.home>
 <20201028075519.GB221115@stefanha-x1.localdomain>
 <4edc7be0-cc34-6ea1-c88b-3b9888089fe2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4edc7be0-cc34-6ea1-c88b-3b9888089fe2@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
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
Cc: peter.maydell@linaro.org, cjia@nvidia.com, mjrosato@linux.ibm.com,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 kwankhede@nvidia.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Max Reitz (mreitz@redhat.com) wrote:
> On 28.10.20 08:55, Stefan Hajnoczi wrote:
> > On Tue, Oct 27, 2020 at 08:13:28PM -0600, Alex Williamson wrote:
> >> This reverts the following commits due to their basis on a bogus
> >> linux kernel header update:
> > 
> > What was the issue? Did the sub-mounts series include kernel header
> > changes that haven't landed in Linux yet?
> 
> Yes.
> 
> The kernel series was applied, however, Miklos fixed some things in the
> process, and then Dave applied the virtiofsd series assuming that it
> would be OK now that the kernel series is in.
> 
> So what could have gone better is e.g.:
> 
> (1) I could have marked the virtiofsd series as RFC until I know the
> definitive state of the kernel series.
> 
> (2) I could have given an explicit NAK to the virtiofsd series once I
> noted that I need to write a v2, and not bury that somewhere deep in the
> kernel side thread (https://marc.info/?l=fuse-devel&m=160087601428180).

Yeh that one would have been useful.
Unfortunately Miklos's changes were such that it didn't break your code;
I did give it a smoke test with 5.10-rc1 and saw that it was doing the submounts OK.

Dave

> (3) I should have noticed Dave applying the virtiofsd series (Monday
> evening) and intervened.  But my inbox full from PTO plus trying to
> perhaps get the FUSE export series done for 5.2 led to me just not noticing.
> 
> Max
> 



-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


