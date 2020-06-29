Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EF2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD8B2462D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7tgGmz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD8B2462D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvZ1-0003NO-0P
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvWz-00029I-8g
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:17:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvWu-0000Yl-Jx
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593443827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1eQnIxetoLTVhts6nPwLObr6VMOIStBgm/GEi7/YYI=;
 b=J7tgGmz8mOPsNeHAIZK2a26beoBRnq9LM6HT91gNwAbOCj+pkgot3VodX7tVP/hgxWe/8A
 1v9+Ct9TUllLRgGk7nQPsrSSginZOLeewrcfHOsmvNrfk8km7AuJvjRMDgCt8gEeGxeWK1
 yMvB2rLIgvtB1tXNo8fyVBr1q0tYR/8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-ObZHVGzXPJuSeYuyprzxnw-1; Mon, 29 Jun 2020 11:17:06 -0400
X-MC-Unique: ObZHVGzXPJuSeYuyprzxnw-1
Received: by mail-wm1-f69.google.com with SMTP id y204so7478733wmd.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r1eQnIxetoLTVhts6nPwLObr6VMOIStBgm/GEi7/YYI=;
 b=a0cKhWAh4/XCsSO6pjHKiWZByW8qD84QmoxIBzF82EQDeerm7t9TDgr1ULEh9oiNtS
 k2Lxon0SKne04sNPSDKNOGiO8ZpoEczpSJ/DDJhnFO6dF6rbueaREnF9Fo9w5+yzYnRY
 H6TrTbYQUByiORCoQQ44YcamT/VEhRxFi78VjV7zahf/moPDnkMYyh9ei5NFsmBWcCdP
 Gn/omaRptTHWomRNT6Woce/YLoelOLdB5RlJQSymIPAukmR4uUXxLClNJKGieWwS0MoR
 lyV+sUGkDtiOqCKpfimWhatuXnQCpAinD2tbX7nKEzLz3dq+a4pE3ooJ099GVNCHhYBD
 F6oQ==
X-Gm-Message-State: AOAM532Kui65d+6UfMKBekD1+RC5dAbIJZMd/NiQ9B/QRCSHynyDHecS
 knFNxvqOr1GerVfEiohDiatdin3m4/erVzJBDVcgXEJPvQLHzkOyeYM3Iiq/7Vlf91226Gd1EoJ
 7bTIIGhbf5qcBR7E=
X-Received: by 2002:a1c:b6c3:: with SMTP id
 g186mr17808865wmf.135.1593443824717; 
 Mon, 29 Jun 2020 08:17:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4wu2SuOIl7KZrVjbcgc7sKl3xSAugvT44YMDqY0RuTcHv9jz4pBj4Jw9R7rB3YKseMYwGJg==
X-Received: by 2002:a1c:b6c3:: with SMTP id
 g186mr17808840wmf.135.1593443824449; 
 Mon, 29 Jun 2020 08:17:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id o205sm149377wme.24.2020.06.29.08.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 08:17:03 -0700 (PDT)
Subject: Re: [PATCH] tests: Inject test name also when the test fails
To: Havard Skinnemoen <hskinnemoen@google.com>, qemu-devel@nongnu.org
References: <20200628213046.2028271-1-hskinnemoen@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8532e28d-2d7b-0671-8f62-b64eb5d29781@redhat.com>
Date: Mon, 29 Jun 2020 17:17:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200628213046.2028271-1-hskinnemoen@google.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/06/20 23:30, Havard Skinnemoen wrote:
> If a test is unsuccessful, the result is "not ok", which does not match
> the regex because it includes a space.
> 
> This regex matches both "ok" and "not ok".
> 
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3f4448a20b..09df2d3f86 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -637,7 +637,7 @@ define do_test_tap
>            { export MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} $2; \
>              $(foreach COMMAND, $1, \
>  	      $(COMMAND) -m=$(SPEED) -k --tap < /dev/null \
> -	      | sed "s/^[a-z][a-z]* [0-9]* /&$(notdir $(COMMAND)) /" || true; ) } \
> +	      | sed "s/^\(not \)\?ok [0-9]* /&$(notdir $(COMMAND)) /" || true; ) } \
>  	      | ./scripts/tap-merge.pl | tee "$@" \
>  	      | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only), \
>  	  "TAP","$@")
> 

Queued, thanks.

Paolo


