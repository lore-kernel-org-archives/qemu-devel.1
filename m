Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552C8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849772076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iR5O4xDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849772076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYEjX-0000kG-E8
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 16:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYEie-0000B9-HX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYEiZ-0004gh-Lr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604004017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6bRj38EH0ubwHz86KmFO0u7JwqtRYe/rJmexAHDbBG8=;
 b=iR5O4xDui45sMbUx7d3yvZupRP5lo9lIsi/poZSuR0iobFcgQ6pdmG40ONAt2nbCEeDrVW
 +GGthAM+bCs7FxtRUY1i5nSc3JFlqnSsuN7Jt8XH7GRaWMHdm6MBg2MVQM3LZFrCmJOEdS
 4kr0yYtrXpTlppDwx7UoQCqc22sOtjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-QvVmOod5Pe2tZfZQjtiSCw-1; Thu, 29 Oct 2020 16:40:15 -0400
X-MC-Unique: QvVmOod5Pe2tZfZQjtiSCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F87C1019628;
 Thu, 29 Oct 2020 20:40:14 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAAD66EF68;
 Thu, 29 Oct 2020 20:40:13 +0000 (UTC)
Date: Thu, 29 Oct 2020 16:40:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] util/cutils: Silent Coverity array overrun warning in
 freq_to_str()
Message-ID: <20201029204013.GL5733@habkost.net>
References: <20201029185506.1241912-1-f4bug@amsat.org>
 <CAFEAcA-spK9H6SWkx9FLZ2tjMZUS5qz7bJ9rFBwxLVW_fxLRGg@mail.gmail.com>
 <CAFEAcA_YEfwbUXj8ypGqpR+b4-kCV==6brGiAxLsRfz88OGvfA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_YEfwbUXj8ypGqpR+b4-kCV==6brGiAxLsRfz88OGvfA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>, Luc Michel <luc@lmichel.fr>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 07:16:35PM +0000, Peter Maydell wrote:
> On Thu, 29 Oct 2020 at 19:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> > We should either consistently assume that idx can never
> > get to 7 (ie don't check it in the while loop condition
> > because that test can never return true) or we should
> > consistently guard against it happening (by switching the
> > while loop to "<=", or by handling the idx==ARRAY_SIZE(suffixes)
> > case specially.)
> 
> Oops; "switching to <=" isn't the right thing; you'd need to switch
> to "< ARRAY_SIZE(suffixes) - 1". Anyway I think we should
> do the other of the two options, not this one.

"< ARRAY_SIZE(suffixes) - 1" patch submitted at
https://lore.kernel.org/qemu-devel/20201029203850.434351-1-ehabkost@redhat.com/

-- 
Eduardo


