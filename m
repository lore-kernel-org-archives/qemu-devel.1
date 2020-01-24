Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CE7C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C6E20838
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsF5chIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C6E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvRJ-0003dc-62
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuvQU-0002h2-3p
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuvQS-0005VB-Se
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:38:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39329
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuvQS-0005V2-Ow
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579858732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBL0I8ZQ+bCwWqG8VxW9HfKdWxgIJ0PesUPuydobCVc=;
 b=AsF5chITOXVYWV6EgtvPgjUo0XQrXapq0dexWorj0qGY6J1WVc5OMggIIpoeWRR3ANX6s5
 Ja0Sbdmj6SXOmY859H1ya7O1Rx8xMdiO8KmxicOPp5AfQm+KWBAtJit/bw+P3OvBRhuu7q
 OJggMgoLF1nKsR5IAsM9OGoqBoA/Udo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-rMXLSAn_PY2oitwtw4nciw-1; Fri, 24 Jan 2020 04:38:47 -0500
Received: by mail-wr1-f70.google.com with SMTP id f15so904047wrr.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 01:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hBL0I8ZQ+bCwWqG8VxW9HfKdWxgIJ0PesUPuydobCVc=;
 b=dmuFthnyRxRfHsP4jyJds//oNA9JzeUZ6AmGrUiZ7Hr/V/ILDaiVcTpV/3YQaeaoEn
 DoM7+CUm3XFquhM5t6CUtPNWbeuSTBEiNWF3AvpIMvA7yttgalYjwIrzVmd/n6WI20bK
 ZBsLljY6RZk6+n1PcFZmdBHIG/Cz5rO/ro9piAnKkdy90wQ1UZNp+MtV+8LyQJ1h2+X1
 gtHCIREmPfUn3BIHyKKzgF9LhQeh7OAKruUhAH5i+HucUNLp7eN5P716gMbhzp54YF3l
 bOjjlGjdh4Po0NVLhUMjoLDeDbLzEwDMQ6SVtL444v9PNvaJSDrjqyzgw/Tfpql+g9pM
 XSVQ==
X-Gm-Message-State: APjAAAVX1+Nrw3zu7Raj4DMtsgHMNYK6ITtV/pT5IWsbjxbjqeyJIF3P
 cGaSIhGGKDhV+5DO2nuCpkekqvohd3sEFleCfDyemNWa4qUFIi7VN+9mu4PYKjcCgmF/O2A5iE/
 073RcQXyJaKSnslw=
X-Received: by 2002:a1c:964f:: with SMTP id y76mr2416066wmd.62.1579858726670; 
 Fri, 24 Jan 2020 01:38:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqz59ciFEiTXYQvU8c5TbUK8WClQnPcTObQcaPZZVxa4XWz6hM9M4oZNAjYOEegy76noDxbR6A==
X-Received: by 2002:a1c:964f:: with SMTP id y76mr2416050wmd.62.1579858726392; 
 Fri, 24 Jan 2020 01:38:46 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id p17sm6586535wrx.20.2020.01.24.01.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 01:38:45 -0800 (PST)
Subject: Re: [PATCH v3 4/4] travis.yml: Enable acceptance KVM tests
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-5-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e500a1ce-d2b6-b372-b1cb-f9bddcbf8334@redhat.com>
Date: Fri, 24 Jan 2020 10:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122012753.9846-5-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: rMXLSAn_PY2oitwtw4nciw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, alex.bennee@linaro.org, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 2:27 AM, Wainer dos Santos Moschetta wrote:
> Some acceptance tests require KVM or they are skipped. Travis
> enables nested virtualization by default with Ubuntu
> 18.04 (Bionic) on x86_64. So in order to run the kvm tests, this
> changed the acceptance builder to run in a Bionic VM. Also
> it was needed to ensure the current user has rw permission
> to /dev/kvm.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   .travis.yml | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 6c1038a0f1..c3edd0a907 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -2,6 +2,7 @@
>   # Additional builds with specific requirements for a full VM need to
>   # be added as additional matrix: entries later on
>   dist: xenial
> +sudo: true
>   language: c
>   compiler:
>     - gcc
> @@ -83,6 +84,9 @@ git:
>   
>   before_script:
>     - if command -v ccache ; then ccache --zero-stats ; fi
> +  - if [[ -e /dev/kvm ]] && ! [[ -r /dev/kvm && -w /dev/kvm ]]; then
> +        sudo chmod o+rw /dev/kvm ;
> +    fi
>     - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>     - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
>   script:
> @@ -272,12 +276,13 @@ matrix:
>           - TEST_CMD="make check-acceptance"
>         after_script:
>           - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
> +      dist: bionic
>         addons:
>           apt:
>             packages:
>               - python3-pil
>               - python3-pip
> -            - python3.5-venv
> +            - python3.6-venv

This line doesn't seem related to the patch.

>               - tesseract-ocr
>               - tesseract-ocr-eng
>   
> 


