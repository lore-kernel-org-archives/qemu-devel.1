Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD0DC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAF52072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpqoWDAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAF52072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWrl-0001qB-2P
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipWqb-0000YO-TH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipWqa-0004Dm-IO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:23:33 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipWqa-000474-44
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:23:32 -0500
Received: by mail-wm1-x344.google.com with SMTP id a5so2707856wmb.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8CPuEeEaqGc2RqUiQ2NusGO9fchaWLO+gexRuq4+2pg=;
 b=fpqoWDAxORFzY8hLnpa92F/A4/++ilnnCjm/hij/b8gBdjrDudYwXC9fnk0Cfgkjjk
 ZtElZeTAatf6aKermHhiWJDJ3gzBLOMwtLdHX+nyoGOvvkODQ1p4SyUpd0PG2E7k+OXZ
 sZ66q0U3E4cYmn7gjkssTmRf8iLtDf+QPhZ1FJjuHJsdnZJcj+snZ5Ah5EXiJkEvr9Ld
 E+ilcxRkA6R62DgKy9IDLUcTEZUZxyN1Hu1WlukLLOpY6W8fsRr86qNO7ykxgqLMqTeU
 HqPeLVB4osfTVEDBqnyYXvZuRuSb/UD2g3lfMTfp1CNoHVyukg4sgl9CY5pToWudexDh
 chZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8CPuEeEaqGc2RqUiQ2NusGO9fchaWLO+gexRuq4+2pg=;
 b=AgqD/LahZstALHWwLCODMthYbh0aLKz2C66O005MmV/12Wb/Fbx1gLqE31LKqgRHvN
 1jqbt/uTu+yIDqCVWU0tL/kOK9vDz4axK56b1EMRi41VVg3MEdP6XfZ/lRd4xb00GqRy
 naEdDHjSWhJceYTKLiZvnTOBTVc24AMfykgLM0ghboqJc99eCtxGWeaPFtEKepYUZQr/
 AM4xlerzL+9OAKF5XwuinxFju5ob9H+xanC9C4RDfdli8C1DVJhPWkRc1024plgBa+NW
 EcSsdgGTYfG2cL2Fj0hcEqfhwFu+m9L8AEHZn9M2rtooP/ZKfs6+wwIsjm9SOZUFKf72
 sQ/A==
X-Gm-Message-State: APjAAAV76bMokcdy/wRjrO9N5zPT6s4Gt9fgKukSNBXuoFt7plpRtooo
 IO9gniRJZhlF6p8MMdb0QZxogA==
X-Google-Smtp-Source: APXvYqxgzrGzjhgOV2a5TI2kkTDVGqqYuMlQCWMh5k0ZgGk2/xe977mY8MIgiblTBinC9X6GQ6G6uw==
X-Received: by 2002:a1c:640a:: with SMTP id y10mr4728783wmb.14.1578572610645; 
 Thu, 09 Jan 2020 04:23:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w20sm2714121wmk.34.2020.01.09.04.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 04:23:29 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 908021FF87;
 Thu,  9 Jan 2020 12:23:28 +0000 (GMT)
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <157709445117.12933.4203495154518338251.stgit@pasha-Precision-3630-Tower>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Subject: Re: [for-5.0 PATCH 05/11] replay: introduce info hmp/qmp command
In-reply-to: <157709445117.12933.4203495154518338251.stgit@pasha-Precision-3630-Tower>
Date: Thu, 09 Jan 2020 12:23:28 +0000
Message-ID: <87k160izsv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, mreitz@redhat.com, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgaluk@gmail.com> writes:

> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> This patch introduces 'info replay' monitor command and
> corresponding qmp request.
> These commands request the current record/replay mode, replay log file
> name, and the instruction count (number of recorded/replayed
> instructions).  The instruction count can be used with the
> replay_seek/replay_break commands added in the next two patches.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>

diff --git a/replay/Makefile.objs b/replay/Makefile.objs
index 939be964a9..f847c5c023 100644
--- a/replay/Makefile.objs
+++ b/replay/Makefile.objs
@@ -8,3 +8,4 @@ common-obj-y +=3D replay-snapshot.o
 common-obj-y +=3D replay-net.o
 common-obj-y +=3D replay-audio.o
 common-obj-y +=3D replay-random.o
+common-obj-y +=3D replay-debugging.o

this has a minor merge conflict. I seem to be missing replay-random.

--=20
Alex Benn=C3=A9e

