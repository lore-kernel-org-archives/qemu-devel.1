Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 07:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734412173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 07:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCQIlmKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734412173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55427 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifIk9-0005iL-KQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 02:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifIjP-0005FY-FJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 02:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifIjO-0000Yc-3f
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 02:17:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifIjN-0000Wz-Sv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 02:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576135069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtYJ85nXYbiYIFPrscbftjICbAnI7ye5q/5npJoT3iQ=;
 b=XCQIlmKklYS+ioL1u8Mla9/tBXqF2aNFYgGgUPOREMJd/mwtRlLmURw+e1U2vSI4DwlxwL
 yfZmpTwaJ2B4Um83jbsUbU0Tfc//QtypG5bFzt+KQ5cvHjCbnFpq9ScZxlBRWHUPBq57+u
 TV7Vv3kfdIGxyovZ8o8DVNxGLqOV0hY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-NAn2Aed9OruByr7H5Cv3Jg-1; Thu, 12 Dec 2019 02:17:45 -0500
Received: by mail-wm1-f70.google.com with SMTP id l13so496106wmj.8
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 23:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Mcpjq99AUbutGHbXzMEKyeZrNJEihaodjTPgkQNcUBg=;
 b=ktgZ74J+afrSMsz5M8J2Kou4or7sV8R6p2ePTpeYoa5vd2ELPz6umuV+1+/8pNuUSi
 M0ftGZDCBQ3ayf54yMlkct4bEiXxCMFVwYZIKQrDvqhrtTtiFwPm3xj4R3pT2lwULHGy
 QF/sdyO7yrf41XxhH1W5ZgBw0rFzv4M7dAb/EVYSCiow7wCUwMguPDxbzycO8VbWF+Gm
 36FwTCLA2zftNQTS7kmJQYQyWn/4NQPcAB5zp9TuCYMEQ9UDbZjS1FLnCWOv3fGeKo0i
 Bl5Sp4GAxYa3KOCaeIGjHKvJETcKoxpaFHdNfzq1rX08fkdlLbBnTfAHoSu6T05PuaU0
 Ao6w==
X-Gm-Message-State: APjAAAW/zYS/dQBggUVkdn/Vc/qohGc35fr3qKaofRLJOLgNj5RIrJ2M
 GcDMRxvb/qYKczugkvKFW+NqXIoPr9Ha/K2zXokp7SPs+qP0DiePSd9GN8LfTrHZzpjy9GRYvZT
 hEbz9/tuMuvp2/5w=
X-Received: by 2002:a5d:428c:: with SMTP id k12mr4424889wrq.57.1576135064357; 
 Wed, 11 Dec 2019 23:17:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqykpFmbplYjpT/U0IMslxnazxs7bSNhNF4s7XhTOYUc/RhNDqSrJ0+w7VEfCreK1Wfs2YAoPQ==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr4424859wrq.57.1576135064043; 
 Wed, 11 Dec 2019 23:17:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id u10sm5033119wmd.1.2019.12.11.23.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 23:17:43 -0800 (PST)
Subject: Re: QEMU VM crashes when enabling KVM
To: Wayne Li <waynli329@gmail.com>
References: <CAM2K0nrhkOhiJDxnANGmAu2140-TP0a9pY58i_PN1k9xAWGz9A@mail.gmail.com>
 <76b207cd-09ce-b3df-e288-a515df40677e@redhat.com>
 <CAM2K0nph2GZQkAv3tCgoP+ciPMWSzVJp0rHDXJJ2Gtqeq2Bgug@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4e14191-efe5-7713-1eac-55a6bafb027a@redhat.com>
Date: Thu, 12 Dec 2019 08:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAM2K0nph2GZQkAv3tCgoP+ciPMWSzVJp0rHDXJJ2Gtqeq2Bgug@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: NAn2Aed9OruByr7H5Cv3Jg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: David Gibson <dgibson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 02:59, Wayne Li wrote:
> We wrote a project that is created on top of the QEMU source code; it
> calls functions from the QEMU code.=C2=A0 I run the executable created by
> compiling that project/QEMU code.=C2=A0 Anyway, looking at the following
> documentation:
>=20
> https://www.kernel.org/doc/Documentation/powerpc/cpu_families.txt
>=20
> It looks like the PowerPC 7457 is Book3S and the PowerPC e6500 is
> BookE.=C2=A0 Is that why you think I require a Book3S KVM?=C2=A0 Exactly =
why do
> you feel this way?=C2=A0 Also would that mean my team would need to go an=
d
> buy a board with a Book3S processor?

CCing the PPC maintainer.  There are aspects of BookE and Book3S that
are different and not really interchangeable in the privileged interface.

Paolo

> -Thanks!, Wayne Li
>=20
> From my understanding
>=20
> On Wed, Dec 11, 2019 at 7:16 PM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>     On 11/12/19 22:23, Wayne Li wrote:
>     >
>     > Now I am fairly sure KVM is actually enabled on the system.=C2=A0 F=
inding
>     > that out was another story that spanned a couple of months.=C2=A0 B=
ut long
>     > story short, lsmod doesn't show that the KVM kernel module is
>     running.=C2=A0
>     > But that's because KVM is built-in and it can't actually be built a=
s a
>     > loadable kernel module in this particular system.
>     >
>     > So I'm not really sure what could be the problem.=C2=A0 Though I wa=
s
>     thinking
>     > if I understood the error better that might help?=C2=A0 Following t=
he
>     code I
>     > see that the "Missing PVR setting capability." is called when a
>     variable
>     > called "cap_segstate" is 0:
>     >
>     > if (!cap_segstate) {
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, "kvm erro=
r: missing PVR setting
>     capability\n");
>     > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOSYS;
>     > }
>     >
>     > And the cap_segstate variable is set by the following function:
>     >
>     > cap_segstate =3D kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
>=20
>     You are not saying how you are running QEMU.=C2=A0 I think you are us=
ing a
>     CPU model that requires a Book3S KVM.
>=20
>     Paolo
>=20


