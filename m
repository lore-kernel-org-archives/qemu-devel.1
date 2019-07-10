Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BBAC004EF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 11:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250A22064A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 11:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDpQ9/ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250A22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlArI-00087O-CI
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 07:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37517)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlAqK-0007ET-Gi
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 07:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlAqI-000834-IU
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 07:33:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlAqE-0007za-PZ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 07:32:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id p17so2046308wrf.11
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bxFICg0n+PhHstls7ISCQcf1IBEcjTvTD7T9ypnPc84=;
 b=jDpQ9/cilI43qrSxr+FX9gxN4anKeoQau1ytvMClf5Xv5zJlFFJhv/sDGvlq6VVCLq
 kBHBu9UhhfX3c8gAHWUbqFpoE+pd8dUZrz6NMrxU1MLaLDIzBibKcvkV74Qr7mDTKuXN
 zPfXoGE7F4quwdUfBC2l4FdKBtoXQ8AswJimezlIxYpMngTwZtxq1narGZS/iEYpJ88u
 0tKUNgyfKbEhS+O3ZTtZ3h+mEoOVxZ7NuoGQvkI3cUZGE3N7vgqOU9GAWtsK2M6CZZp4
 B5gggE8lZf31ZyWUt5YHvp7HisZn2N3nmgtRPwigsVtmL9YjPN/EWy97gU65xEB7+wtn
 qjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bxFICg0n+PhHstls7ISCQcf1IBEcjTvTD7T9ypnPc84=;
 b=okMLbteLT1Zho0Oudy4g9T/Ie8+RgRU93KdAV6pkAIcuOLqbna5BwfZLG023Ib3tiX
 k7U8ZfQLE2eL9kBqr82i13rzp9wTOnGH+xc/a3uMdNj0MrjJshIBDgpOGrk7dQ5jJmbl
 ehC5NuUhzN2323Ge3ucvVg79dfLD5YSGx6HkBp4qYl8C20RTjCTJJRi+IHwSltT/B76H
 sHzzUq7PhssFtqcSSAmx0N82CJD0QyIxbXZZuGRnEHFKJ6qstRxAFXnW1KjCs/gBMawL
 cQ9uK8zd4wH4LobhHzKIjrhd9W0uFTHpgPQjht19xKri7FHONW0kuKcVaC7xcS4lXl2g
 NfBA==
X-Gm-Message-State: APjAAAUYZ9nMbzVn0Sksdp3jGq3n5WtrxWVhXs2v22Q/nwcQh6BY6+6t
 WRHUu+P1mQvYM0A7WhNoPfKh6A==
X-Google-Smtp-Source: APXvYqwc4p2Tr7pqsNYNM3m0cne/0MCiO+R9yFLyDv9MOndySV6iOPOPZt+JhRRMm0p0h9Vhz8xp5A==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr30481649wrq.333.1562758372024; 
 Wed, 10 Jul 2019 04:32:52 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 66sm1612942wma.11.2019.07.10.04.32.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 04:32:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D5BCB1FF87;
 Wed, 10 Jul 2019 12:32:50 +0100 (BST)
References: <20190705160421.19015-1-alex.bennee@linaro.org>
 <20190705160421.19015-3-alex.bennee@linaro.org>
 <af417ca3-248a-d1a8-51c4-46676b6d9d4a@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <af417ca3-248a-d1a8-51c4-46676b6d9d4a@redhat.com>
Date: Wed, 10 Jul 2019 12:32:50 +0100
Message-ID: <87lfx6dt0d.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 2/5] tests/tcg: fix up
 test-i386-fprem.ref generation
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Jan Bobek <jan.bobek@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/5/19 6:04 PM, Alex Benn=C3=A9e wrote:
>> We never shipped the reference data in the source tree because it was
>> quite big (64M). As a result the only option is to generate it
>
> Can we fetch it (with hash verification) or store it compressed?

Seems like a lot of hoops to jump through. The limitation is that you
need to be on an x86 to generate the reference data but that isn't very
hard these days. If you do happen to be on non-x86 and are not paying
attention it becomes a simple regression test against the system
(binfmt_misc) run QEMU. But as it is currently broken and needing some
love it's just an incremental improvement for where we are at the
moment.

>
> $ du -ch pc-bios/edk2-*bz2
> 1.2M    pc-bios/edk2-aarch64-code.fd.bz2
> 1.2M    pc-bios/edk2-arm-code.fd.bz2
> 4.0K    pc-bios/edk2-arm-vars.fd.bz2
> 1.7M    pc-bios/edk2-i386-code.fd.bz2
> 1.9M    pc-bios/edk2-i386-secure-code.fd.bz2
> 4.0K    pc-bios/edk2-i386-vars.fd.bz2
> 1.7M    pc-bios/edk2-x86_64-code.fd.bz2
> 1.9M    pc-bios/edk2-x86_64-secure-code.fd.bz2
> 9.3M    total
>
>> locally. Although we have a rule to generate the reference file we
>> missed the dependency and location changes, probably because it is
>> only run for SLOW test runs.
>>
>> The test still fails with mostly incorrect flags and different than
>> expected NaNs. I'll leave that for the x86 experts to look at.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Jan Bobek <jan.bobek@gmail.com>
>> ---
>>  tests/tcg/i386/Makefile.target | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.ta=
rget
>> index b4033ba3d1..d0eb7023e5 100644
>> --- a/tests/tcg/i386/Makefile.target
>> +++ b/tests/tcg/i386/Makefile.target
>> @@ -35,9 +35,9 @@ test-i386-fprem.ref: test-i386-fprem
>>  	$(call quiet-command, ./$< > $@,"GENREF","generating $@")
>>
>>  run-test-i386-fprem: TIMEOUT=3D60
>> -run-test-i386-fprem: test-i386-fprem
>> +run-test-i386-fprem: test-i386-fprem test-i386-fprem.ref
>>  	$(call run-test,test-i386-fprem, $(QEMU) $<,"$< on $(TARGET_NAME)")
>> -	$(call diff-out,test-i386-fprem, $(I386_SRC)/$<.ref)
>> +	$(call diff-out,test-i386-fprem, test-i386-fprem.ref)
>>  else
>>  run-test-i386-fprem: test-i386-fprem
>>  	$(call skip-test, $<, "SLOW")
>>


--
Alex Benn=C3=A9e

