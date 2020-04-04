Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F1EC2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 05:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D0A206CC
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 05:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdd84qoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D0A206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKbnm-0003OV-Cv
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 01:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jKbmv-0002dq-4z
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 01:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jKbmt-0002HU-Az
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 01:56:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jKbmt-0002H8-4q
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 01:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585979770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbu+yhQJvJC1lvCLLfqKnvLXIL2FpNXjo1kKksMp9Os=;
 b=hdd84qoifPYM1xCKcn36sk8ByCy+8qPVROmF1A+AmUFKlKIlRnn8N/0/neecGzi1KDkxf0
 EU5kL7jEaCVY062tAvY4QFk4tMpn5HmBnuaFk3kXNEUF9eVK3yKOxDYuk8GXM5X8WatiRU
 M2znzJJz7HJVTQVQZBnUs+FOp51eeBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-WHxLg8XsMc6whceK-6e6Bg-1; Sat, 04 Apr 2020 01:56:06 -0400
X-MC-Unique: WHxLg8XsMc6whceK-6e6Bg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7EC113FB;
 Sat,  4 Apr 2020 05:56:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A20610002A8;
 Sat,  4 Apr 2020 05:55:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C4841138610; Sat,  4 Apr 2020 07:55:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 00/12] hw: Add missing error-propagation code
References: <20200325191830.16553-1-f4bug@amsat.org>
 <87r1x8vet0.fsf@dusky.pond.sub.org>
 <dbee4e3d-afba-827d-4950-2ac9b99419ab@redhat.com>
Date: Sat, 04 Apr 2020 07:55:54 +0200
In-Reply-To: <dbee4e3d-afba-827d-4950-2ac9b99419ab@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 3 Apr 2020 19:53:01
 +0200")
Message-ID: <87mu7r23rp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Markus, Peter.
>
> On 3/31/20 3:23 PM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>
>>> This series is inspired of Peter fix:
>>> "hw/arm/xlnx-zynqmp.c: fix some error-handling code"
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg691636.html
>>>
>>> Add a cocci script to fix the other places.
>>>
>>> Based-on: <20200324134947.15384-1-peter.maydell@linaro.org>
>>
>> I skimmed the code patches [PATCH 02-12/12], and they look like bug
>> fixes.  Other reviewers raised a few issues.
>>
>> I also skimmed the Coccinelle script [PATCH 01].  Peter pointed out a
>> few things it apparently missed (e.g. in review of PATCH 06+11).
>> Moreover, the bug pattern applies beyond object_property_set() &
>> friends.  Perhaps the script can be generalized.  No reason to hold
>> fixes.  We may want to add suitable notes to the scipt, though.
>>
>> Can you address the reviews in a v2, so we can get the fixes into -rc1,
>> due today?
>
> Status on this series (sorry I didn't update earlier).
>
> I addressed Peter's comments, improved/simplified/documented the cocci
> script (which I split in smaller ones).
>
> Peter suggested other functions can be checked too, not only the
> "^object_property_set_.*" matches. Indeed, more patches added. Some
> are big.
>
> Another suggestion is replace in init() 'NULL' Error* final argument
> by &error_abort. This can be another series on top.
> However I noticed we can reduce the error_propagate() generated calls
> in many places, when both init()/realize() exist and the property set
> is not dependent of parent operation, by moving these calls from
> realize() to init(). Another cocci script. But to make sense it has to
> be run previous the "add missing error_propagate" one.
>
> While writing the cocci patches, I had 3 different Coccinelle failures.
> Failures not due to a spatch bug, but timeout because C source hard to
> process. Indeed the C source code was dubious, could get some
> simplification rewrite. Then spatch could transform them. More patches
> in the middle.
>
> Now I'm at 47 patches, the reviewed patches at the end of the series.
> Too much for RC2. Since I don't think these are critical bugs, but
> improvements, are you OK to postpone this series to 5.1?

Punting bug fixes to a later release is always kind of sad, but getting
that many patches reviewed properly in time for -rc2 feels hopeless, and
the bugs old and unthreatending on first glance.

> If you think a patch deserves to be in 5.0, point me at it and I can
> send it ASAP with comments addressed. Else I'll post my series as
> -for-5.1 soon.

I'm okay with punting the whole series to 5.1.

We have quite some Error work pending for 5.1.  Beware of conflicts.

In particular, I now plan to make object_property_set() & friends return
a useful value.  This should make your patches a bit smaller.


