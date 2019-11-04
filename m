Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F8BCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 19:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0AD206BA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 19:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hsc9nYUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0AD206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRiHc-0007gV-Vw
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 14:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRiFp-0006Oa-S3
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 14:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRiFo-0006Xb-9s
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 14:43:09 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRiFn-0006WX-K3
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 14:43:08 -0500
Received: by mail-wm1-x342.google.com with SMTP id 8so10366976wmo.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 11:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zdG/zNVQnri2GPs5FUuHX7+ccKsYsuKNZkYucsDAP5w=;
 b=hsc9nYUWG+TGJF8E+wc3FfQc08U6LyQWOkzjFo9MNJrXxAbH5BokpOpDFAi0KDkGkQ
 ZmEdnk5M6SQmu+Tp3OQuDjVUBoyZJtMyPAiGB/nAduUe/uuZuPmOEIwG2YVKJPfzscH2
 CphvgVDLriMDQkDA389OY+4BxZgg7OHGHg3gs35h76gBRz9e89pmOBA+D5jMF7TcpT1i
 7xXpSEkvzA3hpMf9JhLEdlrjX2YQeNVl0FKcKlqcQY1KLAjcbcAhy7B+0XczGpC9GvYN
 mE979+1Xlg7HTHdOpNz+kP+uQz6NZrKdJquhU5fdLiHItrFmaVJ7j48DHHrDgPyspNQa
 QDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zdG/zNVQnri2GPs5FUuHX7+ccKsYsuKNZkYucsDAP5w=;
 b=Dnkl9jurUW+63sWucpXF1l/mDvn8XYFN1PU+j4CnA/2xjuQZDJDE8c5n8JrXTcDjut
 V7pYMaIDDE7l+6stV2voMe6lMjacY5BQIcavcrljI/keBLoJsoLUC3uAyF3cMGW6beh5
 1a/Sa7z4yCivCTogsW1MI05DvelXjB0Od3T8UDNTSAuknv/lXLqP8qnJjYjARkNeG6T/
 R3644LhhSHD6F2HBDE3zGWA7HPVmu2HBAC29Z0KUEVpcmp3Y9OCQq3DfdvHREzMwoeT7
 IwcnQWg0RQ3FtSJLYmI0RA1jRZryDb4EFBK2DMZS3cEmU2cyPtjYBkZ21wpZpT4Y4/dh
 SqqA==
X-Gm-Message-State: APjAAAVQS8GIkHPDFetzfWKZwiwO9+/1EqK5UQo8rdILyHr0asSv5HfO
 9faMhlCuDSdpfIbn6GnSrOZJjg==
X-Google-Smtp-Source: APXvYqznWANVS3F3sft/zDWRi9UzIyd40iKdypbh7eoCRrLdop1B3RcZpVDJ3p22FTWWfwp9UOSqKA==
X-Received: by 2002:a05:600c:24c9:: with SMTP id
 9mr631159wmu.137.1572896585667; 
 Mon, 04 Nov 2019 11:43:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u203sm12312836wme.34.2019.11.04.11.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 11:43:04 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 366D71FF87;
 Mon,  4 Nov 2019 19:43:04 +0000 (GMT)
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <20191104173654.30125-4-alex.bennee@linaro.org>
 <36d0d305-01f8-3604-79df-24ec7cd1843c@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v1 3/6] tests/vm: use console_consume for netbsd
In-reply-to: <36d0d305-01f8-3604-79df-24ec7cd1843c@redhat.com>
Date: Mon, 04 Nov 2019 19:43:04 +0000
Message-ID: <87lfsvjulz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, f4bug@amsat.org,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Alex,
>
> On 11/4/19 6:36 PM, Alex Benn=C3=A9e wrote:
>> From: Gerd Hoffmann <kraxel@redhat.com>
>> Use new helper to read all pending console output,
>> not just a single char.  Unblocks installer boot.
>
> Again, why not use this by default for everything?

I thought that has already got merged via other updates. Will double
check.

>
> Anyway,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Message-Id: <20191031085306.28888-4-kraxel@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/vm/netbsd | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
>> index 5e04dcd9b16..d1bccccfd01 100755
>> --- a/tests/vm/netbsd
>> +++ b/tests/vm/netbsd
>> @@ -93,7 +93,7 @@ class NetBSDVM(basevm.BaseVM):
>>           for char in list("5consdev com0\n"):
>>               time.sleep(0.2)
>>               self.console_send(char)
>> -            self.console_wait("")
>> +            self.console_consume()
>>           self.console_wait_send("> ", "boot\n")
>>             self.console_wait_send("Terminal type",
>> "xterm\n")
>>


--
Alex Benn=C3=A9e

