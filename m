Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA13C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 15:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A711B20671
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 15:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlWJQdwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A711B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfPbh-0000re-Qm
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 11:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfPau-0000DB-NJ
 for qemu-devel@nongnu.org; Sun, 31 May 2020 11:09:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfPas-0003HO-7H
 for qemu-devel@nongnu.org; Sun, 31 May 2020 11:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590937785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2qKs0xPbBqPQwYY9jfgEEMbNuK/sXQhVPogH2Vn+iFQ=;
 b=dlWJQdwgxhuzfvXzm3bR1Ueb40TbBQjtA8YcH1F6GKrcuLk2HGFKgtIH9p+8HCZd0KMVB7
 ans+saf453i0prFbtt7bP2/gBv6sKV69QpY4BljagPfXPju4AWytUsgYALENAUsBbP2itg
 4DshDqOj0vCc0RXSzkqL6FPkWJnFEOo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-TM1K7WCkO1W8NYzGUm00qA-1; Sun, 31 May 2020 11:09:42 -0400
X-MC-Unique: TM1K7WCkO1W8NYzGUm00qA-1
Received: by mail-wm1-f71.google.com with SMTP id q7so2130343wmj.9
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 08:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=2qKs0xPbBqPQwYY9jfgEEMbNuK/sXQhVPogH2Vn+iFQ=;
 b=dbIcXakECYbeqGmpjUh35EXhNJnGxQp2JhvpSWvCaHNgJvUvv/zVYeKko6eCAtqsN6
 ZpClVmN04kecjgHqIrc89iP25K7QIx/MapFmKE5UA0EjopzRU8LIkw167XN/a+zqYV+9
 egDNTtYnzvk2YV9q/XEqpZW2KPgEG5nZPlboDENu5WVEk/gDLIvvlsHZWFl/GiBcHW/5
 Cwjx+9kwAilZmOsaVUC1Uly5UUqiY656UIu4xmlVeuQ+9SO4qT3WrRGjt4rNVTKkAKGq
 I5BNXws+Ou2jM/rOKRWVwpOhfPtJvgMl429WIrAimmFW+eFzSy8F1gfuw0GFrba7ARui
 hfRw==
X-Gm-Message-State: AOAM531Ka3C+kMQuTteddHcyklGiWsv7bO9+M5RGCnxdEmC81SlMNilj
 1cKtNPz+AaSzcJ2Fi3vjdFF58g3Dw0j0FzG+q4cjVmiQUyV1u2fwglp40trkPu4pPzRxxFKy8B+
 0/rDed/Q6D40WvJ4=
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr17248550wmg.17.1590937781533; 
 Sun, 31 May 2020 08:09:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4f4ehMPmhq8yxF3liqjsXCQR8J/gXF8LjQdPdnbh0SiDCfuI0bEwyKEv4LryhPAuxQAIvlQ==
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr17248530wmg.17.1590937781307; 
 Sun, 31 May 2020 08:09:41 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id d5sm18033414wrb.14.2020.05.31.08.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 08:09:40 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] Record/replay acceptance tests
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <159073587336.20809.5404476664125786279.stgit@pasha-ThinkPad-X280>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <540831cc-c5b0-cf10-6889-bab499729a53@redhat.com>
Date: Sun, 31 May 2020 17:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159073587336.20809.5404476664125786279.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 11:09:45
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
Cc: wrampazz@redhat.com, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 9:04 AM, Pavel Dovgalyuk wrote:
> The following series adds record/replay tests to the acceptance group.
> Test pass successfully with the latest submitted record/replay fixes:
>  - replay: notify the main loop when there are no instructions
>  - replay: synchronize on every virtual timer callback
> 
> The provided tests perform kernel boot and disk image boot scenarios.
> For all of them recording and replaying phases are executed.
> Tests were borrowed from existing boot_linux*.py tests. But some
> of the platforms and images were excluded, because icount for them
> still has some issues.
> 
> Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
> 
> v3 changes:
>  - Added record/replay logging (suggested by Philippe Mathieu-Daudé)
>  - Changed the console pattern to get longer kernel execution (suggested by Alex Bennée)
>  - Coding style fixes
>  - Other minor changes
> v2 changes:
>  - Some test structure refactoring (suggested by Willian Rampazzo)
> 
> ---
> 
> Pavel Dovgaluk (11):
>       tests/acceptance: allow console interaction with specific VMs
>       tests/acceptance: refactor boot_linux_console test to allow code reuse
>       tests/acceptance: add base class record/replay kernel tests
>       tests/acceptance: add kernel record/replay test for x86_64
>       tests/acceptance: add record/replay test for aarch64
>       tests/acceptance: add record/replay test for arm
>       tests/acceptance: add record/replay test for ppc64
>       tests/acceptance: add record/replay test for m68k
>       tests/acceptance: record/replay tests with advcal images
>       tests/acceptance: refactor boot_linux to allow code reuse
>       tests/acceptance: Linux boot test for record/replay

Thanks, patches 1/2/10 applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next

- tests/acceptance: allow console interaction with specific VMs
- tests/acceptance: refactor boot_linux_console test to allow code reuse
- tests/acceptance: refactor boot_linux to allow code reuse


