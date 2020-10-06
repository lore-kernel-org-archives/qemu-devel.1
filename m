Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCA2C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9CA20782
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hm9+9FZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9CA20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPr2O-0004nd-MN
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPr1V-0004Fw-Qb
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPr1U-0000NE-7R
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602006311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/j0izEwkRMqaYR3cmrmvMisLv+r2OAg54P/ktyXwRL0=;
 b=hm9+9FZqiZcupeC6NcEpgaHWEyEupixhqeN/BT0QvUPqmKmbTCwGUTUwlo55mdjc1g6oVJ
 yIqZiyimK5GhsIuk6+Ez4/Sv/wOYWdiaxsW97lJ0p7G4PD44PLTh4l6icpdBBlaOkNGKJ2
 uXZ95Rho5YUrnb2ZrKA8sYkSPIiNcYs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-Nz8CrD48PoGTaQGWwSFCGg-1; Tue, 06 Oct 2020 13:44:55 -0400
X-MC-Unique: Nz8CrD48PoGTaQGWwSFCGg-1
Received: by mail-wr1-f71.google.com with SMTP id b2so5590560wrs.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 10:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/j0izEwkRMqaYR3cmrmvMisLv+r2OAg54P/ktyXwRL0=;
 b=WtWNilsjsYpWcszjVhNobWremiykGsXmj2AQ78xtaX64/XS3VfKlkUKU9Pth5K+h21
 tSRctibKYb7vjtkZBT3LtiVe4nCcUJZNQvROsXgpJ2jA6S0DP394CcDdXG5RsroEoG3w
 CyqBraqOcglo8liQ8LHecDXka74PX0BH1V6nBTDIUmhKj5VnOqHeUd9FcA7m9OxNZsdc
 bGsLDtZY4vyKkpTF1KF6tkBK4ZbLW8ZFkQDJPyVt1/XQ/03I1BKVlKr64CoVbtxwurFl
 ED0DCVNqhVAaBxAKNBqnLcYPKE4VEa8jc9U2oub1d6G6mB88gWEBT+0FAWT6rlkEYx/r
 LkAQ==
X-Gm-Message-State: AOAM5315TFMNaqjaoj27wnRc8oKsDU9HZbiu9xqiVip9ct6Vnft615Hu
 6XEEkq4YqGM58GV7MbxnZV6Lvlk2Qdv6ncEe8uOE0p97THWPsXtlIJ85FigH1CCgjfs8/e1Ym/K
 aGLTtYlvAuPvw9q0=
X-Received: by 2002:a05:600c:214c:: with SMTP id
 v12mr4165347wml.23.1602006294200; 
 Tue, 06 Oct 2020 10:44:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb8rMSzFHnzbebH0XoFQkFSn2yUKyVlcRkY6YTCq5E/tKmdeogVqS1qdwWqSudwI81ekOs+w==
X-Received: by 2002:a05:600c:214c:: with SMTP id
 v12mr4165326wml.23.1602006293923; 
 Tue, 06 Oct 2020 10:44:53 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j101sm6254782wrj.9.2020.10.06.10.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 10:44:53 -0700 (PDT)
Subject: Re: [PATCH] tests/docker: Add genisoimage to the docker file
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201006174347.152040-1-thuth@redhat.com>
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
Message-ID: <a9e55b3e-4f15-fdd2-2836-c88e6d505a30@redhat.com>
Date: Tue, 6 Oct 2020 19:44:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006174347.152040-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 7:43 PM, Thomas Huth wrote:
> genisoimage is needed for running the tests/qtest/cdrom-test qtest.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/docker/dockerfiles/centos8.docker      | 1 +
>  tests/docker/dockerfiles/debian-amd64.docker | 1 +
>  tests/docker/dockerfiles/fedora.docker       | 1 +
>  tests/docker/dockerfiles/ubuntu2004.docker   | 1 +
>  4 files changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


