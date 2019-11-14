Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2CEC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EBB20715
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WF6V1glW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EBB20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVMeL-0000LI-Or
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 16:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iVMdc-0008FU-8F
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iVMda-0002KY-M4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:26:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24443
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iVMda-0002KK-I8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573766805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jla/saRYu/JOI6uP5BLmXeDytzulzWfudjgn1bsirg0=;
 b=WF6V1glWzq9/0kYctTOsc9k0g6JB7qJoIQOKxj4Gl+ltPtLjFHvnnoqiVPBdAskCIuiOdj
 QPBo2PjjhZPD1QPoWEH/ErX4aIy0WnkGwZKyDDYRCBIwG49bFF2bR8WcFHE7A9tQt9XF8n
 j7CQkOveZU3H2oh1S1eRX/UWGXxUV+k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-omlgw7iQN-eT3-hvYVwbZg-1; Thu, 14 Nov 2019 16:26:42 -0500
Received: by mail-wr1-f71.google.com with SMTP id q6so5640211wrv.11
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 13:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mzBBBZQU9HDb4P9jS+gy/titsTwaKrr7suw5Izl+0Cc=;
 b=SphiPVyObucAspqW8oD9zN+W42Lk7dVNNwPKpZjbN2tvX0h80KHal4/q+eHgG0b/Uk
 Vx6Kt6+KLPHWemOTatmJYZNMm772+L+QWjsGwrL2mgTksBtKbgdamZIdZxA/sGrCNjvg
 SjJ0OZ7GDF6yivLOLmtkuWg2BdqXeKKkXCoHli1/aCGgSURYHnjj0VHDshdFaidz99/+
 aEeoqWqSJR59Dp/aXNoBADg1XZVWL8hZbzXojyLUO3DdqBAyh9pD/8GeA9lm+c/jrznq
 TEHdxz3WukcCFhSON9ldxrsyLTC94SFJ7Ia8xy7KseWKRnx+VBW5ZoYbSTpRyTOQpWcq
 Ao0A==
X-Gm-Message-State: APjAAAVrmRfxqiinBQDaadSUdqx9e3X6GNCJQXHWCXThheGT2uee9SwL
 1ved8ZeTSSKzkmCQo1/Gno/sVprBrgArZ1V/vPMZt0z2gSNwzHzuMjO2RXVGrR8+tK4+6Xj+i3t
 dATVZuqhQ6vixP6A=
X-Received: by 2002:a1c:6146:: with SMTP id v67mr10674159wmb.102.1573766801469; 
 Thu, 14 Nov 2019 13:26:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4oudtLJm+R1W1ky+87fQblsSdGqzWiQ2pNwypkQVGp/9+piH157VFdH4UusfBnJo8xfFrMA==
X-Received: by 2002:a1c:6146:: with SMTP id v67mr10674133wmb.102.1573766801238; 
 Thu, 14 Nov 2019 13:26:41 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id y6sm8605145wrr.19.2019.11.14.13.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 13:26:40 -0800 (PST)
Subject: Re: [PATCH v2 1/3] hw/block/pflash: Remove dynamic field width from
 trace events
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191108144042.30245-1-philmd@redhat.com>
 <20191108144042.30245-2-philmd@redhat.com>
 <9e7990b7-87ed-84d4-5256-8397bc25a1f4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd59a9d2-d5c8-b054-191b-bbbfd9d7b7b1@redhat.com>
Date: Thu, 14 Nov 2019 22:26:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <9e7990b7-87ed-84d4-5256-8397bc25a1f4@redhat.com>
Content-Language: en-US
X-MC-Unique: omlgw7iQN-eT3-hvYVwbZg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 11/8/19 4:56 PM, Eric Blake wrote:
> On 11/8/19 8:40 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since not all trace backends support dynamic field width in
>> format (dtrace via stap does not), replace by a static field
>> width instead.
>>
>> Reported-by: Eric Blake <eblake@redhat.com>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1844817
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> =C2=A0 hw/block/pflash_cfi01.c | 8 ++++----
>> =C2=A0 hw/block/pflash_cfi02.c | 8 ++++----
>> =C2=A0 hw/block/trace-events=C2=A0=C2=A0 | 8 ++++----
>> =C2=A0 3 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 566c0acb77..787d1196f2 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -276,7 +276,7 @@ static uint32_t pflash_data_read(PFlashCFI01 *pfl,=
=20
>> hwaddr offset,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DPRINTF("BUG in %=
s\n", __func__);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 trace_pflash_data_read(offset, width << 1, ret);
>> +=C2=A0=C2=A0=C2=A0 trace_pflash_data_read(offset, width << 3, ret);
>=20
> Umm, why is width changing?=C2=A0 That's not mentioned in the commit mess=
age.

Previously it was used to set the format width: [1, 2, 4] -> [2, 4, 8].

We usually log the width in byte (accessed at memory location) or bits=20
(used by the bus). When using this device I'm custom to think in bus=20
access width.

Regardless whichever format we prefer, a change is needed.

>=20
>> @@ -389,7 +389,7 @@ static uint32_t pflash_read(PFlashCFI01 *pfl,=20
>> hwaddr offset,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 trace_pflash_io_read(offset, width, width << 1, ret,=
 pfl->cmd,=20
>> pfl->wcycle);
>> +=C2=A0=C2=A0=C2=A0 trace_pflash_io_read(offset, width << 3, ret, pfl->c=
md,=20
>> pfl->wcycle);
>=20
> And even this one is odd.=C2=A0 Matching up to the trace messages:
>=20
>=20
>> -pflash_io_read(uint64_t offset, int width, int fmt_width, uint32_t=20
>> value, uint8_t cmd, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d=20
>> value:0x%0*x cmd:0x%02x wcycle:%u"
>=20
>> +pflash_io_read(uint64_t offset, int width, uint32_t value, uint8_t=20
>> cmd, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%04x=20
>> cmd:0x%02x wcycle:%u"
>=20
> you are changing from:
>=20
> "%04"PRIx64" %d %0*x...", offset, width, width << 1, ret,...
>=20
> (where width<<1, ret matches *x)
>=20
> into
>=20
> "%04"PRIx64" %d %04x...", offset, width << 3, ret,...
>=20
> where you are now printing a different value for width.

Do you prefer using a "-bit" suffix? As

"offset:0x%04"PRIx64" width:%d-bit value:0x%04x cmd:0x%02x wcycle:%u"

I can also simply remove this information. Ideally I'd revert this patch=20
once the we get this format parsable by the SystemTap backend.


