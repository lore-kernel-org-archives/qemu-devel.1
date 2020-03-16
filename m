Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A923AC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747AB20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7Zh9Xry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747AB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDkXF-0006Cg-8Z
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 03:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDkR7-0004XI-5A
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDkR5-0007sv-9D
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:45:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36346
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDkR5-0007cD-2G
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584344718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+z3MlsYNvktNwDTOan27MSMSj5NZcllFVjbXeVXmzBc=;
 b=Y7Zh9Xrywbip/hbA1StsJXfEjQXxLiIle+7SbvEkrdpUjomt1HANU8MeKUjMUki1RUJzQ4
 4YWLwrtOcgvT4yhhZ/1Lg2TcQ8OggqVVHsMUJPBlzd9gfRW9+XkDi3H2V7QeHiVRx5/ZD8
 Yg0oLIweWX7f8yql0pnZdKLhMshgOmk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-zxdQaktVOk21uYm361p9ig-1; Mon, 16 Mar 2020 03:45:14 -0400
X-MC-Unique: zxdQaktVOk21uYm361p9ig-1
Received: by mail-ed1-f71.google.com with SMTP id f13so14315698edy.21
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 00:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v/kyZRR4IuHrdwz59Q2K72I7e6kkprFrmYD4ffbw0ds=;
 b=YRR9F6GrXCpcQuVS86N7uW8llaUiIAyW7bNzZreyeWc3pd486Yx3dPEcqbjD3ZASCu
 8RxepDQUCwTitb/ibeoJCzJMvUTF8BG7cYaHjUb9yZif1NdxrZsmwH0MR0vVbi9rYu30
 O+qHtaC1/yhH/8ggmuYJEBq3mcntuklXeVlWYVey7SKEQZQIy/XXxN9+7YNAoxVdCwNs
 k9JxM9ESN8kscHIujlT69KsmKk5UTMbdZ+XOD6IJnoSxxgu0ediymxzBiy+8W9CQVRrn
 Ub6S/+ttCXxYgafPELGIjyZGKJgAoANOmg/MSfOFG11/4G13KwoQMP33DvHhsqUYEygf
 NsOA==
X-Gm-Message-State: ANhLgQ1hY5C8bCgS73ZACYxKjm4OuXo4Slr5PxSOJM+HAJOWEsjrUyx+
 Zmpp3xsFDLs9NM35kaEpiQwN1LiXQ2dr4XrRbUjOkRUHjrFtHC/UtqJcJRS5IbmOgqvvkKvjy0e
 7ihrtYxAiI5fApaI=
X-Received: by 2002:a17:906:d046:: with SMTP id
 bo6mr1768648ejb.169.1584344713484; 
 Mon, 16 Mar 2020 00:45:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtWVX3TzY/PCamu8sFcH2Ruk/9fT2FOP9IWM7DWYLzejh3GylI9+VlJudEepV33SheoTC06pg==
X-Received: by 2002:a17:906:d046:: with SMTP id
 bo6mr1768622ejb.169.1584344713076; 
 Mon, 16 Mar 2020 00:45:13 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id g5sm4366459edn.9.2020.03.16.00.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 00:45:12 -0700 (PDT)
Subject: Re: [PATCH v2 00/12] user-mode: Prune build dependencies (part 1)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200315235716.28448-1-philmd@redhat.com>
 <CAL1e-=jBg6OVe+Qgg5SOoJ+S4x70vQF_rttE2_VTddhR4O5n0w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d73a1e52-06d4-e57e-43b9-30c5c03d71d0@redhat.com>
Date: Mon, 16 Mar 2020 08:45:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jBg6OVe+Qgg5SOoJ+S4x70vQF_rttE2_VTddhR4O5n0w@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 1:16 AM, Aleksandar Markovic wrote:
>=20
>=20
> On Monday, March 16, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     This is the first part of a series reducing user-mode
>     dependencies. By stripping out unused code, the build
>     and testing time is reduced (as is space used by objects).
>=20
>     Part 1:
>     - reduce user-mode object list
>     - remove some migration code from user-mode
>     - remove cpu_get_crash_info()
>=20
>=20
> What is the purpose of dividing into parts? What is the content of other=
=20
> parts, and when do you plan to submit those? A series is usually a=20
> stand-alone and a complete logical unit - why did you decide to submit=20
> "parts" separately (just curious)?

Big series are hard to digest and scare reviewers. Peter told me twice=20
his rule of thumb is to split a series if it gets bigger than 20 patches=20
(and a patch if it modify more than 200 lines). He also recently said he=20
skipped review of a ~32 patches series of mine which was too big. I=20
don't want other reviewers to do that neither, so I try to split <=3D20.

Each series could be applied apart, except the last patch from the 3rd=20
part (qapi: Restrict code generated for user-mode) which is the one=20
really cutting down user-mode code by avoiding pulling in system-mode=20
symbols.

First part is generic, second part is QAPI-related, and third part=20
concerns hw/core/qdev-properties.c. Each part is covered by different=20
maintainers.

>=20
> Does this series affect executables' size, or cut build times only?

Both. It will saves us CI testing time, save time to distributions=20
packaging linux-user-only builds, produce smaller binaries.

>=20
> Thanks,
> Aleksandar
>=20
>     Since v1:
>     - Addressed Laurent/Richard review comments
>     - Removed 'exec: Drop redundant #ifdeffery'
>     - Removed 'target: Restrict write_elfXX_note() handlers to system-mod=
e'
>=20
>     v1:
>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg688456.html
>     <https://www.mail-archive.com/qemu-devel@nongnu.org/msg688456.html>
>=20
>     Philippe Mathieu-Daud=C3=A9 (12):
>      =C2=A0 Makefile: Only build virtiofsd if system-mode is enabled
>      =C2=A0 configure: Avoid building TCG when not needed
>      =C2=A0 tests/Makefile: Only display TCG-related tests when TCG is av=
ailable
>      =C2=A0 tests/Makefile: Restrict some softmmu-only tests
>      =C2=A0 util/Makefile: Reduce the user-mode object list
>      =C2=A0 stubs/Makefile: Reduce the user-mode object list
>      =C2=A0 target/riscv/cpu: Restrict CPU migration to system-mode
>      =C2=A0 exec: Assert CPU migration is not used on user-only build
>      =C2=A0 arch_init: Remove unused 'qapi-commands-misc.h' include
>      =C2=A0 target/i386: Restrict CpuClass::get_crash_info() to system-mo=
de
>      =C2=A0 target/s390x: Restrict CpuClass::get_crash_info() to system-m=
ode
>      =C2=A0 hw/core: Restrict CpuClass::get_crash_info() to system-mode
>=20
>      =C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 4 +++
>      =C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 +-
>      =C2=A0include/hw/core/cpu.h=C2=A0 |=C2=A0 7 ++++-
>      =C2=A0arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1=
 -
>      =C2=A0exec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 4 ++-
>      =C2=A0hw/core/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++
>      =C2=A0target/i386/cpu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++++-
>      =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++--
>      =C2=A0target/s390x/cpu.c=C2=A0 =C2=A0 =C2=A0| 12 ++++-----
>      =C2=A0stubs/Makefile.objs=C2=A0 =C2=A0 | 52 +++++++++++++++++++++---=
-------------
>      =C2=A0tests/Makefile.include | 18 +++++++------
>      =C2=A0util/Makefile.objs=C2=A0 =C2=A0 =C2=A0| 59 +++++++++++++++++++=
++++++++---------------
>      =C2=A012 files changed, 108 insertions(+), 65 deletions(-)
>=20
>     --=20
>     2.21.1
>=20
>=20


