Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1ABC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 07:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6642520B80
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 07:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5kz9Ls+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6642520B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jp570-0003X1-Ka
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 03:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp55Z-00020j-R1
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 03:17:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55513
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp55W-0006A1-IF
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 03:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593242240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRWp2Vn+oyODVQG5NfV2VoJoFC8DHo7o5x1Pv8vlRgE=;
 b=W5kz9Ls+JjT+fvKHOnpvOT27jo5z1j6i8z76T1OvGKlzkSLR1Jr8Iy59Zg/u0N7W/uRSrO
 eT4oX2Mtx7k9OePh9WRDhb8/ZQlOQSZZ5Z/nMW+g3nc8U4ELHmouJyuq0bEhvBsgSvDsh6
 qyYtRYQlNwPesKRrIC24osy0+HuMSC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-li8-FPUENsibrnHvn0dowA-1; Sat, 27 Jun 2020 03:17:13 -0400
X-MC-Unique: li8-FPUENsibrnHvn0dowA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AAD71005512;
 Sat, 27 Jun 2020 07:17:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 638E82B4A6;
 Sat, 27 Jun 2020 07:17:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4753211384A6; Sat, 27 Jun 2020 09:17:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v2 2/4] smbus: Fix spd_data_generate() error API violation
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004221622140.19234@zero.eik.bme.hu>
 <0af0e0f0-8127-da83-d9d2-89a3fe28f778@redhat.com>
 <alpine.BSF.2.22.395.2004222053070.22480@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006261315070.94870@zero.eik.bme.hu>
Date: Sat, 27 Jun 2020 09:17:09 +0200
In-Reply-To: <alpine.BSF.2.22.395.2006261315070.94870@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Fri, 26 Jun 2020 13:30:29 +0200 (CEST)")
Message-ID: <87k0ztrn9m.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 02:53:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Wed, 22 Apr 2020, BALATON Zoltan wrote:
>> On Wed, 22 Apr 2020, Philippe Mathieu-Daud=C3=83=C2=A9 wrote:
>>> On 4/22/20 4:27 PM, BALATON Zoltan wrote:
>>>> On Wed, 22 Apr 2020, Markus Armbruster wrote:
>>>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>>>> pointer to a variable containing NULL.=C3=82=C2=A0 Passing an argumen=
t of the
>>>>> latter kind twice without clearing it in between is wrong: if the
>>>>> first call sets an error, it no longer points to NULL for the second
>>>>> call.
>>>>>
>>>>> spd_data_generate() can pass @errp to error_setg() more than once whe=
n
>>>>> it adjusts both memory size and type.=C3=82=C2=A0 Harmless, because n=
o caller
>>>>> passes anything that needs adjusting.=C3=82=C2=A0 Until the previous =
commit,
>>>>> sam460ex passed types that needed adjusting, but not sizes.
>>>>>
>>>>> spd_data_generate()'s contract is rather awkward:
>>>>>
>>>>> =C3=82=C2=A0=C3=82=C2=A0 If everything's fine, return non-null and do=
n't set an error.
>>>>>
>>>>> =C3=82=C2=A0=C3=82=C2=A0 Else, if memory size or type need adjusting,=
 return non-null and
>>>>> =C3=82=C2=A0=C3=82=C2=A0 set an error describing the adjustment.
>>>>>
>>>>> =C3=82=C2=A0=C3=82=C2=A0 Else, return null and set an error reporting=
 why no data can be
