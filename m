Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDE0C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970BE21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9YQeCKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970BE21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtUc-0006B3-Va
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAtM0-0006Ob-9t
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAtLy-00004z-Lg
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:07:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAtLy-0008Vq-B7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:07:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id a6so3695972wma.5
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=T3X7iW8zonxKhxux5mIWJQXmtTE452vWJrhhuOcOjwk=;
 b=U9YQeCKw7PdAdwiOd3aeqj0HJW+9wkNKJ93JbqumT4sjqZfdBR4X/zbyWSGS8YYEyl
 B4/H9gkMcRy/lRNJiQzIsFS1rBAPIjxSz/0N/JQ27gdtxsfOESFTDYqRsqjCze0syLL8
 svZeSsJO84jsdg5StKF6l/8zpVauPdef2aiie1NYnBBplO2xfWg0EVz1vkfHhb5t6WVX
 m/zLsAc3s8YfNgnD05niV6jo6TWOOsfotehQ4n1dQ0bA/NwVzWId2IPje9MdzY7ScWAc
 Hnu7IpsdTy7VmcwmIhRIDOwhg2RuImjGITkpp7HSpQcbU55Cee9CW8OGfCi8x2wmeQrW
 UtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=T3X7iW8zonxKhxux5mIWJQXmtTE452vWJrhhuOcOjwk=;
 b=C69EsK9h6YSulQ4pDfLSFpm8WZ1oJ+TCTDZ7d5gWZnr6w8V99G+1ZSmVYLav8iOEY+
 ebYPTP+J7YIum7rTZeBu+kwWepALixeGd6Oio9GubdVNpz0+KS0mhKmIJg+nfY0NLm1r
 vG0xDXnI9ReytAGHrqLGRoAKN7TP4aGK8TeWbWXCRpyiylWjTSIlTM8NYiLmfnsL0k1Y
 XBluod3J3XgiHODeMVe1kwXezzar9xA+vlvNJN0I/SUsU5NL6cHWImr03FXssG5QsPoD
 moObIMYG7ydznVSjIPudQuLwZ04qKqsrop5vyT1USVUXkaaRJx9shKuiAVfBKj7YuMZo
 YqXw==
X-Gm-Message-State: APjAAAXui+iDsSrREMzgUCXmGGuenlensWA511jx5P+ozJMbThPplUZh
 pck2iFFn4t+Q+kyHpnF7QfzvJA==
X-Google-Smtp-Source: APXvYqyXxcLYuX69g6uD9+yWOWrfuFvJ5Vepl35Opal7YyrDJFF4IGKKTtZeNyf0RTKOoLzcsKMsXA==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr2244915wme.16.1568887676602; 
 Thu, 19 Sep 2019 03:07:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e20sm14319040wrc.34.2019.09.19.03.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 03:07:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 48A301FF87;
 Thu, 19 Sep 2019 11:07:55 +0100 (BST)
References: <20190918153335.20797-1-alex.bennee@linaro.org>
 <001801d56ec7$d80940d0$881bc270$@ru>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
In-reply-to: <001801d56ec7$d80940d0$881bc270$@ru>
Date: Thu, 19 Sep 2019 11:07:55 +0100
Message-ID: <87sgoszjic.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] tests/tcg: add simple record/replay smoke
 test for aarch64
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
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 "'open list:ARM TCG CPUs'" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

> Thanks!
>
> This seem to correctly run record and replay command lines.
> When I break the replay correctness, then the test reports a timeout erro=
r.
>
> However, we need some kind of a manual for tcg testing. I had to dig thro=
ugh makefile and configure
> scripts to undestand that testing needs the cross compilers to be install=
ed.
> Then I installed a random cross compiler and everything worked
> normally.

I shall add a section to the testing.rst documentation.

>
> Pavel Dovgalyuk
>
>> -----Original Message-----
>> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> Sent: Wednesday, September 18, 2019 6:34 PM
>> To: qemu-devel@nongnu.org
>> Cc: Alex Benn=C3=A9e; Pavel Dovgalyuk; Peter Maydell; open list:ARM TCG =
CPUs
>> Subject: [PATCH] tests/tcg: add simple record/replay smoke test for aarc=
h64
>>
>> This adds two new tests that re-use the memory test to check basic
>> record replay functionality is still working. We have to define our
>> own runners rather than using the default pattern as we want to change
>> the test name but re-use the memory binary.
>>
>> We declare the test binaries as PHONY as they don't rely exist.
>>
>> [AJB: A better test would output some sort of timer value or other
>> otherwise variable value so we could compare the record and replay
>> outputs and ensure they match]
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>
>> ---
>>  tests/tcg/aarch64/Makefile.softmmu-target | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch=
64/Makefile.softmmu-
>> target
>> index 4c4aaf61dd3..b4b39579634 100644
>> --- a/tests/tcg/aarch64/Makefile.softmmu-target
>> +++ b/tests/tcg/aarch64/Makefile.softmmu-target
>> @@ -32,3 +32,24 @@ memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D1
>>
>>  # Running
>>  QEMU_OPTS+=3D-M virt -cpu max -display none -semihosting-config
>> enable=3Don,target=3Dnative,chardev=3Doutput -kernel
>> +
>> +# Simple Record/Replay Test
>> +.PHONY: memory-record
>> +run-memory-record: memory-record memory
>> +	$(call run-test, $<, \
>> +	  $(QEMU) -monitor none -display none \
>> +		  -chardev file$(COMMA)path=3D$<.out$(COMMA)id=3Doutput \
>> +		  -icount shift=3D5$(COMMA)rr=3Drecord$(COMMA)rrfile=3Drecord.bin \
>> +	   	  $(QEMU_OPTS) memory, \
>> +	  "$< on $(TARGET_NAME)")
>> +
>> +.PHONY: memory-replay
>> +run-memory-replay: memory-replay run-memory-record
>> +	$(call run-test, $<, \
>> +	  $(QEMU) -monitor none -display none \
>> +		  -chardev file$(COMMA)path=3D$<.out$(COMMA)id=3Doutput \
>> +		  -icount shift=3D5$(COMMA)rr=3Dreplay$(COMMA)rrfile=3Drecord.bin \
>> +	   	  $(QEMU_OPTS) memory, \
>> +	  "$< on $(TARGET_NAME)")
>> +
>> +TESTS+=3Dmemory-record memory-replay
>> --
>> 2.20.1


--
Alex Benn=C3=A9e

