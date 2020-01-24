Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1013EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07DB20708
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qe+8SXyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07DB20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuySy-0001RF-2G
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 07:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuySN-00011U-2X
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuySL-0003gn-UF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:53:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuySL-0003e6-PT
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579870381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bVOjj7Ju6IxK95jp5dAIPZ3xLwwMi6xKkMechx+Ako=;
 b=Qe+8SXyIBqzW3ALgJgRGinNAOVojdUOZBfJu5u3xy7x/0coVw3Crv2hnzCSYYPG64SyoM2
 I99waOG+DWlf5jwHtDk7PJ8IjDytef2ET5jY1NJVSg1YXHUDXuqARDKMB+xjUpTSHU5o/b
 AwErGntsfZmUSPIA4efjGYOHoBQrUws=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-qWXUv2FUMbKwesrRVfQ-8Q-1; Fri, 24 Jan 2020 07:52:59 -0500
Received: by mail-wr1-f69.google.com with SMTP id u12so1103876wrt.15
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 04:52:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=duKxw9CDUcDeIO1l0oFi5IfctU/inKkCNIKDVjZASbw=;
 b=p24LpYWSo9AvPHaL8rJW+/jCT44LoWcPpSg/LK2k5DIyBvgQHSSmfYb3y+VWrk7OE9
 2HZMvnShpC/B060hrzT87gxx7jzLn7RAONr18OmpqUnPsobpzb0P/42m5kZ9TRQNDVt0
 EMcotbgB4mXDODOrBTzS31cKmSP0N67LMtYFnNFAwo888586Lb99H+J8TIduYjQd3q8q
 ICFehgNx6R6huUV02ozF3AoJsYfFhlEZliDGhNBEBT7dKvlfuvVbFgUCdbj+j/iOLuMR
 f9Hm4Ad2986keF7NQwFlE+2MKFIO7kmbuAWqqiTScH6JxujQ3Ll6/xSZNhAJHxzONP0Y
 bJ6w==
X-Gm-Message-State: APjAAAXzejL2PrL/VFssA2AJMJYeYIzVNcLX6h4rLgYGN2CRkLawTRHp
 8TThkTgmH9ljy1eQaBPJ10YCJZbjfduyFF8x1vTDTzh9YsNAuLSNHoknH/iwcY8Qa74J9QYd9h2
 LbfRht0H4mM6WSKk=
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr4085132wrp.167.1579870378424; 
 Fri, 24 Jan 2020 04:52:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNmAlR7orhHdhQ5Vi8dkVrF7gYRPWG3v+DfDcOu8KVlldqst7WIKjWGKCtSV5xf7nVo073Pg==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr4085089wrp.167.1579870378089; 
 Fri, 24 Jan 2020 04:52:58 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id h17sm7859267wrs.18.2020.01.24.04.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 04:52:57 -0800 (PST)
Subject: Re: [PATCH rc2 12/25] hw/timer: Add limited support for Atmel 16 bit
 timer peripheral
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-13-f4bug@amsat.org> <875zh1yw38.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <28386847-9b49-2be7-a6df-f6ce030855ec@redhat.com>
Date: Fri, 24 Jan 2020 13:52:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <875zh1yw38.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: qWXUv2FUMbKwesrRVfQ-8Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, S.E.Harris@kent.ac.uk,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, me@xcancerberox.com.ar,
 qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>, dovgaluk@ispras.ru,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 aleksandar.m.mail@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 richard.henderson@linaro.org, mrolnik@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 11:42 AM, Alex Benn=C3=A9e wrote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
>> From: Michael Rolnik <mrolnik@gmail.com>
>>
>> These were designed to facilitate testing but should provide enough
>> function to be useful in other contexts.  Only a subset of the functions
>> of each peripheral is implemented, mainly due to the lack of a standard
>> way to handle electrical connections (like GPIO pins).
>>
>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>> Message-Id: <20200118191416.19934-13-mrolnik@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> [rth: Squash info mtree fixes and a file rename from f4bug, which was:]
>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> [PMD: Use qemu_log_mask(LOG_UNIMP), replace goto by return]
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
<snip>
>> --- /dev/null
>> +++ b/hw/timer/atmel_timer16.c
>> @@ -0,0 +1,605 @@
> <snip>
>> +
>> +/* Helper macros */
>> +#define VAL16(l, h) ((h << 8) | l)
>> +#define DB_PRINT(fmt, args...) /* Nothing */
>> +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ##
>> args)*/
>=20
> Format strings are likely to bitrot. Either use a if (GATE) or
> tracepoints.

To avoid respining, I'll do in a new a patch on top of this series,
and Richard can choose to squash it directly.

> <snip>
>=20
> Otherwise:
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20


