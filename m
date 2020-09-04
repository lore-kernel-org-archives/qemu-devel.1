Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D64C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058EE206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqab5VeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058EE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEyM-0000U1-Rf
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEExe-00089P-Jx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:53:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEExc-0001U4-6k
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599238390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0gWu2qLe9rSwWeLZ2x5ugNJU7QobZlbj5hj9gAHE2cA=;
 b=aqab5VeY6TLVkcCMNU4WkMtBrkZe1C2aJD2NAsB+UjgQKkHyhjnVQW0AIl33f/25M/xC+W
 mxbByH3PaHRNMJNXhIgsy2nqerNZHm9VUeg7yGQ8e7qeS3ak6cH75cUC7j6RMXRb7Ii7wP
 +OtkDOTKsN+lTE+AzVTl0YpewbCW5VA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-aIKohMn4MX2MOqmJ9P4rfw-1; Fri, 04 Sep 2020 12:53:09 -0400
X-MC-Unique: aIKohMn4MX2MOqmJ9P4rfw-1
Received: by mail-wm1-f71.google.com with SMTP id m125so2384158wmm.7
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0gWu2qLe9rSwWeLZ2x5ugNJU7QobZlbj5hj9gAHE2cA=;
 b=Ibua0d9yvH+GezmjHcSWvZ/L96DxNghnJf0TNNeyOKcquUuLCUux8+DACwtEit1+Rz
 jF2DC4EBZQrjDOVATJjJS/50pF0twqMfEbUqe6y2cDc1S71ZyordTP+mS5fmoT4j1Mqe
 P+1WTvEq9g0zcgTWaCliQsL6bMZcxodXgxfm7nYl59HNBxd3pnE4RCRas6wSVmkQvI44
 eO3NeEj68KP9lGtKbDVUnyfjKv/sm6iHTtT0HIuawKptkByR7B4bLzDQl7mFb9rzUSKS
 GJb7C0/YbbE4EIEISK75HRJd3Od1LJL28dhndM+FqlfOh/I7uguk3Kur8OdejhlcltSS
 6nhg==
X-Gm-Message-State: AOAM532HIpUuiDg9CWNxlwz+/pgrDJSzktp0vj67bcht6awiCd66qb8M
 CCgzba/MZZGFhCwXRDzbSG5XyupVcJvzRgICKfnYPT6xp3uMoPvTJzAM1kEE/Nlrb9wnI8wrEGY
 8DFnoY9vzaZnootk=
X-Received: by 2002:a05:600c:20b:: with SMTP id
 11mr8796679wmi.147.1599238388244; 
 Fri, 04 Sep 2020 09:53:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxydwDOudmHTYjUWIUDpc+zQKIBDqMCIyTjKJ8zNON/oZEG+bqdmdNuqJNn5f5qgSfXZSMFw==
X-Received: by 2002:a05:600c:20b:: with SMTP id
 11mr8796659wmi.147.1599238388025; 
 Fri, 04 Sep 2020 09:53:08 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id r15sm12238378wmn.24.2020.09.04.09.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 09:53:07 -0700 (PDT)
Subject: Re: [PATCH 2/7] scripts/ci/gitlab-pipeline-status: improve message
 regarding timeout
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200904164258.240278-1-crosa@redhat.com>
 <20200904164258.240278-3-crosa@redhat.com>
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
Message-ID: <d232b6d8-3302-ecea-7136-340c01d87c8c@redhat.com>
Date: Fri, 4 Sep 2020 18:53:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904164258.240278-3-crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 6:42 PM, Cleber Rosa wrote:
> The script has its own timeout, which is about how long the script
> will wait (when called with --wait) for the pipeline to complete, and
> not necessarily for the pipeline to complete.
> 
> Hopefully this will new wording will be clearer.

too many wills?

> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/ci/gitlab-pipeline-status | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
> index 194dd4d0bb..2a36f74696 100755
> --- a/scripts/ci/gitlab-pipeline-status
> +++ b/scripts/ci/gitlab-pipeline-status
> @@ -69,7 +69,10 @@ def wait_on_pipeline_success(timeout, interval,
>      start = time.time()
>      while True:
>          if time.time() >= (start + timeout):
> -            print("Waiting on the pipeline timed out")
> +            msg = ("Timeout (-t/--timeout) of %i seconds reached, "
> +                   "won't wait any longer for the pipeline to complete")
> +            msg %= timeout
> +            print(msg)

Isn't it more pythonic / cheaper to declare the msg format out
of the loop and call directly:

               print(msg % timeout)

?

>              return False
>  
>          status = get_pipeline_status(project_id, commit_sha)
> 


