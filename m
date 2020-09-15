Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1707BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9322064B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwD1rmNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9322064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIJ2B-00078b-D7
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 18:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIJ0a-0006dQ-MK
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIJ0Y-0006OX-28
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600207260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XHjhE6LGrPDqVvS9MhsdME4pleQ5XtVEJ5fqFezfcMY=;
 b=RwD1rmNTW0KfyhG9IllCU/neyZSVUYiKKU72S8VxX4X1xIn9udb7JG8OVm5CrxUT0113af
 4596y5waqmOokkGx1fSCQA+kTFIMvMFoUhb2o02OQlEUEzJp4tizmFYOw9JZYBMsBk8bpF
 gGUwbWyI4WLeABOuSG1Ibh1CnMNezjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-QW4FP0iZMTCrFWE2NAN-xQ-1; Tue, 15 Sep 2020 18:00:58 -0400
X-MC-Unique: QW4FP0iZMTCrFWE2NAN-xQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A95F186DD23;
 Tue, 15 Sep 2020 22:00:57 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1E6410021AA;
 Tue, 15 Sep 2020 22:00:56 +0000 (UTC)
Date: Tue, 15 Sep 2020 18:00:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/5] qom: Allow objects to be allocated with increased
 alignment
Message-ID: <20200915220055.GF7594@habkost.net>
References: <20200915174635.2333553-1-richard.henderson@linaro.org>
 <20200915174635.2333553-2-richard.henderson@linaro.org>
 <20200915180736.GB7594@habkost.net>
 <6d6a80bf-a542-6818-1638-0318f4aab336@linaro.org>
 <20200915201901.GD7594@habkost.net>
 <74c1e091-63c4-9ea0-c515-ad977ffa1d98@linaro.org>
 <20200915212732.GE7594@habkost.net>
 <7c827913-db00-ab68-94fb-8512f716356c@linaro.org>
MIME-Version: 1.0
In-Reply-To: <7c827913-db00-ab68-94fb-8512f716356c@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 18:01:00
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 02:30:34PM -0700, Richard Henderson wrote:
> On 9/15/20 2:27 PM, Eduardo Habkost wrote:
> > On Tue, Sep 15, 2020 at 01:51:48PM -0700, Richard Henderson wrote:
> >> On 9/15/20 1:19 PM, Eduardo Habkost wrote:
> >>> Once we move to C11, we can just use max_align_t.
> >>
> >> Yes.
> >>
> >>> While we don't move to C11, why not just use
> >>>   __alignof__(union { long l; void *p; double d; long double ld;})
> >>> ?
> >>
> >> For i386, this is 4.
> > 
> > Is i386-linux the only case where there are additional alignment
> > guarantees not covered by C99?
> 
> I think so.
> 
> > I would prefer a i386-linux-specific #ifdef for that case instead
> > of guessing based on undocumented libc internals.
> 
> I was thinking abi, not internals.

I see.  As long as we can point to the specification backing the
assumptions in the code, I'm OK with that.

To me, it seems simpler to start with something that works on all
hosts (the alignment guarantees provided by C99), and add
arch-specific optimizations later.

-- 
Eduardo


