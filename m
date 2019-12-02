Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56D1C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA76205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="FSTxIeKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA76205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibkrP-0000Or-JA
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 07:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ibko0-0007uw-DI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ibknz-0001es-6V
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:27:56 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:52694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ibknv-0001cY-3a; Mon, 02 Dec 2019 07:27:51 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 3FFF196EF0;
 Mon,  2 Dec 2019 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575289668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDDYoSOz3CzxlxX4Sp0U/vxXCaY5fCXwnI4hQzM9KYU=;
 b=FSTxIeKUvVeZxjJ5/ygx6cl5i87zqK6gLpzTN8wlvDxos/zxlBxD6ULV5LGq+6AKVEtJn7
 4Wuo/an7DmuPCY4HOh5fCPiWOXU+KZkn3nUVRmgLlTHlN7U20u9Prbr/B08tzLR0Cq053h
 Z5qCwooQyRkatyZmv3iyKJMWyDMkXBo=
Subject: Re: [PATCH v5 12/13] hw/gpio/bcm2835_gpio: Isolate sdbus reparenting
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-13-damien.hedde@greensocs.com>
 <CAFEAcA-YiD6B1wMTrOvj5=QbYY3uuqdbJbSP57zg3S86nU=k-Q@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <1ae3a4d3-26e6-fe6d-87a3-d5dcce1fd64c@greensocs.com>
Date: Mon, 2 Dec 2019 13:27:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-YiD6B1wMTrOvj5=QbYY3uuqdbJbSP57zg3S86nU=k-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575289668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDDYoSOz3CzxlxX4Sp0U/vxXCaY5fCXwnI4hQzM9KYU=;
 b=bv8wiRv35OOvul7zX10ifi6pX54HzRP2/qeZEwxXv5+qqf02NBr1akxUelVxRYmOnuOBV5
 NkypAirKXHlXpcS6uEDVwPMPeN12vt3VQF2aWWuWvOdGsey+DSFRw8vI0pUPXBclQr/ToK
 hOkR9mrjEK+WXWtM/uQy+Flf62AsAK8=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575289668; a=rsa-sha256; cv=none;
 b=sO5qK3FYrp+SYEw5JfqKVyIKVxBHRwScXkfCv5zExvOB9ziTg0dI0og7Si8t5OB8U9scB1
 6XR5gxc45NpNenr94O/YO6/emqblS8mN7ZrBcNWJ/gXAxR1hEzC6MFDeUrH53EaMLAZ2i0
 bA1K9M3L66i0YKzFYRVZ7+mX7gYtY2I=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
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



On 11/29/19 8:05 PM, Peter Maydell wrote:
> On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com>=
 wrote:
>>
>> Split gpfsel_set() in 2 so that the sdbus reparenting is done
>> in a dedicated function.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Cc: qemu-arm@nongnu.org
>> ---
>>  hw/gpio/bcm2835_gpio.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
>> index 91ce3d10cc..81fe07132f 100644
>> --- a/hw/gpio/bcm2835_gpio.c
>> +++ b/hw/gpio/bcm2835_gpio.c
>> @@ -75,7 +75,10 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t=
 reg, uint32_t value)
>>              s->fsel[index] =3D fsel;
>>          }
>>      }
>> +}
>>
>> +static void gpfsel_update_sdbus(BCM2835GpioState *s)
>> +{
>>      /* SD controller selection (48-53) */
>>      if (s->sd_fsel !=3D 0
>>              && (s->fsel[48] =3D=3D 0) /* SD_CLK_R */
>> @@ -86,6 +89,7 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t =
reg, uint32_t value)
>>              && (s->fsel[53] =3D=3D 0) /* SD_DATA3_R */
>>              ) {
>>          /* SDHCI controller selected */
>> +        sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci);
>>          sdbus_reparent_card(s->sdbus_sdhost, s->sdbus_sdhci);
>>          s->sd_fsel =3D 0;>      } else if (s->sd_fsel !=3D 4
>> @@ -97,6 +101,7 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t=
 reg, uint32_t value)
>>              && (s->fsel[53] =3D=3D 4) /* SD_DATA3_R */
>>              ) {
>>          /* SDHost controller selected */
>> +        sdbus_reparent_card(&s->sdbus, s->sdbus_sdhost);
>>          sdbus_reparent_card(s->sdbus_sdhci, s->sdbus_sdhost);
>=20
> The commit message says it's just splitting the function in two,
> but these two hunks are adding extra calls to sdbus_reparent_card().
> Why do we need to call it twice ?

You're right. I forgot to update the commit message. The patch also
refactor a little the reset procedure and move the call to
sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci)
which was in there to this part of the code.

raspi machines create the sd in &s->sdbus. So there is need for a first
reparenting from this bus.

With this addition "gpfsel_update_sdbus" always do the expected effect
of putting the sd card onto the right bus.

sdbus_reparent_card(src,dst) only do something if the _src_ bus has a
card. So only one of the 2 sdbus_reparent_card will have an effect. If
the card is already onto the _dst_, both calls will be nop-op.

What about rewording the commit message like this ?
| hw/gpio/bcm2835_gpio: Refactor sdbus reparenting
|
| Split gpfsel_set() in 2 so that the sdbus reparenting is done in a
| dedicated function gpfsel_update_sdbus() and update call sites.
| Also make gpfsel_update_sdbus() handle the case where the sdcard is in
| BCM2835GpioState.sdbus (initial sd card holding bus at machine
| creation).
| Refactor the reset procedure in consequence.
|
| This patch is a preparation step for the migration to multi-phases
| reset which will be done in a following commit

Thanks,
--
Damien

