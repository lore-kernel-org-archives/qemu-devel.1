Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69828C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ECF20732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4o0Abqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ECF20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnR7Z-00053J-D0
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnR6M-0004BZ-9w
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:23:26 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnR6J-0006ZA-Tq
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:23:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id a6so15716641wrm.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3V/aEamdd1N9VTaMBbiv286XoNvjhToyRxQ/Rr6dphM=;
 b=b4o0AbqshxUldZHuFqfWn2BWPhnZHS9Ae5fPwjaPpR8a2FHk/eIwCtLHaHQWGql2bL
 dgFc/TgXtyhNn1XnVyxISzGEgsynJIFcUEcyNqSIC7ooLWSBr2BQs+GgS3lKH3ERcgan
 jQg+in9Xnx1Q3Dx/VIu3tJRa/OXIfvy28agPHE6b5ZxVGHJ9B35Rfnr/8xoMkq/Ykh4o
 Skvg6CxA3Jjhbq2Hv2kcLp/wEizkh8wqFGH83p2CSFoje6JpthkBKyNCauO/TgvPDKa4
 Y7HaVjx5/7exXj502ipgOxnrWnCaZ0H2D1QUEOUaS3Rcvq/QlsiBCriKC7SaJ+E1QAHT
 nc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3V/aEamdd1N9VTaMBbiv286XoNvjhToyRxQ/Rr6dphM=;
 b=lrlNLVwV9pc2TyoGr3PDAl+mSMoDCbXrUjO01EtxU2x1cJG712ggJ9kxvCIDc+XaOk
 H8Zhprl+FYEYDt8gw8masA9Ahs1fol8ejeQ85Gx6kU7/UZq6YVESofrw3gMTp9Bj/yPt
 D5sNkXgUx5N8qXkjXxxu/ZHLwIMMuV2HL/W2g2anUs1XEsEx7jIej7+5BnE5iJ3cTX4D
 AUzrAAljkHViJLAHf7R5qT0drT9EDFwb+NYbWPyfHv8A6Zmw6+460ZmmuiWjdN3ZTji1
 DyYptq49DWnEuVqbFm2IbjDC20NNSNnMP2XzoDHiaR/UHeiKHB0MzanxHS/EVR47t2d1
 Bxpg==
X-Gm-Message-State: AOAM5311unizuHLJJRkicw0DjIZnFVm5AWw4bQa2zROvhRbRQ+KFa4RI
 lmU1mtmxnZ4jerd0ibXrM3ZjVA==
X-Google-Smtp-Source: ABdhPJwGcUecJOAimEVh/Ks7sgznKj1wsdlzKYOBuBGNkbEazZDBsH3IpumZzaZM4bIQNtSYeaUKiA==
X-Received: by 2002:a05:6000:12c8:: with SMTP id
 l8mr21045216wrx.148.1592850202266; 
 Mon, 22 Jun 2020 11:23:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u65sm482920wmg.5.2020.06.22.11.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 11:23:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 588B71FF7E;
 Mon, 22 Jun 2020 19:23:20 +0100 (BST)
References: <20200622143204.12921-1-alex.bennee@linaro.org>
 <20200622143204.12921-2-alex.bennee@linaro.org>
 <9ad1234e-bbb7-9396-21e1-58041cffd847@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 01/18] iotests: Fix 051 output after
 qdev_init_nofail() removal
In-reply-to: <9ad1234e-bbb7-9396-21e1-58041cffd847@redhat.com>
Date: Mon, 22 Jun 2020 19:23:20 +0100
Message-ID: <87d05r9cyv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com, "open list:Block
 layer core" <qemu-block@nongnu.org>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, cota@braap.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> On 6/22/20 10:31 AM, Alex Benn=C3=A9e wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>=20
>> Commit 96927c744 replaced qdev_init_nofail() call by
>> isa_realize_and_unref() which has a different error
>> message. Update the test output accordingly.
>>=20
>> Gitlab CI error after merging b77b5b3dc7:
>> https://gitlab.com/qemu-project/qemu/-/jobs/597414772#L4375
>>=20
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20200616154949.6586-1-philmd@redhat.com>
>> ---
>>  tests/qemu-iotests/051.pc.out | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.o=
ut
>> index 0ea80d35f0e..da8ad871876 100644
>> --- a/tests/qemu-iotests/051.pc.out
>> +++ b/tests/qemu-iotests/051.pc.out
>> @@ -142,7 +142,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
>>=20=20
>>  Testing: -drive if=3Dide
>>  QEMU X.Y.Z monitor - type 'help' for more information
>> -(qemu) QEMU_PROG: Initialization of device ide-hd failed: Device needs =
media, but drive is empty
>> +(qemu) QEMU_PROG: Device needs media, but drive is empty
>>=20=20
>>  Testing: -drive if=3Dvirtio
>>  QEMU X.Y.Z monitor - type 'help' for more information
>> @@ -214,7 +214,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
>>=20=20
>>  Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dide,readonly=3Don
>>  QEMU X.Y.Z monitor - type 'help' for more information
>> -(qemu) QEMU_PROG: Initialization of device ide-hd failed: Block node is=
 read-only
>> +(qemu) QEMU_PROG: Block node is read-only
>>=20=20
>>  Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dvirtio,readonly=3Don
>>  QEMU X.Y.Z monitor - type 'help' for more information
>>=20
>
> Just ran into this and wrote an identical fix. The error is not in
> 051.out so the pc-only fix appears to be fine.
>
> Reviewed-by: John Snow <jsnow@redhat.com>
>
> (There seem to be other problems with the CI at the moment, but the
> failures I am seeing are not related to this, so I think it's probably fi=
ne)

It's queued via Max's tree - it's just easier to keep them in
testing/next while I'm testing. I assume his PR will beat the eventual
PR from this.

--=20
Alex Benn=C3=A9e

