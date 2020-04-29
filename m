Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E77C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B912072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfhRg8Va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B912072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfVD-00024A-TQ
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 01:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTfUW-0001BS-Bf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTfUV-0003TK-II
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:42:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51925
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTfUV-0003Sy-3Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588138957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZrl1aU6eeIb/hMHf7u+vXvuU1a7VdPoT7ESDsahC1g=;
 b=CfhRg8Va1spLYuoj7VqUFhciJl7q6LfcVdIUCI4MnnKSgQU5uai2v08PSHbePXe1cpXatS
 IZQIszfkDoTJZyyAtXQzo5KfchTtGKMyuT2Up2TM2TKedJgz+J6eDF1lfhpj0r+qEOGmyO
 35vVDbVEcoY6E8DfeD4HmHSD7VUloZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-riK09AsiPnWET4fvSf70sg-1; Wed, 29 Apr 2020 01:42:34 -0400
X-MC-Unique: riK09AsiPnWET4fvSf70sg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 324D91005510;
 Wed, 29 Apr 2020 05:42:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 910785D76B;
 Wed, 29 Apr 2020 05:42:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1943411358BC; Wed, 29 Apr 2020 07:42:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 2/4] smbus: Fix spd_data_generate() error API violation
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004201613040.29873@zero.eik.bme.hu>
 <87h7xd5rvs.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2004221502090.19234@zero.eik.bme.hu>
 <87r1wdnro1.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2004241539110.87423@zero.eik.bme.hu>
Date: Wed, 29 Apr 2020 07:42:30 +0200
In-Reply-To: <alpine.BSF.2.22.395.2004241539110.87423@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Fri, 24 Apr 2020 15:52:16 +0200 (CEST)")
Message-ID: <87ees6x2yh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
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

> On Fri, 24 Apr 2020, Markus Armbruster wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>> On Tue, 21 Apr 2020, Markus Armbruster wrote:
>>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>>> On Mon, 20 Apr 2020, Markus Armbruster wrote:
>>>>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>>>>> pointer to a variable containing NULL.  Passing an argument of the
>>>>>> latter kind twice without clearing it in between is wrong: if the
>>>>>> first call sets an error, it no longer points to NULL for the second
>>>>>> call.
>>>>>>
>>>>>> spd_data_generate() can pass @errp to error_setg() more than once wh=
en
>>>>>> it adjusts both memory size and type.  Harmless, because no caller
>>>>>> passes anything that needs adjusting.  Until the previous commit,
>>>>>> sam460ex passed types that needed adjusting, but not sizes.
>>>>>>
>>>>>> spd_data_generate()'s contract is rather awkward:
>>>>>>
>>>>>>    If everything's fine, return non-null and don't set an error.
>>>>>>
>>>>>>    Else, if memory size or type need adjusting, return non-null and
>>>>>>    set an error describing the adjustment.
>>>>>>
>>>>>>    Else, return null and set an error reporting why no data can be
>>>>>>    generated.
>>>>>>
>>>>>> Its callers treat the error as a warning even when null is returned.
>>>>>> They don't create the "smbus-eeprom" device then.  Suspicious.
>>>>>
>>>>> The idea here again is to make it work if there's a way it could work
>>>>> rather than throw back an error to user and bail. This is for user
>>>>> convenience in the likely case the user knows nothing about the board
>>>>> or SPD data restrictions.
>>>>
>>>> We're in perfect agreement that the user of QEMU should not need to kn=
ow
>>>> anything about memory type and number of banks.  QEMU should pick a
>>>> sensible configuration for any memory size it supports.
>>>
>>> I though it could be useful to warn the users when QEMU had to fix up
>>> some values to notify them that what they get may not be what they
>>> expect and can then know why.
>>
>> *If* QEMU "fixed up" the user's configuration, then QEMU should indeed
>> warn the user.
>>
>> But it doesn't fix up anything here.  This broken code is unused.
>>
>>>                               If the message really annoys you you can
>>> remove it but I think it can be useful. I just think your real problem
>>> with it is that Error can't support it so it's easier to remove the
>>> warning than fixing Error or use warn_report instead.
>>
>> It's indeed easier to remove broken unused code than to try fixing it.
>> YAGNI.
>>
>>>>>                           You seem to disagree with this
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
>>
>>>> 2. QEMU changing the user's memory size.  Yes, I understand that's an
>>>> attempt to be helpful, but I prefer my tools not to second-guess my
>>>> intent.
>>>
>>> I agree with that and also hate Windows's habit of trying to be more
>>> intelligent than the user and prefer the Unix way however the average
>>> users of QEMU (from my perpective, who wants to run Amiga like OSes
>>> typically on Windows and for the most part not knowing what they are
>>> doing) are already intimidated by the messy QEMU command line
>>> interface and will specify random values and complain or go away if it
>>> does not work so making their life a little easier is not
>>> useless. These users (or any CLI users) are apparently not relevant
>>> from your point of view but they do exist and I think should be
>>> supported better.
>>
>> This theoretical.  Remember, we're talking about unused code.  Proof:
>>
>>    $ ppc-softmmu/qemu-system-ppc -M sam460ex -m 4096
>>    qemu-system-ppc: Max 1 banks of 2048 ,1024 ,512 ,256 ,128 ,64 ,32 MB =
DIMM/bank supported
>>    qemu-system-ppc: Possible valid RAM size: 2048
>>
>> I figure commit a0258e4afa "ppc/{ppc440_bamboo, sam460ex}: drop RAM size
>> fixup" removed the only uses.  If you disagree with it, take it up with
>> Igor, please.
>
> I did raise similar complaints at that patch series and proposed
> several alternatives to preserve the previous functionality (sam460ex
> wasn't the only board that fixed up memory size for users) but since
> current APIs don't support that and adding this extra feature for just
> this machine wasn't a priority, my comments were accepted and ignored
> and I did not feel it would be fair to hold back the whole series for
> this.
>
> I think I've explained how it worked and how it should work in my
> opinion and hope this could be revived at some point when the QEMU CLI
> will be made more user friendly (if ever) but I'm not willing to fight
> for that now. Silence in this case does not mean agreement but I see
> no point arguing if you cannot be convinced.

I acknowledge your opinion.

CLI usability for humans matters.  We're not doing well there.

A big part of the usability problem is complexity.

"Correcting" the user's configuration makes the CLI *more* complex.
Even worse when done deep down in the bowels of board code, because that
can only lead to inconsistency between machines.

The error message for a memory size we can't support could perhaps be
more helpful.

Good defaults are important.  The default memory size for sam460ex looks
okay to me.

If this commit changed the CLI, I'd gladly document your opinion /
opposition in the commit message.  But it doesn't.  It merely deletes
unreachable code because it's buggy.

> Just one point I'd like to keep is that no matter how you fix it the
> board code should be the only one that decides if the error is
> recoverable or not so don't abort or assert from this helper but
> return error to board code and exit from there so it has a chnace to
> recover in the furure or add "magic function" to help users wihtout
> having to touch this helper again. When you're touching the helper it
> would be nice to also try to convert the remaining two machines with
> hard coded SPD data so the final function is truely covering all
> current users of the function.

I'm not going to add unreachable code in the hope it may someday be
needed, sorry.

Refactoring the helper when we actually *have* a need is much more
likely to result in a helper that satisfies them.


