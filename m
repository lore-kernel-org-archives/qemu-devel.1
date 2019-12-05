Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URG_BIZ,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FE4C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D67206D9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGYKyEM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D67206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrqW-0005Gd-6i
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1icrbw-0007qb-Q4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1icrbv-0000cN-I3
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:56:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60169
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1icrbt-0000ad-0k
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575554160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5LEmeBgNeFxpwu+F2QwvSZ7e/bau9swAX/PFV/EtRg=;
 b=FGYKyEM4DYCIyaM/wQruU4IiPLZyEnCB+TXQ4MatfcAXyt8Uw+SmN6S/7aeDJcXprWn+Gv
 cUBnb3zjDO6GXlvIhRudgbTWLewuz7jFuwhQvyNZV6vtmu9EY+kW+kUDeEBQQymxj8qzez
 68WN3hCZ3E3yJul5+iGJ/27IsL/FU8g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-jFR7t8gPNpa6N5wF7e8Knw-1; Thu, 05 Dec 2019 08:55:59 -0500
Received: by mail-qt1-f198.google.com with SMTP id h14so2510643qtq.11
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 05:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bBMUbllceoxZYLj0y2soALV70A6VyMICRdvanuq60ik=;
 b=KeABt1MMIbpO/Zmk0BtymhhAqFuQ/b9C4c6dFXfg+zvt5jsgYXUHyPBuhkRWcN4Ooa
 mww7tcMZPU/eSOliyEzV6mIOoAfS6iXX3P1Xhbn4JzXXU80HnDafVjI00K5Lwr7oeEPO
 8GUjNTcT68TW89Yc7S3iqz+U0a2YxiEDuIRoRpo/0XZBiOlCS2njJq1qvNr72GxjBHMd
 iB1fV+cootgQsqHw1miucrBOgqwHapjh0GS8d631lJPtvyru4SmPwMvviZtAa8jmGpOC
 24ryaFPa8EysjvMVCTedyyBTgwsmLj6ukn0/ONRQdI7/2c//QPlE94VuyOkCvtbQaqQh
 7JCQ==
X-Gm-Message-State: APjAAAWfS9xK/Xi5WVUa5J+Az5VlnmXxzkM3YLva+OkSCDgVppFIlgvr
 zWnWirBP4ltFeD4HFXCNUbPGDBkGaEXAHfViIdVWU8Wk+zY1cs9ArywKkeewGGY7RTcKkbgb+ZD
 vJiNcACmZxIlWbDA=
X-Received: by 2002:a0c:e84d:: with SMTP id l13mr7446445qvo.53.1575554158535; 
 Thu, 05 Dec 2019 05:55:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJQ3yy8a3z4QFTeZTYcibHvWYJowytRSl9SnFpezFArhnlxk5PSL978zxA5MA3Uwu7d0B/hQ==
X-Received: by 2002:a0c:e84d:: with SMTP id l13mr7446423qvo.53.1575554158114; 
 Thu, 05 Dec 2019 05:55:58 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::3])
 by smtp.gmail.com with ESMTPSA id c79sm4963175qkg.76.2019.12.05.05.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 05:55:57 -0800 (PST)
Date: Thu, 5 Dec 2019 08:55:55 -0500
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] migration: Rate limit inside host pages
Message-ID: <20191205135555.GC9673@xz-x1>
References: <20191205102918.63294-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191205102918.63294-1-dgilbert@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: jFR7t8gPNpa6N5wF7e8Knw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, LMa@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 05, 2019 at 10:29:18AM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> When using hugepages, rate limiting is necessary within each huge
> page, since a 1G huge page can take a significant time to send, so
> you end up with bursty behaviour.
>=20
> Fixes: 4c011c37ecb3 ("postcopy: Send whole huge pages")
> Reported-by: Lin Ma <LMa@suse.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/migration.c  | 57 ++++++++++++++++++++++++------------------
>  migration/migration.h  |  1 +
>  migration/ram.c        |  2 ++
>  migration/trace-events |  4 +--
>  4 files changed, 37 insertions(+), 27 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 354ad072fa..27500d09a9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3224,6 +3224,37 @@ void migration_consume_urgent_request(void)
>      qemu_sem_wait(&migrate_get_current()->rate_limit_sem);
>  }
> =20
> +/* Returns true if the rate limiting was broken by an urgent request */
> +bool migration_rate_limit(void)
> +{
> +    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    MigrationState *s =3D migrate_get_current();
> +
> +    bool urgent =3D false;
> +    migration_update_counters(s, now);
> +    if (qemu_file_rate_limit(s->to_dst_file)) {
> +        /*
> +         * Wait for a delay to do rate limiting OR
> +         * something urgent to post the semaphore.
> +         */
> +        int ms =3D s->iteration_start_time + BUFFER_DELAY - now;
> +        trace_migration_rate_limit_pre(ms);
> +        if (qemu_sem_timedwait(&s->rate_limit_sem, ms) =3D=3D 0) {
> +            /*
> +             * We were woken by one or more urgent things but
> +             * the timedwait will have consumed one of them.
> +             * The service routine for the urgent wake will dec
> +             * the semaphore itself for each item it consumes,
> +             * so add this one we just eat back.
> +             */
> +            qemu_sem_post(&s->rate_limit_sem);

I remembered I've commented around this when it was first introduced
on whether we can avoid this post().  IMHO we can if with something
like an eventfd, so when we queue the page we write the eventfd to 1,
here we poll() on the eventfd with the same timeout, then clear it
after the poll no matter what.  When unqueue, we can probably simply
do nothing.  I'm not sure about Windows or other OS, though..

Anyway this patch is not changing that part but to fix huge page
issue, so that's another story for sure.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

--=20
Peter Xu


