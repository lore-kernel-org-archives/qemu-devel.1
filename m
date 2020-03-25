Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BE0C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B529A2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuaK84qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B529A2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5CI-0007b0-UZ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 08:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jH5BB-0006T5-1L
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jH5B9-0002dT-Da
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:30:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23389)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jH5B9-0002ci-9d
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585139438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LS4KDy7cqUQVkxjwQ0+IchzDjoppLpTqN08yO8mfRaI=;
 b=GuaK84qAlzzB5oX2X7utaQUlKgD3B8P4Zsgx5EY1yMSoztl+yZx1m+xMr8Pk1xsSsEVEeO
 Or9J8YtDpF0AUOawsH/enPwE9Yxu0jfXC4eD6Nb6u9YZJEzQ74T501RIxZwmwf/Ixdbqh2
 nWxYgTrDZeayp1HuvBCc4IPt8v7ZBB4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-yD5pMeinNRCdn-b5oxlsPg-1; Wed, 25 Mar 2020 08:30:35 -0400
X-MC-Unique: yD5pMeinNRCdn-b5oxlsPg-1
Received: by mail-ed1-f69.google.com with SMTP id ce13so1988661edb.11
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 05:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GBzkHKCClIw6uNxhXKpdXB6eNena65DQqY1FDjKjU/Q=;
 b=ohUIjlPkQdTqG5bSEEdcpIOfQ1zqj9YKnZi2fwfED17ZPMOdCFc2MAwGoVXAMrLt1m
 2CTIJ4rylywWlUBOyOgB4lWX8uBs0R7DJr1jX0lpKaSpZ8d4UDpFYXjOQzyraJAdayN3
 ntrSRiiTD79INT1OMc4TVpt1yWhc7fdyjZsq/nKZdKmWF5qsRjM/BQSrPH5mN3VG2NDR
 n9kTJRY4NbJbFu0Ar0eT0tfLVn7s+tcPZD2vnOTGKtiibuwfZs+Jmq2avhXtauowODHV
 /jXAQyXI2PnqZuH8I9xof6/8stxUzfqH7TLTTny4aFdnu4ZP02/BbgMm9l+uWOdu8z6V
 6KYg==
X-Gm-Message-State: ANhLgQ1riS3QiUBjqF2XxITDCAOk3B7ccfNDIB4dVPDFJSqZhD1WM208
 6URgejzsQZBA+aJETErOOF7wKQcqiKtoPPHtukW/Pn/EcPRqk7z+O7yt7OHbk4ZukR0+u2edbmH
 wWkHM/7onKhmQ3ik=
X-Received: by 2002:a50:e69a:: with SMTP id z26mr2754460edm.9.1585139432581;
 Wed, 25 Mar 2020 05:30:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu0mAJuccrU5pkt6U3L69J6MWgTNqY5lJ03CV/Lk8zHq3r5WI2I4Djy3cRl3FP61BnS2DqZSA==
X-Received: by 2002:a50:e69a:: with SMTP id z26mr2754434edm.9.1585139432365;
 Wed, 25 Mar 2020 05:30:32 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id v19sm1507630edl.76.2020.03.25.05.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 05:30:31 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v3] Acceptance test: Fix to EXEC migration
To: Oksana Vohchana <ovoshcha@redhat.com>, qemu-devel@nongnu.org
References: <20200325113138.20337-1-ovoshcha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c2007a51-318a-c935-dd77-232e45587b08@redhat.com>
Date: Wed, 25 Mar 2020 13:30:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325113138.20337-1-ovoshcha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, ehabkost@redhat.com,
 wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Oksana,

v2 was=20
https://www.mail-archive.com/qemu-devel@nongnu.org/msg682899.html, so=20
this is v3. Please increment the version in the patch subject.

You could also send a simple "ping" to the specific patch, instead of=20
resending it.

On 3/25/20 12:31 PM, Oksana Vohchana wrote:
> The exec migration test isn't run a whole test scenario.
> This patch fixes it
>=20
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>

v1 of this patch has already received reviewers tags=20
(https://www.mail-archive.com/qemu-devel@nongnu.org/msg679629.html),=20
please collect them and keep them when you resend the same patch:

Fixes: 2e768cb682bf
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

> ---
>   tests/acceptance/migration.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index a8367ca023..0365289cda 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -70,8 +70,8 @@ class Migration(Test):
>  =20
>       @skipUnless(find_command('nc', default=3DFalse), "'nc' command not =
found")
>       def test_migration_with_exec(self):
> -        """
> -        The test works for both netcat-traditional and netcat-openbsd pa=
ckages
> -        """
> +        """The test works for both netcat-traditional and netcat-openbsd=
 packages."""

Btw why are you changing the comment style?

>           free_port =3D self._get_free_port()
>           dest_uri =3D 'exec:nc -l localhost %u' % free_port
> +        src_uri =3D 'exec:nc localhost %u' % free_port
> +        self.do_migrate(dest_uri, src_uri)
>=20

Alex, if there is no Python testing pullreq, can you take this patch via=20
your testing tree?

Thanks,

Phil.


