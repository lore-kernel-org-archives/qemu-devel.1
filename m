Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E123C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28FD20BED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsHFmCRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28FD20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLn14-00038C-Ra
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLmuo-0006fY-T5
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLmum-0007DT-DS
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:33:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601037206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZhT6Bgbl0Hr4v9IxqRqkRrfRBdCzw4/DyBA23D2rH0Q=;
 b=FsHFmCRusYhCZr56Exdyk7GGVSviLLGDvEz/7EwsIwyVylwJqW7Oh/uZBbGfi+5x3QZ7cO
 Wq5FCBZ4sYIob6xmU999TlKHm2rK/edD7JZl/r7h4lgBArZ3DCT658E23LZrPBbqI6ysSP
 j9c11eHf3r0rqT2+M3NdXcRU33Krrvs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-OnVhysnYMGGArOrJpjABTw-1; Fri, 25 Sep 2020 08:33:22 -0400
X-MC-Unique: OnVhysnYMGGArOrJpjABTw-1
Received: by mail-wm1-f70.google.com with SMTP id l26so777666wmg.7
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZhT6Bgbl0Hr4v9IxqRqkRrfRBdCzw4/DyBA23D2rH0Q=;
 b=Htn+NujTcdy62w6Yw4ZIGuTErwprZiRXwV26EvfayZYN1TGMrFVlEXF3jYCLaQPAJ6
 acD2e8pJftmbxS8Zu2ksEUiFToY0Jur1Cy8OSp/61trivOnLfUpiRmrUa03t5cOSY1KB
 aHM5mr7MapHvNA0SCmWImSCfFjbrWhE9oEfL+CLdBEB0pqJ8U5t6t1QTILXGP4ru+H6h
 WPbX4ZshF7Ob9tQJ9SH/ZYfxtBORQgNYAH+giDYsaopEocS6uZC38ytDBnR1PXnncyQ2
 a+D6mnzh6NddYDzI5lB28Qi7NlWorRcgHmUWuMd9js59RycCoU7IypSB/Sbizuk99SqI
 CfSA==
X-Gm-Message-State: AOAM533bCcKNfXd76Tx1vBA3r2gu8/FqTtOZf76P2ZP6/YeOhnrl5VQI
 nlygyxO/Ezoy+4bIFfm/tmCUGhinJQGfwOY4gT7nrfV7w1KsSjs1ObR1y2NggZjY4ZTWwbssOMa
 QpLjmOxwaawPfeXc=
X-Received: by 2002:adf:f24f:: with SMTP id b15mr4557668wrp.301.1601037200605; 
 Fri, 25 Sep 2020 05:33:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbijBBl4aGWFG5lCq5OKIFGAi3NNDcrgx9XhRmzPTMSdQ/hWx/UiB7AAlhHWcykmh3i3Jglg==
X-Received: by 2002:adf:f24f:: with SMTP id b15mr4557644wrp.301.1601037200350; 
 Fri, 25 Sep 2020 05:33:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id 97sm2596029wrm.15.2020.09.25.05.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 05:33:19 -0700 (PDT)
Subject: Re: [PULL 00/11] capstone + disassembler patch queue
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200922174741.475876-1-richard.henderson@linaro.org>
 <CAFEAcA9u_hj3uAn8qSYPovkH3vcwxxYxcm0cbqUJkDhpP=8VFw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a018601c-511c-be16-4862-d7b9c050f371@redhat.com>
Date: Fri, 25 Sep 2020 14:33:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9u_hj3uAn8qSYPovkH3vcwxxYxcm0cbqUJkDhpP=8VFw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 12:03, Peter Maydell wrote:
> 
> Linux qemu01 4.15.0-72-generic s390x
> From https://git-us.linaro.org/people/pmaydell/qemu-arm
>    8c1c07929f..a53ea1e6f9  staging    -> pmaydell/staging
> Fetching submodule capstone
> From https://git.qemu.org/git/capstone
>    fc236325..4457d451  master     -> origin/master
>    02af5976..2f38802e  next       -> origin/next
>    d57e7af3..7ca653c7  v4         -> origin/v4
>  * [new tag]           4.0.2      -> 4.0.2
> make: Entering directory '/home/ubuntu/qemu/build/all'
> config-host.mak is out-of-date, running configure
> make: *** No rule to make target 'capstone/all', needed by 'Makefile'.  Stop.
> make: *** Waiting for unfinished jobs....
>   GIT     ui/keycodemapdb tests/fp/berkeley-testfloat-3
> tests/fp/berkeley-softfloat-3 meson dtc capstone slirp roms/SLOF
> cross containers  no

I think this is just temporary and running "make" again would fix it.
It can be worked around too, though.

Paolo


