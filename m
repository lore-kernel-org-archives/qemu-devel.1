Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92DCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D9C225AB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOPRvNkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D9C225AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvQb0-000815-0H
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 15:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvQaG-0007CY-1y
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:27:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvQaD-0006XZ-Pg
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594754837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z3kA3OdbWGxh8D1c6w1xuBj/70oD26rTW3u1fPhpzQQ=;
 b=NOPRvNkhm6lTCQjdY6/m8hTmdJPTq5C+vjDl2NAw9xsjBZCAR/B8COhCG9UFBZMLFR+OqD
 1/v4QB/MnVfkVuvuMMAsk8kMkQI/1KR7fYBHPmMGDylQtsBFM56uIdGaxmsnIXAALSjmTk
 5APnPlntRQRNr4oNSktSGZBBLK6+MMA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325--De3nMBFO3KftXqZ6wavWQ-1; Tue, 14 Jul 2020 15:25:22 -0400
X-MC-Unique: -De3nMBFO3KftXqZ6wavWQ-1
Received: by mail-wr1-f72.google.com with SMTP id j5so22985030wro.6
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 12:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Z3kA3OdbWGxh8D1c6w1xuBj/70oD26rTW3u1fPhpzQQ=;
 b=pNMQdvkDVaAVFOV+FKgy8oUjDunzGp05lXlLAQMqQp4xe4sFakPmZnEWdApJc8wRYa
 gXk4wmKCPN9eLhefMqqeQ2hyTiDlv7yjG42W7gK/+UxAHV6R1IOT1+1+hEbc7TXzXUb+
 MjyjOAyHlJuVIRE7DLkW5r9CWEjFMrgXizA+uNZoidGMNhVz9JqUMkWMxE8obDVniRd9
 50wiuV2Wx+yLqacWjJI8NXl5uFV2YbKfI2L0piYF8egKWnauUNVLPzSkwHFQ5O/WDTEL
 Hnh+rCp3Ojyn8+vHy8tv3rxbKhaklf2BM00iqk1nrr5An9waukZR3UnFrwaUwJYFNVOm
 8q3g==
X-Gm-Message-State: AOAM532tvUlMg/a+Fik/REvdk++tV7SE4ysU8sKywWCkiZVcf+O1CxXN
 v9XLVGizY6xoNfKJh0VLijL0bahkZi+O6y8Ie3qhVdeM3dH26HVzL9Xepc5Z8Wy6iodEKsr3h9+
 SmSgX/GvC8I1VUtY=
X-Received: by 2002:a1c:2485:: with SMTP id k127mr5173318wmk.138.1594754721307; 
 Tue, 14 Jul 2020 12:25:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA6ciBr1UvilJbPkYpKl2rwz+40r5kf6dkTSNk757ycVf9gmthN12a+uh0X0FvMZIf1X2nag==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr5173301wmk.138.1594754720934; 
 Tue, 14 Jul 2020 12:25:20 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y6sm24580507wrr.74.2020.07.14.12.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 12:25:20 -0700 (PDT)
Subject: Re: [PATCH v5 00/16] python: add mypy support to python/qemu
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200710052220.3306-1-jsnow@redhat.com>
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
Message-ID: <111513d2-f235-464d-a372-c61acffd8d25@redhat.com>
Date: Tue, 14 Jul 2020 21:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200710052220.3306-1-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 7:22 AM, John Snow wrote:
> Based-on: 20200710050649.32434-1-jsnow@redhat.com
> 
> This series modifies the python/qemu library to comply with mypy --strict,
> pylint, and flake8.
> This requires my "refactor shutdown" patch as a pre-requisite.
> 
[...]
> 
> These should all 100% pass.
> 
> John Snow (16):
>   python/qmp.py: Define common types
>   iotests.py: use qemu.qmp type aliases
>   python/qmp.py: re-absorb MonitorResponseError
>   python/qmp.py: Do not return None from cmd_obj
>   python/qmp.py: add casts to JSON deserialization
>   python/qmp.py: add QMPProtocolError

I've applied patches 1 to 6 on python-next, because unfortunately
then patch 7 now conflicts.

We'll merge them in 5.2 with the 'make check-python' rule patch last,
to avoid regressions.

Thanks,

Phil.

>   python/machine.py: Fix monitor address typing
>   python/machine.py: reorder __init__
>   python/machine.py: Don't modify state in _base_args()
>   python/machine.py: Handle None events in events_wait
>   python/machine.py: use qmp.command
>   python/machine.py: Add _qmp access shim
>   python/machine.py: fix _popen access
>   python/qemu: make 'args' style arguments immutable
>   iotests.py: Adjust HMP kwargs typing
>   python/qemu: Add mypy type annotations


