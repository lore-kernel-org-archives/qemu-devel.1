Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501B2C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 05:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5322084D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 05:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjFXhwRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5322084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQlTq-00032i-7H
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 01:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQlT0-0002ET-41
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 01:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQlSo-0002uU-Bl
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 01:29:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQlSn-0002lB-FJ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 01:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587446931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjYUw3j7qop4L+02wRj4r/XE/VcN2svRNDZs78UA96I=;
 b=MjFXhwRcs61P4kGyeN3mTX+DyQxLaPjbgm4QR/V9PFs2fXkX0PbSG4Ze3OsC+3w3IDDmlF
 atcCqKT7uUHMnUkd0/YU78XiOKKsYLRLew3DcYxFMMI2oQNUpa68WgfYwGNQzwFaEWL1/s
 wQfR3Q03g2OLtBk4vnnZ2zNOI77F8AY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-emP0jcHwNMqAnm2fj4ba9g-1; Tue, 21 Apr 2020 01:28:50 -0400
X-MC-Unique: emP0jcHwNMqAnm2fj4ba9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94483149C0;
 Tue, 21 Apr 2020 05:28:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8CC427A3A0;
 Tue, 21 Apr 2020 05:28:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6EA9C11358BC; Tue, 21 Apr 2020 07:28:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 1/4] sam460ex: Revert change to SPD memory type for <= 128
 MiB
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-2-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004201604130.29873@zero.eik.bme.hu>
Date: Tue, 21 Apr 2020 07:28:46 +0200
In-Reply-To: <alpine.BSF.2.22.395.2004201604130.29873@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Mon, 20 Apr 2020 16:12:46 +0200 (CEST)")
Message-ID: <87imht5rw1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
>> Requesting 32 or 64 MiB of RAM with the sam460ex machine type produces
>> a useless warning:
>>
>>    qemu-system-ppc: warning: Memory size is too small for SDRAM type, ad=
justing type
>
> Why is it useless? It lets user know there was a change so it could
> help debugging for example.

The memory type is chosen by QEMU, not the user.  Why should QEMU warn
the user when it chooses DDR, but not when it chooses DDR2?

>> This is because sam460ex_init() asks spd_data_generate() for DDR2,
>> which is impossible, so spd_data_generate() corrects it to DDR.
>
> This is correct and intended. The idea is that the board code should
> not need to know about SPD data, all knowledge about that should be in
> spd_data_genereate().

I challenge this idea.

The kind of RAM module a board accepts is a property of the board.
Modelling that in board code is sensible and easy.  Attempting to model
it in a one size fits all helper function is unlikely to work for all
boards.

Apparently some boards (including malta) need two banks, so your helper
increases the number of banks from one to two, but only when that's
possible without changing the type.

What if another board needs one bank?  Four?  Two even if that requires
changing the type?  You'll end up with a bunch of flags to drive the
helper's magic.  Not yet because the helper has a grand total of *two*
users, and much of its magic is used by neither, as demonstrated by
PATCH 2.

If you want magic, have a non-magic function that does exactly what it's
told, and a magic one to tell it what to do.  The non-magic one will be
truly reusable.  You can have any number of magic ones.  Boards with
sufficiently similar requirements can share a magic one.

>> The warning goes back to commit 08fd99179a "sam460ex: Clean up SPD
>> EEPROM creation".  Turns out that commit changed memory type and
>> number of banks to
>>
>>    RAM size    #banks  type    bank size
>>     128 MiB         1   DDR2     128 MiB
>>      64 MiB         2   DDR       32 MiB
>>      32 MiB         1   DDR       32 MiB
>>
>> from
>>
>>    RAM size    #banks  type    bank size
>>     128 MiB         2   SDR       64 MiB
>>      64 MiB         2   SDR       32 MiB
>>      32 MiB         2   SDR       16 MiB
>>
>> Reverting that change also gets rid of the warning.
>>
>> I doubt physical Sam460ex boards can take SDR or DDR modules, though.
>
> It can't but it can use both DDR and DDR2 (the board can't but the SoC
> can and the firmware is OK with that too). This is what the commit
> fixed, please don't break it.

When a commit fixes something, it should say so.  This one does not:

    commit 08fd99179a8c5d34c7065e2ad76c7f8b6afe239e
    Author: BALATON Zoltan <balaton@eik.bme.hu>
    Date:   Thu Jan 3 17:27:24 2019 +0100

        sam460ex: Clean up SPD EEPROM creation

        Get rid of code from MIPS Malta board used to create SPD EEPROM dat=
a
        (parts of which was not even needed for sam460ex) and use the gener=
ic
        spd_data_generate() function to simplify this.

        Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
        Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

This commit message certainly suggests it was a refactoring that did not
change SPD data at all.  Not the case, but you have to look at the patch
closely to see.  Water under the bridge, of course.

It misled me to assume the change was unintentional.

>                               The firmware may be confused if
> presented with different type of SDRAM than DDR or DDR2. Does it still
> boot and finds correct mem size after your change? (I think bdinfo
> U-Boot command tells what it detects.)

You're right: 08fd99179a8^ appears not to boot with -m 128 and lower.
08fd99179a8 was indeed a silent bug fix.

"make check" passes, though :)

I'll replace this patch by one that merely suppresses the warning.

Thanks!


