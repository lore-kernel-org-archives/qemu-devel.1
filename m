Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B554C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2C6204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaMh9Bt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2C6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3hJ1-0005II-31
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 10:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3hIS-0004ny-E7
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:55:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3hIP-00049e-SI
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596725703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C8l/WJYe6RUP9ADPS/Cv5on6YDZjcAmDIdwpE4TvEUU=;
 b=ZaMh9Bt3zLn7MSXjmlSshfVtXNOtaohPY3VinW9RuY73JPhAc01NKr3T4MmnNLa/SDSwpa
 Ns6QNi+T+hrrr1jgOTMOqoQZYzvzCNwQtiVNNc07e4ot0cMcK47DijiVt3xPOFNT5el0Vr
 m+kTo3j/c2uoajgL4kerDIaB+F+P93E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-COnJIojhPo-Ih0FzuVrY6Q-1; Thu, 06 Aug 2020 10:55:00 -0400
X-MC-Unique: COnJIojhPo-Ih0FzuVrY6Q-1
Received: by mail-wr1-f71.google.com with SMTP id 89so14894373wrr.15
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 07:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=C8l/WJYe6RUP9ADPS/Cv5on6YDZjcAmDIdwpE4TvEUU=;
 b=OWH7DFUaPkR9oiyzyY3VfWypFM3/qaWDQIZnM4zfGXZ+2+dh/YlGcSLBe50YAlzapE
 FhrervP3xKWWMFIZROW2Z0IGUYuDfYBJFfkybXJiOJ2fAH2yHk1oPYrIOw6TCLjBEamm
 pe8P4U9AFAhOn/1gzQk6mYa7nPMuO0EOYePVGTpla34wCOQMZtlRpwX/Fv9vWb5u5k6X
 pUZvpJLLrauhYoBgXB48SkhthgnFaP+/DbYlCF9j5EsKROos0N1tXVNRrfI1Fc6rcFry
 6OkzL9xGwa0BGd+wlCErgwV7Ohv9etiPUQXe00cSjd2gDNArz+UTF+ozctrRZRXzTpS4
 /fAg==
X-Gm-Message-State: AOAM533gPQ4jHkprQbBI3BFJVn2YY5xOKIagBlZj1JE4ZsxF6LS8XCy6
 14K8stgyHAz4tYPO/a6YFoSxy/8H5pgUkK4gzPEBxGgfXIp8Zu/iaFiCZ/oEl/QN+HPO9cJhpof
 z9vPlZxzP/zdo2uQ=
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr7780648wrw.365.1596725699608; 
 Thu, 06 Aug 2020 07:54:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYVab/GQHFIOgZHggbfehz9HNfZmfu2aFGt9uk6jKVTFb988DQXMfhqluUxhW8yAlAa7+Zmg==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr7780632wrw.365.1596725699372; 
 Thu, 06 Aug 2020 07:54:59 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id i6sm6613234wrp.92.2020.08.06.07.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 07:54:58 -0700 (PDT)
Subject: Re: [PATCH 4/4] trace-events: Fix attribution of trace points to
 source
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200806141334.3646302-1-armbru@redhat.com>
 <20200806141334.3646302-5-armbru@redhat.com>
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
Message-ID: <792eea2f-0e73-0b02-9c0d-81e2b5fad249@redhat.com>
Date: Thu, 6 Aug 2020 16:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200806141334.3646302-5-armbru@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 4:13 PM, Markus Armbruster wrote:
> Some trace points are attributed to the wrong source file.  Happens
> when we neglect to update trace-events for code motion, or add events
> in the wrong place, or misspell the file name.
> 
> Clean up with help of scripts/cleanup-trace-events.pl.  Funnies
> requiring manual post-processing:
> 
> * accel/tcg/cputlb.c trace points are in trace-events.
> 
> * block.c and blockdev.c trace points are in block/trace-events.
> 
> * hw/block/nvme.c uses the preprocessor to hide its trace point use
>   from cleanup-trace-events.pl.
> 
> * hw/tpm/tpm_spapr.c uses pseudo trace point tpm_spapr_show_buffer to
>   guard debug code.
> 
> * include/hw/xen/xen_common.h trace points are in hw/xen/trace-events.
> 
> * linux-user/trace-events abbreviates a tedious list of filenames to
>   */signal.c.
> 
> * net/colo-compare and net/filter-rewriter.c use pseudo trace points
>   colo_compare_miscompare and colo_filter_rewriter_debug to guard
>   debug code.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/trace-events        |  5 ++---
>  hw/block/trace-events     |  2 +-
>  hw/char/trace-events      |  2 +-
>  hw/display/trace-events   |  4 +++-
>  hw/hyperv/trace-events    |  2 +-
>  hw/mips/trace-events      |  2 +-
>  hw/misc/trace-events      |  8 +++++---
>  hw/ppc/trace-events       |  6 ++----
>  hw/riscv/trace-events     |  2 +-
>  hw/rtc/trace-events       |  2 +-
>  hw/tpm/trace-events       |  2 +-
>  hw/usb/trace-events       |  4 +++-
>  hw/vfio/trace-events      | 10 ++++++----
>  hw/virtio/trace-events    |  2 +-
>  migration/trace-events    | 36 +++++++++++++++++++-----------------
>  target/riscv/trace-events |  2 +-
>  trace-events              |  5 +++--
>  ui/trace-events           |  6 +++---
>  util/trace-events         |  4 +++-
>  19 files changed, 58 insertions(+), 48 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


