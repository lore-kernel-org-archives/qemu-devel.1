Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A585C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 05:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650F42084D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 05:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uacgkyc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650F42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQlTw-00037b-Hu
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 01:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQlT2-0002Fz-58
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 01:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQlSy-0003BT-34
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 01:29:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56781
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQlSw-00034p-MC
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 01:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587446940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lh6uMsNnpCI8EjsvqOLxi8U+g15XPBB8ybsLw2pVu4A=;
 b=Uacgkyc+9jDSwdWx/iztz2PG1Z5ymtkHyJ+YDP8I0wWdUH33UjLi/r37dgCCpw5evZUGtk
 o2S7DN0BcSbF/XfMlNlrgYrHkonCCPBV05tYbtIzKwTCrrCAfylPQYigjNWA2RgAGKGJJm
 bn/YhyUXSlRjBvmi8puvTRrqb8lCffg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-G3BtEZa_N1ePhiCorRm2uQ-1; Tue, 21 Apr 2020 01:28:58 -0400
X-MC-Unique: G3BtEZa_N1ePhiCorRm2uQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39AC9801E53;
 Tue, 21 Apr 2020 05:28:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05A2D19C58;
 Tue, 21 Apr 2020 05:28:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7773211358BC; Tue, 21 Apr 2020 07:28:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 2/4] smbus: Fix spd_data_generate() error API violation
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004201613040.29873@zero.eik.bme.hu>
Date: Tue, 21 Apr 2020 07:28:55 +0200
In-Reply-To: <alpine.BSF.2.22.395.2004201613040.29873@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Mon, 20 Apr 2020 16:20:37 +0200 (CEST)")
Message-ID: <87h7xd5rvs.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 23:40:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Mon, 20 Apr 2020, Markus Armbruster wrote:
>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>> pointer to a variable containing NULL.  Passing an argument of the
>> latter kind twice without clearing it in between is wrong: if the
>> first call sets an error, it no longer points to NULL for the second
>> call.
>>
>> spd_data_generate() can pass @errp to error_setg() more than once when
>> it adjusts both memory size and type.  Harmless, because no caller
>> passes anything that needs adjusting.  Until the previous commit,
>> sam460ex passed types that needed adjusting, but not sizes.
>>
>> spd_data_generate()'s contract is rather awkward:
>>
>>    If everything's fine, return non-null and don't set an error.
>>
>>    Else, if memory size or type need adjusting, return non-null and
>>    set an error describing the adjustment.
>>
>>    Else, return null and set an error reporting why no data can be
>>    generated.
>>
>> Its callers treat the error as a warning even when null is returned.
>> They don't create the "smbus-eeprom" device then.  Suspicious.
>
> The idea here again is to make it work if there's a way it could work
> rather than throw back an error to user and bail. This is for user
> convenience in the likely case the user knows nothing about the board
> or SPD data restrictions.

We're in perfect agreement that the user of QEMU should not need to know
anything about memory type and number of banks.  QEMU should pick a
sensible configuration for any memory size it supports.

>                           You seem to disagree with this

Here's what I actually disagree with:

1. QEMU warning the user about its choice of memory type, but only
sometimes.  Why warn?  There is nothing wrong, and there is nothing the
user can do to avoid the condition that triggers the warning.

2. QEMU changing the user's memory size.  Yes, I understand that's an
attempt to be helpful, but I prefer my tools not to second-guess my
intent.

>                                                          and want to
> remove all such logic from everywhere. Despite the title of this patch
> it's not just fixing error API usage but removing those fix ups.

I'm removing unused code that is also broken.  If you want to keep it,
please fix it, and provide a user and/or a unit test.  Without that, it
is a trap for future callers.

> If Error cannot be used for this could you change error_setg to
> warn_report and keep the fix ups untouched? That fixes the problem
> with error (although leaves no chance to board code to handle
> errors). Maybe fix Error to be usable for what it's intended for
> rather than removing cases it can't handle.

Error is designed for errors, not warnings.

A function either succeeds (no error) or fails (one error).

It can be pressed into service for warnings (you did, although in a
buggy way).  You still can return at most one Error per Error **
parameter.  If you need multiple warnings, use multiple parameters
(ugh!).  You could also try to squash multiple warnings into one the
hints mechanism.

I'd advise against combining warn_report() and Error ** in one function.
A function should either take care of talking to the user completely, or
leave it to its caller completely.


