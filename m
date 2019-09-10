Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A376C4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC25B20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJgzPHAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC25B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7f8g-0003bb-4n
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7f0L-0007mG-RD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7f0K-0007Vq-NM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:12:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7f0K-0007Uq-Fy
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:12:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id d17so6966315wrq.13
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=doYj+GefKpMb9jXaKMscQzv6jkYE4lGQbDXrEs+U1No=;
 b=OJgzPHAkPotDiynHuNIhfUzN3D9zDl8rYp6e5vGVmxslAID251WfatSmyVcUuhaE0t
 JLYN8hS4gvYNJ+iI16Udqpv+2DZ31SAr2SJqznwH9zQ0znCONDwYZa1CrqJFp86CY6jC
 NNBIzW9FxxKhfKNq3viydrMZ8dYJIuUPdoLuOtPELhLzG2aiRFfh0KkNhOxmviUKvQ1m
 6en26Aa82pRpSvp9rDXPb3I8vhkC8wgdUfx9G9rP3tbed3YeIu5yNpUu6//EL4RliCxs
 fdwC/QYBoc0qq+KtNVWnK2i3feHMeBtrhlsMBOK5g5LZtt8CSR6yXRilo7voHVTZzNYg
 pnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=doYj+GefKpMb9jXaKMscQzv6jkYE4lGQbDXrEs+U1No=;
 b=eslKAOCv4RW9sbgpWIJ/Ll83BILBd7m7k3qWMq+tsdXvfu5rRl9/lLItKtbS6faZP0
 6mwoFmstO/djqOd6cLtbKfU6HDshKpoZQctEwwb2Af0xL3IPcNPcaiqGa6APAy3PvbQ1
 D0qzhjb8ZrlbOmjaBK9/9WZe4kJbgcLtRavRXLiNM55ahlxFe+0kJyLCNVbv81iPQtf0
 80ZY9nudI3pBn/rC8c8VzsKyNBD31RiZ1TFcO69UPO2IUVn8CAmPU/+4aPQJAcKbk3t/
 wbeKn6cJ4ZTp2RSWNBdgFiv+/w5JfQyc1+zgUbWxVu2c5Xfc7bc55sRixqrVRIqh+o3G
 Dlzw==
X-Gm-Message-State: APjAAAWijauE+QoGSPuOmAXKa9Omza5+WwUTCvfrfmICmL2mQdeaJ04N
 Jg0GXiLGTshwN/t5zWeBg2JrzQ==
X-Google-Smtp-Source: APXvYqydTHVSvCqculuSQKNTALkvUZ5i96a2rGI4JWPb89dCpbXhrfGj0zhIkP1G0dkhehFfv5+JnA==
X-Received: by 2002:adf:dc89:: with SMTP id r9mr25429177wrj.139.1568117535276; 
 Tue, 10 Sep 2019 05:12:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y13sm37193040wrg.8.2019.09.10.05.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 05:12:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 08E4C1FF87;
 Tue, 10 Sep 2019 13:12:14 +0100 (BST)
References: <20190910090821.28327-1-sgarzare@redhat.com>
 <87mufc1nvd.fsf@linaro.org> <20190910110759.hbzjbhcpypkensmz@steredhat>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
In-reply-to: <20190910110759.hbzjbhcpypkensmz@steredhat>
Date: Tue, 10 Sep 2019 13:12:14 +0100
Message-ID: <87imq01hb5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] elf-ops.h: fix int overflow in load_elf()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefano Garzarella <sgarzare@redhat.com> writes:

> On Tue, Sep 10, 2019 at 10:50:30AM +0100, Alex Benn=C3=A9e wrote:
>>
>> Stefano Garzarella <sgarzare@redhat.com> writes:
>>
>> > This patch fixes a possible integer overflow when we calculate
>> > the total size of ELF segments loaded.
>> >
>> > Reported-by: Coverity (CID 1405299)
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> > Now we are limited to INT_MAX, should load_elf() returns ssize_t
>> > to support bigger ELFs?
>> > ---
>> >  include/hw/elf_ops.h | 6 ++++++
>> >  hw/core/loader.c     | 1 +
>> >  2 files changed, 7 insertions(+)
>> >
>> > diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
>> > index 1496d7e753..46dd3bf413 100644
>> > --- a/include/hw/elf_ops.h
>> > +++ b/include/hw/elf_ops.h
>> > @@ -485,6 +485,12 @@ static int glue(load_elf, SZ)(const char *name, i=
nt fd,
>> >                  }
>> >              }
>> >
>> > +            if (mem_size > INT_MAX - total_size) {
>> > +                error_report("ELF total segments size is too big to l=
oad "
>> > +                             "max is %d)", INT_MAX);
>> > +                goto fail;
>> > +            }
>> > +
>>
>> Seem sensible enough (although gah, I hate these glue bits). Would the
>> large amount of goto fail logic be something that could be cleaned up
>> with the automatic cleanup functions we recently mentioned in
>> CODING_STYLE.rst?
>>
>
> As Peter pointed out, maybe we should keep the 'goto fail' and do a
> better cleanup, but thanks to pointing that out to me.
>
>> Anyway:
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Thanks for the review!
>
> I'm sending a v2 following the Peter's suggestions,
> removing the error_report and returing a new ELF_LOAD_TOO_BIG error
> value.
>
> Can I keep your R-b, or would you like to have a look at v2?

I'm happy with that - I'm not super familiar with the Elf code although
I'm about to become so....

>
> Thanks,
> Stefano


--
Alex Benn=C3=A9e

