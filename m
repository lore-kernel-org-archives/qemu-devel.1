Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A895FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BF22072D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BK49nvyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BF22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8NLu-0000Fi-KH
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 08:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k8NLF-0008Hq-5E
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:37:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43849
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k8NLC-00021A-Qk
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597840637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPATgKyPSEQvIdKTuIIMpwH44syt0zjo0Kg7TzEGgiw=;
 b=BK49nvyzLfxzvBWw9qtyTVFv2OxC9frLotIBsNAEw7+KI5VlsW9qqSW+9CnZmxRxnyQSTD
 RLn2866wnBGOYPskToFv7h0wsVFoYweUdtCZpK1X3yCA3nUSEpLN8DPbKVCOHqwI1Ohx9f
 Xbj/qA3Ge3XJUIPhGL7Ji8ClVJV8iE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-S34OMjzYNOW-7b6XjM9F8A-1; Wed, 19 Aug 2020 08:37:15 -0400
X-MC-Unique: S34OMjzYNOW-7b6XjM9F8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45897801AE5;
 Wed, 19 Aug 2020 12:37:14 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A193F7A40F;
 Wed, 19 Aug 2020 12:37:12 +0000 (UTC)
Date: Wed, 19 Aug 2020 14:37:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2 1/7] x86: lpc9: let firmware negotiate 'CPU hotplug
 with SMI' features
Message-ID: <20200819143711.3cb79eeb@redhat.com>
In-Reply-To: <5d53a2d1-d664-07ea-20f7-ca04aec76016@redhat.com>
References: <20200818122208.1243901-1-imammedo@redhat.com>
 <20200818122208.1243901-2-imammedo@redhat.com>
 <f5a7a4a6-f80e-9836-1524-d4ffe896be92@redhat.com>
 <20200819105811.4e649725.cohuck@redhat.com>
 <5d53a2d1-d664-07ea-20f7-ca04aec76016@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 aaron.young@oracle.com, David Gibson <dgibson@redhat.com>,
 boris.ostrovsky@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 11:14:45 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 08/19/20 10:58, Cornelia Huck wrote:
> 
> > I consider any patch that adds compat options without adding all compat
> > machines first to be buggy. We had that in the past, and it had been
> > painful to sort it out again later. That's why I usually post a compat
> > machines patch during hardfreeze, to be picked up by anyone who needs
> > it.
> > 
> > (See
> > https://lore.kernel.org/qemu-devel/20200728094645.272149-1-cohuck@redhat.com/
> > -- this is the patch that Daniel re-posted.)  
> 
> Indeed, thank you -- in the end, I did notice that Daniel's patch
> started with "From: Cornelia" :) and then I checked my qemu-devel
> folders for more emails with the same subject.
> 
> > Just pick my original patch, it has a bunch of acks already.  
> 
> True, but Igor's series wouldn't apply without manual conflict
> resolution, and I can't do that if I want to respond with a Tested-by.
> 
> (Of course, picking up your patch and including it in v3 is feasible for
> Igor.)

I'll rebase this path on top 5.2 machine patch and post it here.

> 
> Thanks!
> Laszlo


