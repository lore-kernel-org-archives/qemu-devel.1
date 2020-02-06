Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B49C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D45220838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JystRIJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D45220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjcf-0006pj-EO
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izjbM-0005pM-Uh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izjbL-0005T7-0F
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:02:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izjbK-0005PU-Re
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581004918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxFLV35j4CcHC9+3pCHa6yK4aiE3YuvgOAPAM7jEx8Q=;
 b=JystRIJvyhBDqTKjF8dukLmby3zvjNGzmwREklHwpUEJve7z0oJcejivfO8FjgkjNpFpK0
 QcC12G/HsmSu3pUhh2nEqOce01iV8UR5GJMuu6a6oaZz8zAqaXySgs9aZX4sK412Xdofjt
 Mq2QccUTy0Eu4qrDaT95Wxhiwjb1yL0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-yjgh55NjOF2ZqXU3GUBqgw-1; Thu, 06 Feb 2020 11:01:41 -0500
Received: by mail-wr1-f69.google.com with SMTP id 90so3670177wrq.6
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 08:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UxFLV35j4CcHC9+3pCHa6yK4aiE3YuvgOAPAM7jEx8Q=;
 b=cnE+Nj4//pV3bUW5eRmo4Tmq99DfvYfUytgA+vxsKjvytkHsrPEfIssxSXJNJmFXrA
 ThSWz5L74lqw5AzH0tjsLoI1vCwlMZLCtCr57+LtN4u/srdjxJgfOigK1uJHTN8BbsNm
 P4moKLuR68X/JHk6kdHFDYOu6lwP11b0dbYcaXEBMpAhRJ0PNEPFnOuqV/jMv+k0DzFC
 PdiDXFSKWxJPnyJDWbjEt6b/iRY9uPToZLkuY6ZDibvbUiwYuVu8IS/1utG8P8lHg/td
 PdtEpHwuS4bX+hA/1rxpnKBEQ/Ksv7EUDDWy9SAdGvibGcIwcK0o+Mr68mGrjFTgVE3u
 s5IA==
X-Gm-Message-State: APjAAAWhqrWErN/x0huTsOUpcKhNB6CIQ8XGlgwRMzHi/SbTecNlhEkz
 bZdqnEZyeN6z9sKq403Ac5tIibbcep8MLsQf8PdltJze0RsBTV36TIi5nGYsK34yi9jOtydvOLb
 gfXwBLnw+79yOPcE=
X-Received: by 2002:adf:dd52:: with SMTP id u18mr4400514wrm.131.1581004900363; 
 Thu, 06 Feb 2020 08:01:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqyxFRUmnHWBbLV1f5xLUuGxgaZe7VPA5b5812y/NAoxQyCVM/dS9Js6LWwlRT0jGjmJdyG4HA==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr4400489wrm.131.1581004900131; 
 Thu, 06 Feb 2020 08:01:40 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y131sm4313021wmc.13.2020.02.06.08.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 08:01:39 -0800 (PST)
Subject: Re: [PATCH v3 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
References: <158099477921.19404.14812857642999580348@a1bbccc8075a>
 <d835601e-9995-e69f-dad0-6a4a7c8b24f6@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <37536446-4bc2-a43f-a016-24dd6cd918a1@redhat.com>
Date: Thu, 6 Feb 2020 17:01:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d835601e-9995-e69f-dad0-6a4a7c8b24f6@gmx.com>
Content-Language: en-US
X-MC-Unique: yjgh55NjOF2ZqXU3GUBqgw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: patchew-devel@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com,
 slp@redhat.com, pbonzini@redhat.com, max@m00nbsd.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 2:21 PM, Kamil Rytarowski wrote:
> Am I supposed to do something with this or is this an issue in a script?

I think either storage full or network failure.

> On 06.02.2020 14:13, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20200206115731.13552-1-n54@gmx.com/
>>
>>
>>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
>>
>> Subject: [PATCH v3 0/4] Implements the NetBSD Virtual Machine Monitor accelerator
>> Message-id: 20200206115731.13552-1-n54@gmx.com
>> Type: series
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> git rev-parse base > /dev/null || exit 0
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>> git config --local diff.algorithm histogram
>> ./scripts/checkpatch.pl --mailback base..
>> === TEST SCRIPT END ===
>>
>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>> fatal: git fetch_pack: expected ACK/NAK, got 'ERR upload-pack: not our ref 1c298dad3d820f7a2161054ff581cf2fa65ee1b4'
>> fatal: The remote end hung up unexpectedly
>> error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384
>> Traceback (most recent call last):
>>    File "patchew-tester/src/patchew-cli", line 521, in test_one
>>      git_clone_repo(clone, r["repo"], r["head"], logf, True)
>>    File "patchew-tester/src/patchew-cli", line 48, in git_clone_repo
>>      stdout=logf, stderr=logf)
>>    File "/opt/rh/rh-python36/root/usr/lib64/python3.6/subprocess.py", line 291, in check_call
>>      raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f', '--mirror=fetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384', 'https://github.com/patchew-project/qemu']' returned non-zero exit status 1.
>>
>>
>>
>> The full log is available at
>> http://patchew.org/logs/20200206115731.13552-1-n54@gmx.com/testing.checkpatch/?type=message.


