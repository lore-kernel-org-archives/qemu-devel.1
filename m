Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87A8C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 16:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEC1206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 16:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bF9LLYH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEC1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9sQE-000701-LT
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 12:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1k9sPC-0006KF-24
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 11:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1k9sPA-0006oE-4W
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 11:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598198374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YojgVkY/gEEFl1jcuFNUHUWyx2kxbwD4xw5PlPZf7i0=;
 b=bF9LLYH1KDvnZmnAXk17bcqrSnOKGvRi66VV01AkBMx2arIUIgvPkxa7lQSYE7RYKLgv6/
 Px/cEJVn42La1eE4vnUaPx+f2mToAyrNLi6zqw5eFEJLVyyalnfxadGnjZf0ldfrZeqYS7
 Vg8S4poK8AAu17nWPOOOlLZMeHUPKYE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-EaOC-KpPP6e6p71dlSO5PQ-1; Sun, 23 Aug 2020 11:59:32 -0400
X-MC-Unique: EaOC-KpPP6e6p71dlSO5PQ-1
Received: by mail-il1-f197.google.com with SMTP id w8so4884748ilg.15
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 08:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YojgVkY/gEEFl1jcuFNUHUWyx2kxbwD4xw5PlPZf7i0=;
 b=qT1DByUdVcrpmplxlyo7D+rwvap7nRrco1iWy9EzUNvi6M6/sB5ByDJITKOnFHiaIw
 Yti3PM6iR0+Fhd/ZQcFARZdw2wq4W8DFR4yNie78EZWvos50IkvClhzaXM98eu3TS8qS
 1j/++aWi8J2SdggrXPDB9p1m6djMLUpdTAywIOUP5CWmZK4vDUWfDsj5W/LHjtLpTj54
 vANdFU1Qm3AqhFPOp5TirsVEyIjUJ2CVaIhj78rE5KB5AmXf0fNPl5aCAqY7SRU2AgTm
 maUFpXK+XGv8pAiilwRfZfigG9yindaFDMBufBmjeEj+3LJt2bNWZG3Fqff8LTM7y/De
 rnSw==
X-Gm-Message-State: AOAM531NP1aGIoDFFKsgSlkB5LuItdw4Z/vEymz7RKcBgDup1wjN6+lt
 zlNybtDMs415OjFTUA4fgnLWbexG4r1rl/yelZ8EnSvsAMb/n9LC/Jaoh4fEuY6NHLqdhIQ9svK
 imiLuzuHVLz8CLYiN1yISchBHipa1ndo=
X-Received: by 2002:a05:6638:2493:: with SMTP id
 x19mr1769609jat.53.1598198372220; 
 Sun, 23 Aug 2020 08:59:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/mg2F5UPkjPsc5xPpRXQ2Twk6vZrCQoxR7WQN1eskG4qNNTKgf07j7GsfK+Ny588Qru4950mb81OscuoFzNY=
X-Received: by 2002:a05:6638:2493:: with SMTP id
 x19mr1769591jat.53.1598198371973; 
 Sun, 23 Aug 2020 08:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200823102617.32358-1-thuth@redhat.com>
In-Reply-To: <20200823102617.32358-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 23 Aug 2020 19:59:20 +0400
Message-ID: <CAMxuvazg9xRTcCqXg6MRdvaMreQwGJ-mEe8WFeDP_toqpKMECw@mail.gmail.com>
Subject: Re: [PATCH] scripts/qemu-version.sh: Add missing space before ']'
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 11:59:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sun, Aug 23, 2020 at 2:26 PM Thomas Huth <thuth@redhat.com> wrote:
>
> When configure has been run with --with-pkgversion=3Dxyz, the shell compl=
ains
> about a missing ']' in this script.
>
> Fixes: 2c273f32d3 ("meson: generate qemu-version.h")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

oops, my bad

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  scripts/qemu-version.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> index 4847385e42..03128c56a2 100755
> --- a/scripts/qemu-version.sh
> +++ b/scripts/qemu-version.sh
> @@ -6,7 +6,7 @@ dir=3D"$1"
>  pkgversion=3D"$2"
>  version=3D"$3"
>
> -if [ -z "$pkgversion"]; then
> +if [ -z "$pkgversion" ]; then
>      cd "$dir"
>      if [ -e .git ]; then
>          pkgversion=3D$(git describe --match 'v*' --dirty | echo "")
> --
> 2.18.2
>


