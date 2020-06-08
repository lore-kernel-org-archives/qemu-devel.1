Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17319C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 06:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D562076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 06:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ch8Ov9QR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D562076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiAtr-0003mG-5W
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 02:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiAsc-0002aZ-Vy
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 02:03:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57172
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiAsb-0002ai-Ku
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 02:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591596207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KBig24TU0IcJx4ZQYRu08SgRrgmT+HyPYB0hyi1gdsg=;
 b=Ch8Ov9QRr0wOo5DOCyjWYsI/E9uO8J571R3Inr96IjoojTp80uwI0zzOCa2wmydlv9Wn6N
 Cjd/oDz4dpTE9jQuFMIfXqa+eOYFnXIqZkoP7uMqbuVIlnx5jXpjDjAqUZfDHl3il56X9N
 B/nCILkcklWrnzNcZFpRFfeyhMHLgeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-B37kiFRTPTSoJ1yK5jlUiw-1; Mon, 08 Jun 2020 02:03:26 -0400
X-MC-Unique: B37kiFRTPTSoJ1yK5jlUiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF934107ACCA;
 Mon,  8 Jun 2020 06:03:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F016F5C1D6;
 Mon,  8 Jun 2020 06:03:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 82A1011386A6; Mon,  8 Jun 2020 08:03:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] or1k: Fix compilation hiccup
References: <20200526185132.1652355-1-eblake@redhat.com>
 <m1d06msod9.fsf@redhat.com>
 <CAFEAcA9Huery0AeUFsLVrcK4bUGibg1f-m8gMuMiJgnr+Hj7CA@mail.gmail.com>
 <87eeqx9alv.fsf@dusky.pond.sub.org>
Date: Mon, 08 Jun 2020 08:03:20 +0200
In-Reply-To: <87eeqx9alv.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Tue, 02 Jun 2020 09:43:08 +0200")
Message-ID: <873676ksbb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Jia Liu <proljc@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Fri, 29 May 2020 at 17:23, Christophe de Dinechin
>> <dinechin@redhat.com> wrote:
>>> On 2020-05-26 at 20:51 CEST, Eric Blake wrote...
>>> > diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
>>> > index d08ce6181199..95011a8015b4 100644
>>> > --- a/hw/openrisc/openrisc_sim.c
>>> > +++ b/hw/openrisc/openrisc_sim.c
>>> > @@ -129,7 +129,7 @@ static void openrisc_sim_init(MachineState *machine)
>>> >      const char *kernel_filename = machine->kernel_filename;
>>> >      OpenRISCCPU *cpu = NULL;
>>> >      MemoryRegion *ram;
>>> > -    qemu_irq *cpu_irqs[2];
>>> > +    qemu_irq *cpu_irqs[2] = {};
>>>
>>> Why is the value [2] correct here? The loop that initializes loops over
>>> machine->smp.cpus. Is it always less than 2 on this machine?
>>
>> Yes: openrisc_sim_machine_init() sets mc->max_cpus = 2.
>> My suggestion of adding an assert() is essentially telling the
>> compiler that indeed smp_cpus must always be in the range [1,2],
>> which we can tell but it can't.
>
> Do we have a proper patch for this on the list?

Apparently not.

Philippe did try Peter's suggestion, found it works, but then posted it
only to Launchpad.  Philippe, please post to the list, so we can finally
get this fixed.


