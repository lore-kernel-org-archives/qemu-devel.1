Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2286CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13A122224
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYLz7vjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13A122224
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvJYG-0008JB-5U
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 07:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvJXT-0007lE-In; Tue, 14 Jul 2020 07:56:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvJXS-0003i9-2o; Tue, 14 Jul 2020 07:55:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id z2so21100780wrp.2;
 Tue, 14 Jul 2020 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=p4m2ZOzIyPSL2/rHaH7le3Am/4eMEoYZvIFijH3lXiE=;
 b=jYLz7vjrH/sHuDQpLem48wz+1BxKsCLjiDvpJKm4KkNFvpWg/hvjDxWYfYThf/FIjY
 XzIdEyruy48Z+4xcS9s1HONKfSzKLqdWu4D5P2C2Pzbe49wCyeC2oMda6iYF1JDYmp6i
 AVylQjQUsUJugS+W/xNIDB6aZC32BDpokvANk7cNtkHq1lC4MU7mT8AIMtbagcrPVu6P
 bZk5BkyypNIVi8OlRwco+kOnvEybkB7xEtGaaYZBaVJ+kzgT3HWeWQlNfZ8BZFF6Es/s
 nRVXM3za6LjCcYruOdGDUAKat94TxDhTqv76Et+55E3KkKRFfm0QvUzj3GIyiXWzSd9e
 vP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p4m2ZOzIyPSL2/rHaH7le3Am/4eMEoYZvIFijH3lXiE=;
 b=ZvUC51IDFu4rBbgcGgIgFdHbDCyHPZwuGK/VfhwXHcqWArG1h4GTidFcsHJSIAQzgX
 l5WHcNS15io0FD/AAJ6HqjrTFyHyXmUOlSmNHQYh70VIQg4Zy71Vg5TwW76U3qI8IxTb
 +Rhkqlyjc/UN/bi3E20/9+3b9a0zdBFG8o3tF1+DPEOpkVSgmrxPdKkcNRlHXHanUHBA
 6yQNgAiYVpu4f0EpiphR/IdSpsZFLcCf+RwRrABjzsXW3ccLGlmDkUV7wKKxHme8B43o
 h0sTAA6eTguVA87x+c4bKMBChxgMnkY0eFqKNpgKrz48I5ULK/JFEY70H2D75snd7N4l
 INVQ==
X-Gm-Message-State: AOAM530c213JpE00snz71waF4RDzW95up9XmcXkghBKf/vbmP+EhUR5Z
 1kQaGTtBctunjHdZVbbloNE=
X-Google-Smtp-Source: ABdhPJzR6wjMEzGI4uUm4MsqGJHgwj1ancTW38mlmkdU0/89pIvHqtOkzs59TIJmNAKoRaaw7PzLbA==
X-Received: by 2002:a5d:6a07:: with SMTP id m7mr4979340wru.324.1594727756212; 
 Tue, 14 Jul 2020 04:55:56 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 14sm3906004wmk.19.2020.07.14.04.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 04:55:55 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] tests/acceptance/boot_linux: Expand SD card image
 to power of 2
To: Cleber Rosa <crosa@redhat.com>
References: <20200713183209.26308-1-f4bug@amsat.org>
 <20200713183209.26308-5-f4bug@amsat.org>
 <20200714032226.GE2983508@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2ad539ee-f23f-f3d5-4c2a-3962d6f0977f@amsat.org>
Date: Tue, 14 Jul 2020 13:55:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714032226.GE2983508@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 5:22 AM, Cleber Rosa wrote:
> On Mon, Jul 13, 2020 at 08:32:04PM +0200, Philippe Mathieu-Daudé wrote:
>> In few commits we won't allow SD card images with invalid size
>> (not aligned to a power of 2). Prepare the tests: add the
>> pow2ceil() and image_pow2ceil_expand() methods and resize the
>> images (expanding) of the tests using SD cards.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Since v1: Addressed review comments
>> - truncate -> expand reword (Alistair Francis)
>> - expand after uncompress (Niek Linnenbank)
>> ---
>>  tests/acceptance/boot_linux_console.py | 27 +++++++++++++++++---------
>>  1 file changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> index b7e8858c2d..8f2a6aa8a4 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -28,6 +28,18 @@
>>  except CmdNotFoundError:
>>      P7ZIP_AVAILABLE = False
>>  
>> +# round up to next power of 2
>> +def pow2ceil(x):
>> +    return 1 if x == 0 else 2**(x - 1).bit_length()
>> +
> 
> Nitpick: turn the comment into a docstring.

OK will do.

> Then, I was going to have a second nitpick about the method name, but
> realized it was following qemu-common.h's implementation.
> 
>> +# expand file size to next power of 2
>> +def image_pow2ceil_expand(path):
>> +        size = os.path.getsize(path)
>> +        size_aligned = pow2ceil(size)
>> +        if size != size_aligned:
>> +            with open(path, 'ab+') as fd:
>> +                fd.truncate(size_aligned)
>> +
> 
> Same nitpick comment about comment -> docstring here.
> 
> Either way,
> 
> Reviewed-by: Cleber Rosa <crosa@redhat.com>

Thanks!

Phil.

