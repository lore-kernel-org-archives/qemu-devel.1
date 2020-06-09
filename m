Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F6D20737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsR6kaZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F6D20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihMd-0002YR-3h
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jihEg-0007NK-Jv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:36:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45967
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jihEf-0002PZ-BH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spJYis+Y88w7NLVjXzarAKSj5ec5ikZqTT5JG/3zWOo=;
 b=HsR6kaZ2BDYqGiipXaF2O4XLK/6jcCld6My0IYas2Oqo7xJg1CxfkwBrbMELwDOODc2DTS
 fnG/g79EBuy5/bw78LpssqmWCC2vnsJWsPiJZt1OxuwIUWdQ75M9d6VGUO5tdgdKF8yt2W
 BPz4RrtdkwBg8iibMbgYYWP9V44TaBw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-q4paBCYqP0CyGJKdyVBm4w-1; Tue, 09 Jun 2020 12:36:22 -0400
X-MC-Unique: q4paBCYqP0CyGJKdyVBm4w-1
Received: by mail-wr1-f70.google.com with SMTP id a4so8807758wrp.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=IGJ2d4qtsL60d26Z346sjoVa9dEa9xwTrtzlnWl4VKk=;
 b=qNQLc9hTdkNJE2rLcI8FEyL0b7DB3DijaVMxHrTUIwcg7ag7bnBwlxiINt4WESnmnP
 j7ap/Tmxr5D70erEz4zMbDPEmEzr0/gqjv5BuT92EV+HjDFrPnmCmf7xwTZVpy2BpHcv
 gtcW3+FUwQtiWUDbJFniHJ/UiSdXCv+c5iLIUIFVqpJdA+i5PU5R+y8xonmiTEOceZ4g
 yoqpKV8z/D2km5RUzUBeg6NdUangEzrGNaJ7IowuK2+o8ojoPm4wSwG/Zm+VG+2i3XZV
 ikmf5horlhsgxtwsHN4lVez1CdJ6NJfkEoEO30gEqSdn1vRHIUx/pmm6myLvfhOUxUu4
 8Cog==
X-Gm-Message-State: AOAM531OILG1NxSWhuHM9teypElHQ4X36eMiAfd2kBkRnLt/RhEzxE69
 zeYIh7RjRtxuyP8EzrNgqJJcbXgFyo4MYpC5POTgDJEe9umPtle6Vghv42WUSw/mSVJWcT/s+XN
 Fd9SRfTelTgmJvMA=
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr4773445wmg.17.1591720580132; 
 Tue, 09 Jun 2020 09:36:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzPC1gFkfSZSgVr4S4dvKC7Q/UBWa7BjFGYJ4UKC2SziaIfYQR/f0dbF5SvcbWApirFQY6+Q==
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr4773419wmg.17.1591720579871; 
 Tue, 09 Jun 2020 09:36:19 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id d17sm4399135wrg.75.2020.06.09.09.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:36:19 -0700 (PDT)
Date: Tue, 9 Jun 2020 12:36:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PULL 3/9] tests/migration: Reduce autoconverge initial bandwidth
Message-ID: <20200609123323-mutt-send-email-mst@kernel.org>
References: <20200325131632.311034-1-dgilbert@redhat.com>
 <20200325131632.311034-4-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200325131632.311034-4-dgilbert@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: vsementsov@virtuozzo.com, maozhongyi@cmss.chinamobile.com,
 pannengyuan@huawei.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 01:16:26PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> When using max-bandwidth=~100Mb/s, this test fails on Travis-CI
> s390x when configured with --disable-tcg:
> 
>   $ make check-qtest
>     TEST    check-qtest-s390x: tests/qtest/boot-serial-test
>   qemu-system-s390x: -accel tcg: invalid accelerator tcg
>   qemu-system-s390x: falling back to KVM
>     TEST    check-qtest-s390x: tests/qtest/pxe-test
>     TEST    check-qtest-s390x: tests/qtest/test-netfilter
>     TEST    check-qtest-s390x: tests/qtest/test-filter-mirror
>     TEST    check-qtest-s390x: tests/qtest/test-filter-redirector
>     TEST    check-qtest-s390x: tests/qtest/drive_del-test
>     TEST    check-qtest-s390x: tests/qtest/device-plug-test
>     TEST    check-qtest-s390x: tests/qtest/virtio-ccw-test
>     TEST    check-qtest-s390x: tests/qtest/cpu-plug-test
>     TEST    check-qtest-s390x: tests/qtest/migration-test
>   **
>   ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'got_stop' should be FALSE
>   ERROR - Bail out! ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'got_stop' should be FALSE
>   make: *** [tests/Makefile.include:633: check-qtest-s390x] Error 1
> 
> Per David Gilbert, "it could just be the writing is slow on s390
> and the migration thread fast; in which case the autocomplete
> wouldn't be needed. Perhaps we just need to reduce the bandwidth
> limit."
> 
> Tuning the threshold by reducing the initial bandwidth makes the
> autoconverge test pass.
> 
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Message-Id: <20200323184015.11565-1-philmd@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


This slows make check down significantly for me, it stays
at the migration test for minutes.

I'm carrying a revert at top of my tree for now but I'd rather
not need that.


This seems like a fragile way to test things anyway.
What happens if someone slows writing even more
e.g. because it's running in a container or a VM?

How about detecting that migration finished too early
and slowing it down until autocomplete triggers?



> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 3d6cc83b88..2568c9529c 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
>       * without throttling.
>       */
>      migrate_set_parameter_int(from, "downtime-limit", 1);
> -    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
> +    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
>  
>      /* To check remaining size after precopy */
>      migrate_set_capability(from, "pause-before-switchover", true);
> -- 
> 2.25.1
> 
> 


