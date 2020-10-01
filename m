Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA17C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580EA20759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPv6kCnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580EA20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1Dr-0006EZ-C1
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO14q-0003A6-Sr
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO14n-0007hr-4Y
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601568298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0LdREGamTfFkyAK/AKSpatlUwBvQx5+xzAfBjq7pmg=;
 b=EPv6kCnEB3ycCfuRODNsNKunYB9EKdqHg5iInuBlEGYY2IGx9JaXKl3zCgjMhy8olfKA2f
 Vz6XYqnDDl3/QFy8FIADdKnXl9N/EkGjsgXNOoBhR+5C/Xwy+ao1iAMi0yUGTBI5YC1ARi
 YrbEZ+ORp2w2eg3m2VHcONzMf258pzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-Yro1V5aUMtiR9rPajWQ_OA-1; Thu, 01 Oct 2020 12:04:55 -0400
X-MC-Unique: Yro1V5aUMtiR9rPajWQ_OA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6C2F9CC05;
 Thu,  1 Oct 2020 16:04:53 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6474660BF1;
 Thu,  1 Oct 2020 16:04:53 +0000 (UTC)
Date: Thu, 1 Oct 2020 12:04:52 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: [PULL 2/2] core/register: Specify instance_size in the TypeInfo
Message-ID: <20201001160452.GF3717385@habkost.net>
References: <20200927134609.2358960-1-alistair.francis@wdc.com>
 <20200927134609.2358960-3-alistair.francis@wdc.com>
 <CAFEAcA9Rduz5RB4oUD_wR41_oEfdRSbB8O=99pb+AjXM8gLG6A@mail.gmail.com>
 <20200929132216.GI3717385@habkost.net>
 <CAKmqyKMemWmj2we2uN0bYCFOyo3_dFhoBgeC4qRv7LFxj20ExA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMemWmj2we2uN0bYCFOyo3_dFhoBgeC4qRv7LFxj20ExA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 01, 2020 at 08:37:31AM -0700, Alistair Francis wrote:
> On Tue, Sep 29, 2020 at 6:22 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > On Tue, Sep 29, 2020 at 01:55:35PM +0100, Peter Maydell wrote:
> > > On Sun, 27 Sep 2020 at 15:00, Alistair Francis <alistair.francis@wdc.com> wrote:
> > > >
> > > > Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > > > Message-Id: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.alistair.francis@wdc.com>
> > > > ---
> > > > @@ -269,13 +258,18 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
> > > >          int index = rae[i].addr / data_size;
> > > >          RegisterInfo *r = &ri[index];
> > > >
> > > > -        *r = (RegisterInfo) {
> > > > -            .data = data + data_size * index,
> > > > -            .data_size = data_size,
> > > > -            .access = &rae[i],
> > > > -            .opaque = owner,
> > > > -        };
> > > > -        register_init(r);
> > > > +        if (data + data_size * index == 0 || !&rae[i]) {
> > > > +            continue;
> > >
> > > Coverity thinks (CID 1432800) that this is dead code, because
> > > "data + data_size * index" can never be NULL[*]. What was this
> > > intending to test for ? (maybe data == NULL? Missing dereference
> > > operator ?)
> >
> > I believe the original check in the old register_init() function
> > were just to make the function more flexible by allowing NULL
> > arguments, but it was always unnecessary.  We have 4 callers of
> > register_init_block*() and neither rae or data are NULL on those
> > calls.
> 
> In this case *data is an array, I guess the idea was to try and catch
> if somehow a point in the array was NULL?

I don't understand what you mean.  The area pointed by data
doesn't contain any pointers, just the register values.

> 
> I'll send a patch to remove the check.

Thanks!

-- 
Eduardo


