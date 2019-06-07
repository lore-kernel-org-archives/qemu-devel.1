Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96174C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D96E206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D96E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZETO-0004zR-Ls
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55853)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hZER9-0003WH-K3
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hZEF8-0001Cj-3l
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:45:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hZEF7-00017x-QY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:45:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D2B722386E;
 Fri,  7 Jun 2019 12:45:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54B4C83863;
 Fri,  7 Jun 2019 12:45:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C5EBE11386A0; Fri,  7 Jun 2019 14:45:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <87woihi1wl.fsf@dusky.pond.sub.org>
 <564efcce-64ac-0a39-8899-f6b6d6d7984e@redhat.com>
 <871s05g5ub.fsf@dusky.pond.sub.org>
 <3a4ce577-0744-6ff7-9f7e-9239fe5d4333@redhat.com>
Date: Fri, 07 Jun 2019 14:45:01 +0200
In-Reply-To: <3a4ce577-0744-6ff7-9f7e-9239fe5d4333@redhat.com> (Paolo
 Bonzini's message of "Fri, 7 Jun 2019 13:35:09 +0200")
Message-ID: <875zphd0oi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 07 Jun 2019 12:45:06 +0000 (UTC)
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
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/06/19 10:25, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 23/05/19 18:14, Markus Armbruster wrote:
>>>> * Machine core (Eduardo, Marcel)
>>>>
>>>>   query-machines, query-current-machine, 
>>>>
>>>>   ~60 lines.  Hardly worthwhile from a "let's shrink misc.json" point of
>>>>   view.  Might be worthwhile from a "let's make get_maintainers.pl
>>>>   work".
>>>>
>>>> * CPUs (Paolo, Richard)
>>>>
>>>>   query-cpus, query-cpus-fast
>>>>
>>>>   ~300 lines.  The commands are implemented in cpus.c, which MAINTAINERS
>>>>   covers both under "Main loop" and under "Guest CPU cores (TCG) /
>>>>   Overall".  Neither feels right to me for these QMP commands.
>>>>
>>>> * NUMA (Eduardo)
>>>>
>>>>   query-memdev, set-numa-node
>>>>
>>>>   ~200 lines.
>>>
>>> I would move all three of these and add a new entry to MAINTAINERS.
>> 
>> Double-checking: do you propose to move all three to a single new QAPI
>> module, with a new MAINTAINERS entry covering just the new QAPI module?
>> If yes, care to propose a QAPI module file name, a MAINTAINERS head
>> line, and maintainers?
>
> Just one, qapi/machine.json, with a MAINTAINERS patch based on this one.

Okay, I'd like to take care of that.

>  We could probably create a new directory hw/machine too.

I'd prefer to leave that to you, because making you explain to me what
exactly you want moved is likely more work for both of us :)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index a96829ea83..9bf3e6b670 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1274,8 +1274,12 @@ S: Supported
>  F: hw/core/machine.c
>  F: hw/core/null-machine.c
>  F: hw/cpu/cluster.c
> +F: numa.c
> +F: qom/cpu.c
>  F: include/hw/boards.h
>  F: include/hw/cpu/cluster.h
> +F: include/qom/cpu.h
> +F: include/sysemu/numa.h
>  T: git https://github.com/ehabkost/qemu.git machine-next
>
>  Xtensa Machines
> @@ -1839,12 +1843,6 @@ M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
>  F: scripts/coverity-model.c
>
> -CPU
> -L: qemu-devel@nongnu.org
> -S: Supported
> -F: qom/cpu.c
> -F: include/qom/cpu.h
> -
>  Device Tree
>  M: Alistair Francis <alistair.francis@wdc.com>
>  R: David Gibson <david@gibson.dropbear.id.au>
> @@ -1947,13 +1945,6 @@ W: http://info.iet.unipi.it/~luigi/netmap/
>  S: Maintained
>  F: net/netmap.c
>
> -NUMA
> -M: Eduardo Habkost <ehabkost@redhat.com>
> -S: Maintained
> -F: numa.c
> -F: include/sysemu/numa.h
> -T: git https://github.com/ehabkost/qemu.git machine-next
> -
>  Host Memory Backends
>  M: Eduardo Habkost <ehabkost@redhat.com>
>  M: Igor Mammedov <imammedo@redhat.com>

This merges MAINTAINERS section "NUMA" into "Machine core" (with section
"CPU" thrown in for good measure).  Moving their QAPI schema bits from
misc.json to new machine.json then makes sense.  Good.

The part I'm unsure about is item "CPUs" from my list, i.e. query-cpus
and query-cpus-fast.  If I move these QAPI schema bits to machine.json
as well, then the QAPI schema for query-cpus, query-cpus-fast is covered
by section "Machine core", while the C code (in cpus.c) is covered by
"Main loop" and "Guest CPU cores (TCG) / Overall".  I hate that.  Would
you like me to try moving the C code out of cpus.c so it can be covered
by "Machine core"?

[...]

