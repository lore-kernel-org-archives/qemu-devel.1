Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCECBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DD120FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZyH7gIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DD120FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlXrx-0004SS-W9
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlXrG-0003uc-9k
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:12:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45158
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlXrE-00012v-01
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592399519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uqmCCLJeMjjG7S3iLkzD6qlomobzA/viDo+A+sQNAhI=;
 b=SZyH7gIiW9B/ZQkC4UN58pIg0HasFJiv8cu6iBdg7nPOgV14WPqIs89LIrh1PWP/yll9Ov
 aWd+m3qIp/abqrjm32HJo6/tvaq9WiV+XSIC0EMf+JYeZA1MPKb/oYwsoyz3jgliY1Q8co
 zyCVCOTYjfwAyHczd/TKan6pgZHNEF4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-sV_mvldbPsKvhJSpQ85HZg-1; Wed, 17 Jun 2020 09:11:53 -0400
X-MC-Unique: sV_mvldbPsKvhJSpQ85HZg-1
Received: by mail-ed1-f69.google.com with SMTP id y5so844361edt.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 06:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=uqmCCLJeMjjG7S3iLkzD6qlomobzA/viDo+A+sQNAhI=;
 b=d/l5awSMYsAKsqt4mCj0p6gT6C0xGhNjdnmQSMYUPFfRftgTq53BgqhDulfDZWnVxj
 JIRr23jdhQgkmEfxCD2UkgCGzJtIBLOjTa9H0ixAV8UQaOWMCqF3Wpig+l4M/Mm4IJB+
 SXkuvNjLpN3Yg2UUEI9hxNhe5JHkurJKsGfiOfzXzOwGtRAWd2gt0axxJ8tN6fpXxL8h
 Tl+Z9YidyVJqqXj0Olx+3VG8whJJgcvGgoKzCH2zNvFMTNC7t+B36qIzyVVtyMX3nPWJ
 wOyhqCBLfJ7g+3W4Fvfv5XUWj9E72HU8ZmcvTmE+eMcXzzIJibQXFM93dFNV19RhH9bL
 l7Vw==
X-Gm-Message-State: AOAM530SV3AfvcTdAJ4JRYVk3brv+kS2tSnx6nKU3tMueO6Fw3mzPQCf
 BJKj8V1+fgVZGV8/jzjpTRgn4ZbTZkJuPO2RAGb6voxONfiHCM72vA3VAWyEvuYWi9mKvevjDsx
 2i6MWtDbsp5W6ryQ=
X-Received: by 2002:a17:906:6a4b:: with SMTP id
 n11mr7130059ejs.198.1592399512533; 
 Wed, 17 Jun 2020 06:11:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGwkJYIwASwTPuL1p/+O4nDx9D9wt78CorZqvnoijrage4X5+XnZQnMyqohUfPTVbqzsyFvw==
X-Received: by 2002:a17:906:6a4b:: with SMTP id
 n11mr7130044ejs.198.1592399512312; 
 Wed, 17 Jun 2020 06:11:52 -0700 (PDT)
Received: from [192.168.1.38] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id i9sm13301844ejv.44.2020.06.17.06.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 06:11:51 -0700 (PDT)
Subject: Re: Core dump happened when starting a VM on arm64 server
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Andrew Jones <drjones@redhat.com>, Haibo Xu <haibo.xu@linaro.org>
References: <CAJc+Z1Eb815hroFPY+9Ai_9hh=+eje+X2ENtGj9XA+_F0XUPqg@mail.gmail.com>
 <20200611091419.e2rfcurztmlajlwr@kamzik.brq.redhat.com>
 <a6740274-1bd7-460c-7011-244cdf2fc945@redhat.com>
 <e47664d7-a13e-7f60-975d-97f085036067@redhat.com>
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
Message-ID: <c1dee39b-39e1-0b56-eba6-8890f59a66f5@redhat.com>
Date: Wed, 17 Jun 2020 15:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e47664d7-a13e-7f60-975d-97f085036067@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 12:32 PM, Philippe Mathieu-Daudé wrote:
> On 6/17/20 10:23 AM, Philippe Mathieu-Daudé wrote:
>> On 6/11/20 11:14 AM, Andrew Jones wrote:
>>> On Thu, Jun 11, 2020 at 04:46:45PM +0800, Haibo Xu wrote:
>>>> Hi,
>>>>
>>>> I met a qemu core dump issue when starting a VM with cpu feature
>>>> "pmu=on" on an arm server.
>>>> The commands to start the machine is:
>>>>
>>>>   ./qemu-system-aarch64 \
>>>>            -cpu host,pmu=on -M virt,accel=kvm,gic-version=3 -nographic
>>>> -m 2048M \
>>>>            -kernel ./Image \
>>>>            -initrd /boot/initrd.img-5.6.0-rc2+ \
>>>>            -append "root=/dev/vda rw console=ttyAMA0" -nodefaults -serial stdio\
>>>>            -drive if=none,file=./xenial.rootfs.ext4,id=hd0,format=raw \
>>>>            -device virtio-blk-device,drive=hd0
>>>>
>>>>
>>>> And here is the stack dump:
>>>>
>>>>  Core was generated by `./qemu-system-aarch64 -cpu host,pmu=on -M
>>>> virt,accel=kvm,gic-version=3 -nograph'.
>>>>  Program terminated with signal SIGSEGV, Segmentation fault.
>>>>  #0  kvm_ioctl (s=0x0, type=type@entry=44547) at
>>>
>>> s=0x0 means cpu->kvm_state is NULL
>>>
>>>> The root cause is in the arm_get_pmu() operation which was introduced
>>>> in ae502508f83.
>>>
>>> Actually the root cause is d70c996df23f ("target/arm/kvm: Use
>>> CPUState::kvm_state in kvm_arm_pmu_supported()"). ae502508f83 used
>>> the machine kvm_state, not the cpu kvm_state, and that allows pmu=on
>>> to work. d70c996df23f changed that saying that "KVMState is already
>>> accessible via CPUState::kvm_state, use it.", but I'm not sure why,
>>> since kvm_init_vcpu() doesn't run until the vcpu thread is created.
>>>
>>> Philippe?
>>
>> Sorry for some reason I missed this email. I'll look at this today.
> 
> Quick reproducer:
> 
> $ qemu-system-aarch64 -cpu host,pmu=on -M virt,accel=kvm,gic-version=3
> Segmentation fault (core dumped)

Fix sent:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg713249.html


