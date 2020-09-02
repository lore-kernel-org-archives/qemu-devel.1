Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B791C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DBD20709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+OOxo4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DBD20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWDa-0001in-DK
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kDWB0-0005fx-G9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:04:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46418
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kDWAy-0000Y4-AB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599066238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y7+OkQxZ9zZMzEvjWG4Zf3Tz59qT8JJg3f5jc7jmrzU=;
 b=i+OOxo4FIrIwvB5uvPbudZJ4BLGXkdNSwjVCcfb0Ko6k8pAQBIE8DBGE/kKL4aa1yN6NSs
 R00kMNx0vA/grTo58sslghPAsg/xQ9ROrntgCpMAvayNqKvY5O2ZTPQP0zxw1rmerIOxsg
 bhRKq0EVpNGz+h0bjuaIoVYW95yt0eU=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-2U5iuCJEMuC7q0Dfdx9l6A-1; Wed, 02 Sep 2020 13:02:48 -0400
X-MC-Unique: 2U5iuCJEMuC7q0Dfdx9l6A-1
Received: by mail-vs1-f72.google.com with SMTP id n128so1066262vsd.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y7+OkQxZ9zZMzEvjWG4Zf3Tz59qT8JJg3f5jc7jmrzU=;
 b=sEmTGJi8jZ3sru4x+WxXVqJW6XvK1ubCQxxtciVpMfqPgWiUjA+UtT5eMmxdYEXsun
 RauHljZVGlBJUNEM+dbVPrAhjwqgaDugO5oCA6vvD/jIq/rRXGV/y477UyGGjB1wF8e7
 aAXonbwP1/COviLN4QqbNl4ni8XEi6HQIgt1n+D59pBjyoEYsbRmJGI201KCUvi1+uDS
 rjFq74krRZJX+thF0WQ0p8MNd4U/e7slfsO8WicRSUh02AvO02DlQdqDs4eIreYy1Yjd
 of8J5y/7k1/+/jBxg4wIXE18NQ1zexh/8/lJg4FKRsTZiRtongt2DH1Sx+kKz7JKsi7Y
 svzA==
X-Gm-Message-State: AOAM531LXOpsETQnSP3odIHYJeL9Yepu4SGPtGLXIprRapSMrJ2JXnJP
 3Kbu+KKnvJ02x+bOxWRoqUc3ws2pANtUc1w23clQk6rv+k2RAq3+1yXI4lop7AJJUwZbRXs0u1Q
 oLy6hFNQMdr/QfU7WoO+JJUSDAh/jeHQ=
X-Received: by 2002:a67:ea56:: with SMTP id r22mr6269052vso.29.1599066168202; 
 Wed, 02 Sep 2020 10:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTDgA4uFn7x6WQf9a5mQydh7p9W3+XDVmmoltu1AM1uwl0P3Q7V/weJWYiI1WTHpb40/sl5UcZfoDzIfLpyjI=
X-Received: by 2002:a67:ea56:: with SMTP id r22mr6269014vso.29.1599066167936; 
 Wed, 02 Sep 2020 10:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903462803.28509.16851113546106095750.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159903462803.28509.16851113546106095750.stgit@pasha-ThinkPad-X280>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Wed, 2 Sep 2020 14:02:37 -0300
Message-ID: <CAKJDGDZiT9VxMj_8HYSq6iSZ7TEvEHCDD4nm4ZPFFjT1XBAnpA@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] tests: bump avocado version
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 armbru@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa Junior <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 mreitz@redhat.com, Philippe Mathieu Daude <philmd@redhat.com>,
 zhiwei_liu@c-sky.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 2, 2020 at 5:17 AM Pavel Dovgalyuk
<pavel.dovgalyuk@ispras.ru> wrote:
>
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
>
> Reverse debugging test uses gdb remote client of avocado framework.
> This client was fixed since the currently used version 76.
> Therefore this patch bumps the version to 81 and fixes command
> line version compatibility issue.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> ---
>  tests/Makefile.include |    2 +-
>  tests/requirements.txt |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 9ac8f5b86a..0687c8bcda 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -517,7 +517,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>              --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
>              --filter-by-tags-include-empty --filter-by-tags-include-empty-key \
>              $(AVOCADO_TAGS) \
> -            $(if $(GITLAB_CI),,--failfast=on) tests/acceptance, \
> +            $(if $(GITLAB_CI),,--failfast) tests/acceptance, \
>              "AVOCADO", "tests/acceptance")
>
>  # Consolidated targets
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index f9c84b4ba1..036691c922 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -1,5 +1,5 @@
>  # Add Python module requirements, one per line, to be installed
>  # in the tests/venv Python virtual environment. For more info,
>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> -avocado-framework==76.0
> +avocado-framework==81.0
>  pycdlib==1.9.0
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