>>>>> =C3=82=C2=A0=C3=82=C2=A0 generated.
>>>>>
>>>>> Its callers treat the error as a warning even when null is returned.
>>>>> They don't create the "smbus-eeprom" device then.=C3=82=C2=A0 Suspici=
ous.
>>>>>
>>>>> Since the previous commit, only "everything's fine" can actually
>>>>> happen.=C3=82=C2=A0 Drop the unused code and simplify the callers.=C3=
=82=C2=A0 This gets rid
>>>>> of the error API violation.
>>>>
>>>> This leaves board code no chance to recover from values given by
>>>> user that won't fit without duplicating checks that this function
>>>> does. Also this will abort without giving meaningful errors if an
>>>> invalid value does get through and result in a crash which is not
>>>> used friendly. So I don't like this but if others think this is
>>>> acceptable maybe at least unit test should be adjusted to make
>>>> sure aborts cannot be triggered by user for values that are not
>>>> usually tested during development.
>>>
>>> Agreed. Do you have an example (or more) to better show Markus this
>>> code use? So we can add tests.
>>
>> After Markus's patches probably nothing uses it any more but this
>> comes with the result that previously giving some random value such
>> as -m 100 did produce a working sam460ex machine after some warnings
>> but now it just thows back some errors to the user which may or may
>> not be helpful to them.
>>
>>> Personally I'd use a script to generate a dumb static array of all
>>> possible sizes...
>>
>> Maybe testing with the biggest valid value such as -m 2048 (that's
>> commonly used probably) and an invalid value such as -m 100 might be
>> enough. Testing all possible values might take too long and would
>> not test what happens with invalid values. Ideally those invalud
>> values should also work like before a0258e4afa but should at least
>> give a meaningful warning so the user can fix the command line
>> without too much head scratching. Actually that commit was from Igor
>> not from Marcus so sorry for attributing that to Marcus too, I
>> remembered wrong.
>>
>> By the way you could argue that on real machine you cannot plug
>> certain combinations of memory modules so it's enough to model that
>> but I think QEMU does not have to be that strict and also support
>> configs that cannot happen on real hadware but would work. This
>> might be useful for example if you have some ammount of memory to
>> set aside for a VM on a host but that's not a size that exists in
>> memory modules on real hardware. This also works on pc machine in
>> qemu-system-i386 for example: it accepts -m 100 and does its best to
>> create a machine with such unrealistic size. The sam460ex did the
>> same (within SoC's limits) and before a0258e4afa -m 100 was fixed up
>> to 96 MB which is now not possible due to change in QEMU internal
>> APIs. This probably isn't important enough to worth the extra effort
>> to support but would have been nice to preserve.
>
> Besides the above here's another use case of the fix ups that I wanted
> to keep:
>
> https://patchew.org/QEMU/cover.1592315226.git.balaton@eik.bme.hu/b5f45985=
29a77f15f554c593e9be2d0ff9e5fab3.1592315226.git.balaton@eik.bme.hu/
>
> This board normally uses OpenBIOS which gets RAM size from fw_cfg and
> so works with whatever amount of RAM (also Linux booted with -kernel
> probably does not care) so any -memory value is valid. However some
> may want to also use original firmware ROM for compatibility which
> detects RAM reading SPD eeproms (the i2c emulation needed for that is
> not working yet but once that's fixed this will be the case). I want
> to add smbus_eeproms for this but do not want to just abort for cases
> where -memory given by user cannot be covered with SPD data. Instead a
> warning and covering as much RAM as possible should be enough (the ROM
> will detect less RAM than given with -m=20
> but that's OK and better than just bailing out without a message
> tripping an assert). But I don't want to replicate in board code the
> calculation and checks the spd_data_generate() function does anyway
> (that would just puzzle reviewers for every use of this functions).
>
> Previously this was possible with my original spd_data_generate()
> implementation. What's your suggestion to bring that functionality
> back without breaking Error API? Maybe adding new parameters to tell
> the spd_data_generate() which fixups are allowed?

Quick reply without having thought through the issues at all: I'm not
opposed to you doing work to enable additional or even arbitrary memory
sizes where these actually work.  I'm first and foremost opposed to me
wasting time on "improving" code that is not used for anything.  That's
why I dumbed down spd_data_generate().

Secondly, I'm opposed to QEMU "correcting" user configuration.  I want
QEMU do exactly what it's told, and fail with a clear error message when
that is not possible.  The error message may include hints for the user
on how to correct the configuration.


