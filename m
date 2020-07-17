Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301EAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E5D2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3NGJLho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E5D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwT9o-0000NA-98
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 12:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jwT8y-0007wu-B8
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:23:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57444
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jwT8u-0002Dt-Qw
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595003003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1dfrZEZskB06LrLySbQ4gjoCsbmFGNExS4vekrUiptM=;
 b=K3NGJLhovibXfQN8B+KqdMZ+qphKwPUnyQ66EByuyCuHJxGqwCvxLyf0rQeAKfJzDmBh0P
 sidsschePlhymcwMiAfgoEccctJg/Qsaac7FDkHP2Ai89n/5Hl/RUrdvlN4+Fp+5Umoypf
 JGLhIGjOPViCi8Q5ODQCKnaohWUTTHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-3O38PBKrNEul-zYmr2D-cA-1; Fri, 17 Jul 2020 12:23:22 -0400
X-MC-Unique: 3O38PBKrNEul-zYmr2D-cA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AE381800D42;
 Fri, 17 Jul 2020 16:23:20 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8BAC7BD47;
 Fri, 17 Jul 2020 16:23:19 +0000 (UTC)
Date: Fri, 17 Jul 2020 10:23:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 3/9] vfio: add quirk device write method
Message-ID: <20200717102319.77d5b529@x1.home>
In-Reply-To: <CAFEAcA-_8=edW0_uu5UcRnG-pNjkE7GvHyti=og0+vpYAHpwRA@mail.gmail.com>
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-4-ppandit@redhat.com>
 <CAFEAcA-1EhD=0vU1r=48HhFPpovns2M5DBgTu7g2074kueaEuw@mail.gmail.com>
 <20200717095352.45845d8a@x1.home>
 <CAFEAcA-_8=edW0_uu5UcRnG-pNjkE7GvHyti=og0+vpYAHpwRA@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 P J P <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 16:57:40 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 17 Jul 2020 at 16:54, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Thu, 16 Jul 2020 18:46:33 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> > > Alex (Williamson) -- as the vfio maintainer, do you have a view
> > > on whether we should be logging write accesses to port 0x3c3
> > > here as guest-errors or unimplemented-QEMU-functionality?
> > >
> > > Guest-error seems plausible to me, anyway.  
> >
> > I believe the intention was that writes would be dropped, so if this
> > generates logging that is going to cause users to file bugs, that would
> > be undesirable.  Thanks,  
> 
> It will only log if the user explicitly turns on "log things the
> guest does which are bugs in it, like writing to read-only
> registers" (with the '-d guest_errors' option).

IIRC, this quirk is based on observation more so than an actual spec,
so whether a log of such an event is interpreted as a guest error or an
emulation error might be up for debate.  Aside from that nit, and lack
of bandwidth to research how hardware handles writes,

Acked-by: Alex Williamson <alex.williamson@redhat.com>

Thanks,
Alex


