Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AFDC43445
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 06:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22C02075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 06:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpQWNRre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22C02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jus8C-0001JH-PC
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 02:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jus74-0000qj-Uw
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 02:38:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jus73-00017K-DR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 02:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594622332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WpG8jKDwfeCrTEDizT0DN8+zkkla36TOIQzMwyAnfmM=;
 b=JpQWNRre+dSTfSBvbCF4Xpc2wX4AcY2PFqplWKfGJeABbrGp9qzJovycGG2aYySuhugxOG
 1z19YS7JGdmdj9LeYLx4F7SCIGE+tjOWPMFqszuFO7Q1dLEwQEGMBfvbxV/4uVxVaE0wW8
 pcrL2jV65z19mWxafQCFFrj0lxgwRps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-CByJZUEHM7OlbFTh6jAJIQ-1; Mon, 13 Jul 2020 02:38:48 -0400
X-MC-Unique: CByJZUEHM7OlbFTh6jAJIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EFE281E9EA;
 Mon, 13 Jul 2020 06:38:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05AA85C66E;
 Mon, 13 Jul 2020 06:38:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2BD709AB2; Mon, 13 Jul 2020 08:38:46 +0200 (CEST)
Date: Mon, 13 Jul 2020 08:38:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/2] tests: fix "make check-qtest" for modular builds
Message-ID: <20200713063846.vfns7m4f4rt3p4zg@sirius.home.kraxel.org>
References: <20200710203652.9708-1-kraxel@redhat.com>
 <20200710203652.9708-2-kraxel@redhat.com>
 <6936f087-35b0-47f0-88f8-aed15582fd43@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6936f087-35b0-47f0-88f8-aed15582fd43@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 07:36:20AM +0200, Thomas Huth wrote:
> On 10/07/2020 22.36, Gerd Hoffmann wrote:
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  tests/qtest/Makefile.include | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> > index 98af2c2d9338..6a0276fd42dd 100644
> > --- a/tests/qtest/Makefile.include
> > +++ b/tests/qtest/Makefile.include
> > @@ -277,6 +277,7 @@ tests/qtest/tco-test$(EXESUF): tests/qtest/tco-test.o $(libqos-pc-obj-y)
> >  tests/qtest/virtio-ccw-test$(EXESUF): tests/qtest/virtio-ccw-test.o
> >  tests/qtest/display-vga-test$(EXESUF): tests/qtest/display-vga-test.o
> >  tests/qtest/qom-test$(EXESUF): tests/qtest/qom-test.o
> > +tests/qtest/modules-test$(EXESUF): tests/qtest/modules-test.o
> >  tests/qtest/test-hmp$(EXESUF): tests/qtest/test-hmp.o
> >  tests/qtest/machine-none-test$(EXESUF): tests/qtest/machine-none-test.o
> >  tests/qtest/device-plug-test$(EXESUF): tests/qtest/device-plug-test.o
> 
> What was the error that you run into here? ... some words in the commit
> message would be nice. Actually, I always wondered why we need a
> separate entry for each and every test here ... I'd rather expect that
> this is handled by a normal generic make rule instead?

With this line the build is done in two steps:
  gcc -o test.o test.c
  gcc -o test test.o -llib

Without this line the build is done in one step:
  gcc -o test test.c -llib

The later seems to not pick up all cflags needed, I got build errors
due to an include file not being found (out-of-tree build).

take care,
  Gerd


