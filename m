Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9948C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718D320674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZscwFx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718D320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE5Ae-0003EY-N8
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jE58Q-0001Ta-4B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jE58N-0000u4-RE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:51:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jE58N-0000qA-Lk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584424283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZyc03uIXxVnHk5B0Ka968IeL/7/8G1+6bALMy4dLP8=;
 b=aZscwFx7h3/5AQBtccsJPDKONA2C82qqWKlmx7lWodDoYxfz6m2I5GWcdAL9wsZvrC4Qn3
 XizksEdGxGgnAye/guLFxUPw4qKivcw0krcH1Q3iQw01XX3dKASrMXusa02sWNdnhVPQVV
 qfX0kvb3kNFlhuuXv/8Iw8AZ5gee9l0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-y3l1xS7ZM-yCYbEVlpAtLw-1; Tue, 17 Mar 2020 01:51:21 -0400
X-MC-Unique: y3l1xS7ZM-yCYbEVlpAtLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DCFA18A5500;
 Tue, 17 Mar 2020 05:51:20 +0000 (UTC)
Received: from [10.72.12.89] (ovpn-12-89.pek2.redhat.com [10.72.12.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93B18907FB;
 Tue, 17 Mar 2020 05:51:17 +0000 (UTC)
Subject: Re: [PATCH] hw/net/i82596: Correct command bitmask (CID 1419392)
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200214004753.15736-1-f4bug@amsat.org>
 <CAFEAcA9CdtrbTTFAkngP90jNaSALVN2svOx75qLORhLKGUoUUA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cbc557d0-a32d-af1c-33d8-c6177dca2883@redhat.com>
Date: Tue, 17 Mar 2020 13:51:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9CdtrbTTFAkngP90jNaSALVN2svOx75qLORhLKGUoUUA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/13 =E4=B8=8B=E5=8D=887:01, Peter Maydell wrote:
> On Fri, 14 Feb 2020 at 00:48, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>> The command is 32-bit, but we are loading the 16 upper bits with
>> the 'get_uint16(s->scb + 2)' call.
>>
>> Once shifted by 16, the command bits match the status bits:
>>
>> - Command
>>    Bit 31 ACK-CX   Acknowledges that the CU completed an Action Command.
>>    Bit 30 ACK-FR   Acknowledges that the RU received a frame.
>>    Bit 29 ACK-CNA  Acknowledges that the Command Unit became not active.
>>    Bit 28 ACK-RNR  Acknowledges that the Receive Unit became not ready.
>>
>> - Status
>>    Bit 15 CX       The CU finished executing a command with its I(interr=
upt) bit set.
>>    Bit 14 FR       The RU finished receiving a frame.
>>    Bit 13 CNA      The Command Unit left the Active state.
>>    Bit 12 RNR      The Receive Unit left the Ready state.
>>
>> Add the SCB_COMMAND_ACK_MASK definition to simplify the code.
>>
>> This fixes Coverity 1419392 (CONSTANT_EXPRESSION_RESULT):
>>
>>    /hw/net/i82596.c: 352 in examine_scb()
>>    346         cuc =3D (command >> 8) & 0x7;
>>    347         ruc =3D (command >> 4) & 0x7;
>>    348         DBG(printf("MAIN COMMAND %04x  cuc %02x ruc %02x\n", comm=
and, cuc, ruc));
>>    349         /* and clear the scb command word */
>>    350         set_uint16(s->scb + 2, 0);
>>    351
>>    >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
>>    >>>     "command & (2147483648UL /* 1UL << 31 */)" is always 0 regard=
less of the values of its operands. This occurs as the logical operand of "=
if".
>>    352         if (command & BIT(31))      /* ACK-CX */
>>    353             s->scb_status &=3D ~SCB_STATUS_CX;
>>    >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
>>    >>>     "command & (1073741824UL /* 1UL << 30 */)" is always 0 regard=
less of the values of its operands. This occurs as the logical operand of "=
if".
>>    354         if (command & BIT(30))      /*ACK-FR */
>>    355             s->scb_status &=3D ~SCB_STATUS_FR;
>>    >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
>>    >>>     "command & (536870912UL /* 1UL << 29 */)" is always 0 regardl=
ess of the values of its operands. This occurs as the logical operand of "i=
f".
>>    356         if (command & BIT(29))      /*ACK-CNA */
>>    357             s->scb_status &=3D ~SCB_STATUS_CNA;
>>    >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
>>    >>>     "command & (268435456UL /* 1UL << 28 */)" is always 0 regardl=
ess of the values of its operands. This occurs as the logical operand of "i=
f".
>>    358         if (command & BIT(28))      /*ACK-RNR */
>>    359             s->scb_status &=3D ~SCB_STATUS_RNR;
>>
>> Fixes: Covertiy CID 1419392 (commit 376b851909)
> ("Coverity")
>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> Jason, are you planning to pick this one up?


Yes. queued.

Thanks


> thanks
> -- PMM
>


