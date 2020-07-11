Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB1FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 08:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2377520725
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 08:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+LnvJCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2377520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juB3d-0006fF-9Q
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 04:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juB32-0006EJ-Bi
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 04:39:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juB2z-0006qB-Pc
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 04:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594456788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hGS2oqzhi+XUs1siNdPxS1I6s1+JTPaGzIA7wK0jQWA=;
 b=f+LnvJCz5KcUq4VppRvy6l80LiCUalTTt+V6gadJGi+msU2UQH4RyVXCdCP1qV495PoETM
 D+VbkjcHnK3t9NLf/l74rh7qEPllfDMh9x0u3hALM2J3wjaa9H/EOZua/p5QsKKY/s4LZK
 KN75tyEsZHfIKoKjczGi+jaKjmTylrA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-sn_sxvVDOG2SylMENXVXgQ-1; Sat, 11 Jul 2020 04:39:44 -0400
X-MC-Unique: sn_sxvVDOG2SylMENXVXgQ-1
Received: by mail-wr1-f71.google.com with SMTP id j3so9260778wrq.9
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 01:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hGS2oqzhi+XUs1siNdPxS1I6s1+JTPaGzIA7wK0jQWA=;
 b=RGpZFPgctqdg+c21FjSqjjtm4mo8OhXTMoG08CqnvG3Mu1IW6/SgSKn1yxZb9rHJCd
 yD8n9mGecMcXFhPDM9ZU+FrpIuwQAWi3BMNVfkF8F8QMxjawWc9iJqTXT3WxW3cBtolx
 kV+hr46aHgUCgAVfm/4RrMrw3Q73ZgTHhZdZjGyZjGPknZsk2P4e124xacRf5//BlB5B
 EIAXBF/6B4lKKWmPNJfregl+Mqrap7Eq/iy9RcNgfslvGxaSeKOLTHOrTyhbMicVpis3
 LGpGn8AtuxQTx058hgsgcNZGVhTUFtj/A9BnBxxJ6MAxk6QqMmUfEaXDEzgW29unz8Kf
 I2eA==
X-Gm-Message-State: AOAM531RPo0Xbj1ReFPZnFI42kP0c+wne7zEnIHqIcdXwa758V/dMYZq
 i3LomsaPkNRy0rmR2Wg8OvMmQS992tjQO+qRJmoi/M8YcC4lVst33IxzFqcR2/If81cVb4K02zc
 tmtjjJlS58A1NpYw=
X-Received: by 2002:a5d:4e8e:: with SMTP id e14mr67529717wru.134.1594456782983; 
 Sat, 11 Jul 2020 01:39:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNTtW4bR0Oh8mcVsOonNN6/5NfJy7lFC6WT/BiWARvtrGJzL8k58V6EvdPt2UyOlUNMYuwaQ==
X-Received: by 2002:a5d:4e8e:: with SMTP id e14mr67529703wru.134.1594456782733; 
 Sat, 11 Jul 2020 01:39:42 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id m4sm12471093wmi.48.2020.07.11.01.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2020 01:39:42 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] scripts/performance: Add dissect.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, qemu-devel@nongnu.org,
 aleksandar.qemu.devel@gmail.com, alex.bennee@linaro.org, eblake@redhat.com,
 ldoktor@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
References: <20200709052055.2650-1-ahmedkhaledkaraman@gmail.com>
 <20200709052055.2650-2-ahmedkhaledkaraman@gmail.com>
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
Message-ID: <e43124cf-7a0f-c8e7-3acd-bb1550335e8e@redhat.com>
Date: Sat, 11 Jul 2020 10:39:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709052055.2650-2-ahmedkhaledkaraman@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 04:20:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On 7/9/20 7:20 AM, Ahmed Karaman wrote:
> Python script that dissects QEMU execution into three main phases:
> code generation, JIT execution and helpers execution.
> 
> Syntax:
> dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
>                  <target executable> [<target executable options>]
> 
> [-h] - Print the script arguments help message.
> 
> Example of usage:
> dissect.py -- qemu-arm coulomb_double-arm
> 
> Example output:
> Total Instructions:        4,702,865,362
> 
> Code Generation:             115,819,309	 2.463%
> JIT Execution:             1,081,980,528	23.007%
> Helpers:                   3,505,065,525	74.530%
> 
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  scripts/performance/dissect.py | 166 +++++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100755 scripts/performance/dissect.py

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


