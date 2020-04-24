Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D10C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBCD20700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBCD20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRymN-0007sw-Tf
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 09:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRykp-00056G-KO
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRykn-0003y7-Ki
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:52:30 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:58932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jRykl-0003hT-K2; Fri, 24 Apr 2020 09:52:29 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 77013746340;
 Fri, 24 Apr 2020 15:52:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3B92D74633E; Fri, 24 Apr 2020 15:52:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 38F8874633D;
 Fri, 24 Apr 2020 15:52:16 +0200 (CEST)
Date: Fri, 24 Apr 2020 15:52:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/4] smbus: Fix spd_data_generate() error API violation
In-Reply-To: <87r1wdnro1.fsf@dusky.pond.sub.org>
Message-ID: <alpine.BSF.2.22.395.2004241539110.87423@zero.eik.bme.hu>
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004201613040.29873@zero.eik.bme.hu>
 <87h7xd5rvs.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2004221502090.19234@zero.eik.bme.hu>
 <87r1wdnro1.fsf@dusky.pond.sub.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 09:52:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 152.66.115.2
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

On Fri, 24 Apr 2020, Markus Armbruster wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> On Tue, 21 Apr 2020, Markus Armbruster wrote:
>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>> On Mon, 20 Apr 2020, Markus Armbruster wrote:
>>>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>>>> pointer to a variable containing NULL.  Passing an argument of the
>>>>> latter kind twice without clearing it in between is wrong: if the
>>>>> first call sets an error, it no longer points to NULL for the second
>>>>> call.
>>>>>
>>>>> spd_data_generate() can pass @errp to error_setg() more than once when
>>>>> it adjusts both memory size and type.  Harmless, because no caller
>>>>> passes anything that needs adjusting.  Until the previous commit,
>>>>> sam460ex passed types that needed adjusting, but not sizes.
>>>>>
>>>>> spd_data_generate()'s contract is rather awkward:
>>>>>
>>>>>    If everything's fine, return non-null and don't set an error.
>>>>>
>>>>>    Else, if memory size or type need adjusting, return non-null and
>>>>>    set an error describing the adjustment.
>>>>>
>>>>>    Else, return null and set an error reporting why no data can be
>>>>>    generated.
>>>>>
>>>>> Its callers treat the error as a warning even when null is returned.
>>>>> They don't create the "smbus-eeprom" device then.  Suspicious.
>>>>
>>>> The idea here again is to make it work if there's a way it could work
>>>> rather than throw back an error to user and bail. This is for user
>>>> convenience in the likely case the user knows nothing about the board
>>>> or SPD data restrictions.
>>>
>>> We're in perfect agreement that the user of QEMU should not need to know
>>> anything about memory type and number of banks.  QEMU should pick a
>>> sensible configuration for any memory size it supports.
>>
>> I though it could be useful to warn the users when QEMU had to fix up
>> some values to notify them that what they get may not be what they
>> expect and can then know why.
>
> *If* QEMU "fixed up" the user's configuration, then QEMU should indeed
> warn the user.
>
> But it doesn't fix up anything here.  This broken code is unused.
>
>>                               If the message really annoys you you can
>> remove it but I think it can be useful. I just think your real problem
>> with it is that Error can't support it so it's easier to remove the
>> warning than fixing Error or use warn_report instead.
>
> It's indeed easier to remove broken unused code than to try fixing it.
> YAGNI.
>
>>>>                           You seem to disagree with this
>>>
>>> Here's what I actually disagree with:
>>>
>>> 1. QEMU warning the user about its choice of memory type, but only
>>> sometimes.  Why warn?  There is nothing wrong, and there is nothing the
>>> user can do to avoid the condition that triggers the warning.
>>
>> The memory size that triggers the warning is specified by the user so
>> the user can do someting about it.
>
> There is no way to trigger the warning.  If we dropped PATCH 1 instead
> of fixing it as I did in v2, then the only way to trigger the warning is
> -M sam460ex -m 64 or -m 32, and the only way to avoid it is to don't do
> that.
>
> Why would a user care whether he gets DDR or DDR2 memory?
>
>>> 2. QEMU changing the user's memory size.  Yes, I understand that's an
>>> attempt to be helpful, but I prefer my tools not to second-guess my
>>> intent.
>>
>> I agree with that and also hate Windows's habit of trying to be more
>> intelligent than the user and prefer the Unix way however the average
>> users of QEMU (from my perpective, who wants to run Amiga like OSes
>> typically on Windows and for the most part not knowing what they are
>> doing) are already intimidated by the messy QEMU command line
>> interface and will specify random values and complain or go away if it
>> does not work so making their life a little easier is not
>> useless. These users (or any CLI users) are apparently not relevant
>> from your point of view but they do exist and I think should be
>> supported better.
>
> This theoretical.  Remember, we're talking about unused code.  Proof:
>
>    $ ppc-softmmu/qemu-system-ppc -M sam460ex -m 4096
>    qemu-system-ppc: Max 1 banks of 2048 ,1024 ,512 ,256 ,128 ,64 ,32 MB DIMM/bank supported
>    qemu-system-ppc: Possible valid RAM size: 2048
>
> I figure commit a0258e4afa "ppc/{ppc440_bamboo, sam460ex}: drop RAM size
> fixup" removed the only uses.  If you disagree with it, take it up with
> Igor, please.

I did raise similar complaints at that patch series and proposed several 
alternatives to preserve the previous functionality (sam460ex wasn't the 
only board that fixed up memory size for users) but since current APIs 
don't support that and adding this extra feature for just this machine 
wasn't a priority, my comments were accepted and ignored and I did not 
feel it would be fair to hold back the whole series for this.

I think I've explained how it worked and how it should work in my opinion 
and hope this could be revived at some point when the QEMU CLI will be 
made more user friendly (if ever) but I'm not willing to fight for that 
now. Silence in this case does not mean agreement but I see no point 
arguing if you cannot be convinced.

Just one point I'd like to keep is that no matter how you fix it the board 
code should be the only one that decides if the error is recoverable or 
not so don't abort or assert from this helper but return error to board 
code and exit from there so it has a chnace to recover in the furure or 
add "magic function" to help users wihtout having to touch this helper 
again. When you're touching the helper it would be nice to also try to 
convert the remaining two machines with hard coded SPD data so the final 
function is truely covering all current users of the function.

Regards,
BALATON Zoltan

