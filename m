Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBE0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FDF20663
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK3nbtze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FDF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnq5h-0003Mh-LJ
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 17:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnq19-0004Vw-2b
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:59:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnq17-0005Mx-6r
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592945980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOENgS0XF4NaFotGT0xIoyNxr2QDq61TTcJKXjVqc9I=;
 b=XK3nbtzeU6ukVaUfTuZCzQFcJXWtfD5bgdr3yd9qZkVxzw0Uo7Oe4JIyBUMNvteEzXTlbu
 YzvEr0CS6svVdSsuc/35ytP88bif0wLhAqkubx7AEHw37uS1C2kIDMGtymvd9KgbN6A2sE
 9Z987u9lQsTN5eCZoM3CtmRdhcngUjg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-HLy5b0XUOQO335WYE6sqjg-1; Tue, 23 Jun 2020 16:59:34 -0400
X-MC-Unique: HLy5b0XUOQO335WYE6sqjg-1
Received: by mail-wm1-f71.google.com with SMTP id a7so87523wmf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 13:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cVbhEcF9emc5HX+8R3htz+lknT/qeNVLk/+wnMeuF8o=;
 b=jlS/UqXjucrBz3KK7p8XzzlEj23x/IkC6E60RXay769Uw8Qd59nbBm51hVU3BB2vso
 vt+dXPW2wZlcJmhbpgxvz5dNcPpEOxe9+ZqiHsxQVnykgYXGOh2j+N3oCe9rUuKRdrHK
 90BTvOrjxHbz/B2av1VBgN4Oo+x0AjeaAcSOzFgiLFrCQLbxf5I3cv7tTj7L8/7AWF+e
 M9HxKu+/ZmAxzddL2ZHUHbHFkIwjaVQxBKc+Xyri0YQopFvIYj1pXxf27xOfnK3+ugAy
 UmfF2QJos68yoA8YO3pSzMJi6nHbShq+PaJjf6xtxdDcO29WjpqwoNhgxVyRGPYrpVDc
 /jgQ==
X-Gm-Message-State: AOAM533oH/TtVWK/9oQslgBLo3pjMzmoXtA+PXfqQzyGreAT24LCdSz8
 Yl5q4UFT4Q2g1wvQVSAAU1Hr1ggUiYQdQzpHY1TCoEVeuoWfDNk0uPVRQeVirFNCTY5WWwGEPdA
 pUuh8wkNtfw3JpzM=
X-Received: by 2002:adf:fe85:: with SMTP id l5mr25875900wrr.333.1592945973060; 
 Tue, 23 Jun 2020 13:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvOPfGBGD7En3ZA2Doh6N7cltBfEPTkBYRzNy1e39DfxgYy5Dh5vlPDhiyVF5aGXDzNcAtZg==
X-Received: by 2002:adf:fe85:: with SMTP id l5mr25875886wrr.333.1592945972868; 
 Tue, 23 Jun 2020 13:59:32 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 i15sm23852043wre.93.2020.06.23.13.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 13:59:31 -0700 (PDT)
Date: Tue, 23 Jun 2020 16:59:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
Message-ID: <20200623165916-mutt-send-email-mst@kernel.org>
References: <20200623145506.439100-1-mst@redhat.com>
 <3554a068-ba6f-0aa0-38b4-b6dca3069630@redhat.com>
 <5d3c4773-5aa2-e80d-68c7-a94eac8a7422@redhat.com>
 <66821238-4da7-ec35-4bb7-6dc46bcbca1d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <66821238-4da7-ec35-4bb7-6dc46bcbca1d@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 07:35:34PM +0200, Philippe Mathieu-Daudé wrote:
> On 6/23/20 7:07 PM, Thomas Huth wrote:
> > On 23/06/2020 17.39, Philippe Mathieu-Daudé wrote:
> >> On 6/23/20 4:56 PM, Michael S. Tsirkin wrote:
> >>> This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
> >>> since that change makes unit tests much slower for all developers, while it's not
> >>> a robust way to fix migration tests. Migration tests need to find
> >>> a more robust way to discover a reasonable bandwidth without slowing
> >>> things down for everyone.
> >>
> >> Please also mention we can do this since 1de8e4c4dcf which allow
> >> marked the s390x job as "unstable" and allow it to fail.
> >>
> >> But if nobody is going to look at it, instead lets disable
> >> it until someone figure out the issue:
> >>
> >> -- >8 --
> >> diff --git a/.travis.yml b/.travis.yml
> >> index 74158f741b..364e67b14b 100644
> >> --- a/.travis.yml
> >> +++ b/.travis.yml
> >> @@ -507,6 +507,7 @@ jobs:
> >>
> >>      - name: "[s390x] Clang (disable-tcg)"
> >>        arch: s390x
> >> +      if: false # Temporarily disabled due to issue testing migration
> >> (see commit 6d1da867e65).
> >>        dist: bionic
> >>        compiler: clang
> >>        addons:
> > 
> > Sorry, but that looks wrong. First, the disable-tcg test does not run
> > the qtests at all. So this is certainly the wrong location here.
> 
> Indeed, this is the previous job:
> 
> -- >8 --
> diff --git a/.travis.yml b/.travis.yml
> index 74158f741b..b399e20078 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -464,6 +464,7 @@ jobs:
>          - CONFIG="--disable-containers
> --target-list=ppc64-softmmu,ppc64le-linux-user"
> 
>      - name: "[s390x] GCC check-tcg"
> +      if: false # Temporarily disabled due to issue testing migration
> (see commit 6d1da867e65).
>        arch: s390x
>        dist: bionic
>        addons:
> ---


OK - can yo submit this as a proper patch?

> > Second,
> > if just one of the qtests is failing, please only disable that single
> > failing qtest and not the whole test pipeline.
> 
> Last time we talked about this Dave was against that option:
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg690085.html


