Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D53EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561C920738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="His0bqgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561C920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juziN-0001jp-Ki
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1juzhj-0001Dq-Ju
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:45:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57575
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1juzhh-0003zw-RS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594651513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1a6FjTH4cGtL8yZd2kdR0A22HhkLgj7s2+1MUb3ZR8=;
 b=His0bqgUyTCzKiPjJuzs0lpxefZlPRaywDOnG4nr9BNrY8VW36AyuaTWa5tlgJ0WnElkDn
 zfrN3UUK+HwF78YZ2LX6lpHnBsb34+FBjfPywVr2xVfFGe4WbJivr+6v8G9QBKnXWQvRSz
 WxEg4YXIOXtm40016E43aXIDPzCfdbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-1SM00JYmODCyWNj_-qHPsQ-1; Mon, 13 Jul 2020 10:45:11 -0400
X-MC-Unique: 1SM00JYmODCyWNj_-qHPsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25EB3E86CC;
 Mon, 13 Jul 2020 14:44:56 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7A4560BEC;
 Mon, 13 Jul 2020 14:44:55 +0000 (UTC)
Date: Mon, 13 Jul 2020 10:44:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v5 1/4] target/i386: add missing vmx features for several
 CPU models
Message-ID: <20200713144454.GX780932@habkost.net>
References: <20200619073114.24303-1-chenyi.qiang@intel.com>
 <20200619073114.24303-2-chenyi.qiang@intel.com>
 <20200709221226.GM780932@habkost.net>
 <d3542ac6-9282-ed88-3819-3cc8b3368ee7@intel.com>
 <20200710164832.GR780932@habkost.net>
 <7b8ceab5-2bf4-0905-ff9f-b2d9e2bd89a1@intel.com>
 <b67d7f1c-4a1f-dc57-ceb5-70dd8da9b5d8@intel.com>
MIME-Version: 1.0
In-Reply-To: <b67d7f1c-4a1f-dc57-ceb5-70dd8da9b5d8@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Robert Hoo <robert.hu@linux.intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 03:45:55PM +0800, Xiaoyao Li wrote:
> On 7/13/2020 3:23 PM, Chenyi Qiang wrote:
> > 
> > 
> > On 7/11/2020 12:48 AM, Eduardo Habkost wrote:
> > > On Fri, Jul 10, 2020 at 09:45:49AM +0800, Chenyi Qiang wrote:
> > > > 
> > > > 
> > > > On 7/10/2020 6:12 AM, Eduardo Habkost wrote:
> > > > > 
> > > > > I'm very sorry for taking so long to review this.  Question
> > > > > below:
> > > > > 
> > > > > On Fri, Jun 19, 2020 at 03:31:11PM +0800, Chenyi Qiang wrote:
> > > > > > Add some missing VMX features in Skylake-Server,
> > > > > > Cascadelake-Server and
> > > > > > Icelake-Server CPU models based on the output of Paolo's script.
> > > > > > 
> > > > > > Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > > > > 
> > > > > Why are you changing the v1 definition instead adding those new
> > > > > features in a new version of the CPU model, just like you did in
> > > > > patch 3/4?
> > > > > 
> > > > 
> > > > I suppose these missing vmx features are not quite necessary for
> > > > customers.
> > > > Just post it here to see if they are worth being added.
> > > > Adding a new version is reasonable. Is it appropriate to put all
> > > > the missing
> > > > features in patch 1/4, 3/4, 4/4 in a same version?
> > > 
> > > Yes, it would be OK to add only one new version with all the new
> > > features.
> > > 
> > 
> > During the coding, I prefer to split the missing vmx features into a new
> > version of CPU model, because the vmx features depends on CPUID_EXT_VMX.
> > I think It would be better to distinguish it instead of enabling the vmx
> > transparently. i.e.
> > {
> >      .version = 4,
> >      .props = (PropValue[]) {
> >          { "sha-ni", "on" },
> >          ... ...
> >          { "model", "106" },
> >                  { /* end of list */ }
> >      },
> > },
> > {
> >      .version = 5,
> >      .props = (PropValue[]) {
> >          { "vmx", "on" }
> 
> Chenyi,
> 
> This is not we have discussed. I prefer to changing the logic of versioned
> CPU model to not add the features in versioned CPU model to
> env->user_features[]. They're not supposed to be added to
> env->user_features[] since they're not set by user through -feature/+feature
> 
> Eduardo,
> 
> What do you think?

If features added by the CPU model versions appear in
user_features, that's a bug.  What's the user-visible symptom you
are seeing because of it?

-- 
Eduardo


