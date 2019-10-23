Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4ECCA9EBB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF911214B2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLiE56tJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF911214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFtK-00026I-Q7
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNFof-0006yq-2i
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNFod-00029F-P4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:32:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNFod-00028n-LH
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571833959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/m7/secoBFmHtG+lhTVngcjPLIOZgYH4Vrn09+sL2e8=;
 b=VLiE56tJZ8iZJHZave+jtR1Zz85iEwXpx9xTzQVJ1QFn5cTf4zcsHCH1Zy9VllmDuEHth0
 cM2YzBE4Wljf3HHIgnjSBTOSp/YvRvF9jf8H3cH2w6kNvWqC3VKTKwH5PgUpDy/OGFlkIX
 RxTqWnBnfKyiIh4CZbc5ydDQUxLYm8E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-TYbvdqOoMkWoEHtM2I0RiQ-1; Wed, 23 Oct 2019 08:32:37 -0400
Received: by mail-wm1-f71.google.com with SMTP id o8so8761448wmc.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 05:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=khzsXHxphTt5lF3JUkT+BVbSWLmqvJ1qAycv7xALohw=;
 b=txqHqVKemOL5bEfh2D39ZiF1GlYoIqga7W378BU0iZ5+nomreogy/SVZpX2w+5/Uym
 myhI0gL/0dKUmmx5ZXOx6XP+c0mtavh31SPs2l4bczgkykR5mJcxOmACFFU5O15vrqWg
 FWLQkf8LDOy7C8gcKTHao0FJAQ3dCs/KFNBXZHh1wsNnnx14kZJH1Vi6y1FESKrQg/jm
 DW6A6khtYn5uBU3Nn/hNkpQEeorXtPkHJkmkSdagFdBX0VMqKEG7J9cVyXhicwI96Sdj
 5YQbdyj/JBXFtaGiPKDaQhDVqewpnGlWn59NnXD9BpMohNVkLvTRE+EM3VD6g0MZQ1VV
 BqJA==
X-Gm-Message-State: APjAAAV0xC0bp1fmAo06is83XSW89rGMnm2GOwjEaWdotCJJvbRvKo0U
 D4z0b/T3la4w7c7A00hv18sVA8b8/qP7bF3t0k38yVrbvjBRDcMHUNbh3NpEbGSP+2R4l5EppaO
 ZQVLVCB0VBL/FPHA=
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr8410023wrj.345.1571833956406; 
 Wed, 23 Oct 2019 05:32:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw2ZM4S1KEY8/Zi3X0Q0uBsYApbjk0Z3NZsE+vRvMnhyj1maLHCN8RNSY9/mPZuSbY6zigydQ==
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr8410004wrj.345.1571833956185; 
 Wed, 23 Oct 2019 05:32:36 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id m18sm24800850wrg.97.2019.10.23.05.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 05:32:35 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] ps2: accept 'Set Key Make and Break' commands
To: Sven Schnelle <svens@stackframe.org>
References: <20191022205941.23152-1-svens@stackframe.org>
 <20191022205941.23152-4-svens@stackframe.org>
 <c0a0c73a-496f-e6bc-54ce-a6631ef3a81d@redhat.com>
 <20191023120844.GA22554@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b9f952bc-dad7-3656-ef2b-1dd874c6a660@redhat.com>
Date: Wed, 23 Oct 2019 14:32:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023120844.GA22554@stackframe.org>
Content-Language: en-US
X-MC-Unique: TYbvdqOoMkWoEHtM2I0RiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 2:08 PM, Sven Schnelle wrote:
> Hi Philippe,
>=20
> On Wed, Oct 23, 2019 at 01:08:35PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Hi Sven,
>>
>> (Please Cc reviewers who previously commented your patch)
>>
>> On 10/22/19 10:59 PM, Sven Schnelle wrote:
>>> HP-UX sends both the 'Set key make and break (0xfc) and
>>> 'Set all key typematic make and break' (0xfa). QEMU response
>>> with 'Resend' as it doesn't handle these commands. HP-UX than
>>> reports an PS/2 max retransmission exceeded error. Add these
>>> commands and just reply with ACK.
>>>
>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>>> ---
>>>    hw/input/ps2.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
>>> index 67f92f6112..0b671b6339 100644
>>> --- a/hw/input/ps2.c
>>> +++ b/hw/input/ps2.c
>>> @@ -49,6 +49,8 @@
>>>    #define KBD_CMD_RESET_DISABLE=090xF5=09/* reset and disable scanning=
 */
>>>    #define KBD_CMD_RESET_ENABLE   =090xF6    /* reset and enable scanni=
ng */
>>>    #define KBD_CMD_RESET=09=090xFF=09/* Reset */
>>> +#define KBD_CMD_SET_MAKE_BREAK  0xFC    /* Set Make and Break mode */
>>> +#define KBD_CMD_SET_TYPEMATIC   0xFA    /* Set Typematic Make and Brea=
k mode */
>>>    /* Keyboard Replies */
>>>    #define KBD_REPLY_POR=09=090xAA=09/* Power on reset */
>>> @@ -573,6 +575,7 @@ void ps2_write_keyboard(void *opaque, int val)
>>>            case KBD_CMD_SCANCODE:
>>>            case KBD_CMD_SET_LEDS:
>>>            case KBD_CMD_SET_RATE:
>>> +        case KBD_CMD_SET_MAKE_BREAK:
>>
>> OK
>>
>>>                s->common.write_cmd =3D val;
>>>                ps2_queue(&s->common, KBD_REPLY_ACK);
>>>                break;
>>> @@ -592,11 +595,18 @@ void ps2_write_keyboard(void *opaque, int val)
>>>                    KBD_REPLY_ACK,
>>>                    KBD_REPLY_POR);
>>>                break;
>>> +        case KBD_CMD_SET_TYPEMATIC:
>>> +            ps2_queue(&s->common, KBD_REPLY_ACK);
>>
>> I'm not sure, can't this loop?
>=20
> I don't see how?

I misunderstood the two switch statements.

>> Can you fold it with the '0x00' case?
>=20
> Ok.
>=20
>>> +            break;
>>>            default:
>>>                ps2_queue(&s->common, KBD_REPLY_RESEND);
>>>                break;
>>>            }
>>>            break;
>>> +    case KBD_CMD_SET_MAKE_BREAK:
>>
>> We can reorder this one in the same case with:
>>
>>      case KBD_CMD_SET_LEDS:
>>      case KBD_CMD_SET_RATE:
>=20
> Ok.

With these changes:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
>>> +        ps2_queue(&s->common, KBD_REPLY_ACK);
>>> +        s->common.write_cmd =3D -1;
>>> +        break;
>>>        case KBD_CMD_SCANCODE:
>>>            if (val =3D=3D 0) {
>>>                if (s->common.queue.count <=3D PS2_QUEUE_SIZE - 2) {
>>>
>>
>=20
> Regards
> Sven
>=20


