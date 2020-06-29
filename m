Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31A4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B80823884
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIJDrRRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B80823884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqit-0007fV-RP
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpqgp-0005HU-EF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:07:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43236
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpqgn-0005Nj-Jh
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593425221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ebtbzuShKdFsnLEEnvlghxuCH/oUBzNFvOMFpJTb4PY=;
 b=GIJDrRRbmhm6dj0FrAj/CtawC4vDOWcLKF9Q05C1kj4HjrHLoDN9X1e+C4l0qhXz+kekhq
 eRjIjRMLLQkVYPSW8QGNgFSe4UjH0D8ES8OWp7eQjK5TqrX0H6wTNqvStFHTrwytuXTfDE
 z0hbmycftp8OsHusfyLr8B0vj2v47DI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-aDj6HH4eOPOQNdCzEOwFDQ-1; Mon, 29 Jun 2020 06:06:57 -0400
X-MC-Unique: aDj6HH4eOPOQNdCzEOwFDQ-1
Received: by mail-wr1-f72.google.com with SMTP id z3so16303291wrr.7
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ebtbzuShKdFsnLEEnvlghxuCH/oUBzNFvOMFpJTb4PY=;
 b=ePYEEO7ayeZa4yxFqRiTvEapEB8TvG6S40lHjO8zpAr7lwwnSICIfezirorht90oaH
 IAyZ23tYsmMfhOHGbtM6CKbTs8gFLkDTn6aDop6KHAz3lUzyLGA7eL2cbiVzWp+oHkAB
 WCNSKzUtpfv+bDXxzL3xIRaYSXKFhPCdE8mHn534KSpeeoBy1XgpOZYOILqm7EwmrbmK
 jXqleV7UcBU+Etr2x11Vf8oEtiPrafXxV8UZKfPF1qXit+qIt+FNemHxeTPK7ahG7MZL
 cSqFmmJeMJZCN21++hDEwehTcxMtowDZobBe+a9iX+iBCMVG0AD1XPjL3mfi8dy1glx7
 f3kw==
X-Gm-Message-State: AOAM531tWyLsAmlvvJTmfhZWKiCA1jcSAIZzYE8x5hMK4ikG9AUToLH0
 2M+8dicM/xwkLqb+cM5Wb5TTR/zn3WoODsHhu2FlPRoPjtlh0Psl7vihwxgxIQSV0y9Pi3IcxnF
 tmisXyr3nR87q/Rk=
X-Received: by 2002:a1c:2503:: with SMTP id l3mr15678852wml.188.1593425216101; 
 Mon, 29 Jun 2020 03:06:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx75PigmuY4UP7EoMhNv7tgqxG6sDJA1dyvsFBMOHn9OQUAVEeDpti4jsyvAuNANRzbTt0LNw==
X-Received: by 2002:a1c:2503:: with SMTP id l3mr15678841wml.188.1593425215920; 
 Mon, 29 Jun 2020 03:06:55 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id q1sm33681268wro.82.2020.06.29.03.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 03:06:55 -0700 (PDT)
Subject: Re: [PATCH v3 09/30] tests/vm: change scripts to use self._config
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-10-alex.bennee@linaro.org>
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
Message-ID: <a58c1f3d-f877-588a-e0e5-738479248402@redhat.com>
Date: Mon, 29 Jun 2020 12:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626181357.26211-10-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, cota@braap.org,
 Peter Puhov <peter.puhov@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 8:13 PM, Alex Bennée wrote:
> From: Robert Foley <robert.foley@linaro.org>
> 
> This change converts existing scripts to using for example self.ROOT_PASS,
> to self._config['root_pass'].
> We made similar changes for GUEST_USER, and GUEST_PASS.
> This allows us also to remove the change in basevm.py,
> which adds __getattr__ for backwards compatibility.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200601211421.1277-8-robert.foley@linaro.org>
> ---
>  tests/vm/basevm.py | 11 ++---------
>  tests/vm/fedora    | 17 +++++++++--------
>  tests/vm/freebsd   | 16 ++++++++--------
>  tests/vm/netbsd    | 19 ++++++++++---------
>  tests/vm/openbsd   | 17 +++++++++--------
>  5 files changed, 38 insertions(+), 42 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


