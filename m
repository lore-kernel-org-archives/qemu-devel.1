Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815EFC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 11:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDBD20736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 11:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBPB3aBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDBD20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRwRo-0000J5-Eu
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 07:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRwQd-0007Vd-LU
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 07:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRwQd-0004VD-54
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 07:23:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRwQc-0004Ty-PK
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 07:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587727409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEUu1kgC6gqBeN9aDGUA6QUd2XEjSAcmpxBCzTARG1w=;
 b=aBPB3aBj1OkaKtfGO2nLeTEkjFfawdEQH/bm8eTUrj6bxRoQZ+IqAxHccqtAX2dzaqqkUZ
 4HuEBq3mPl/tFLU359kgpvZ7S/Y75cvtBSPNToYV5z0gZCm0eeqe2MjW6X6DJZpRXECxyL
 n3DUQCct3ip57FU0tMKVjBX+XbMPwnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-3SXDJXE8MnibyEAx7spuZQ-1; Fri, 24 Apr 2020 07:23:25 -0400
X-MC-Unique: 3SXDJXE8MnibyEAx7spuZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40914108BD0A;
 Fri, 24 Apr 2020 11:23:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A800A60CD0;
 Fri, 24 Apr 2020 11:23:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F0CC011358BC; Fri, 24 Apr 2020 13:23:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/4] smbus: Fix spd_data_generate() error API violation
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004201613040.29873@zero.eik.bme.hu>
 <87h7xd5rvs.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2004221502090.19234@zero.eik.bme.hu>
 <87r1wdnro1.fsf@dusky.pond.sub.org>
 <ea6a25ab-17e9-1560-d1c3-9479bcecef54@redhat.com>
Date: Fri, 24 Apr 2020 13:23:21 +0200
In-Reply-To: <ea6a25ab-17e9-1560-d1c3-9479bcecef54@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 24 Apr 2020 12:18:44
 +0200")
Message-ID: <87wo65ktzq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:54:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/24/20 11:45 AM, Markus Armbruster wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>> On Tue, 21 Apr 2020, Markus Armbruster wrote:
> [...]
>>>>
>>>> Here's what I actually disagree with:
>>>>
>>>> 1. QEMU warning the user about its choice of memory type, but only
>>>> sometimes.  Why warn?  There is nothing wrong, and there is nothing th=
e
>>>> user can do to avoid the condition that triggers the warning.
>>>
>>> The memory size that triggers the warning is specified by the user so
>>> the user can do someting about it.
>>
>> There is no way to trigger the warning.  If we dropped PATCH 1 instead
>> of fixing it as I did in v2, then the only way to trigger the warning is
>> -M sam460ex -m 64 or -m 32, and the only way to avoid it is to don't do
>> that.
>>
>> Why would a user care whether he gets DDR or DDR2 memory?
>
> To use a different firmware code path!

Let's see how that works out for users.

Assume machine foobar needs a non-default firmware for "small" memory
sizes, such as -m 64.

Alice doesn't know.  She starts QEMU like this:

    $ qemu-system-foo -M foobar -m 64

It hangs early in boot.  Not good.

Except the warning from spd_data_generate() rides to her rescue!

    qemu-system-foo: warning: Memory size is too small for SDRAM type, adju=
sting type

Since Alice is rather sharp, the warning makes her realize immediately
that she needs to use different firmware, like this:

    $ qemu-system-foo -M foobar -m 64 -bios roms/foobar/firmware-small.bin

Okay, I'm done telling my fairy tale.

If you want helpful, make it work out of the box: default to the
firmware that actually works, don't make users guess which one they
need.

But one more time: this is all theoretical.  We're talking about unused,
broken code.  If you want to keep it, please add users, and fix it up.


