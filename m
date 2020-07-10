Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632CFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9DA20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEe4XK+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9DA20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtwD4-0000IA-6l
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtwCV-0008I0-61
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:48:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtwCT-0001hk-FG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594399716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBIoXRU6VRU9Nwhfbjd3NGlYjMXcM1jG//7uV3/U9B4=;
 b=MEe4XK+9iQoUOa/gs61r81u74QZHZtatoYNBNbLvesnu/H0wrkzrE03aLzu9rgqYY0kJSY
 zWQyzmYieBnU6n540UPBC8qS7NEUs0j7UYjyTphUVJ6SPNE9+mH3Oel6vUe2tBKaOvD7ev
 Nhhf1uiMDtxBhatDAHyA2A9imCN+324=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-dkd5zP6QMA6BacYYO9Ontg-1; Fri, 10 Jul 2020 12:48:35 -0400
X-MC-Unique: dkd5zP6QMA6BacYYO9Ontg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 210591009445;
 Fri, 10 Jul 2020 16:48:34 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B714774F4E;
 Fri, 10 Jul 2020 16:48:33 +0000 (UTC)
Date: Fri, 10 Jul 2020 12:48:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v5 1/4] target/i386: add missing vmx features for several
 CPU models
Message-ID: <20200710164832.GR780932@habkost.net>
References: <20200619073114.24303-1-chenyi.qiang@intel.com>
 <20200619073114.24303-2-chenyi.qiang@intel.com>
 <20200709221226.GM780932@habkost.net>
 <d3542ac6-9282-ed88-3819-3cc8b3368ee7@intel.com>
MIME-Version: 1.0
In-Reply-To: <d3542ac6-9282-ed88-3819-3cc8b3368ee7@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 09:45:49AM +0800, Chenyi Qiang wrote:
> 
> 
> On 7/10/2020 6:12 AM, Eduardo Habkost wrote:
> > 
> > I'm very sorry for taking so long to review this.  Question
> > below:
> > 
> > On Fri, Jun 19, 2020 at 03:31:11PM +0800, Chenyi Qiang wrote:
> > > Add some missing VMX features in Skylake-Server, Cascadelake-Server and
> > > Icelake-Server CPU models based on the output of Paolo's script.
> > > 
> > > Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > 
> > Why are you changing the v1 definition instead adding those new
> > features in a new version of the CPU model, just like you did in
> > patch 3/4?
> > 
> 
> I suppose these missing vmx features are not quite necessary for customers.
> Just post it here to see if they are worth being added.
> Adding a new version is reasonable. Is it appropriate to put all the missing
> features in patch 1/4, 3/4, 4/4 in a same version?

Yes, it would be OK to add only one new version with all the new
features.

-- 
Eduardo


