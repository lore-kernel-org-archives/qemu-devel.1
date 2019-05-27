Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB9C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632162070D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632162070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41583 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAZd-0006VX-K4
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:01:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVAYc-0005sO-Qo
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVAYa-0006uT-Uy
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:00:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVAYZ-0006t6-7U
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:00:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EBBB33BCD;
	Mon, 27 May 2019 08:00:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 957095D968;
	Mon, 27 May 2019 08:00:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 28C101138648; Mon, 27 May 2019 10:00:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <87woihi1wl.fsf@dusky.pond.sub.org>
	<20190524185344.GJ10764@habkost.net>
Date: Mon, 27 May 2019 10:00:21 +0200
In-Reply-To: <20190524185344.GJ10764@habkost.net> (Eduardo Habkost's message
	of "Fri, 24 May 2019 15:53:44 -0300")
Message-ID: <87r28k1g4q.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 27 May 2019 08:00:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] qapi/misc.json is too big,
 let's bite off a few chunks
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Thu, May 23, 2019 at 06:14:18PM +0200, Markus Armbruster wrote:
>> It's nice when QAPI schema modules clearly belong to a single subsystem
>> in addition to "QAPI Schema".  misc.json doesn't, and it's grown fat:
>> 3000+ lines.  Let's move out some stuff.  Here are a few candidates:
>>=20
>> * Dump (Marc-Andr=C3=A9)
>>=20
>>   dump-guest-memory, query-dump, DUMP_COMPLETED,
>>   query-dump-guest-memory-capability
>>=20
>>   ~200 lines.
>>=20
>> * Machine core (Eduardo, Marcel)
>>=20
>>   query-machines, query-current-machine,=20
>>=20
>>   ~60 lines.  Hardly worthwhile from a "let's shrink misc.json" point of
>>   view.  Might be worthwhile from a "let's make get_maintainers.pl
>>   work".
>>=20
>> * CPUs (Paolo, Richard)
>>=20
>>   query-cpus, query-cpus-fast
>>=20
>>   ~300 lines.  The commands are implemented in cpus.c, which MAINTAINERS
>>   covers both under "Main loop" and under "Guest CPU cores (TCG) /
>>   Overall".  Neither feels right to me for these QMP commands.
>
> Should it include query-cpu-* (currently on target.json),
> and query-hotpluggable-cpus?

Interesting question.  We might need both cpu.json and cpu-target.json,
to keep target-independent and target-dependent separated.

>> * NUMA (Eduardo)
>>=20
>>   query-memdev, set-numa-node
>>=20
>>   ~200 lines.
>>=20
>> Opinions?
>>=20
>> Additional candidates?
>
> QOM: qom-list, qom-get, qom-set, qom-list-properties, object-add
> object-del.

Also qom-list-types.

~230 lines.

As long as we don't have an active QOM maintainer[*], the benefit is
low.


[*] We need one.  I'm not volunteering.

