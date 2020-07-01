Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF66720780
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTtWAuzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF66720780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqcKr-0006bT-0V
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqcK6-0005qC-Nd
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:58:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28097
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqcK4-0004sg-Q1
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593608324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q4kH6UYzzbB28jFGr6RdcF3XJO/pbyI6No/EeYQ0lPI=;
 b=YTtWAuzRONqnnV8vXRpZVOprpredrcFvAbT0BxCUz3Moeh+rxj4J/Fj4/Q/KCkntx6wzIn
 iiWeJSNl9lyXD4oCV8Vs8iQIcCtqTcz+F4Hu7qiNBZx1eKnu1N4rCKAkwMomyTgDo5u+9a
 IL0KZWo8lwsNso5zwTK1kCytQFXhrKI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-el4F0bA6PzWH6RUHGLuyCg-1; Wed, 01 Jul 2020 08:58:39 -0400
X-MC-Unique: el4F0bA6PzWH6RUHGLuyCg-1
Received: by mail-ej1-f70.google.com with SMTP id q9so4624100ejr.21
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 05:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Q4kH6UYzzbB28jFGr6RdcF3XJO/pbyI6No/EeYQ0lPI=;
 b=j2DJmkeX1JDHYbq5+ANu+IQePwgd01+kqT2l+YGA12kh6Hn9WeBVIHoJCFxaFt/DHz
 hNENADVkeW64SyaRqqNS1CSyDj2rzxBKq2l/bRLaJyvX1GrnE2Yn/jw2yLdvgXBYnXjc
 /UVmsDY++Uln+T7LHqCdxCRJgdjq6A3GNdSx8rzcM26JEx7eRz6bUaG2ULjhaVR/k8YV
 jeCz6Q0H9thFqqmt8hdBMbPrhR8LFshPKnsThJTMqaPTXSWg8NYESmzdLW5MZ/JfAfMm
 PEWkn9jxHi8l+btmZXs7+09IsFwSJftkzQPAMF13c95Zc5eSTXM2OsToZW/W9oA66B5T
 2qvw==
X-Gm-Message-State: AOAM532e7/HpQBc9TcvD9INRRbWHpoz3w9XmtEH92hVggz7745SJeYsj
 Vm8ytU93i1weHTIGW1H6zlVQQRUXGqKbmn/bxIO4XnG/BwZYX0pa9Ocj32QxIiQFUSj93WOvU5e
 2bpDykHB8rzn9Hbw=
X-Received: by 2002:a50:931e:: with SMTP id m30mr30058849eda.341.1593608317935; 
 Wed, 01 Jul 2020 05:58:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWQW9axunJwqMnuYDxr2AESpoA1db67qmSJCe1gb43BMi6VJ4kz06N5Xsris0Im11dNtBBNw==
X-Received: by 2002:a50:931e:: with SMTP id m30mr30058830eda.341.1593608317717; 
 Wed, 01 Jul 2020 05:58:37 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u13sm4658716ejx.3.2020.07.01.05.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 05:58:36 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/block/nvme: handle transient dma errors
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 kwolf@redhat.com, mreitz@redhat.com
References: <20200629202053.1223342-1-its@irrelevant.dk>
 <159346486377.15477.6186679362319226240@d1fd068a5071>
 <20200629213408.qlehce2mtgqodqd6@apples.localdomain>
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
Message-ID: <30b8117f-25bd-e50b-98cb-db2e0a2690d0@redhat.com>
Date: Wed, 1 Jul 2020 14:58:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200629213408.qlehce2mtgqodqd6@apples.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
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
Cc: kbusch@kernel.org, k.jensen@samsung.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 11:34 PM, Klaus Jensen wrote:
> On Jun 29 14:07, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20200629202053.1223342-1-its@irrelevant.dk/

>> --- /tmp/qemu-test/src/tests/qemu-iotests/040.out       2020-06-29 20:12:10.000000000 +0000
>> +++ /tmp/qemu-test/build/tests/qemu-iotests/040.out.bad 2020-06-29 20:58:48.288790818 +0000
>> @@ -1,3 +1,5 @@
>> +WARNING:qemu.machine:qemu received signal 9: /tmp/qemu-test/build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,path=/tmp/tmp.Jdol0fPScQ/qemu-21749-monitor.sock -mon chardev=mon,mode=control -qtest unix:path=/tmp/tmp.Jdol0fPScQ/qemu-21749-qtest.sock -accel qtest -nodefaults -display none -accel qtest
>> +WARNING:qemu.machine:qemu received signal 9: /tmp/qemu-test/build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,path=/tmp/tmp.Jdol0fPScQ/qemu-21749-monitor.sock -mon chardev=mon,mode=control -qtest unix:path=/tmp/tmp.Jdol0fPScQ/qemu-21749-qtest.sock -accel qtest -nodefaults -display none -accel qtest

Kevin, Max, can iotests/040 be affected by this change?

> 
> 
> Hmm, I can't seem to reproduce this locally and the test succeeded on
> the next series[1] that is based on this.
> 
> Is this a flaky test? Or a bad test runner? I'm of course worried when
> a qcow2 test fails and I touch something else than the nvme device ;)
> 
> 
>   [1]: https://patchew.org/QEMU/20200629203155.1236860-1-its@irrelevant.dk/
> 


