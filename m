Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45835C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 22:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154ED208D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 22:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154ED208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pp1.inet.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlgW7-00032k-AQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 18:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aperamak@pp1.inet.fi>)
 id 1jlgVV-0002Lx-Dj; Wed, 17 Jun 2020 18:26:09 -0400
Received: from mta-out1.inet.fi ([62.71.2.226]:54262 helo=julia1.inet.fi)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aperamak@pp1.inet.fi>)
 id 1jlgVS-0006He-UP; Wed, 17 Jun 2020 18:26:09 -0400
Received: from [91.154.154.51] (91.154.154.51) by julia1.inet.fi
 (9.0.019.26-1) (authenticated as perall-2)
 id 5EEA260E00020150; Thu, 18 Jun 2020 01:25:28 +0300
Subject: Re: [PATCH] hw/audio/gus: Fix registers 32-bit access
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200615201757.16868-1-aperamak@pp1.inet.fi>
 <CAFEAcA-eKboVf3uk4iY_A9_uQ=HnGyic4fzbzJhv1gH2V+TMVw@mail.gmail.com>
From: Allan Peramaki <aperamak@pp1.inet.fi>
Message-ID: <87e628f4-6c0e-c4a2-daba-57cb1e508b77@pp1.inet.fi>
Date: Thu, 18 Jun 2020 01:25:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-eKboVf3uk4iY_A9_uQ=HnGyic4fzbzJhv1gH2V+TMVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=62.71.2.226; envelope-from=aperamak@pp1.inet.fi;
 helo=julia1.inet.fi
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 18:26:02
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/06/2020 23:23, Peter Maydell wrote:
> 
> This patch is quite difficult to read because it mixes some
> whitespace only changes with some actual changes of
> behaviour.

Sorry about that. I had to put some whitespace in the two lines I 
modified because of checkpatch.pl, but then the nearby lines would have 
had inconsistent style if left unmodified. On the other hand, QEMU wiki 
said it is ok to fix style issues in the immediate area.

> So, I think the actual bugfix change here is just the changing
> of uint16_t to uint32_t in the GUSregd definition...
> 
>> -#define GUSregb(position)  (*            (gusptr+(position)))
>> -#define GUSregw(position)  (*(uint16_t *) (gusptr+(position)))
>> -#define GUSregd(position)  (*(uint16_t *)(gusptr+(position)))
>> +#define GUSregb(position)  (*(gusptr + (position)))
>> +#define GUSregw(position)  (*(uint16_t *)(gusptr + (position)))
>> +#define GUSregd(position)  (*(uint32_t *)(gusptr + (position)))
> 
> ...and similarly here, and all the other changes are purely
> cleaning up the spaces. Is that right?

That's right. The only real change is uint16_t -> uint32_t in GUSregd. 
This reverses what seems to be an accident in commit 135f5ae1974c, where 
GUSdword (defined as "unsigned int" or "uint32_t" depending on compiler) 
was replaced with uint16_t. That change broke applications that 
read/write DRAM above 64k via I/O ports (in lieu of using DMA.)

> 
>> -#define GUSvoice(position) (*(uint16_t *)(voiceptr+(position)))
>> +#define GUSvoice(position) (*(uint16_t *)(voiceptr + (position)))
> 
> Are these accesses all guaranteed to be correctly aligned
> to be 16 or 32 bit loads/stores ? Otherwise it would be
> better to use the ldl_p/stl_p/ldw_p/stw_p/etc accessors,
> which correctly handle possibly misaligned pointers.

Yes (assuming compiler aligns struct fields properly.) It is not obvious 
though (and easy to break), so I suppose refactoring much of the GUS 
code would be nice. For example, the few places where GUSregd(position) 
is used, position is 2 (mod 4). On the other hand, gusptr is also 2 (mod 
4) bytes (making gusptr+position = 0 (mod 4)), because we have the struct

typedef struct GUSState {
     ISADevice dev;
     GUSEmuState emu;
     QEMUSoundCard card;
     uint32_t freq;
     uint32_t port;
     int pos, left, shift, irqs;
     int16_t *mixbuf;
     uint8_t himem[1024 * 1024 + 32 + 4096];
     int samples;
     SWVoiceOut *voice;
     int64_t last_ticks;
     qemu_irq pic;
     IsaDma *isa_dma;
     PortioList portio_list1;
     PortioList portio_list2;
} GUSState;

where himem is 2 (mod 4). When GUSregd() is used, gusptr is (himem + 
1024 * 1024 + 32), so gusptr is also 2 (mod 4). Similar applies to 
GUSvoice(position).

Best regards,
Allan

