Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DACC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D0A20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLWwqRDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D0A20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPl3N-0005i4-Qq
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPkuW-0002an-Sx
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPkuT-0005QK-UQ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601982813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPf2uclSCMKvJzabCYV++5DDS/lhd3Wt8bVfXYSncVs=;
 b=iLWwqRDE89WXjOpXtJla2KiumkBENjF00uQPHzrfqTACkd743MFr6WnzARxe3tcH2a2zzP
 X/oNgoM0MqSYdAqfgxaDxnMz+tfufjR/qFc9S66d3SHkyVQNel39SMxgoVw8MIF13FbkFh
 Er8o9xsWWQACQn7g04oC8oYmmTZqN34=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-Y5j80eVuMfWTI7iGf3eMhg-1; Tue, 06 Oct 2020 07:13:31 -0400
X-MC-Unique: Y5j80eVuMfWTI7iGf3eMhg-1
Received: by mail-oi1-f200.google.com with SMTP id w200so591139oiw.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mPf2uclSCMKvJzabCYV++5DDS/lhd3Wt8bVfXYSncVs=;
 b=IImBRSwjnOVUXJi1vcMxO5P3cYW8NHzV1iYOlrFWU8cjUeTtqUObNYxUa4wT28de1Y
 yEwDgKS92vBrXoLiQW5U5Txzje39t8IkcuECdvWUlVKuJhb7lkJ8C9UY2R8WMRuGyqCD
 DwrMw+7cbaOTrIKGpc2HXxYY9lPq2p/9jhg+/lea3iDb+2XVfDxDHlo8kEWhzd+/hyjF
 hBxblz0Gw1h160i8aSdtvM7baJjyHOWhCjYRImzChy3AhnDTdoIsN7WXP2PslhrTvXz9
 3JzcT5sBtJ2YOu4CdGkOuFFWEMPHG5sXsAgOm7NQ8RO8TmPsx8HD74UUU3r94cD92XND
 4BWA==
X-Gm-Message-State: AOAM532ntlwalJBnllQ5lmEaELrTJC3R/N5lFbwR9cKM2XGlWlDpRhEz
 j/PzpdRVbXBwiDzhx8iakukHZAYbIa2Gsw5mJ/pZQOuXA9qPbsPKXxYWFx3KcEj75Qm/ftvJ1SF
 FCh2lhKFbU86+FfKqWB17Kz7k4Bw103g=
X-Received: by 2002:a4a:4845:: with SMTP id p66mr2769637ooa.68.1601982810659; 
 Tue, 06 Oct 2020 04:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweWdMTOot6+4QSOkHNTaOp4nx85jA1is0Zk6YP8pavj5ViFB8A26mmPJJ2DAzUrimJ7Ru2sv9glvYPuvvue0o=
X-Received: by 2002:a4a:4845:: with SMTP id p66mr2769625ooa.68.1601982810459; 
 Tue, 06 Oct 2020 04:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201006111219.2300921-1-philmd@redhat.com>
 <20201006111219.2300921-2-philmd@redhat.com>
In-Reply-To: <20201006111219.2300921-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 6 Oct 2020 13:13:19 +0200
Message-ID: <CAP+75-WhgxvQpmH7VS6hN9t0trHNA6fW5f8zYnvZu3X-23wF+g@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] migration: Only add migration files to the
 Meson sourceset
To: QEMU Developers <qemu-devel@nongnu.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 6, 2020 at 1:12 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> I'm not sure how that works, but keep the use of Meson
> sourcesets consistent, only add source files.
>

Eventually:
Fixes: 5516623020 ("meson: convert migration directory to Meson")

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  migration/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/meson.build b/migration/meson.build
> index b5b71c8060..55c9e1329f 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -14,7 +14,7 @@ libmigration =3D static_library('migration', sources: m=
igration_files + genh,
>                                build_by_default: false)
>  migration =3D declare_dependency(link_with: libmigration,
>                                 dependencies: [zlib, qom, io])
> -softmmu_ss.add(migration)
> +softmmu_ss.add(migration_files)
>
>  softmmu_ss.add(files(
>    'block-dirty-bitmap.c',
> --
> 2.26.2
>


