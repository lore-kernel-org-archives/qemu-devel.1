Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D849C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A4F2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6nwt7J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A4F2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdWU9-0003kI-W3
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdWTV-0002ub-Na
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:06:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35976
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdWTT-0001NG-Rs
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590487577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D4rY0tGnhIq+EwhdAv0D1YWF9Ijf82UQGWP/HGFFgkg=;
 b=f6nwt7J5ORM7he02AbEWLjnJ+uGzjSZR5sv6cHz4bNGbAgo7ASShiua7JhbxocuY+q9jKd
 /NlgvRzaQanck4ZRwU8fN+YoXh+ok/KwT9KdHHi0lCByKNQHX2jaY8mpTsEnSfj7ebnfLS
 a7b4rpKNuGdt6khVou7ygYsIuSQlw/w=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-GZ3v3VvgNKWsKWwZS8B69A-1; Tue, 26 May 2020 06:06:13 -0400
X-MC-Unique: GZ3v3VvgNKWsKWwZS8B69A-1
Received: by mail-il1-f199.google.com with SMTP id v87so17026087ill.23
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D4rY0tGnhIq+EwhdAv0D1YWF9Ijf82UQGWP/HGFFgkg=;
 b=RT3yJ8dLI3sCMVX3lW0xB1/AIq4TUv+FrYQE4r5TnK45veGt4t0CCb9JT8nyvP2Qeg
 hoCRm29/ODI0SLXSqntoDWhbn99lq02kc/MVsfdIG5kBNZeVAYUoPL0ftY4/pRm05Ld0
 fiAJNi1Zn05OZbqyLD+Spaz0Q9C/J/wUtPhYUPEmgFw1AzqA13Ie7DYoQeiyHiiPrP/G
 Hx6H7qSK5W11x0aLFLeCSJDhUoZ3KKZhcRQ06ey7xn7qxP71TYgS2l2ZCfAgx1Q2LbiU
 h/sKEfyTXL6GS2/M+o/cH5qlxjcrp3gbnDCbH/WA/hXEgErh75QQwI95YA139rK01yNr
 WqyQ==
X-Gm-Message-State: AOAM532xmefUIUecg0SDq9SGlQy/wictvJ4NBgVRkt6U/IDIjwM0saUl
 IcnmBluRIL2VCJYWfS1do60S7uWro18HqhBgKDnaCXGdXXx2pNsoz68fcuuNCRW2qRF3jtSd0pr
 NadxvTqiI3f8UoxI9p2bsDxOSnSoCs2Y=
X-Received: by 2002:a05:6e02:589:: with SMTP id
 c9mr323983ils.271.1590487573257; 
 Tue, 26 May 2020 03:06:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMzTQZJjuWJfWOUmCq0GfXWX00baMWDNQVQIw4oRNG03Fp4mQZ2Y6Q+475KB6xuHwG01deIwfAEm3lud2A4dY=
X-Received: by 2002:a05:6e02:589:: with SMTP id
 c9mr323911ils.271.1590487572148; 
 Tue, 26 May 2020 03:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200526075042.420162-1-ppandit@redhat.com>
In-Reply-To: <20200526075042.420162-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 26 May 2020 12:06:00 +0200
Message-ID: <CAP+75-Wb+RZu8GOUupU298Aw_Pc79b8pmSVufSWg_t5NTGRv_g@mail.gmail.com>
Subject: Re: [PATCH v3] exec: set map length to zero when returning NULL
To: P J P <ppandit@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Ding Ren <rding@gatech.edu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 9:53 AM P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> When mapping physical memory into host's virtual address space,
> 'address_space_map' may return NULL if BounceBuffer is in_use.
> Set and return '*plen = 0' to avoid later NULL pointer dereference.
>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

> Fixes: https://bugs.launchpad.net/qemu/+bug/1878259
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  exec.c | 1 +
>  1 file changed, 1 insertion(+)
>
> Update v3: set *plen = 0;
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg06249.html
>
> diff --git a/exec.c b/exec.c
> index 5162f0d12f..4eea84bf66 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3538,6 +3538,7 @@ void *address_space_map(AddressSpace *as,
>
>      if (!memory_access_is_direct(mr, is_write)) {
>          if (atomic_xchg(&bounce.in_use, true)) {
> +            *plen = 0;
>              return NULL;
>          }
>          /* Avoid unbounded allocations */
> --
> 2.26.2
>


