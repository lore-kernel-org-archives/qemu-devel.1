Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB4CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 11:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BE320707
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 11:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkCOvePv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BE320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfMcZ-0007K7-CO
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 07:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfMbX-0006pW-Cf
 for qemu-devel@nongnu.org; Sun, 31 May 2020 07:58:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfMbW-0001CZ-DF
 for qemu-devel@nongnu.org; Sun, 31 May 2020 07:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590926293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MmmO/ihpoSKfaVfh7mlN4r/JI6hiqVN5nG0g2Ehw4So=;
 b=hkCOvePvHlnO3mcjsde2HK+9y8W7ikAqRVTsZydq8o40d9fbcsiGCKsAwKfhN/8i7Ne4z8
 XwSuwo8nDaGRJ4PDWfvbTMl2WZQZh5VE+bF5GzDgb64AfOvSE4e1c+/fP1CSCcRqSpsyyb
 qHmVEfmJTYOzkQZIH2NRXXWIJvJeelQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-aWcvlMlmN1azfCD9xFtsmA-1; Sun, 31 May 2020 07:58:11 -0400
X-MC-Unique: aWcvlMlmN1azfCD9xFtsmA-1
Received: by mail-wm1-f72.google.com with SMTP id 18so2109491wmu.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 04:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MmmO/ihpoSKfaVfh7mlN4r/JI6hiqVN5nG0g2Ehw4So=;
 b=CKxyVX6WXSnrfqbwOqQRONuLZ0CFRjqYYhRuoi3NPwFaHhq0IiGdfOAIjA2+Xvbtde
 m2X38tFwYGV4hWD9OL7hZzpQS1YRbLQRLcIWSFA2AXgzhrri+4yrIszPiPr2hg8lWT3V
 7s6fNefaOJOGQTaCpb/ZXY26SnTqm9fLk/4hTCcm1+1Q54hvmcZyXXM1JowBCh2E3NRk
 i5UOHl/sSJX2+VDa45KE725RS2tDUZvxD391wFpkBrXASXNkle+TiA6m0VuzORLkTCzJ
 xfB1o3v3BRJLNN14M/u0d+R6acyCNJwCNeWka+FR/OAUA7sTY9TdWJ5mX3eX6unO21OU
 kc4w==
X-Gm-Message-State: AOAM532KAw6FZ+ztjGpGYr51/uwdHWYxlTvMYVlwkK+DqdbdOr8QKFRX
 llNrKSezXP3b5cT6dTmcJ2SqEf2XJNzgohCG3FaMRgm6JqAI0E4h8pbDnjzGbnlSAqmVIzD1Lme
 X/UCBF2bWp0WLEGE=
X-Received: by 2002:a5d:4404:: with SMTP id z4mr16707839wrq.189.1590926290495; 
 Sun, 31 May 2020 04:58:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxST56XRYh5WWj7Ino56Z0fj2MUr21C7vuYYqKb96L9T0bd+xUwmvmLBfyB2qLNxQcbEIBUGg==
X-Received: by 2002:a5d:4404:: with SMTP id z4mr16707822wrq.189.1590926290292; 
 Sun, 31 May 2020 04:58:10 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id d13sm7540438wmb.39.2020.05.31.04.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 04:58:09 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance/migration.py: Wait for both sides
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, ovoshcha@redhat.com
References: <20200528112404.121972-1-dgilbert@redhat.com>
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
Message-ID: <9ad38809-ab7b-4d41-ccb7-7fad35060aeb@redhat.com>
Date: Sun, 31 May 2020 13:58:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528112404.121972-1-dgilbert@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 05:57:31
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 1:24 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> When the source finishes migration the destination will still be
> receiving the data sent by the source, so it might not have quite
> finished yet, so won't quite have reached 'completed'.
> This lead to occasional asserts in the next few checks.
> 
> After the source has finished, check the destination as well.
> (We can't just switch to checking the destination, because it doesn't
> give a status until it has started receiving the migration).
> 
> Reported-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/acceptance/migration.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
> index 0365289cda..792639cb69 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -35,6 +35,10 @@ class Migration(Test):
>                        timeout=self.timeout,
>                        step=0.1,
>                        args=(src_vm,))
> +        wait.wait_for(self.migration_finished,
> +                      timeout=self.timeout,
> +                      step=0.1,
> +                      args=(dst_vm,))
>          self.assertEqual(src_vm.command('query-migrate')['status'], 'completed')
>          self.assertEqual(dst_vm.command('query-migrate')['status'], 'completed')
>          self.assertEqual(dst_vm.command('query-status')['status'], 'running')
> 

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


