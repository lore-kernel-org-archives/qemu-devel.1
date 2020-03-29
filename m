Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48733C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 19:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E3320748
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 19:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMvK1VeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E3320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIdo9-0007Y2-4K
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 15:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jIdnC-00070G-4E
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 15:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jIdnA-0000M5-8G
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 15:40:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jIdnA-0000Kk-3H
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 15:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585510818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4oNGJEnWvgvWmYwy9R/t9+CrqOZpKYjlYzS/Hso2L9c=;
 b=iMvK1VeMXPmcvojTiwSxfLY4qP8z3qSZZcDfU0syjwgYZcJ0mDg3A3J7J4OvpLklg/+4+Z
 FIQjV18CZUM3h/Sx/XyCUC5aMfn1kdpyy0r3hgZetV8LvF7LlslHvosm/Rcjf07NoFg2GG
 +EwbVz9ksfriY6JJixWqr/6guWNdG1M=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-n0hPDzPZOXuyb8piPTZFEQ-1; Sun, 29 Mar 2020 15:40:13 -0400
X-MC-Unique: n0hPDzPZOXuyb8piPTZFEQ-1
Received: by mail-ed1-f71.google.com with SMTP id a32so13527124edf.17
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 12:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QbdDQdguYk+pB7fUGmRTI8Jj8L7gPLMff0Y6sa6ivCM=;
 b=tQplzGJt77TNuTEM2N/ctqCtsx5QAbOe1KDKWl44lexUN53jKg3zTLyjUYXs1kq6ic
 0wIl4vJ+CUm1JlA+L5rp7A5UWL2wZyNTXawHJlD2MVHEH+iRpwqrr/UKrVqTMBMi7X0R
 jzPXl97IKUBYhO4/3AiBPNBkDzTfEd8RXnnPBjU//cZcjK7K+PEH3Pw1ox/GVrR/yR21
 qMkyOqI3VMveTpf094hx5No38urQHQspgzkaLKvgDc7P9sl67LsDUcH4PPeHKWDbizNK
 jwc4b4KLfwc+no3fRG03IUfXTjqEW71m6SwSJD4qVMOnVXotY0JZih/hq9DOl2EoIvwX
 SBhA==
X-Gm-Message-State: ANhLgQ2wb8OH7BetP4BcRr6XGbQ0oxzPDnGuueuubGK8h8db8AE7BTO2
 UeI+WlgHHrhK2iLKrXc+0HofVNaXUwYWnDKF+glCFdO4IOiXSiJoKEAQ7I7M9ixR5JOGd4I+wgT
 GAHURZmjebjuwTHk=
X-Received: by 2002:aa7:c251:: with SMTP id y17mr8557726edo.117.1585510812337; 
 Sun, 29 Mar 2020 12:40:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvGUJrT0y+zQoSMiReM9ER57+1prQWhEozSuGng6etei2hqYNfvBe+1lYMLtXZ4MNRaeDeMtQ==
X-Received: by 2002:aa7:c251:: with SMTP id y17mr8557706edo.117.1585510812132; 
 Sun, 29 Mar 2020 12:40:12 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j31sm141719edb.39.2020.03.29.12.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2020 12:40:11 -0700 (PDT)
Subject: Re: [PATCH v2] tests/acceptance/machine_sparc_leon3: Do not run
 HelenOS test by default
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20200212203627.16592-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e52d2e63-f1fc-1d71-8abd-9cced388aa50@redhat.com>
Date: Sun, 29 Mar 2020 21:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212203627.16592-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I just noticed I forgot to Cc Eduardo when posting this :S

Eduardo, do you want me to prepare a pullreq for rc1 with this patch and=20
Oksana other fix?

On 2/12/20 9:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The www.helenos.org server is slow and downloading the Leon3 binary
> takes too long [*]. Do not include this test in the default suite.
>=20
> Similarly to commit 471c97a69b:
>=20
>    Currently the Avocado framework does not distinct the time spent
>    downloading assets vs. the time spent running a test. With big
>    assets (like a full VM image) the tests likely fail.
>=20
>    This is a limitation known by the Avocado team.
>    Until this issue get fixed, do not run this tests automatically.
>=20
>    Tests can still be run setting the AVOCADO_TIMEOUT_EXPECTED
>    environment variable.
>=20
> [*] https://travis-ci.org/stsquad/qemu/jobs/649599880#L4198
>=20
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Add missing staged hunk...
> ---
>   tests/acceptance/machine_sparc_leon3.py | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/m=
achine_sparc_leon3.py
> index f77e210ccb..27e4717a51 100644
> --- a/tests/acceptance/machine_sparc_leon3.py
> +++ b/tests/acceptance/machine_sparc_leon3.py
> @@ -5,6 +5,9 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later. See the COPYING file in the top-level directory.
>  =20
> +import os
> +
> +from avocado import skipUnless
>   from avocado_qemu import Test
>   from avocado_qemu import wait_for_console_pattern
>  =20
> @@ -13,6 +16,7 @@ class Leon3Machine(Test):
>  =20
>       timeout =3D 60
>  =20
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
>       def test_leon3_helenos_uimage(self):
>           """
>           :avocado: tags=3Darch:sparc
>=20


