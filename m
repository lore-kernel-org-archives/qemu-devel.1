Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890B0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBEB2068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="gEjSSEus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBEB2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAaO-0007Dd-I7
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chouteau@adacore.com>)
 id 1jgAZo-0006m2-1c
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:19:48 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d]:43687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chouteau@adacore.com>)
 id 1jgAZm-0002P8-VK
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:19:47 -0400
Received: by mail-io1-xd2d.google.com with SMTP id h4so8376011iob.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=naT145SaWxXJx4cfmQmrA0LvsRtIewFrmKNYrZxFSgw=;
 b=gEjSSEus1xPNEmC3jti7++EKMhZAi12+HIuhH1hz6ekOz+sFWeaAyvhvUnlmuGxQAC
 1wRtyBXdm+ztV52OsQPSZ8auNosyTTplHKA9IqeW9xJtHzILVFbgxoj2PZ3fGnJSCofI
 8Omc53SgLmyVcGaiZopLRJ1Yj+aBkuhcR5OUNpmBmwNJglMIHXDEGkuYcJ092Gz63x9e
 VfmbBcL3lYAv8bkcqHdlMc6e4gpnhqj6kCkAqXa2YLzozPScyfWgdx9sfjVd04vorCrW
 +N6G/9ZTkKcYG08w7eC9OHhWPVUBs74ApYbQ4X+Alcvn02Emat9JJdnOHrBxtupNAVFH
 aSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=naT145SaWxXJx4cfmQmrA0LvsRtIewFrmKNYrZxFSgw=;
 b=bPgL0tahQf8uCAQ5E79eTNQiYLJ4+GUWTT1r08thTZX7h7jWH8kVUd4qG1h/MpVyH2
 UgdHMkRW6HaNtb4ROZCFqq2v0gZXKrBQj59ZFBUPcck6b+v8o2LFZMmk57Qc1qmuM5mt
 hF4mvbzPzM1iLY+W79Ii5MwADdKxOfXhLXkw9V1BALTmNr8opUGOVCtfVmfPT+G8pDlM
 rWW3OhBvK15u0yRbVSVXGtKiRdj2XMzOG7v3+n23XXk8oan64JCbz8fIrflAamF6eo4T
 Ov/Bk/PQu+fC0ugTcmX65OkRcO8vOL7JAZBVGySdrhkZKCZhMw5VOVQSMPHGg1yHxcRB
 HmqA==
X-Gm-Message-State: AOAM530WTooLNxqa0YYiZ3wC9dq32Kr5iptgdtyrUWk1DstrxGmDpFXf
 RDuTkeR8oqWB9IGqTwhmvEbOpMH7oWbvC4uAq158Yw==
X-Google-Smtp-Source: ABdhPJxr4NbeJ+k7h02ednpn5Kyhs3cTSsv4is9cm9d1bn0PzSbbtPFPz1N2EvIb3tXoZhZ5y43k6zkYCI1qFiCcevY=
X-Received: by 2002:a05:6638:d05:: with SMTP id
 q5mr25647189jaj.2.1591118385795; 
 Tue, 02 Jun 2020 10:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <CALQG_Wh7eMt9U3gWkZZGDq0RFvWfuSVoiNBRNnPS_cDVfUc30w@mail.gmail.com>
 <CAFEAcA_1+rDcjD7Lyk9ESSkPAKmJwF=0ZdwkgQYUDp8Gtn6jHA@mail.gmail.com>
In-Reply-To: <CAFEAcA_1+rDcjD7Lyk9ESSkPAKmJwF=0ZdwkgQYUDp8Gtn6jHA@mail.gmail.com>
From: Fabien Chouteau <chouteau@adacore.com>
Date: Tue, 2 Jun 2020 19:19:35 +0200
Message-ID: <CALQG_WgP=ZebEMrXh_EpQJXqJPi48i6nwZU_yWq7VqhV_=eTVQ@mail.gmail.com>
Subject: Re: gdbstub.c CPU clusters not handled for ThreadInfo packets
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=chouteau@adacore.com; helo=mail-io1-xd2d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you Peter,

Le mar. 2 juin 2020 =C3=A0 18:44, Peter Maydell <peter.maydell@linaro.org> =
a =C3=A9crit :
>
> By default gdb does not attach to all clusters (this is IIRC something
> that can't
> be influenced on the QEMU end);

You mean I cannot have QEMU attach all clusters by default?

> are you explicitly asking it to attach to the second cluster?

So far the behavior that we had was to see all the CPUs without asking
explicitly.
I want to go back to that behavior because the current situation is a
huge drawback for our users.

> https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg07035.html
> is a mailing list post from January which gives the gdb commands which
> ought to cause it to attach to the second cluster on this machine.

The commands:
        target extended-remote :1234
        add-inferior
        inferior 2
        attach 2
        set schedule-multiple
        info threads

Do not work for me, "attach 2" in GDB asks me to kill the debugged program.

Thanks for your help,

