Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA99C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E104206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edbVwr3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E104206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgusO-0000Tt-5r
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgurk-0008TG-H3
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:45:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22991
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguri-0002NT-CM
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591296321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOEx89caHkL2CykDbowt/iDZiR6VUF8L7i3XdAnceF4=;
 b=edbVwr3pV9AZhvoVMXbAebxQoW8aWyY8UfrG53M6ETz01nQQOEQU6Q4BqmvZkE+Cr3V3vp
 ueIqrqKA89syBaWdKX6aZuFWxHUVS+jNmBGY57eFpwK6XYn3qvcBZPEfTTYJcUaavdfxX8
 xKj6mdZvMAayMy9l2d+Tg5+GfvjeQRE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-0vjc1AByMfquOyHtg2_Nbg-1; Thu, 04 Jun 2020 14:45:18 -0400
X-MC-Unique: 0vjc1AByMfquOyHtg2_Nbg-1
Received: by mail-wr1-f72.google.com with SMTP id p10so2774485wrn.19
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 11:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NOEx89caHkL2CykDbowt/iDZiR6VUF8L7i3XdAnceF4=;
 b=Ycv+k8kh+YvNlubF0dFpOuRZRfkh6TW3UTTrjcvkw3fcicxAm+F4lzWg2b0tQYLkkd
 JdjcWe/YhrAEGxNPqtWh6XTpEZltRHT0KCc/lwlxqxP5qVK6mxlV7FgVrCzf6HjvhyIz
 1oWY060ztFjz9NiTZFLEObrAqAF0B5HEAAIVdQkTidjUMvqRFE3dXPDgvVwVPqOqSbEQ
 tZCthX/rpFhP2xVO+r63yt5/t2zKMBqPly8jNS1CvgS/f02QXFMBsGhH2oeaQHqtgNDy
 0kO4fqy1gxJotNhB9ZOLDZgP4/3Pw3lNxkzLfDbz52dQ/9aBuHdQ4RDhJtU4jKEYyDBH
 +x7A==
X-Gm-Message-State: AOAM532Am66nNhEy8iZXcUJIUQlCvk7oQ/sSP9ZTfVo+sVhHRQaEEuYa
 5ICvfqJ5tMA1RNkwi7MI9EmRayuTsRcaLZWHT2CbRkv3HtbQydKWQle4kk+qTBctBsHxVrZxE3P
 yXYAFY6FIevxL7xI=
X-Received: by 2002:a1c:4857:: with SMTP id v84mr5089718wma.96.1591296317268; 
 Thu, 04 Jun 2020 11:45:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7ofyc9OVeG2df3Q+WPE/8t047teuZvoE7mYTeBm2vjHqKid56SyBWWJgjDhPf+12LtNojMQ==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr5089701wma.96.1591296316977; 
 Thu, 04 Jun 2020 11:45:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id q5sm9161377wrm.62.2020.06.04.11.45.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 11:45:16 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: reversed logic with acpi test checks
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20200602053614.54745-1-mst@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b03eaa8c-fb1d-523a-6e41-c1d4ceaafd53@redhat.com>
Date: Thu, 4 Jun 2020 20:45:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200602053614.54745-1-mst@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:58:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/06/20 07:36, Michael S. Tsirkin wrote:
> Logic reversed: allowed list should just be ignored. Instead we
> only take that into account :(
> 
> Fixes: e11b06a880ca ("checkpatch: ignore allowed diff list")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 0ba213e9f2..55aa45dc16 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1267,7 +1267,7 @@ sub checkfilename {
>          # files and when changing tests.
>  	if ($name =~ m#^tests/data/acpi/# and not $name =~ m#^\.sh$#) {
>  		$$acpi_testexpected = $name;
> -	} elsif ($name =~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
> +	} elsif (not $name =~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
>  		$$acpi_nontestexpected = $name;
>  	}
>  	if (defined $$acpi_testexpected and defined $$acpi_nontestexpected) {
> 

Queued with "!~" to achieve the logical not.

Paolo


