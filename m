Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B970C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FC92071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1IC8VM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FC92071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZyi0-0003Gg-9f
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 09:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1iZygj-0002Ps-UG
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1iZygi-0001iX-RO
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:53:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24812
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1iZygi-0001hK-BX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574866381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IC+15nQfowoQr+RgcKeTuc/PNELIBguC8mJgXQg86V4=;
 b=L1IC8VM4Ob6x/xZ3vEAxsz/zRpgcKQEpsavdwjox8UJzm2UClyHrcnHmzIFf6ajIZwCDj+
 hcG8I5unuXV/t8hoRrgcjn8T47wYlI3qwF87Ww0osTY56FyeFo1UWWp8G/DgKpRHrFoRol
 Q9Ndip3mAWA7HRaFYKnUHDDfEftTwBg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-673cFPYDNPycbvmbsD7X-w-1; Wed, 27 Nov 2019 09:51:32 -0500
Received: by mail-wr1-f71.google.com with SMTP id q12so12314603wrr.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 06:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IC+15nQfowoQr+RgcKeTuc/PNELIBguC8mJgXQg86V4=;
 b=ZlbGapEApKmiR9zyvv/2FH/URQPJ6/N+sEGgPN8q20DE2YWPqsLpZ182/iN8R5pdIg
 RpO+Jv06OemkbQDz6VQKFGHcFLlCfrLqxDfoKKRYef6TY7UUfkjuQN40KsTvMP9HxX/E
 0CVHo3KHxOw5cJhEdNXg/hOMM1tygNwKmy66tZzgg7JMG6sISaR52Vo369RHvYuUmSlX
 NvYxt2viF/NFuEOvaFwyO5Hm8DrT7iyWoLkOLZOTEbHld7lhAYWZSL1AmK0CJDafwCiA
 FfOtiX4Qc1ocNU7Aw5o96U9Wr17ymBuTw6i42xEans8FD9LLFUtfqYa/cTC38ktgqMZm
 jtXg==
X-Gm-Message-State: APjAAAU6FGztbZT3qV4ciRT687R7pFL2GYw8JpJe0uPytgRLh7s4UlpR
 3dFpyPIt3C99PLhKBrH9suKRVQ2AWFJd67g0a7PzOe1hSUWa85CSY+TNJ0FBXLu4Dj9P7k8tPG8
 PyR5v6NideFn3aWBWH9Qf0VFjTkFWjUI=
X-Received: by 2002:a7b:c632:: with SMTP id p18mr4701630wmk.73.1574866291538; 
 Wed, 27 Nov 2019 06:51:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOtD00InEf8n3V09g1aalnOJea+U1MnXtpNPUKuMo1yYOaSFz9iw/vy3uxdbCxQYENfWsFjywMMWP4QWl2zpA=
X-Received: by 2002:a7b:c632:: with SMTP id p18mr4701616wmk.73.1574866291300; 
 Wed, 27 Nov 2019 06:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20191126223810.20180-1-philmd@redhat.com>
 <20191126223810.20180-2-philmd@redhat.com>
In-Reply-To: <20191126223810.20180-2-philmd@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Wed, 27 Nov 2019 11:51:19 -0300
Message-ID: <CAKJDGDbMQQCgGFGehNNKTDyioRYss7AjBGVLwMfvn0UDk+PKKQ@mail.gmail.com>
Subject: Re: [PATCH-for-4.2? v2 1/2] tests/boot_linux_console: Fetch assets
 from Debian snapshot archives
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: 673cFPYDNPycbvmbsD7X-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 7:38 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The kernel packaged was fetched from an unstable repository.
> Use the stable snapshot archive instead.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2:
> - Rebased
> - Dropped Alex's Tested-by tag, since commit 2ecde8b2fb got merged
>   since and it changed the tested kernel version.
> ---
>  tests/acceptance/boot_linux_console.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 7e41cebd47..752f776f68 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -479,7 +479,8 @@ class BootLinuxConsole(Test):
>          :avocado: tags=3Darch:m68k
>          :avocado: tags=3Dmachine:q800
>          """
> -        deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m68k=
/main'
> +        deb_url =3D ('https://snapshot.debian.org/archive/debian-ports'
> +                   '/20191021T083923Z/pool-m68k/main'
>                     '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.u=
deb')
>          deb_hash =3D '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
>          try:

Tested-by: Willian Rampazzo <wrampazz@redhat.com>

The code was tested and works as expected.

---
Willian


