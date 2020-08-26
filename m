Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F7EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF1A2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G85yRBtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF1A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqOW-0006nR-Nw
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqNz-0006Iu-Co
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqNx-0004B8-9f
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598428940;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IceReS5urR7oxiq7JZofugZ7vn307giG56gUhEw1ORE=;
 b=G85yRBtC9WNE2L1tsuW0egqhnJSml41l42lJdOx2ijvmyULQFxokkTTJXgYL7nhPPbZqFg
 3joNRE3TzgSmlJMssHexNx+FFkBlHoJ+8mqJuAJgnfH/vO4Ek9msqwc5vXYceKM+HwV+l5
 T6vd5vgQZRvMkFSnuN38zTpicF9cGug=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-qA2XyiwhNDabubUb9_gMEw-1; Wed, 26 Aug 2020 04:02:18 -0400
X-MC-Unique: qA2XyiwhNDabubUb9_gMEw-1
Received: by mail-wm1-f71.google.com with SMTP id f125so471839wma.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 01:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G+cLFL8yEdkBH3yow4+6ZbZvxrDo8zepFhkkyNnP2kg=;
 b=Zxd5Db/EigxF/3KqVjC9RPghBbp2p0GpR2LJMyk+GIYkW1gLPoblIrKGAuz1EIeELZ
 6K4uJVqvlJASpUMyc43Z9pJQIqmP6aDzUnPzq9mdTi0/H3We+FzHUO6ep5xuhqeLFJAB
 7ex3HdVfiWfbxPXiIsyu/U8j2sYs/m5duwqiH0lqZJC3ZsDYYQowuWWfIZDRJWsYivLg
 TxGcutv84vCsHpehXym1FqA5h0rPpEuL2tVWqXJLk1aMIxgBdah9UNi7+eEjfqmN6Y+I
 wV6LmFMxQh4cWBBouK4dwHyO5Hpci6snCVsYqklv/QZsB5HS81yo46PMGv2javhiNEkz
 34rA==
X-Gm-Message-State: AOAM533MvdT7A99+dRDo56ngla+PEtKzN7FGfNHXuBvw7LPuDx4XHWfo
 BQhffTVtW4OIHVbI0xfG4wf7V9HUAuJ6+qj+KuTLR91KscFfEz7mCfxGoLnG6zv+I3DSFxFcf7c
 znfibbIYbPz8MjCU=
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr15309338wra.118.1598428937544; 
 Wed, 26 Aug 2020 01:02:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTUhdcIpNRU3VUvS4tp1AIY+Oz9N9C9qsavDdUBCjRbYqMLCYnQmaNkxYRTh7m6m1+LgttHA==
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr15309298wra.118.1598428937244; 
 Wed, 26 Aug 2020 01:02:17 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id o2sm3715968wrj.21.2020.08.26.01.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 01:02:16 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 62/74] [automated] Use TYPE_INFO macro
In-Reply-To: <20200825192110.3528606-63-ehabkost@redhat.com> (Eduardo
 Habkost's message of "Tue, 25 Aug 2020 15:20:58 -0400")
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-63-ehabkost@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 26 Aug 2020 10:02:15 +0200
Message-ID: <87y2m1ygvs.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 02:45:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 haxm-team@intel.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> wrote:
> Generated using:
>   $ ./scripts/codeconverter/converter.py -i --passes=3D2 \
>     --pattern=3DTypeRegisterCall,TypeInitMacro $(git grep -l TypeInfo -- =
'*.[ch]')
>
> One notable difference is that files declaring multiple types
> will now have multiple separate __construtor__ functions
> declared, instead of one for all types.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v2 -> v3:
> * Removed hunks due to rebase conflicts:
>   hw/sd/milkymist-memcard.c hw/sd/pl181.c
> * Reviewed-by line from Daniel was kept, as no additional hunks
>   are introduced in this version
>
> Changes v1 -> v2:
> * Add note about multiple constructor functions to commit message
>   (suggested by Daniel)
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

[ I removed CC'd people, -ETOOMANYRECIPIENTS]

....

> diff --git a/migration/migration.c b/migration/migration.c
> index dbd4afa1e8..561e2ae697 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3844,10 +3844,6 @@ static const TypeInfo migration_type =3D {
>      .instance_init =3D migration_instance_init,
>      .instance_finalize =3D migration_instance_finalize,
>  };
> +TYPE_INFO(migration_type)
> =20
> -static void register_migration_types(void)
> -{
> -    type_register_static(&migration_type);
> -}
> =20
> -type_init(register_migration_types);
> diff --git a/migration/rdma.c b/migration/rdma.c
> index bea6532813..15ad985d26 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3942,13 +3942,9 @@ static const TypeInfo qio_channel_rdma_info =3D {
>      .instance_finalize =3D qio_channel_rdma_finalize,
>      .class_init =3D qio_channel_rdma_class_init,
>  };
> +TYPE_INFO(qio_channel_rdma_info)
> =20
> -static void qio_channel_rdma_register_types(void)
> -{
> -    type_register_static(&qio_channel_rdma_info);
> -}
> =20
> -type_init(qio_channel_rdma_register_types);
> =20
>  static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma, const char *mode)
>  {

For the migration bits.

Reviewed-by: Juan Quintela <quintela@redhat.com>


