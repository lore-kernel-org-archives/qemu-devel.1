Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481F1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF1B2075A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyAVePN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF1B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGkj-0007el-7j
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeGk3-00079B-FO
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:30:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36732
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeGk2-0001p1-Jy
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590665429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+orAPpHTr9mMcivWG0xTr7GgvCdWJ4uzBZKL8mHokB0=;
 b=MyAVePN8OWVMyLq0oLJR1u/3wcCXOemXvYanfSzvw8jaqVI/xfgtBSADNOP+CBt7UTNeLZ
 /3l68xjKy4cZaSNOZh2jvytT5pWU7wKj98uBTCQwS0x1KFxTruXrm+D3feyh62i8P61QeX
 3iSL4G44/RQEBDW0dppWKD5cV5zkTkI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-qhwa4l5YPDmwPn0nWn4zmA-1; Thu, 28 May 2020 07:30:28 -0400
X-MC-Unique: qhwa4l5YPDmwPn0nWn4zmA-1
Received: by mail-wm1-f72.google.com with SMTP id u11so633770wmc.7
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 04:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+orAPpHTr9mMcivWG0xTr7GgvCdWJ4uzBZKL8mHokB0=;
 b=F5Q9gOx8WTZ/60zs+TeDv3s2uFPMUDrCyW5iYu5cJ/vnE5tVBGiigRbUFNX0UM413W
 FFjHCJhVrXUB4Vs7/VmJS8SZt9dLXC51XKUpb79l8wmrlxAXYlKI2bhSfJgJSPFTBQjF
 Frvq84MSA3BRQ7cz/3u/jtow3zYX8osT369YdD+Yy8t5Evdg+ErEleTmhqrf3PQNKkFo
 4tg8AusRS/8NmnUeyrrw/G/WCY7BDNx3j220iMS9T2lmf40O/je+EYK1oLgk2b0RNZi0
 O+2Z2i4eafsM8n/YLqPsru1tyeNFv8C06YsPDqQoZvg5RN/HvXEEIhTD5SD5AT0qTdvo
 iIyg==
X-Gm-Message-State: AOAM531JKqbKmfrNpy9Cf0v7s+ciF/wX7y4xQMcbwQ9RheR9BhXZUPal
 t6KzHcQ9MDWlxK1fwvebIHDfxzcYTYnjy2XRXPMxqaTQ/o6dbuRGlrKwgTx4P9vacrioVG+Me97
 5wD9xJL0jnwJ7Jgc=
X-Received: by 2002:adf:edc8:: with SMTP id v8mr3016261wro.176.1590665427014; 
 Thu, 28 May 2020 04:30:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws3LxqvBpq5L+CsKGymHrT2mMYqnI0HnBp16dGF1QXAnRLhqHjYj4dXji1gaq9UXS9YX6i9g==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr3016238wro.176.1590665426742; 
 Thu, 28 May 2020 04:30:26 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c25sm6070969wmb.44.2020.05.28.04.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 04:30:26 -0700 (PDT)
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
Message-ID: <33dd3b7c-e719-78cb-05b8-17223eee3018@redhat.com>
Date: Thu, 28 May 2020 13:30:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528112404.121972-1-dgilbert@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
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

Fixes: a7abb53765 ?

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

I'm not sure the Test.timeout is well used (it represents the maximum
total time the framework will wait this test can take). Anyway this is
incorrectly used before your patch, so I wouldn't bother...

> +                      step=0.1,
> +                      args=(dst_vm,))

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>          self.assertEqual(src_vm.command('query-migrate')['status'], 'completed')
>          self.assertEqual(dst_vm.command('query-migrate')['status'], 'completed')
>          self.assertEqual(dst_vm.command('query-status')['status'], 'running')
> 


