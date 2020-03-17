Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D33FC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F52206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8QuB7dW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F52206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8oO-0003KP-1d
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jE8ne-0002k8-Ak
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jE8nd-0001yZ-1g
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:46:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jE8nc-0001tb-Pl
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:46:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id s1so2990277wrv.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YaZb90/IWpQuItwXcKzvr0yr1YWTc84HF4O4RnLII+0=;
 b=X8QuB7dWGmpa7eGUHWVozwTZ48dXGJHJ83irVvXvEUfBbSatym5dmObWyxvUp1CJfu
 XXtbbtXzqDI458dqImoqZTh7YYU3yG8YuJS4+BQJP3tlIhrx9bghqriZTzs1GlDmQ/Q/
 kD8W4gtUucQHtZk3btoJGdVEpUiJm4M5OZiY+gFw1WQGJ31IT6P1dJXrhfOm9cdlXOam
 oett1BGKJ8mqZOD3MPtfp8JWp0OgVuIrNkuz8BQ9sgrBAUbjTzYXiPxdht9hyxVmX9f9
 8GgskM3le+hrGnEfEEKBYUKwReFVtls/a26E658mBFGV8GFiMcvceq8Uqkxq92Yb2fbs
 546A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YaZb90/IWpQuItwXcKzvr0yr1YWTc84HF4O4RnLII+0=;
 b=XEp41WEo9ZslGwRyo8YkXky5ju14bqiV+4MHhqQ+qmiySj0R1Tmj3Lj4V1+4FIzDJE
 H9q2hkoRUzmMFSMI7eG8hbVcAyR5uy97MbURcseRBkTovBHT6dEQLv5tRXIIYKmX4rOf
 kydnVTmI2hN3h+R+r87VqREfYi35VDZ1+dDvlWonuf54WkduSUUsyqK8kX+3EwZ+B9y2
 psXVCFAOCbRMS8GxqTtVOdGjAN+TgLlnVqxswpLv0XRn4ssf/KRX8T37MP05Zqo3dfxE
 hunJ2EFAZ2OHUJ10ZsF+B3Df8/VIvFX1JYzGZuK3FFhSTRX9yQ8DoqlUc4Mkf9jmTlDB
 buRA==
X-Gm-Message-State: ANhLgQ3r9+CR+DFahh7QXrJnKtHtcgvimcQwY6n6g8J01ZUxQaMVkByV
 eRXJ3+R+wBC03rYXjs1C56EYQg==
X-Google-Smtp-Source: ADFU+vtpPaSlm7VA32dY/rzSiuNjSJVN207XikG9ESv29U0/IhrRX/u2NSYMMptVubfLHOsjL3hPwg==
X-Received: by 2002:adf:e98c:: with SMTP id h12mr5221244wrm.345.1584438371083; 
 Tue, 17 Mar 2020 02:46:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x24sm3160071wmc.36.2020.03.17.02.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 02:46:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D9A141FF7E;
 Tue, 17 Mar 2020 09:46:08 +0000 (GMT)
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-22-alex.bennee@linaro.org>
 <CAFEAcA-x5L8=csd5tYYEwTaE2wb-8d9qcbaF3A9G2bC0vOOhhg@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 21/28] configure: allow user to specify what gdb to use
In-reply-to: <CAFEAcA-x5L8=csd5tYYEwTaE2wb-8d9qcbaF3A9G2bC0vOOhhg@mail.gmail.com>
Date: Tue, 17 Mar 2020 09:46:08 +0000
Message-ID: <87r1xrjov3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 16 Mar 2020 at 18:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> This is useful, especially when testing relatively new gdbstub
>> features that might not be in distro packages yet.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  configure | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/configure b/configure
>> index eb49bb6680c..6724158fde1 100755
>> --- a/configure
>> +++ b/configure
>> @@ -303,6 +303,7 @@ libs_qga=3D""
>>  debug_info=3D"yes"
>>  stack_protector=3D""
>>  use_containers=3D"yes"
>> +gdb_bin=3D$(command -v "gdb")
>>
>>  if test -e "$source_path/.git"
>>  then
>> @@ -1588,6 +1589,8 @@ for opt do
>>    ;;
>>    --disable-fuzzing) fuzzing=3Dno
>>    ;;
>> +  --with-gdb=3D*) gdb_bin=3D"$optarg"
>> +  ;;
>>    *)
>>        echo "ERROR: unknown option $opt"
>>        echo "Try '$0 --help' for more information"
>> @@ -1773,6 +1776,7 @@ Advanced options (experts only):
>>    --enable-plugins
>>                             enable plugins via shared library loading
>>    --disable-containers     don't use containers for cross-building
>> +  --with-gdb=3DGBB-path      gdb to use for gdbstub tests [$gdb_bin]
>
> s/GBB/GDB/. (Also, the only other program we pass to configure
> with "--with-foo=3D" is git; for make, install, python, sphinx-build,
> smbd, iasl, cc, gcov we just use "--foo=3D".)

Alright I'll fix that up in the PR.

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

