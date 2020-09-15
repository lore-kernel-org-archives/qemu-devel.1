Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9F1C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD0C2078D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmpvkU4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD0C2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI7Ay-0005YB-4W
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 05:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kI7AK-00059M-E4
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 05:22:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kI7AI-0002ah-Oi
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 05:22:20 -0400
Received: by mail-wm1-x344.google.com with SMTP id b79so2667946wmb.4
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 02:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4R00cSkZL7zXpckeEA6kq6+ZOwDHV5SDpKEbMIJMfO8=;
 b=XmpvkU4UQGAdCiVgSglsIgFLoHircv3B2nkJ1p2DlHTNT+TwhqwyweKD+ci4/kCE3r
 YojHwwpjIo5JDmOf5BqG4reQjYD4D8SVZ31D7ZCmdn60caaURh6xbWZH1EHGuRTdg8+M
 mssSgxG6RYTnHE9jyDfo58WRHAFhsJP8tQRkw1D2fJNEkMQBhrC3gdQFIZXlgr3MSSZ2
 vhroDyutgS6STz9Mfhq+lbjk8QdupHRiwKXZM1U0aXrbGJdOAdxSeiBxfHZwXHe0tsOO
 sRBd8vtCznd604j+i3UqbZOrIWceguAXFolK6vgXkG+zIDNx4II//dSCRjZfBZ2mbhEy
 3O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4R00cSkZL7zXpckeEA6kq6+ZOwDHV5SDpKEbMIJMfO8=;
 b=V79SA0JKubm9bYZE60y5lmDZrzUGCUhshr1OZz2A5O6oDAFTfVS4dA4PNMXcgcA8Xy
 G7ox/F3Ps0emCMIhf3KRByIAtITvkKMR8Cnov8Ucdaiieln5ZZbp26llfjZSwTXijmpB
 /iTituSIk0P5Vac4MGQEIr6eaP8IEi8fC5Tp1Yht0dPwDEETq7PM1jGiKuXJs4yOViK0
 sgqiWbiIZ554ADqKlq/pXtvAAsIFFlrvYNDZroB6hfr7sNCJLKWrb2QYHicfqU/jlYt/
 9DzZOc9S5DrzUWHIh8OtXm+Vl49/GTN37/+adl+b2Dw6v1EH1EOGS4B0tqE2rISxCk9N
 pSfw==
X-Gm-Message-State: AOAM53240wtmvcEPWfr5dtO20a+TMH8fvJh9ohoO3RII4lcf+ERvNSJ3
 oeYdhQR0kMQvE9yEnBdH8eH17Q==
X-Google-Smtp-Source: ABdhPJyTPU36nbibYXtfui3ger020tWFnc6n0vYbyL7Q+5Fy4MAMxrjRlfniimvVaaMGBNyGRbjyQw==
X-Received: by 2002:a1c:7508:: with SMTP id o8mr3499820wmc.127.1600161736881; 
 Tue, 15 Sep 2020 02:22:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d5sm26430702wrb.28.2020.09.15.02.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 02:22:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2540F1FF7E;
 Tue, 15 Sep 2020 10:22:15 +0100 (BST)
References: <20200914150716.10501-1-alex.bennee@linaro.org>
 <20200914150716.10501-4-alex.bennee@linaro.org>
 <CAFEAcA9dCDfFTNsxYR2fpVfQYiNd6T-iLpQyfQAWayo2Mc0buA@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 3/6] configure: also skip deprecated targets with
 target-list-exclude
In-reply-to: <CAFEAcA9dCDfFTNsxYR2fpVfQYiNd6T-iLpQyfQAWayo2Mc0buA@mail.gmail.com>
Date: Tue, 15 Sep 2020 10:22:15 +0100
Message-ID: <875z8f1jjs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 14 Sep 2020 at 16:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Now the user has to make an even more deliberate decision to
>> enable a deprecated target rather than getting it as a side effect of
>> using --target-exclude-list.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  configure | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/configure b/configure
>> index e365a90cc133..50052378e417 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1722,9 +1722,15 @@ if [ "$bsd_user" =3D "yes" ]; then
>>      mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-bsd-user.m=
ak"
>>  fi
>>
>> -if test -z "$target_list_exclude" -a -z "$target_list"; then
>> -    # if the user doesn't specify anything lets skip deprecating stuff
>> -    target_list_exclude=3Dppc64abi32-linux-user
>> +# If the user doesn't explicitly specify a deprecated target we will
>> +# skip it.
>> +if test -z "$target_list"; then
>> +    deprecated_targets_list=3Dppc64abi32-linux-user
>
> If you put this variable setting outside the if...
>
>> +    if test -z "$target_list_exclude"; then
>> +        target_list_exclude=3D"$deprecated_targets_list"
>> +    else
>> +        target_list_exclude=3D"$target_list_exclude,$deprecated_targets=
_list"
>> +    fi
>>  fi
>>
>>  exclude_list=3D$(echo "$target_list_exclude" | sed -e 's/,/ /g')
>
> then later on once we've parsed the exclude list and set
> default_target_list we can say something like (untested!)
>
> for dep_target in $(echo "$deprecated_targets_list" | sed -e 's/,/ /g'); =
do
>     for target in $default_target_list; do
>         if "$dep_target" =3D "target"; then
>             add_to deprecated_features $target
>             break
>         fi
>     done
> done
>
> and then the only thing necessary to add another deprecated target
> will be to add it to the variable (ie we can just delete the
> add_to line your patch 2 puts in as we don't need to modify
> that code at all any more).

That makes sense - actually I think we can do:

    # if a deprecated target is enabled we note it here
    if echo "$deprecated_targets_list" | grep -q "$1"; then
        add_to deprecated_features $1
    fi

just before test "$tcg" =3D "yes" && return 0 in supported_target.

>
> (Side note: I just followed the code we have currently for
> doing the "is the target in the exclude list" but this
> seems tremendously clunky given we're really just trying
> to ask "is string X in set Y"...)

Yeah that can be cleaned up.

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

