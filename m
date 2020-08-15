Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B03C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AF323101
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sj8WlTEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AF323101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xnN-0005da-DW
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6xjA-0007sb-JB
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:04:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26482
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6xj6-0006ob-Sg
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597503847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1ji2mx+Xn4Am5yZ92CUiZs3kBOCYikIb934jqwUCkg=;
 b=Sj8WlTEpdpz0MBgRVsLRbaQlj5DEYC9fBGEKH/7GBhOb8FKRNeYB1m+vpQka4pb4qiR6qa
 o1Pg+y+DsEg7MJfr6IEJ5jMow0USQjpYPpwigmNhLEWFRX0jj3I0vgnPsUrUv0kLhST4rd
 PvUTA01Ick/U+G61+6WbE7U04OIaWxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-fuwg5IwbMICxtOWiCOvkUA-1; Sat, 15 Aug 2020 02:59:31 -0400
X-MC-Unique: fuwg5IwbMICxtOWiCOvkUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E8DF801AAE;
 Sat, 15 Aug 2020 06:59:29 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F07DD5D9CA;
 Sat, 15 Aug 2020 06:59:23 +0000 (UTC)
Date: Sat, 15 Aug 2020 08:59:20 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peng Liang <liangpeng10@huawei.com>
Subject: Re: [RFC 5/9] target/arm: introduce CPU feature dependency mechanism
Message-ID: <20200815065920.de22a6g4jvfawyuc@kamzik.brq.redhat.com>
References: <20200813102657.2588720-1-liangpeng10@huawei.com>
 <20200813102657.2588720-6-liangpeng10@huawei.com>
 <20200813124821.psavdkhddg4duar6@kamzik.brq.redhat.com>
 <1e7160d1-96e7-7581-cdc9-cb4ad44aca72@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1e7160d1-96e7-7581-cdc9-cb4ad44aca72@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 17:09:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 mst@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou 00584000 <xiexiangyou@huawei.com>, qemu-arm@nongnu.org,
 pbonzini@redhat.com, zhukeqian 00502301 <zhukeqian1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 15, 2020 at 10:19:27AM +0800, Peng Liang wrote:
> On 8/13/2020 8:48 PM, Andrew Jones wrote:
> > On Thu, Aug 13, 2020 at 06:26:53PM +0800, Peng Liang wrote:
> >> Some CPU features are dependent on other CPU features.  For example,
> >> ID_AA64PFR0_EL1.FP field and ID_AA64PFR0_EL1.AdvSIMD must have the same
> >> value, which means FP and ADVSIMD are dependent on each other, FPHP and
> >> ADVSIMDHP are dependent on each other.
> >>
> >> This commit introduces a mechanism for CPU feature dependency in
> >> AArch64.  We build a directed graph from the CPU feature dependency
> >> relationship, each edge from->to means the `to` CPU feature is dependent
> >> on the `from` CPU feature.  And we will automatically enable/disable CPU
> >> feature according to the directed graph.
> >>
> >> For example, a, b, and c CPU features are in relationship a->b->c, which
> >> means c is dependent on b and b is dependent on a.  If c is enabled by
> >> user, then a and b is enabled automatically.  And if a is disabled by
> >> user, then b and c is disabled automatically.
> > 
> > And what if a is mutually exclusive with b? I.e. a and b can both be
> > disabled, but only a or b may be enabled.
> > 
> > Thanks,
> > drew
> > 
> > .
> > 
> 
> Currently, a and b will be both enabled or disabled.  For example, a and b are
> in relationship a->b, which means b is dependent on a.  If -cpu host,a=off,b=on,
> then both a and b are enabled.  If -cpu host,b=on,a=off, then both a and b are
> disabled.  Maybe we should report an error to user in this scenario?
>

Right. There are more relationships between features than "depends on",
such as "only if not" or "only if value is". The last one points out
that just setting the minimum feature value may not be sufficient to
control all the features. Also, there could be relationships involving
more than two features, such as 'a iff b and c', or 'a iff b and !c'.

We really have to take each feature of each ID register one at a time to
make sure we handle them appropriately. Exposing them all like this
without any checks just pushes all the pain onto the user to figure
everything out, and if there's not even errors generated, then how will
the user know when they got something wrong until their guest breaks
in some mysterious way?

Thanks,
drew


