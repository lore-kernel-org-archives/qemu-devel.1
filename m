Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B7FC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBBA2220B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azfu5Rg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBBA2220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBcQ-0000id-EE
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIBbk-0008Cl-Mh
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:06:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36414
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIBbi-0007IK-Bd
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600178812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/IJP6BGDc3ODuUXcaZG5oBNE/08pLzssZtv+hFIHYg=;
 b=Azfu5Rg5vNUH/3y3qs54kXNgke7+Va9O16FUny+q0zmqA3QjSRM5tGqCO7kwUQjkZgZmwE
 cPWX/dK/YHr3Wgb/TXs8HjJhS5IGAQqIikhei4NKSF6f+pyOoQFovuw5kXdoFl9v7kbm/a
 IX6PmhHobuQlRBvKEWrCJtI635tTsco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-mufUtyr2OVWcRFqvWpxw9A-1; Tue, 15 Sep 2020 10:06:50 -0400
X-MC-Unique: mufUtyr2OVWcRFqvWpxw9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68FC81074650;
 Tue, 15 Sep 2020 14:06:49 +0000 (UTC)
Received: from localhost (unknown [10.10.67.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D2A210013BD;
 Tue, 15 Sep 2020 14:06:49 +0000 (UTC)
Date: Tue, 15 Sep 2020 10:06:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v2 1/2] Introduce (x86) CPU model deprecation API
Message-ID: <20200915140648.GB8079@habkost.net>
References: <1591843676-102054-1-git-send-email-robert.hu@linux.intel.com>
 <20200909181506.GM1618070@habkost.net>
 <e3a289f5db0064dd363cb3481d152e20df14b35d.camel@linux.intel.com>
 <20200911140013.GS1618070@habkost.net>
 <b3d7de0e900c199e28702584a90a08987862e655.camel@linux.intel.com>
 <20200914133849.GY1618070@habkost.net>
 <e37ad7f662256431512f2b1e0bfed7d2b0853a3e.camel@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <e37ad7f662256431512f2b1e0bfed7d2b0853a3e.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:11:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "Hu, Robert" <robert.hu@intel.com>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 10:56:06AM +0800, Robert Hoo wrote:
> On Mon, 2020-09-14 at 13:38 +0000, Eduardo Habkost wrote:
> > On Mon, Sep 14, 2020 at 06:50:09PM +0800, Robert Hoo wrote:
[...]
> > > 2) Each x86 cpudef CPU model has 1 unversioned cpu_model_type then
> > > its
> > > versioned cpu_model_types. Refer to code in
> > > x86_register_cpudef_types(). The unversioned model won't be marked
> > > deprecated as it is unkown when registered. In
> > > machine_run_board_init(), the cpu_model being checked is the
> > > unversioned one, if I set -cpu to its general unversioned model.
> > > In short, the unversioned cpudef CPU model would escape the
> > > deprecation
> > > check.
> > 
> > Why is that a problem?  If, for example, Model-v1 is deprecated
> > and Model-v2 is not deprecated, we must never tell the user that
> > "-cpu Model" is deprecated.  
> 
> Yes, that's why I cannot mark the unversioned one deprecated or not in
> its init.
> 
> > Even if some machine types resolve
> > "-cpu Model" to Model-v1.
> > 
> That's what I concerned. Say, if I named "-cpu Icelake-Client" and it's
> resolved to Icelake-CPU-v1 (deprecated), shouldn't we warn user?

For Icelake-Client, we want to make all versions of
Icelake-Client deprecated, so "Icelake-Client" can and should be
marked as deprecated at class_init time.

I don't think we need to support a use case where "Model" is not
deprecated bu "Model-v1" is.

-- 
Eduardo


