Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3735AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006B220772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M40dwKgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006B220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8e5-0005KL-83
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jh8c7-0002iz-Iu
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:26:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25833
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jh8c5-0002uE-W8
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591349169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kg3XEioT4HPDMkgX0CPkLGBlfefRuRKEAP9K82Www04=;
 b=M40dwKgflbOVLS5x5gt074Yb1D9u/LklgGevJq1Lb+BbLPHT8MPNLcKiH25SX9krDE8PWS
 pXCzn1rGEDQsiERZ/Mc1fF8kard2/4UEPc8W/WG/gX7xWz1EBoI+uV8eYxbdxaA1Y1CzdG
 A++G1LUBIGfWTd4GIqLJjSlXvRLa380=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-zyF8zY02PE-O1fXhwyzWQA-1; Fri, 05 Jun 2020 05:26:07 -0400
X-MC-Unique: zyF8zY02PE-O1fXhwyzWQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 654B9EC1A2;
 Fri,  5 Jun 2020 09:26:05 +0000 (UTC)
Received: from work-vm (ovpn-113-211.ams2.redhat.com [10.36.113.211])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C341E5C549;
 Fri,  5 Jun 2020 09:26:00 +0000 (UTC)
Date: Fri, 5 Jun 2020 10:25:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v3] migration/xbzrle: add encoding rate
Message-ID: <20200605092553.GC2897@work-vm>
References: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
 <CAFXwXrm4R5nxk6ruTJ2kP5dUnF7Qm3TfRRiKVAUDNA1uwYf65w@mail.gmail.com>
 <5ED86344.4020505@intel.com>
 <4b9cd244-0d96-d1c8-11ec-b61a6bc2bfaa@linaro.org>
 <20200604093828.GB2851@work-vm> <5ED8CC78.90006@intel.com>
 <26a232a7-8ec6-da2c-348f-41da899cdc9a@linaro.org>
 <5ED9A81F.6070008@intel.com>
MIME-Version: 1.0
In-Reply-To: <5ED9A81F.6070008@intel.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kevin.tian@intel.com, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, gloryxiao@tencent.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Wang (wei.w.wang@intel.com) wrote:
> On 06/05/2020 12:57 AM, Richard Henderson wrote:
> > On 6/4/20 3:27 AM, Wei Wang wrote:
> > > On 06/04/2020 05:38 PM, Dr. David Alan Gilbert wrote:
> > > > Hmm OK; I'll admit to not liking NaN/Inf in output.
> > > > 
> > > > Dave
> > > > 
> > > OK. To deal with the reported issue, how about using FLT_MAX (as opposed to
> > > UINT64_MAX or inf):
> > > xbzrle_counters.encoding_rate = FLT_MAX;
> > So you'd rather see 340282346638528859811704183484516925440.00 printed?
> > 
> > It's arbitrary and not correct in any mathematical sense.
> > 
> > If you *really* insist on not printing Inf (which may have some diagnostic
> > value), then 0 is just as arbitrary, and at least smaller in the output.
> 
> 0 works fine (though it logically means the lowest encoding rate).
> I slightly prefer the biggest number or inf, which naturally means it's very
> encoding friendly.
> Let's see if Dave has any thought about the choices :)

0 is fine for me.

Dave

> Best,
> Wei
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


