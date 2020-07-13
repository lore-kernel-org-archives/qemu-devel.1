Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9CDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E442065D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/stMGSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E442065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juu8q-000538-KU
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1juu8G-0004cz-3j
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:48:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25328
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1juu8E-0001HD-BJ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594630093;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9q8hfSo4mXqUoJ6qEV3kAmJEkcjrF04P+COcILsugU=;
 b=U/stMGSeKZagVvP4/Q72hoD1X8HmY5FUy3mzj37evMM/4sBzYFzpMLpXg3l9wL7U2DchqY
 I5nMh9BKmi59D6h5PMZpKtmQ/IosvikZUXnDwv9A88EnxipiZY0V4ojj4vFgysJgGnBX8H
 RK3VIUVSlb5955Pu4ostqq04/zHFUxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-5bEbt6VIMvuj_XWe7Fruxg-1; Mon, 13 Jul 2020 04:48:05 -0400
X-MC-Unique: 5bEbt6VIMvuj_XWe7Fruxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACDF2800685
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:48:04 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9F6B60BF3;
 Mon, 13 Jul 2020 08:48:02 +0000 (UTC)
Date: Mon, 13 Jul 2020 09:47:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] tests: improve performance of device-introspect-test
Message-ID: <20200713084759.GA4044570@redhat.com>
References: <20200709112857.3760116-1-berrange@redhat.com>
 <87mu47gms3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87mu47gms3.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 10:03:56PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Total execution time with "-m slow" and x86_64 QEMU, drops from 3
> > minutes 15 seconds, down to 54 seconds.
> >
> > Individual tests drop from 17-20 seconds, down to 3-4 seconds.
> 
> Nice!
> 
> A few observations on this test (impatient readers may skip to
> "Conclusions"):

snip

> * The number of known device types varies between targets from 33
>   (tricore) to several hundreds (x86_64+i386: 421, ppc 593, arm 667,
>   aarch64 680, ppc64 689).  Median is 215, sum is 7485.

snip

> * The test matrix is *expensive*.  Testing even a simple QMP query is
>   when you do it a quarter million times.  ARM is the greediest pig by
>   far (170k introspections, almost two thirds of the total!), followed
>   by ppc (36k), x86 (12k) and mips (11k).  Ideas on trimming excess are
>   welcome.  I'm not even sure anymore this should be a qtest.

We have 70 arm machines, 667 devices. IIUC we are roughly testing every
device against everything machine. 46,690 tests.

Most of the time devices are going to behave identically regardless of
which machine type is used. The trouble is some machines are different
enough that they can genuinely trigger different behaviour. It isn't
possible to slim the (machine, device) expansion down programatically
while still exercising the interesting combinations unless we get alot
more advanced.

eg if a have a PCI device, we only need test it in one PCI based machine,
and only need test it on one non-PCI based machine.

I would be interesting to actually get some CPU profiling data for
this test to see if it points out anything interesting about where the
time is being spent. Even if we don't reduce the complexity, reducing
a time factor will potentially greatly help. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


