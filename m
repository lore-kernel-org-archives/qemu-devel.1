Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D36C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DA120872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGb2jcWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DA120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnsC-0002iF-HT
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCmuD-0007zP-2h
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCmuA-00062n-BA
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:39:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCmu8-00061u-Ir
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:39:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id 3so569144wmi.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qclRRxXYeP+oEHUpWSgbBttIh6GIZkCeB7ty9HlkVEc=;
 b=kGb2jcWztH1UW6soq/kMMeyhsU/4oWhGrovh4QKh0HCrqYnIz7ZnR17njbVHIJT6ZM
 JLTV61affaMIhNKJn5Dkag98R2b3ZyQgiuRf+Il5uXj8NLMRjDkPVrkpYoEyNRt0h1WN
 NKLCYMuZkkaabSzO4VIYOBtYekm+5a8jtdt6R0aqrGGQBwvo2vwQOcTewM1P6Daz0yJ0
 kpNZjnU8Zsp+3fILRo4zkvMovixz7/gVMxTwedDm8ZqjNPx7BDZfewgTxdP3/VUBht20
 rhaslLmk0GBYHMZiVWimjnk87jxV4W2dim5QE7mTDrhjNoT08CFeaaJpwA/0BqQl5w6s
 LscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qclRRxXYeP+oEHUpWSgbBttIh6GIZkCeB7ty9HlkVEc=;
 b=iJe8zMswGft3wpFVTvVrgv+2iB83flaQ+chgXhtURVjPEEG6KXL9Ya3+adh6rp0RP2
 T878ieIaKX5bWtHmhngK77em+xDsgK9iYa+fyOZN9+v80xPA81E+zE/Y2dxJU23D9U3q
 oiVhP3p7TCG/Cgl5HsgFb7OPbNQdOb4xbw4wT+8DwYokK4lKiOVZLCENntMFeT3SJDcE
 VLDFhE35u3z/FPFedVtXBiuw8u80YNY3r2Lv0yLJSJXaf/EW8OdYUKm+kBBIKofvfNa/
 x1jXAciMWjaz7KkQeydrq7VwAVih/Czn8tc7P9R/wqh9KCxtcs4W5viq6AxHoqD6yK/9
 h7CA==
X-Gm-Message-State: APjAAAUdEXoBenUX8TiBFM7hRmiZxA1Gh1F12H0f3xLMfGsG5NsvosMt
 2Z/BCZEQPYGTVo3jnq6LZH+cf4DAuZ5Eyg==
X-Google-Smtp-Source: APXvYqy7ZSGtxyFuGxSISg9/X8mRsJyWWr0EGH1vzygtfFK8pmj3dICs1XqRz+Hni2LtjcI6iv6apQ==
X-Received: by 2002:a1c:c78f:: with SMTP id x137mr813859wmf.42.1569339541820; 
 Tue, 24 Sep 2019 08:39:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm478677wmm.0.2019.09.24.08.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 08:39:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 541381FF87;
 Tue, 24 Sep 2019 16:39:00 +0100 (BST)
References: <20190923174942.12182-1-dgilbert@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Subject: Re: [PATCH] migration/postcopy: Recognise the recovery states as
 'in_postcopy'
In-reply-to: <20190923174942.12182-1-dgilbert@redhat.com>
Date: Tue, 24 Sep 2019 16:39:00 +0100
Message-ID: <875zlhbt63.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Various parts of the migration code do different things when they're
> in postcopy mode; prior to this patch this has been 'postcopy-active'.
> This patch extends 'in_postcopy' to include 'postcopy-paused' and
> 'postcopy-recover'.
>
> In particular, when you set the max-postcopy-bandwidth parameter, this
> only affects the current migration fd if we're 'in_postcopy';
> this leads to a race in the postcopy recovery test where it increases
> the speed from 4k/sec to unlimited, but that increase can get ignored
> if the change is made between the point at which the reconnection
> happens and it transitions back to active.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

In my xenial stress test I run 100 times and it never triggered the 180s
timeout I set on my retry.py script:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  migration/migration.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 01863a95f5..5f7e4d15e9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1659,7 +1659,14 @@ bool migration_in_postcopy(void)
>  {
>      MigrationState *s =3D migrate_get_current();
>
> -    return (s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +    switch (s->state) {
> +    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> +    case MIGRATION_STATUS_POSTCOPY_PAUSED:
> +    case MIGRATION_STATUS_POSTCOPY_RECOVER:
> +        return true;
> +    default:
> +        return false;
> +    }
>  }
>
>  bool migration_in_postcopy_after_devices(MigrationState *s)


--
Alex Benn=C3=A9e

