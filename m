Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC0AC4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566022145D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZXW7Sq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566022145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFds-0001CU-4d
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNFaO-0006zu-RW
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNFaL-0006z4-3W
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:22:28 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601385741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFywnijHgI+gQGq00g7eoRIpE0OQobk4j1dg1gBDWVM=;
 b=FZXW7Sq/2UdxRMEmNqGcJKyZn1WTNxxQbL8dl5mFKKTrjh6jxBRSAhme8FIDoaX77ZyX2a
 xVlKW7PHDFWsKYGp5VBuEwDA876Q0vcVhgY2A4Bc++7X953kL+qXDxf6m54PvbqT8Bns0c
 lMa5IVjIoy8UD60sNvW4TyPn5UIjVjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-YqxD6iJHMG2JguaeIs9-ZA-1; Tue, 29 Sep 2020 09:22:18 -0400
X-MC-Unique: YqxD6iJHMG2JguaeIs9-ZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 696C0801AB7;
 Tue, 29 Sep 2020 13:22:17 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DB2C10013D0;
 Tue, 29 Sep 2020 13:22:16 +0000 (UTC)
Date: Tue, 29 Sep 2020 09:22:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 2/2] core/register: Specify instance_size in the TypeInfo
Message-ID: <20200929132216.GI3717385@habkost.net>
References: <20200927134609.2358960-1-alistair.francis@wdc.com>
 <20200927134609.2358960-3-alistair.francis@wdc.com>
 <CAFEAcA9Rduz5RB4oUD_wR41_oEfdRSbB8O=99pb+AjXM8gLG6A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Rduz5RB4oUD_wR41_oEfdRSbB8O=99pb+AjXM8gLG6A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 01:55:35PM +0100, Peter Maydell wrote:
> On Sun, 27 Sep 2020 at 15:00, Alistair Francis <alistair.francis@wdc.com> wrote:
> >
> > Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > Message-Id: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.alistair.francis@wdc.com>
> > ---
> > @@ -269,13 +258,18 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
> >          int index = rae[i].addr / data_size;
> >          RegisterInfo *r = &ri[index];
> >
> > -        *r = (RegisterInfo) {
> > -            .data = data + data_size * index,
> > -            .data_size = data_size,
> > -            .access = &rae[i],
> > -            .opaque = owner,
> > -        };
> > -        register_init(r);
> > +        if (data + data_size * index == 0 || !&rae[i]) {
> > +            continue;
> 
> Coverity thinks (CID 1432800) that this is dead code, because
> "data + data_size * index" can never be NULL[*]. What was this
> intending to test for ? (maybe data == NULL? Missing dereference
> operator ?)

I believe the original check in the old register_init() function
were just to make the function more flexible by allowing NULL
arguments, but it was always unnecessary.  We have 4 callers of
register_init_block*() and neither rae or data are NULL on those
calls.

> 
> [*] The C spec is quite strict about what valid pointer arithmetic
> is; in particular adding to a NULL pointer is undefined behaviour,
> and pointer arithmetic that overflows and wraps around is
> undefined behaviour, so there's no way to get a 0 result from
> "ptr + offset" without the expression being UB.
> 
> thanks
> -- PMM
> 

-- 
Eduardo


