Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6DEC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9286220767
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frxqOs8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9286220767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRuuo-0004nk-Ll
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 05:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRutn-0003uj-GT
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRutl-0004Sl-Jy
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:45:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRutk-0004Jj-Nw
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587721527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=govfui9Xk5toF0eWPOyRdkUyeS4dUF9ZNTvHX+BmzIQ=;
 b=frxqOs8pycSEYK1YZnF7aiTB9x2ibSIOg0SEjB7GApWRqFR4/gUVr3UobyKrV6Czqmr6oB
 6vEic+UJtyViLBroHboEWUtv9d+IH0FNQzVrb7DrLbQiHBCpIH2rb+2B/GV8Znmw2U4y2M
 Uhr28/TqtmA61Vvl+kxkCV/4V1Z1LLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-y8p_dEq7NuCYPdun5j2KQw-1; Fri, 24 Apr 2020 05:45:22 -0400
X-MC-Unique: y8p_dEq7NuCYPdun5j2KQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38CB38730A1;
 Fri, 24 Apr 2020 09:45:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 864AB5D9D7;
 Fri, 24 Apr 2020 09:45:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D58D311358BC; Fri, 24 Apr 2020 11:45:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 2/4] smbus: Fix spd_data_generate() error API violation
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004201613040.29873@zero.eik.bme.hu>
 <87h7xd5rvs.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2004221502090.19234@zero.eik.bme.hu>
Date: Fri, 24 Apr 2020 11:45:18 +0200
In-Reply-To: <alpine.BSF.2.22.395.2004221502090.19234@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Wed, 22 Apr 2020 15:43:38 +0200 (CEST)")
Message-ID: <87r1wdnro1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Tue, 21 Apr 2020, Markus Armbruster wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>> On Mon, 20 Apr 2020, Markus Armbruster wrote:
>>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>>> pointer to a variable containing NULL.  Passing an argument of the
>>>> latter kind twice without clearing it in between is wrong: if the
>>>> first call sets an error, it no longer points to NULL for the second
>>>> call.
>>>>
>>>> spd_data_generate() can pass @errp to error_setg() more than once when
>>>> it adjusts both memory size and type.  Harmless, because no caller
>>>> passes anything that needs adjusting.  Until the previous commit,
>>>> sam460ex passed types that needed adjusting, but not sizes.
>>>>
>>>> spd_data_generate()'s contract is rather awkward:
>>>>
>>>>    If everything's fine, return non-null and don't set an error.
>>>>
>>>>    Else, if memory size or type need adjusting, return non-null and
>>>>    set an error describing the adjustment.
>>>>
>>>>    Else, return null and set an error reporting why no data can be
>>>>    generated.
>>>>
>>>> Its callers treat the error as a warning even when null is returned.
>>>> They don't create the "smbus-eeprom" device then.  Suspicious.
>>>
>>> The idea here again is to make it work if there's a way it could work
>>> rather than throw back an error to user and bail. This is for user
>>> convenience in the likely case the user knows nothing about the board
>>> or SPD data restrictions.
>>
>> We're in perfect agreement that the user of QEMU should not need to know
>> anything about memory type and number of banks.  QEMU should pick a
>> sensible configuration for any memory size it supports.
>
> I though it could be useful to warn the users when QEMU had to fix up
> some values to notify them that what they get may not be what they
> expect and can then know why.

*If* QEMU "fixed up" the user's configuration, then QEMU should indeed
warn the user.

But it doesn't fix up anything here.  This broken code is unused.

>                               If the message really annoys you you can
> remove it but I think it can be useful. I just think your real problem
> with it is that Error can't support it so it's easier to remove the
> warning than fixing Error or use warn_report instead.

It's indeed easier to remove broken unused code than to try fixing it.
YAGNI.

>>>                           You seem to disagree with this
>>
>> Here's what I actually disagree with:
>>
>> 1. QEMU warning the user about its choice of memory type, but only
>> sometimes.  Why warn?  There is nothing wrong, and there is nothing the
>> user can do to avoid the condition that triggers the warning.
>
> The memory size that triggers the warning is specified by the user so
> the user can do someting about it.

There is no way to trigger the warning.  If we dropped PATCH 1 instead
of fixing it as I did in v2, then the only way to trigger the warning is
-M sam460ex -m 64 or -m 32, and the only way to avoid it is to don't do
that.

Why would a user care whether he gets DDR or DDR2 memory?

>> 2. QEMU changing the user's memory size.  Yes, I understand that's an
>> attempt to be helpful, but I prefer my tools not to second-guess my
>> intent.
>
> I agree with that and also hate Windows's habit of trying to be more
> intelligent than the user and prefer the Unix way however the average
> users of QEMU (from my perpective, who wants to run Amiga like OSes
> typically on Windows and for the most part not knowing what they are
> doing) are already intimidated by the messy QEMU command line
> interface and will specify random values and complain or go away if it
> does not work so making their life a little easier is not
> useless. These users (or any CLI users) are apparently not relevant
> from your point of view but they do exist and I think should be
> supported better.

