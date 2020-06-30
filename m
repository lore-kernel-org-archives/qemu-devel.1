Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC771C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01CC204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01CC204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCZK-0001ts-WB
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jqCYV-0000xD-PI; Tue, 30 Jun 2020 05:27:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:19319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jqCYS-0006ie-4o; Tue, 30 Jun 2020 05:27:55 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DFBA2748DCC;
 Tue, 30 Jun 2020 11:27:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9B775748DCB; Tue, 30 Jun 2020 11:27:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 99869748DCA;
 Tue, 30 Jun 2020 11:27:48 +0200 (CEST)
Date: Tue, 30 Jun 2020 11:27:48 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 2/4] smbus: Fix spd_data_generate() error API violation
In-Reply-To: <20bcd5be-7664-4555-38bc-c8c68b603127@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2006301118100.65701@zero.eik.bme.hu>
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004221622140.19234@zero.eik.bme.hu>
 <0af0e0f0-8127-da83-d9d2-89a3fe28f778@redhat.com>
 <alpine.BSF.2.22.395.2004222053070.22480@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006261315070.94870@zero.eik.bme.hu>
 <87k0ztrn9m.fsf@dusky.pond.sub.org>
 <731e8765-4886-3bfe-b877-06078d0e977d@amsat.org>
 <alpine.BSF.2.22.395.2006292127520.63145@zero.eik.bme.hu>
 <20bcd5be-7664-4555-38bc-c8c68b603127@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1423549813-1593509268=:65701"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 05:27:49
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1423549813-1593509268=:65701
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 30 Jun 2020, Philippe Mathieu-Daudé wrote:
> On 6/29/20 11:31 PM, BALATON Zoltan wrote:
>>>>> Besides the above here's another use case of the fix ups that I wanted
>>>>> to keep:
>>>>>
>>>>> https://patchew.org/QEMU/cover.1592315226.git.balaton@eik.bme.hu/b5f4598529a77f15f554c593e9be2d0ff9e5fab3.1592315226.git.balaton@eik.bme.hu/
>>>>>
>>>>>
>>>>> This board normally uses OpenBIOS which gets RAM size from fw_cfg and
>>>>> so works with whatever amount of RAM (also Linux booted with -kernel
>>>>> probably does not care) so any -memory value is valid. However some
>>>>> may want to also use original firmware ROM for compatibility which
>>>>> detects RAM reading SPD eeproms (the i2c emulation needed for that is
>>>>> not working yet but once that's fixed this will be the case). I want
>>>>> to add smbus_eeproms for this but do not want to just abort for cases
>>>>> where -memory given by user cannot be covered with SPD data. Instead a
>>>>> warning and covering as much RAM as possible should be enough (the ROM
>>>>> will detect less RAM than given with -m
>>>>> but that's OK and better than just bailing out without a message
>>>>> tripping an assert). But I don't want to replicate in board code the
>>>>> calculation and checks the spd_data_generate() function does anyway
>>>>> (that would just puzzle reviewers for every use of this functions).
>>>>>
>>>>> Previously this was possible with my original spd_data_generate()
>>>>> implementation. What's your suggestion to bring that functionality
>>>>> back without breaking Error API? Maybe adding new parameters to tell
>>>>> the spd_data_generate() which fixups are allowed?
[...]
>> What I'd like is reverting f26740c61a57f and fix that some other way so
>> I don't have to duplicate size check in board code as can be seen in the
>> patchew link above but could just call spd_data_generate() to do its
>> job. This was discussed at the time that patch was in review you can
>> read it here:
>>
>> http://patchwork.ozlabs.org/project/qemu-devel/patch/20200420132826.8879-3-armbru@redhat.com/
>>
>>
>> My points were not really considered then, now that I have another use
>> case maybe it could be revisited and fixed. What I want is to be able to
>> call spd_data_generate() from board code with whatever sizÃ?Â© (the
>> board does not need to know about SPD limits and so cannot pre-check the
>> size) and the function should return the largest possible size SPD and
>> some indication if the size was not used completely. If Error cannot be
>> used for this, return the message or error some other way but let the
>> board code decide if it wants to abort or it can use the smaller SPD. Do
>> not assert in the helper function. Maybe the DIMM type fix up can be
>> dropped and only keep the size fix up so then we don't need to use error
>> twice, the board could call the function again if a different type is
>> also acceptable, since only sam460ex would need this I can do that there
>> for type fixup and call spd_data_generate() again with DDR2 if first one
>> with DDR could not fit all ram. But at least the asserts should be
>> dropped for this and the size check brought back. Then adding SPD to
>> mac_oldworld could also be done by calling spd_data_generate() instead
>> of duplicating the checks this function does anyway. This board has
>> three slots so if user says -m 1400 it would call spd_data_generate()
>> with 1400 first, get back 512 SPD that it adds to first slot then calls
>> spd_data_generate() again with 888, gets 512 again that it adds to 2nd
>> slot and calls spd_data_generate() for last slot with 376 which would
>> give 256 and 120 remaining that it may warn the user about but still
>> continue because the SPD data is only used by a ROM from real hardware
>> (that may be used for compatibility with some software) but the default
>> OpenBIOS disregards SPD data and would still use 1400 so it's not an
>> error to abort on. Simply if using a firmare ROM then only 1280 MB of
>> the 1400 will be available due to its limitations but that's not a
>> reason to force users to change their command line. Printing a warning
>> is enough to hint they may use different value but aborting without an
>> error message on an assert which is the current situation is not really
>> a user friendly way.
>
> I just noticed we have a MachineClass::fixup_ram_size() handler. There
> is only one implementation (on s390x) which does a bit the opposite:
> If the user asks for -m 1400, it will pad to a valid physical size,
> so in your example to 1472 MiB. Then the guest can use only 1400 if it
> is happy with it. 72 MiB are wasted, but this is still better than the
> 576 MiB wasted if we were using 2 GiB instead ;)
>
> See commit 5c30ef937f5:
>
> static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
> {
>    /* same logic as in sclp.c */
>    int increment_size = 20;
>    ram_addr_t newsz;
>
>    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
>        increment_size++;
>    }
>    newsz = sz >> increment_size << increment_size;
>
>    if (sz != newsz) {
>        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64
>                    "MB to match machine restrictions. "
>                    "Consider updating "
>                    "the guest definition.\n", (uint64_t) (sz / MiB),
>                    (uint64_t) (newsz / MiB));
>    }
>    return newsz;
> }

May have a look but first sight it might work for sam460ex but not for the 
mac_oldworld problem as described above without duplicating size checks in 
board code that I'd like to avoid and have it only in spd_data_generate 
for clarity and avoiding mistakes in duplicated copies. What the above 
could be good for is to avoid unused RAM area but that's not related to 
spd_data_generate and if it returns error some way or asserts.

I think the problem with fix up was that memdev will allocate mem region 
and it does not have a callback for the board to apply fixup or any other 
way to specify constraints so by the time board code runs the memory 
region is already allocated with the user specified size so all the board 
code can do is use that or abort (or not use and waste some amount). Maybe 
s390x wasn't converted to this or using it differently?

Regards,
BALATON Zoltan
--3866299591-1423549813-1593509268=:65701--

