Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE42C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 425A72087D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nxlrz0ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425A72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbno-0001jQ-CS
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFbmw-0001GW-1s
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:27:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFbmr-0008Co-LV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:27:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id j2so18711433wrx.7
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pQV6CrSIwspR/+hQrDd1u9yRA53VUf83tmXUTH4P02w=;
 b=Nxlrz0ahBxQXNHiA9/AenCUDXr6cT2AaWsqqiw3YOEc78h18hsAD5DXVrjwx3kjCqL
 m/PW3UKPpwNjwCamJCc+7dmPeslZgJPCbDE7rHxvW06iidPQ/HFI5890+Bq+1Owv131y
 ORFzIweXF0lJ5NUJSv+wrwuWZVtf6/MZnqyxSYLc3juYsRUcvaOygjCur0T+tMT/egt+
 Pv6F1AuFmMGB1J4yPC1rUBy0nOSwtv07s5dRR1K//3+Xg65E30t3tmb5+Ll5EX+h/G/8
 mV3/KZIxSv6iY44FUCzXUacPG9M5XxYiIaS2uW1q61msf2dx+EsTtIDIJ7H2yZKFeqNs
 CM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pQV6CrSIwspR/+hQrDd1u9yRA53VUf83tmXUTH4P02w=;
 b=V2TeQzyKl8oKkQKsbg3UjlJHZr5gC9P28B/TzbOrCy9kM9ibBSP7wbtraTtJGDYpK+
 QZYkR7Ma98VwI8vJcvEcIrw9EUAE9PvOt7VQV73VWou91two9vz0H0Ol5kN07HMnH8+x
 yDkQpun3klvlkLY6IUgg7RAL0KxtMYJJpVvR0jy9ymP0d294FRR4poSCnXDpIvp8eVzF
 CfoJHmWbqNHUvhQBYFCIxpnmgbVsEGzmPSjPvrHHQ1LBuGntLVYRz3wpQz6ypp0UOsAl
 0jbsw28zXBKKkU/TZl/3t5DGtBuvAZk6fZ/OWh2M/ElCKGAvPxmb5tIthn+t5SpN/d+p
 FCqg==
X-Gm-Message-State: AOAM530U0VW9vsaXAj+FNa4b/1UF6FTjnGzxOeW9a0ik3gJL7tD+X+yC
 59842YkrKuk6Yp+njqj5I/9c5A==
X-Google-Smtp-Source: ABdhPJx2HsZV/ETucLfOeojoKFx6oijKDv3AMHkaL42fkSkRi3dS+0i5EoNogzlChjfmdcVRJn8MyQ==
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr25498039wrw.379.1599564463807; 
 Tue, 08 Sep 2020 04:27:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s124sm32225794wme.29.2020.09.08.04.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 04:27:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E658F1FF7E;
 Tue,  8 Sep 2020 12:27:40 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903462227.28509.8201860642659050083.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 13/15] replay: describe reverse debugging in
 docs/replay.txt
In-reply-to: <159903462227.28509.8201860642659050083.stgit@pasha-ThinkPad-X280>
Date: Tue, 08 Sep 2020 12:27:40 +0100
Message-ID: <87wo14pkyb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> This patch updates the documentation and describes usage of the reverse
> debugging in QEMU+GDB.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> ---
>  docs/replay.txt |   33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Minor aside - it is probably worth having a separate patch to convert
this file into an .rst and put it in the docs/system folder so we can
properly incorporate it into the user documentation.=20

>
> diff --git a/docs/replay.txt b/docs/replay.txt
> index 70c27edb36..18d6169f3b 100644
> --- a/docs/replay.txt
> +++ b/docs/replay.txt
> @@ -294,6 +294,39 @@ for recording and replaying must contain identical n=
umber of ports in record
>  and replay modes, but their backends may differ.
>  E.g., '-serial stdio' in record mode, and '-serial null' in replay mode.
>=20=20
> +Reverse debugging
> +-----------------
> +
> +Reverse debugging allows "executing" the program in reverse direction.
> +GDB remote protocol supports "reverse step" and "reverse continue"
> +commands. The first one steps single instruction backwards in time,
> +and the second one finds the last breakpoint in the past.
> +
> +Recorded executions may be used to enable reverse debugging. QEMU can't
> +execute the code in backwards direction, but can load a snapshot and
> +replay forward to find the desired position or breakpoint.
> +
> +The following GDB commands are supported:
> + - reverse-stepi (or rsi) - step one instruction backwards
> + - reverse-continue (or rc) - find last breakpoint in the past
> +
> +Reverse step loads the nearest snapshot and replays the execution until
> +the required instruction is met.
> +
> +Reverse continue may include several passes of examining the execution
> +between the snapshots. Each of the passes include the following steps:
> + 1. loading the snapshot
> + 2. replaying to examine the breakpoints
> + 3. if breakpoint or watchpoint was met
> +    - loading the snaphot again
> +    - replaying to the required breakpoint
> + 4. else
> +    - proceeding to the p.1 with the earlier snapshot
> +
> +Therefore usage of the reverse debugging requires at least one snapshot
> +created in advance. See the "Snapshotting" section to learn about running
> +record/replay and creating the snapshot in these modes.

I would explicitly state you need:

  - a block device for storing VM snapshots (independent of storage
    devices you may have)
  - to specify the starting rrsnapshot in both the record and replay runs

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

