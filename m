Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCC0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6BB206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H21E8Kxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6BB206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtOoi-0008Jp-NO
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 01:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtOo1-0007nF-SO
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:09:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44872
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtOnz-0007yB-Uq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594271346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eWtWDdRRvZrEv2sPMjTiOSA0+XxFeYLlFQt8qunszD8=;
 b=H21E8KxcF80xhggPfXGmFs4ls3d4qp7d7HdGRTlcgZNfhJNZjjZ49DwC+jjfPIVb2u50/w
 iWPhIDRkfN8MeVvKkfMkjPHuAkZIXLA9VMBT2PJ/F6cCVJxt3pyVm1NrcuZLQdg9d8SENL
 fPOxoUz08sBookhHL3UXNXKcwbNOByE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-L-JRdROPPN2b04BRHnTF5g-1; Thu, 09 Jul 2020 01:09:05 -0400
X-MC-Unique: L-JRdROPPN2b04BRHnTF5g-1
Received: by mail-wr1-f71.google.com with SMTP id w4so1071217wrm.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 22:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eWtWDdRRvZrEv2sPMjTiOSA0+XxFeYLlFQt8qunszD8=;
 b=scjXB4ZA6gGUhtXHf7Jx4a8agKgTfqMDUEZkeTboCF3uY6hqyD5ZYZsj9j5Q/W0/e9
 1j7lVfsPXPuMidl4VEl9acywGLcZUQ+dyyXDu5zN1YolfO4SwkitTzN9vLO7Dvsx2ovF
 BRXiyVUrNwXBPGZDBczb1Nk01hZtFIlFebwuQjUoqJ/GqsGPDSRi4nABOkqTB8nsHuEg
 VvQlcBEbR6DJhfFexjjgjPxhBXoJR5fdu7f7+OfyUGK+AY/JtXPxhiNrtWcvbXTgnLnD
 +A3aSAEb5RFpOUgbTI29hmzFhr7oV9OTIIUtN2o3ppyHbuzNS7fQH3+3zv+yXAmBqfJp
 ftXA==
X-Gm-Message-State: AOAM5310+Ypxh99cvG5fGrXVa+FohjVly3jr+tYBKli4FWNCpow1yd7t
 LDslZTjq3puCj2PCDW5KuD0aqpL9hHACgc1MjWMGc9BnS/SqNeG2rOzqiFJpkWd8wdhGXjE8sxA
 ltYhZi+0yyCVGYfw=
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr12133695wmj.20.1594271343349; 
 Wed, 08 Jul 2020 22:09:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa4I+7wXADrDu+iUwMP7RWq0hDKxh8WseLMEpm8sHjAjfrLrH8pjKV97AlsO5ftZOmChal3g==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr12133681wmj.20.1594271343152; 
 Wed, 08 Jul 2020 22:09:03 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a22sm2811626wmb.4.2020.07.08.22.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 22:09:02 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 2/2] fuzz: add missing header for rcu_enable_atfork
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200708200104.21978-1-alxndr@bu.edu>
 <20200708200104.21978-3-alxndr@bu.edu>
 <96f1c98a-982b-c146-80af-8f83e8117ac5@redhat.com>
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
Message-ID: <3afe7750-3401-7365-bfe8-d5fd02663b69@redhat.com>
Date: Thu, 9 Jul 2020 07:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <96f1c98a-982b-c146-80af-8f83e8117ac5@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 liq3ea@163.com, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 7:03 AM, Philippe Mathieu-Daudé wrote:
> On 7/8/20 10:01 PM, Alexander Bulekov wrote:
>> In 45222b9a90, I fixed a broken check for rcu_enable_atfork introduced
>> in d6919e4cb6. I added a call to rcu_enable_atfork after the
>> call to qemu_init in fuzz.c, but forgot to include the corresponding
>> header, breaking --enable-fuzzing --enable-werror builds.
>>
>> Fixes: 45222b9a90 ("fuzz: fix broken qtest check at rcu_disable_atfork")
>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> ---
>>  tests/qtest/fuzz/fuzz.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
>> index a36d9038e0..0b66e43409 100644
>> --- a/tests/qtest/fuzz/fuzz.c
>> +++ b/tests/qtest/fuzz/fuzz.c
>> @@ -19,6 +19,7 @@
>>  #include "sysemu/runstate.h"
>>  #include "sysemu/sysemu.h"
>>  #include "qemu/main-loop.h"
>> +#include "qemu/rcu.h"
>>  #include "tests/qtest/libqtest.h"
>>  #include "tests/qtest/libqos/qgraph.h"
>>  #include "fuzz.h"
>>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 

Please add the include to softmmu/vl.c too.


