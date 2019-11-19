Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75381C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E61C208A1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlaP5LLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E61C208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7NZ-0002qV-Al
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iX7LX-0001Kj-Rn
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iX7LW-0001oe-Q5
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:31:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iX7LW-0001oM-Mi
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574184682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFO4Fd9u/CVYHslXIygpMzVwjW3PaK3FLXbvxDBnp0o=;
 b=PlaP5LLjz4WcMhgCkYv1F6zZ8q01I+EEQXo86mjwdksHbOtdRZJr0ftB5lkw6y4lx/4pEq
 BvxJptrwb9S/9+QnUFegwVxtM0SsUTBCD6yiUex7aBBb7ekzXl74nJ2Qfo6I6gKRAeRp/l
 aLN7JxzgQt+82FuOfM7oMA+3nJVeqZw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-5LDaOH3MNAm4DING1Rvv0Q-1; Tue, 19 Nov 2019 12:31:21 -0500
Received: by mail-wm1-f71.google.com with SMTP id f21so2777149wmh.5
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 09:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=exFZMFnEdw2D17p6leX3WBenRTPBmQ2xcCpv1umAEMc=;
 b=MDM5WmCP2QF0pnhPqw/3nH1iAtkvveJwOjXWjuYHUfd2rjN8f3ArhxjmzVFaJagaZh
 TVt8FdVWDXI0Ys7vMPA4dtzMpDm5vSn6KQ3JXAdXABXZVDdxSUvRp4YtWOgibe0J3BDU
 3AkuQNcPazDLQKv5HL7/6m0MtGYgwD9wUdgviZwJUMw+xpPA9JZgKENtVlyGnG47zc1j
 7eTN5orlbv7+pbYcvTJKJc7WgjoGemAOFElf4hh0EQ7vBBRhTks4mZgpH4x9gMJ91xQl
 WMNsAU+/E4xgUGZQdxVZy5u9oRaEF5fWp5TawdehoIZO+wcFGAd/zP/mkdbIk6p7BPim
 zcYg==
X-Gm-Message-State: APjAAAX6Y6Q5Ba4wY9UxVb4Yi/5eu5V+JCJV1XDVwhH8NOjZ5U5hvQ16
 7ArNKeU5S+YWe2At1E/J7XdA9D8XVc+cHuHEFRWNC8llfyy46oKBSVbyy0+kUZUtC3w2+hTVgxP
 U2P+B/ZcJ5vOc2kQ=
X-Received: by 2002:a1c:39c2:: with SMTP id g185mr6967872wma.88.1574184679591; 
 Tue, 19 Nov 2019 09:31:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOKQNR60eGUmGHRZfF8SxaQpls6t6xTgU75LApnCWfrtmob53OuGZjYJZdtmjrEeFYi07jRg==
X-Received: by 2002:a1c:39c2:: with SMTP id g185mr6967818wma.88.1574184679237; 
 Tue, 19 Nov 2019 09:31:19 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id f67sm3916852wme.16.2019.11.19.09.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 09:31:18 -0800 (PST)
Subject: Re: [PATCH 4/6] tests/test-util-filemonitor: Skip test on non-x86
 Travis containers
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d78b45e0-4011-afa2-0b11-8c7246e55364@redhat.com>
Date: Tue, 19 Nov 2019 18:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119170822.45649-5-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: 5LDaOH3MNAm4DING1Rvv0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 6:08 PM, Thomas Huth wrote:
> test-util-filemonitor fails in restricted non-x86 Travis containers
> since they apparently blacklisted some required system calls there.
> Let's simply skip the test if we detect such an environment.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/test-util-filemonitor.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>=20
> diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.=
c
> index 301cd2db61..45009c69f4 100644
> --- a/tests/test-util-filemonitor.c
> +++ b/tests/test-util-filemonitor.c
> @@ -406,10 +406,21 @@ test_file_monitor_events(void)
>       char *pathdst =3D NULL;
>       QFileMonitorTestData data;
>       GHashTable *ids =3D g_hash_table_new(g_int64_hash, g_int64_equal);
> +    char *travis_arch;
>  =20
>       qemu_mutex_init(&data.lock);
>       data.records =3D NULL;
>  =20
> +    /*
> +     * This test does not work on Travis LXD containers since some
> +     * syscalls are blocked in that environment.
> +     */
> +    travis_arch =3D getenv("TRAVIS_ARCH");
> +    if (travis_arch && !g_str_equal(travis_arch, "x86_64")) {
> +        g_test_skip("Test does not work on non-x86 Travis containers.");

We might need to refactor this hunk to a more generic place some day.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> +        return;
> +    }
> +
>       /*
>        * The file monitor needs the main loop running in
>        * order to receive events from inotify. We must
>=20


