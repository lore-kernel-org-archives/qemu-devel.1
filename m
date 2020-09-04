Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE95AC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 17:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C13206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 17:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjSi24rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C13206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEF4I-0003NW-Jo
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEF3k-0002ss-5J
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:59:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36273
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEF3i-0002Gn-Io
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599238769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Iah12nhRI2YNAweJb41ywig/D/Ge2O1NI4HI0xI5l6A=;
 b=DjSi24rgDj9qE5tJsw2sUAkYNvNVnQ4SL1fr5wRm4QYaLGETXqUt62pBBsJ162y3Nlb8OH
 PlDjoLc/jhrTVyovzeVmk70Zdm8ff7WSuKC3GGCWpQVs40B9w3LI4cC2Xox7Ue092LXRAj
 q3c6jSQrknRP3VVHUo4rfk3KVFeau40=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-fCV2zOLxPtesNg8uIpjQ5w-1; Fri, 04 Sep 2020 12:59:26 -0400
X-MC-Unique: fCV2zOLxPtesNg8uIpjQ5w-1
Received: by mail-wm1-f71.google.com with SMTP id c72so1907658wme.4
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Iah12nhRI2YNAweJb41ywig/D/Ge2O1NI4HI0xI5l6A=;
 b=pMwEa8BVN9Ot47EHBB0R0GUYN6TSvVsWA+yHOpH3fbCNUsGSOcq6yKLTBAqIgixifZ
 hl/KVIiBGBPn5km+IvY9P6od5TRktH7AQeu6qDSFf+UyxhXHld1KrMDAlbX2EzJb30pC
 e6ZcRVCZMNbMk5oRnXf1ax9TmuplCfriz9Mh46ustpqcGAlmJ8TlyI7FgbnnEcPhxmSE
 tEolG+gi8okATuvsbb/Pz+xj1iz6av35asBriGzH/rRQKjpqe/Nih5pgG1nGzDTU5+fN
 0PCJL9vnzADtiBbTGaclmS+9Ou2D7RRGSqF0sc9irYj6D6Dm+ke0lyK1zDYBZ6dxZvVm
 L07g==
X-Gm-Message-State: AOAM532UZsGrXxCJ6ZzxeEcIDIL92bpLhx86Q4lpXnA8ZhwjdtL0MWbO
 tx6eEzt4c4SdPawhFRWbHg7PpsqeLQMlcVisfcgkx0exlOMGsaP4OIJtt7VB9+wuB3E2HDBa0f6
 nJmvqkdE1Y5Qh0bA=
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr8584591wmj.30.1599238765694; 
 Fri, 04 Sep 2020 09:59:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw54m4RaJQ1SX04GzmGClsAVeQT/5/KyHuotYaSV5Qqklnj1PQy7f3FlxIwc112tQ5Mr8zsZA==
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr8584568wmj.30.1599238765432; 
 Fri, 04 Sep 2020 09:59:25 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id f3sm12294939wmb.35.2020.09.04.09.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 09:59:24 -0700 (PDT)
Subject: Re: [PATCH 3/7] scripts/ci/gitlab-pipeline-status: give early
 feedback on running pipelines
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200904164258.240278-1-crosa@redhat.com>
 <20200904164258.240278-4-crosa@redhat.com>
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
Message-ID: <c6940533-2bbe-8883-5b00-a2ae17df9864@redhat.com>
Date: Fri, 4 Sep 2020 18:59:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904164258.240278-4-crosa@redhat.com>
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
> When waiting for a pipeline to run and finish, it's better to give
> early feedback, and then sleep and wait, than the other wait around.
> 
> Specially for the first iteration, it's frustrating to see nothing
> while the script is sleeping.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  scripts/ci/gitlab-pipeline-status | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
> index 2a36f74696..18609553be 100755
> --- a/scripts/ci/gitlab-pipeline-status
> +++ b/scripts/ci/gitlab-pipeline-status
> @@ -77,8 +77,8 @@ def wait_on_pipeline_success(timeout, interval,
>  
>          status = get_pipeline_status(project_id, commit_sha)
>          if status['status'] == 'running':
> -            time.sleep(interval)
>              print('running...')
> +            time.sleep(interval)
>              continue
>  
>          if status['status'] == 'success':
> 