This theoretical.  Remember, we're talking about unused code.  Proof:

    $ ppc-softmmu/qemu-system-ppc -M sam460ex -m 4096
    qemu-system-ppc: Max 1 banks of 2048 ,1024 ,512 ,256 ,128 ,64 ,32 MB DI=
MM/bank supported
    qemu-system-ppc: Possible valid RAM size: 2048

I figure commit a0258e4afa "ppc/{ppc440_bamboo, sam460ex}: drop RAM size
fixup" removed the only uses.  If you disagree with it, take it up with
Igor, please.

>>>                                                          and want to
>>> remove all such logic from everywhere. Despite the title of this patch
>>> it's not just fixing error API usage but removing those fix ups.
>>
>> I'm removing unused code that is also broken.  If you want to keep it,
>> please fix it, and provide a user and/or a unit test.  Without that, it
>> is a trap for future callers.
>
> What was broken in this patch? Isn't freeing the previous warning when

My commit message explains:

     The Error ** argument must be NULL, &error_abort, &error_fatal, or a
     pointer to a variable containing NULL.  Passing an argument of the
     latter kind twice without clearing it in between is wrong: if the
     first call sets an error, it no longer points to NULL for the second
     call.

     spd_data_generate() can pass @errp to error_setg() more than once when
     it adjusts both memory size and type.  Harmless, because no caller
     passes anything that needs adjusting.  Until the previous commit,
     sam460ex passed types that needed adjusting, but not sizes.

Now have a look at the code I delete:

    if (size < 4) {
        error_setg(errp, "SDRAM size is too small");
        return NULL;
    }
    sz_log2 =3D 31 - clz32(size);
    size =3D 1U << sz_log2;
    if (ram_size > size * MiB) {
--->    error_setg(errp, "SDRAM size 0x"RAM_ADDR_FMT" is not a power of 2, =
"
                   "truncating to %u MB", ram_size, size);
    }
    if (sz_log2 < min_log2) {
--->    error_setg(errp,
                   "Memory size is too small for SDRAM type, adjusting type=
");
        if (size >=3D 32) {
            type =3D DDR;
            min_log2 =3D 5;
            max_log2 =3D 12;
        } else {
            type =3D SDR;
            min_log2 =3D 2;
            max_log2 =3D 9;
        }
    }
    [...]
    if (size > (1ULL << sz_log2) * nbanks) {
--->    error_setg(errp, "Memory size is too big for SDRAM, truncating");
    }

If more than one of the conditions guarding these error_setg() is true,
and @errp is neither null, &error_abort, nor &error_fatal, then it'll
point to an Error * that is not null for the non-first error_setg()
call.  This will trip the assertion in error_setv().

> adding a new one or combining them as you say below (although I don't
> really get what you mean) would fix it without removing fix ups? It's
> only unused now because in previous patches you've removed all usages:
> first broke memory fixup because of some internal QEMU API did not
> support fixing up memory size so instead of fixing that API removed
> what did not fit, then now removing type fix ups because it's not
> fitting Error API.
>
> Originally it did work well and produced usable values for whatever
> number the user specified and it was convenient for users. (Especially
> the sam460ex is a problematic case because of SoC and firmware limits
> that the user should not need to know about.)

I don't doubt it worked in your testing.

It's still wrong.

>>> If Error cannot be used for this could you change error_setg to
>>> warn_report and keep the fix ups untouched? That fixes the problem
>>> with error (although leaves no chance to board code to handle
>>> errors). Maybe fix Error to be usable for what it's intended for
>>> rather than removing cases it can't handle.
>>
>> Error is designed for errors, not warnings.
>>
>> A function either succeeds (no error) or fails (one error).
>>
>> It can be pressed into service for warnings (you did, although in a
>> buggy way).  You still can return at most one Error per Error **
>> parameter.  If you need multiple warnings, use multiple parameters
>> (ugh!).  You could also try to squash multiple warnings into one the
>> hints mechanism.
>>
>> I'd advise against combining warn_report() and Error ** in one function.
>> A function should either take care of talking to the user completely, or
>> leave it to its caller completely.
>
> I've tried to use error so the board code can decide what's an error
> and what's a warning but if this cannot be done with this QEMU
> facility I don't know a better way than using warn_report for
> warnings.

Is there any board that genuinely wants to decide what's an error and
what's a warning?

Here's spd_data_generate() contract again:

        If everything's fine, return non-null and don't set an error.

        Else, if memory size or type need adjusting, return non-null and
        set an error describing the adjustment.

        Else, return null and set an error reporting why no data can be
        generated.

It has a grand total of two users.  Both treat the second case as
warning, and the third as error.

Until you have a user that wants to handle things differently, you're
overcomplicating things.

YAGNI!


