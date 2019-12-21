Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36507C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 07:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26FC206EF
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 07:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/2U5HCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26FC206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiZf1-0005cd-63
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 02:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iiZeJ-00059M-Nw
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 02:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iiZeE-0002q4-7r
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 02:58:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iiZeD-0002hd-NV
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 02:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576915080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xzzv/1rlNpRMxCF2tBg1KM6TV5D2ieQV+Th/dzZJDA8=;
 b=D/2U5HCHPby96PHsmudKCR1qBw32Eh4Y6LDexLg1RnjLGcxnJTQhqeOiX7XrB09MbsmxLo
 ix4TLJvEm6YkKDsttC3eWww9dvS/Xratz65C6NRPLzt+Dfr3Kp0tFuDTdtWr0q0uOIIisr
 ji1NoxG/VnwGBf5OhQNwBauK/mEhce8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-8RJ311dSNQCT_JJ3mvCiPQ-1; Sat, 21 Dec 2019 02:57:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5106107ACC9
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2019 07:57:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7596F26FD8;
 Sat, 21 Dec 2019 07:57:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DFD2D11385C9; Sat, 21 Dec 2019 08:57:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: Can we retire Python 2 now?
References: <8736dfdkph.fsf@dusky.pond.sub.org> <877e2qakqt.fsf@trasno.org>
Date: Sat, 21 Dec 2019 08:57:55 +0100
In-Reply-To: <877e2qakqt.fsf@trasno.org> (Juan Quintela's message of "Fri, 20
 Dec 2019 19:56:58 +0100")
Message-ID: <87zhfmp0u4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8RJ311dSNQCT_JJ3mvCiPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Python 2 EOL is only a few days away[*].  We made configure bitch about
>> it in commit e5abf59eae "Deprecate Python 2 support", 2019-07-01.  Any
>> objections to retiring it now, i.e. in 5.0?
>>
>> Cc'ing everyone who appears to be maintaining something that looks like
>> a Python script.
>>
>> [*] https://pythonclock.org/
>
> I am pretty sure that I am not a python maintaainer at all.

You are:

    $ scripts/get_maintainer.pl -f scripts/vmstate-static-checker.py
    Juan Quintela <quintela@redhat.com> (maintainer:Migration)
    "Dr. David Alan Gilbert" <dgilbert@redhat.com> (maintainer:Migration)
    Eduardo Habkost <ehabkost@redhat.com> (odd fixer:Python scripts)
    Cleber Rosa <crosa@redhat.com> (odd fixer:Python scripts)
    qemu-devel@nongnu.org (open list:All patches CC here)

Resistance is futile!

[...]


