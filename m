Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70818C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36317214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwThZkXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36317214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgyM-0005mn-Br
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1izgug-0006XI-UC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1izgue-0003nW-Mt
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:09:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1izgue-0003mR-JD
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580994582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cvnhhp1Si3xknEBPVz11bbel1MZTEbtWZmS8ulphYwU=;
 b=iwThZkXbL4+NNMfE05ULsIcpcVLhwsLwKyt+x2i4FtSOGnKeJQJJiVVczj1SBfHTSj0ec7
 hjzf9RGYgV6ONBJ/eslmAI+lxTrozvNYenxilTQQwKWYMVvQp4TLKkpVOZNCROXixMEcsK
 JLCO56uk6OXWOQt+IMiqklyaumLboFI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-UkTMW7gyPvCqlK7DvdeeYQ-1; Thu, 06 Feb 2020 08:09:21 -0500
Received: by mail-wm1-f71.google.com with SMTP id b133so2609624wmb.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 05:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Cvnhhp1Si3xknEBPVz11bbel1MZTEbtWZmS8ulphYwU=;
 b=SWkmto8oXBGWpHXCnz7awFO+ur8gpznEoozqfyjrczxUgQSuRi4v6clZn/MTagJBdu
 5bSIkx50vljBIKOfxOuTqqW7uXH7Q16EjwhmnzqUkNGXWlnrO7cGjSWP8kXUk183VElG
 pJE65zMA09DGcpfpHAd5Y4ZohEWM/xnvzB7ra3/SztVIbE5HuIV8MIwDbs/vZtW8Zbj7
 T+YgJm4tNOkchvyTJDp3BqhO7Qh2lbzV1KCoZXYea+Mn0LVv+qxwA67EIiECUq9oWlE0
 px7k/kZ7a1fL32MHJphiB1Wdlpg8b8B0uWMFQ20+jpmUnBk/H6KtqrLPVwDukgLJ1EOp
 Ge0g==
X-Gm-Message-State: APjAAAXJA/rDSCVIMPSCTYplAejWP7HdS7/k5CwcLSK9y5cisdoUmd7U
 0pPFtN7esppC6PvG+Ksnd55pLbPAHYlen0AKXQO4VSnGV0Yi/pbMMscAhHht9ZCwBnXjCyg9AxX
 mdJVbFCNkuE/e/6jT8PSw0W7mqBHQ4P4=
X-Received: by 2002:adf:fa50:: with SMTP id y16mr4025739wrr.204.1580994560053; 
 Thu, 06 Feb 2020 05:09:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqxw3H2bg8gXo3sB9U4NU3bqzyCPp0t+i4Re/brCAhnCSsXzyO6ZoPrY31rXqFOnURrJmRDigx5CgWECGJ2kVYk=
X-Received: by 2002:adf:fa50:: with SMTP id y16mr4025712wrr.204.1580994559823; 
 Thu, 06 Feb 2020 05:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com>
 <20200128140945.929-5-n54@gmx.com>
 <0ed12efa-eee4-b3ff-8f02-f9c3b80d0e21@redhat.com>
 <2ae4caf9-05fd-b740-2612-e1c1ecafe277@gmx.com>
 <87o8ubuapr.fsf@dusky.pond.sub.org>
In-Reply-To: <87o8ubuapr.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 6 Feb 2020 14:09:08 +0100
Message-ID: <CAP+75-VnwDz0My7p5Zy3SN2gPeACW0z02MUgrdFnSGiZm6xGXg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Add the NVMM acceleration enlightenments
To: Markus Armbruster <armbru@redhat.com>
X-MC-Unique: UkTMW7gyPvCqlK7DvdeeYQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Kamil Rytarowski <n54@gmx.com>, max@m00nbsd.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 6, 2020 at 2:06 PM Markus Armbruster <armbru@redhat.com> wrote:
> Kamil Rytarowski <n54@gmx.com> writes:
>
> > On 03.02.2020 12:54, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> @@ -2029,6 +2072,19 @@ static void qemu_whpx_start_vcpu(CPUState *cpu=
)
> >>>   #endif
> >>>   }
> >>>
> >>> +static void qemu_nvmm_start_vcpu(CPUState *cpu)
> >>> +{
> >>> +    char thread_name[VCPU_THREAD_NAME_SIZE];
> >>> +
> >>> +    cpu->thread =3D g_malloc0(sizeof(QemuThread));
> >>> +    cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
> >>
> >> Nitpick, we prefer g_new0().
> >
> > In this file other qemu_*_start_vcpu() use  g_malloc0().
> >
> > I will leave this part unchanged and defer tor future style fixups if
> > someone is interested.
>
> Time to re-run Coccinelle with the semantic patch from commit
> b45c03f585e.

I thought about it, but then noticed it would be clever to modify
checkpatch to refuse 'g_malloc0?(.*sizeof.*);'


