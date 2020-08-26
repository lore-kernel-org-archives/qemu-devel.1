Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7B5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C4A2087D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0k1wnyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C4A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqVH-0004za-DE
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqUW-0003xg-4k
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:09:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42098
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqUT-0004xd-G7
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598429344;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLP42d08jlqtDdnGGiR1ac66izB7N8sAvplYxoFxlws=;
 b=N0k1wnyj08k5oeTkDbhkDAJ1cqKjMNHLMW5RbUwqUhw7ClQ2uT6wrbf1ym6BlvzJOgZYBe
 wtyN64weHHpBLGaBI47tjN/OLRPPYz/IsgmJlA00Eu2AynIESdMbhUar8K71dApqCO/JPV
 HF3rn/ZGLrdBoJ5rebH8Dsy3FVvAJ/k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-_i-Tma1dM-GHEnmMVRGzqA-1; Wed, 26 Aug 2020 04:09:03 -0400
X-MC-Unique: _i-Tma1dM-GHEnmMVRGzqA-1
Received: by mail-wm1-f70.google.com with SMTP id a5so464495wmj.5
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 01:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kLIsu+nEc3aBl1VyG4Sd867PXkn1bWp9ManfPK6FPHs=;
 b=jQu2tbcFu24MvPKxvp6vTZhrV8w7rgdazmkC3bkea6k3iTds4RlE2NgD2u8/0D57ge
 M6I8Sn2aZtdN7wdPyz5clTk9LAYkvdMzdOnuoIgrKZfU+5hsJsLZxdvbA0hha+WtV/Gs
 N7MyTswPY4ztiaQp9FyX8XppVIN6+Mn4duMF/D4KOMhEtnDV9QfdezXLgXCjvmj/FSwO
 uwMCChGRJ+B2m37erI0LQxksjR95O0hRM5i44FzAABG4aJ91YW0kk8sE8WcyWfWUj8IT
 YSkemSecgcozuU25WZI6FFZ8Yb3OWOCf4KEnKgV9nSmUWSlYlMTkpbStIr1CuGtPOC/D
 B88A==
X-Gm-Message-State: AOAM532RgqOBwMy2QRUlt1cDR/55SbRwjD9ftjLG8AcE8Nh5ZjkI0Qy1
 n2+PfxcGf5Ntl22j0Cc2foVxRyYW2Y8He30kh9dHqK8/Ec3H40VKfgV71mG3K0XViMiQs+bznMW
 4a7XKrteQrrm5E1c=
X-Received: by 2002:adf:9e8d:: with SMTP id a13mr13566868wrf.94.1598429341765; 
 Wed, 26 Aug 2020 01:09:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT9BIXEipC0KHHms1/LKk2MRcW/qT6UlqJ2yHzgxQ4Cz3Ybar/ud7Phbq6goZoBDpiyvRYng==
X-Received: by 2002:adf:9e8d:: with SMTP id a13mr13566848wrf.94.1598429341511; 
 Wed, 26 Aug 2020 01:09:01 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id z9sm3613141wmg.46.2020.08.26.01.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 01:09:00 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 66/74] [automated] Use DECLARE_*CHECKER* macros
In-Reply-To: <20200825192110.3528606-67-ehabkost@redhat.com> (Eduardo
 Habkost's message of "Tue, 25 Aug 2020 15:21:02 -0400")
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-67-ehabkost@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 26 Aug 2020 10:08:59 +0200
Message-ID: <87ft89ygkk.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 02:47:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: quintela@redhat.com
Cc: qemu-riscv@nongnu.org, kvm@vger.kernel.org, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> wrote:
>  $ ./scripts/codeconverter/converter.py -i \
>    --pattern=3DTypeCheckMacro $(git grep -l '' -- '*.[ch]')
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v2 -> v3:
> * Removed hunks due to rebase conflicts:
>   hw/arm/integratorcp.c hw/arm/versatilepb.c hw/sd/pl181.c
>   include/hw/ppc/xive.h
> * Reviewed-by line from Daniel was kept, as no additional hunks
>   are introduced in this version

[Dropeed CC'd]

...

> diff --git a/migration/rdma.c b/migration/rdma.c
> index e3eac913bc..87cb277d05 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -399,8 +399,8 @@ typedef struct RDMAContext {
> =20
>  #define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
>  typedef struct QIOChannelRDMA QIOChannelRDMA;
> -#define QIO_CHANNEL_RDMA(obj)                                     \
> -    OBJECT_CHECK(QIOChannelRDMA, (obj), TYPE_QIO_CHANNEL_RDMA)
> +DECLARE_INSTANCE_CHECKER(QIOChannelRDMA, QIO_CHANNEL_RDMA,
> +                         TYPE_QIO_CHANNEL_RDMA)
> =20
> =20
> =20

Reviewed-by: Juan Quintela <quintela@redhat.com>


