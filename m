Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94543C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC7520B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC7520B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAD3-0006mA-AM
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 04:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56262)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hZABk-0006Lg-M6
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hZABj-0007IQ-JJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:25:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hZABj-0007DE-Dm
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:25:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9599EC1EB1E5;
 Fri,  7 Jun 2019 08:25:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C37C7C45F;
 Fri,  7 Jun 2019 08:25:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB18711386A0; Fri,  7 Jun 2019 10:25:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <87woihi1wl.fsf@dusky.pond.sub.org>
 <564efcce-64ac-0a39-8899-f6b6d6d7984e@redhat.com>
Date: Fri, 07 Jun 2019 10:25:16 +0200
In-Reply-To: <564efcce-64ac-0a39-8899-f6b6d6d7984e@redhat.com> (Paolo
 Bonzini's message of "Fri, 24 May 2019 20:31:17 +0200")
Message-ID: <871s05g5ub.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 07 Jun 2019 08:25:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] qapi/misc.json is too big,
 let's bite off a few chunks
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 23/05/19 18:14, Markus Armbruster wrote:
>> * Machine core (Eduardo, Marcel)
>> 
>>   query-machines, query-current-machine, 
>> 
>>   ~60 lines.  Hardly worthwhile from a "let's shrink misc.json" point of
>>   view.  Might be worthwhile from a "let's make get_maintainers.pl
>>   work".
>> 
>> * CPUs (Paolo, Richard)
>> 
>>   query-cpus, query-cpus-fast
>> 
>>   ~300 lines.  The commands are implemented in cpus.c, which MAINTAINERS
>>   covers both under "Main loop" and under "Guest CPU cores (TCG) /
>>   Overall".  Neither feels right to me for these QMP commands.
>> 
>> * NUMA (Eduardo)
>> 
>>   query-memdev, set-numa-node
>> 
>>   ~200 lines.
>
> I would move all three of these and add a new entry to MAINTAINERS.

Double-checking: do you propose to move all three to a single new QAPI
module, with a new MAINTAINERS entry covering just the new QAPI module?
If yes, care to propose a QAPI module file name, a MAINTAINERS head
line, and maintainers?

Or do you propose to create three QAPI modules machine.json, cpus.json,
numa.json, with machine.json filed in MAINTAINERS under "Machine core",
numa.json under "NUMA", and cpus.json under a new entry?

