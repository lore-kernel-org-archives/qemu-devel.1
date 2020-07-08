Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF12C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0DC20674
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAp0S1mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0DC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtHe0-0003AC-Kq
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtHaG-0006Gr-MF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:26:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50201
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtHaE-0001q2-VA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrW3ISu0KT6KfnFR7UAWObZg8Y6b4dfrBXbmannj/eU=;
 b=SAp0S1mW1CUbvbaCrF93kwo8xidgEvzBKME7vufod2mC8iPGUfRRCAxAmKG2hdq/2i/M7a
 H/PY/PU+S2w+TjRRVAWjBHTWJL+BvPn1TP0m/nwYLZgTBxm5t71A/ryboEk9LuNY5DXs2f
 tsFgfFx2KGB2OdA/PotdzRbjI36+lzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-JCA3oVQVOPi1V7yB-82Haw-1; Wed, 08 Jul 2020 11:25:43 -0400
X-MC-Unique: JCA3oVQVOPi1V7yB-82Haw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68ED7800401;
 Wed,  8 Jul 2020 15:25:42 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4123E1A8EC;
 Wed,  8 Jul 2020 15:25:41 +0000 (UTC)
Date: Wed, 8 Jul 2020 11:25:40 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] cpu: Add starts_halted() method
Message-ID: <20200708152540.GZ7276@habkost.net>
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net>
 <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 02:14:03PM +0100, Peter Maydell wrote:
> On Wed, 8 Jul 2020 at 12:12, David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Wed, Jul 08, 2020 at 10:38:29AM +0200, Philippe Mathieu-Daudé wrote:
> > > Class boolean field certainly sounds better, but I am not sure this
> > > is a property of the machine. Rather the arch? So move the field
> > > to CPUClass? Maybe not, let's discuss :)
> >
> > It is absolutely a property of the machine.  e.g. I don't think we
> > want this for powernv.  pseries is a bit of a special case since it is
> > explicitly a paravirt platform.  But even for emulated hardware, the
> > board can absolutely strap things so that cpus do or don't start
> > immediately.
> 
> It's a property of the individual CPU, I think. One common setup
> for Arm systems is that the primary CPU starts powered up but
> the secondaries all start powered down.

Both statements can be true.  It can be a property of the
individual CPU (although I'm not convinced it has to), but it
still needs to be controlled by the machine.

> 
> The original bug as described in the commit message sounds
> to me like something we should look to fix in the implementation
> of async_run_on_cpu() -- it shouldn't cause a CPU that's halfway
> through reset to do a KVM_RUN or otherwise run guest code,
> whether that CPU is going to start powered-up or powered-down.

What "halfway through reset" means, exactly?  Isn't halted==1
enough to indicate the CPU is in that state?

-- 
Eduardo


