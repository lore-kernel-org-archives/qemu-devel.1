Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F695C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E45D20857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b5pcK9/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E45D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXG8-0003Fm-65
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX8q-0006br-3k
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX88-0001bf-Ix
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:59:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUX88-0001bH-5h
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:59:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id l18so1071046wrn.6
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jhRrDGgSU7B1ej4BGuESZi1Y5JLg1v4AM68D5nCSdFU=;
 b=b5pcK9/tFPLXPPXpTTvaMMcj0fm/TqhVox2/eRNrzsgXjqjLlJmlaTacqYKSGFrUj1
 eZxi2N4cC7mlcf22nsBYMTibKndOP4z5eakWzCfS1oV9MTyRKVG7qVse+khOGpXBC8wd
 GVTno3rruY/MA9MG3xXK/uXqFy0daxola2xLrwVFQ3g1H1FBwfk25fNQlQUit++/+R35
 VR+D4IXZcSnSah2XzZjGMRc4tKdcxtpJ8IMUHCJUYgjAp1X95Y9V/1wAC6JelFGVdksn
 KMXJ4vHSJSEIKwIKSCc3ZUFKXn5pTroykzNR39ByUiymofabOK0mmfHceqU4n9o43WvE
 5KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jhRrDGgSU7B1ej4BGuESZi1Y5JLg1v4AM68D5nCSdFU=;
 b=j4z1fctH8BSBhTNy3hn0S60UBcAFBwCbMhA+g/mbVMFoBAwOm51hg533biUB8+PLmd
 e8jS4iNlLMkrhslUIwfY4nccvQOayuzZvLwfsGejXpOtY1xKuI9MKcyWG2EAg78BXybD
 U/cCwA/5gPNfGM0NbhTdpFHXQvmfm+PsRrRRNogMDo/U8puet7GZjuhT/dAj412kJ734
 iAAQdO+vF13cq7nEuf50uGwq3KesQ6LP018/88bqpAcCSL8oYkREiErOS297Im/OZPHJ
 v3HfKtl7MHOyfhr5pbCWNkrcINdw9iQqesvKHJI4FiWVLR9MhKSprKr6rYBZpXVinWO2
 mbQA==
X-Gm-Message-State: AGi0PuZjiQmvr7OmafHqyPFd4BM0QOvfXFIqZJGTXFsbUdXUw3lrU7hE
 YBnJuDASfgHwc54C6mX28ReKwg==
X-Google-Smtp-Source: APiQypKRNifZD3tKagpYZOTOeKb0oWoxqlIc0GxkfIfHHl5fBSCC/Tw415xRWL63+vzTCfAjvFWSWQ==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr4617198wrw.228.1588345146680; 
 Fri, 01 May 2020 07:59:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g6sm4901472wrw.34.2020.05.01.07.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 07:59:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A24481FF7E;
 Fri,  1 May 2020 15:59:04 +0100 (BST)
References: <20200430190122.4592-1-alex.bennee@linaro.org>
 <20200430190122.4592-8-alex.bennee@linaro.org>
 <274b5e0f-f95f-a15a-2b54-4d8c3c7576bc@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 7/9] tests/guest-debug: use the unix socket for
 linux-user tests
In-reply-to: <274b5e0f-f95f-a15a-2b54-4d8c3c7576bc@linaro.org>
Date: Fri, 01 May 2020 15:59:04 +0100
Message-ID: <87sggjitvr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/30/20 12:01 PM, Alex Benn=C3=A9e wrote:
>> +    if "system" in args.qemu:
>> +        gdb_cmd +=3D " -ex 'target remote localhost:1234'"
>> +    else:
>> +        gdb_cmd +=3D " -ex 'target remote %s'" % (socket_name)
>
> Why should not system testing be moved to sockets?
> Surely that has the same problem in the end.

Sure - I can cook up a patch for that. I hadn't bothered because
currently we don't run any system level debug tests for the gdbstub
test.

--=20
Alex Benn=C3=A9e

