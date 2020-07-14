Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3ADC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3032145D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDbtbg29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3032145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFpP-0005Nx-HD
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvFom-0004yd-Vr
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:57:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49136
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvFok-0005U4-3C
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594713452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJuzeen2J9oH/kM1HYcS+neMEfRiIn7Nm//XepiXBok=;
 b=eDbtbg29zkHzLfDmQBnZUMWUBbS5FwhquzlwdPjCjeEQV9X3TjBmzEIUtW486q+9raXhyA
 e4I+JU8D94GVN2lFGj4D943vcLYpqrE4B989qIsAu1LTNAfJlaY139D0M7W3p4UZQMKuYO
 iCfWrVA5Dyp+hHl1nfFx/rSDTfSGDoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-wHJTVjilOAG5K0JLFC16dQ-1; Tue, 14 Jul 2020 03:57:31 -0400
X-MC-Unique: wHJTVjilOAG5K0JLFC16dQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89D4D800400
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 07:57:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54F835C1B2;
 Tue, 14 Jul 2020 07:57:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D8394105A45D; Tue, 14 Jul 2020 09:57:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] tests: improve performance of device-introspect-test
References: <20200709112857.3760116-1-berrange@redhat.com>
 <87mu47gms3.fsf@dusky.pond.sub.org>
 <20200713084759.GA4044570@redhat.com>
Date: Tue, 14 Jul 2020 09:57:28 +0200
In-Reply-To: <20200713084759.GA4044570@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Mon, 13 Jul 2020 09:47:59 +0100")
Message-ID: <87h7ua8r6f.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Jul 10, 2020 at 10:03:56PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > Total execution time with "-m slow" and x86_64 QEMU, drops from 3
>> > minutes 15 seconds, down to 54 seconds.
>> >
>> > Individual tests drop from 17-20 seconds, down to 3-4 seconds.
>>=20
>> Nice!
>>=20
>> A few observations on this test (impatient readers may skip to
>> "Conclusions"):
>
> snip
>
>> * The number of known device types varies between targets from 33
>>   (tricore) to several hundreds (x86_64+i386: 421, ppc 593, arm 667,
>>   aarch64 680, ppc64 689).  Median is 215, sum is 7485.
>
> snip
>
>> * The test matrix is *expensive*.  Testing even a simple QMP query is
>>   when you do it a quarter million times.  ARM is the greediest pig by
>>   far (170k introspections, almost two thirds of the total!), followed
>>   by ppc (36k), x86 (12k) and mips (11k).  Ideas on trimming excess are
>>   welcome.  I'm not even sure anymore this should be a qtest.
>
> We have 70 arm machines, 667 devices. IIUC we are roughly testing every
> device against everything machine. 46,690 tests.
>
> Most of the time devices are going to behave identically regardless of
> which machine type is used. The trouble is some machines are different
> enough that they can genuinely trigger different behaviour. It isn't
> possible to slim the (machine, device) expansion down programatically
> while still exercising the interesting combinations unless we get alot
> more advanced.
>
> eg if a have a PCI device, we only need test it in one PCI based machine,
> and only need test it on one non-PCI based machine.

The trouble is .instance_init() can do anything, and can therefore
interact badly with anything.

Example: m2sxxx_soc_initfn() of device type "msf2-soc" messes with
nd_table[0].  That's wrong.  The test doesn't catch it with machine type
"none", where nd_table[0] is blank.  It does catch it with machine type
"ast2600-evb", because aspeed_machine_init() puts something incompatible
into nd_table[0], which makes m2sxxx_soc_initfn() crash.

"msf2-soc" is not a PCI device, but if it was, then the two machines
(with and without PCI) picked for testing PCI devices may well both
leave nd_table[0] blank, and therefore not catch the bug.

Some instances of "device code does stuff it should not" could be
prevented by making interfaces inaccessible there.  We'd have to
identify device code first.  The hw/BASE-ARCH/ contain both boards and
devices.  Possibly even in the same .c.

> I would be interesting to actually get some CPU profiling data for
> this test to see if it points out anything interesting about where the
> time is being spent. Even if we don't reduce the complexity, reducing
> a time factor will potentially greatly help.=20

Hunch: when we want to test device instantiation and finalization for a
million (give or take) combinations of board x device, testing them one
by one with QMP might be a bad idea.


