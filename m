Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C06C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E1020890
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E1020890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm1YH-0003g5-CO
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 16:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jm1XY-0002mH-VA; Thu, 18 Jun 2020 16:53:40 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jm1XW-0008PM-DQ; Thu, 18 Jun 2020 16:53:40 -0400
X-Originating-IP: 82.252.130.88
Received: from [192.168.1.155] (lns-bzn-59-82-252-130-88.adsl.proxad.net
 [82.252.130.88]) (Authenticated sender: jcd@tribudubois.net)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 5DCE51C0008;
 Thu, 18 Jun 2020 20:53:31 +0000 (UTC)
Subject: Re: [PATCH v5 3/3] hw/net/imx_fec: improve PHY implementation.
To: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1591272275.git.jcd@tribudubois.net>
 <cbafa49a59659051387e43b7b35d8f280e59f1a3.1591272275.git.jcd@tribudubois.net>
 <CAFEAcA-ivCjAcK=mVBktdN_ms09M096WF=9zoKM+11=HzgmwSA@mail.gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <a1e6519c-4e8a-9557-f3f5-4088904ba7d7@tribudubois.net>
Date: Thu, 18 Jun 2020 22:53:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ivCjAcK=mVBktdN_ms09M096WF=9zoKM+11=HzgmwSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=217.70.183.197; envelope-from=jcd@tribudubois.net;
 helo=relay5-d.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 16:53:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/06/2020 à 15:03, Peter Maydell a écrit :
> On Thu, 4 Jun 2020 at 13:39, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>> improve the PHY implementation with more generic code.
>>
>> This patch remove a lot of harcoded values to replace them with
>> generic symbols from header files.
>>
>> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
>> ---
>>   v2: Not present
>>   v3: Not present
>>   v4: Not present
>>   v5: improve PHY implementation.
>>
>>   hw/net/imx_fec.c     | 76 +++++++++++++++++++++++++++-----------------
>>   include/hw/net/mii.h |  4 +++
>>   2 files changed, 50 insertions(+), 30 deletions(-)
>
>> -    case 5:     /* Auto-neg Link Partner Ability */
>> -        val = 0x0f71;
>> +    case MII_ANLPAR:     /* Auto-neg Link Partner Ability */
>> +        val = / | MII_ANLPAR_10 | MII_ANLPAR_10FD |
>> +              MII_ANLPAR_TX | MII_ANLPAR_TXFD | MII_ANLPAR_PAUSE |
>> +              MII_ANLPAR_PAUSEASY;
> The old value is 0x0f71, but the new one with the constants
> is 0x0de1.

First of I should say that this PHY, first borrowed by the mfc_fec.c 
(coldfire ethernet device) from lan9118 (and now by imx_fec.c) is not 
one used on any real i.MX (i.MX6, i.MX7, i.MX31, i.MX25, ...) based 
board that I know of (this particular PHY is embedded n the lan9118 
ethernet device)

It is there because we were in need of a PHY and this PHY needs to be 
simple and more or less standard.

I might have missed something but I am not really aware of way in Qemu 
to swap PHYs for a given ethernet emulator depending on the emulated board.

So here this PHY was just a blind cut and paste of the lan9118.c PHY 
part to get a reasonable working PHY for the FEC/ENET device.

So here the previous value of this register is not really meaningful. It 
is a mix of standard MII defined bits and LAN911X specific bits (for 
which I don't necessarily have definition ).

Here I decided to restrict the implementation of this rather "virtual" 
PHY to only standard defined bits

actually I think, I should have removed a lot more lan911x specific 
bits/registers to get to a really simple/trivial standard PHY.

>> -    case 30:    /* Interrupt mask */
>> +    case MII_SMC911X_IM:    /* Interrupt mask */
>>           val = s->phy_int_mask;
>>           break;
>> -    case 17:
>> -    case 18:
>> +    case MII_NSR:
>> +        val = 1 << 6;
>> +        break;
> The old code didn't have a case for MII_NSR (16).

I am not sure anymore why I added MII_NSR register. It is not present on 
lan9118 ethernet device but it is a standard defined register.

>> +    case MII_LBREMR:
>> +    case MII_REC:
>>       case 27:
>>       case 31:
>
>> -    case 4:     /* Auto-neg advertisement */
>> -        s->phy_advertise = (val & 0x2d7f) | 0x80;
>> +    case MII_ANAR:     /* Auto-neg advertisement */
>> +        s->phy_advertise = (val & (MII_ANAR_PAUSE_ASYM | MII_ANAR_PAUSE |
>> +                                   MII_ANAR_TXFD | MII_ANAR_TX |
>> +                                   MII_ANAR_10FD | MII_ANAR_10 | 0x1f)) |
>> +                                   MII_ANAR_TX;
> The old code does & 0x2d7f; the new code is & 0xdff.
Same reason as the ANLPAR register.
>>           break;
> If some of these are bug fixes, please can you put them in a separate
> patch, so that the "use symbolic constants" change can be reviewed
> as making no functional changes?
>
> thanks
> -- PMM
>


