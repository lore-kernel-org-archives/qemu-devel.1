Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483AEC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13833205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="2U/sAm8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13833205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iblQh-0000sm-5j
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 08:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iblO1-00088f-45
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iblNz-0002Ci-RX
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:05:09 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:53804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iblNw-0002B4-DE; Mon, 02 Dec 2019 08:05:04 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 9D34D96EF2;
 Mon,  2 Dec 2019 13:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575291902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59jHss8An0NYZMESND1tXJ7A23ua1uMaUfpnpEIm3Lc=;
 b=2U/sAm8R++nNlTJEguc4NZCONBgfkiDK6JAsfwSupYjapVY1h/tEPVFCFkOrVe8ZTS5srj
 ohXsJoG1MDz/AHUzwebMb6sp7LRU4HMEIce4ZOy+ef5b8Pf0qaNSiQ69aCJcgsbP+1Mc5u
 E4V7BjXdxzj31vV2k+sUKjMcLJ/ttXk=
Subject: Re: [PATCH v5 12/13] hw/gpio/bcm2835_gpio: Isolate sdbus reparenting
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-13-damien.hedde@greensocs.com>
 <CAFEAcA-YiD6B1wMTrOvj5=QbYY3uuqdbJbSP57zg3S86nU=k-Q@mail.gmail.com>
 <1ae3a4d3-26e6-fe6d-87a3-d5dcce1fd64c@greensocs.com>
 <CAFEAcA89bbvd0Zi44GZrCDc8e-AEKqGkJ3SA3e=Sz6xVHNbfEw@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <8bd421d9-d0a9-853d-1ab2-09467df64e05@greensocs.com>
Date: Mon, 2 Dec 2019 14:05:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA89bbvd0Zi44GZrCDc8e-AEKqGkJ3SA3e=Sz6xVHNbfEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575291902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59jHss8An0NYZMESND1tXJ7A23ua1uMaUfpnpEIm3Lc=;
 b=yg/C5QnGwUNCtTZ+3miMKD56lDWZdT4Sa+ZbMfcvm/Bwcci0xDSa5c0OsRY2X+4eFyZ0Dy
 HD/rY473Bl0Dpqs1KacjHuS6qCbtVcSiudXP7LwuAYFqDNR65ETyTGoPxM0+a0j5wjxSzL
 sNW1G12qUsaJbgqlbK1XGitwoQ6LmpQ=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575291902; a=rsa-sha256; cv=none;
 b=kbN66ivQO5obHOCsPHk/7oA9GN/c85XcrufnEaunsnOzC9dwiGvlV7bWMRYxoSvBZ8baLO
 ZiezTVC2ywOCnKXSF7lWvbzMD2jPSrX+IjVU9DkFn9mPe7J2vm29WwojHTZ1J/O82mHnQN
 6rURIxNVnK03oioRFjmDTN1lqXu9MtU=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/2/19 1:33 PM, Peter Maydell wrote:
> On Mon, 2 Dec 2019 at 12:27, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>>
>>
>> On 11/29/19 8:05 PM, Peter Maydell wrote:
>>> On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>>> @@ -97,6 +101,7 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t reg, uint32_t value)
>>>>              && (s->fsel[53] == 4) /* SD_DATA3_R */
>>>>              ) {
>>>>          /* SDHost controller selected */
>>>> +        sdbus_reparent_card(&s->sdbus, s->sdbus_sdhost);
>>>>          sdbus_reparent_card(s->sdbus_sdhci, s->sdbus_sdhost);
>>>
>>> The commit message says it's just splitting the function in two,
>>> but these two hunks are adding extra calls to sdbus_reparent_card().
>>> Why do we need to call it twice ?
>>
>> You're right. I forgot to update the commit message. The patch also
>> refactor a little the reset procedure and move the call to
>> sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci)
>> which was in there to this part of the code.
>>
>> raspi machines create the sd in &s->sdbus. So there is need for a first
>> reparenting from this bus.
>>
>> With this addition "gpfsel_update_sdbus" always do the expected effect
>> of putting the sd card onto the right bus.
>>
>> sdbus_reparent_card(src,dst) only do something if the _src_ bus has a
>> card. So only one of the 2 sdbus_reparent_card will have an effect. If
>> the card is already onto the _dst_, both calls will be nop-op
> 
> The intention of sdbus_reparent_card() is that it moves
> something from the 'src' bus to the 'dst' bus. So one
> call is supposed to do the whole job of the move. If
> it doesn't, then that's a bug.
> 
> I thought the raspi machines had an sd card that could
> either be connected to one of the controllers, or the
> other. Why would the sd card ever be somewhere else
> than on one of those two buses? If the machine creation
> puts the sdcard somewhere wrong then we should probably
> just fix that.
> 

I don't know why it has been implemented like this but right now the
raspi_init() does the following during machine creation:
| bus = qdev_get_child_bus(DEVICE(&s->soc), "sd-bus");
| [...]
| carddev = qdev_create(bus, TYPE_SD_CARD);
which put the sd in the BCM2835GpioState.sdbus .

Then the reset procedure of the BCM2835Gpio move the sd card
to one of the two usable controllers and the sd card can never go back
to the initial BCM2835GpioState.sdbus.
As far as I understand, it is theorically possible to have the sd card
on no controller at all (it's maybe the reason for the .sdbus "useless"
bus) (for example if the BCM2835Gpio is badly configured) but this is
not implemented in qemu.

Anyway I can add some plumbing to only call sdbus_reparent_card() when
really needed by:
+ not duplicating the sdbus_reparent_card() in gpfsel_update_sdbus()
+ adding needed test in reset() method to only do the initial
  sdbus_reparent_card() if needed (first time we call reset).

--
Damien


