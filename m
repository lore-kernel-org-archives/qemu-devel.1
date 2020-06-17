Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AC1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F1520C09
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrVCo2rV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F1520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTN3-0004jf-Ln
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlTMG-0003ny-Vc
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:23:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55605
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlTMF-0003pK-7j
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592382222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZaqCgUw8zSAZRcflFosuS4OMVEMxzr1V2B3dxGETmjk=;
 b=KrVCo2rVHfghe70wue/5c8WayP6LLSzcfQ3hUNDlxMBjyMMBkdBgnCTPHqPds2Iz4tQquh
 1pJFrPcLcJIKDnWrT+bjIzaTLMSImViOIiZVtrbXjS0Sc0m8yQer7Fe77G7TCz5fZojokv
 /zFOX2D5PwIUZhNii0QnkvNp+WrVoec=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-mu8tomFXN7eEbZqI3QSHdg-1; Wed, 17 Jun 2020 04:23:40 -0400
X-MC-Unique: mu8tomFXN7eEbZqI3QSHdg-1
Received: by mail-ej1-f70.google.com with SMTP id bg25so681810ejb.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 01:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZaqCgUw8zSAZRcflFosuS4OMVEMxzr1V2B3dxGETmjk=;
 b=Wo/2lOpEcoYbCmBoZiZ/vnqcvtzA4NoJH6aRhDxhWl2v5INe5eckhtLBfsir3emhsL
 oRSR9z930juv++tCciOLVah4TrkGngyGdALllHwh1O+KaX/ikcgLns1f61ipt6mOIKof
 UZtBOO6XbxXMgswaP3ebAxA1QcoLwFlq/S0vHaATPJa9qp/skqxIt1QnP/dXFkn0qDCw
 LnzBdmlIIId7WgbYfwDgvlDK6tm97ROuWmr16anPib+fbasr830NbsztovzjfP2imS2p
 KV7sG1dwt4MQ0fLggkfvAJw1YqoXatqBi+MQOkzOlGVoPsCFeGnhE4lXZZkdtTu76sMH
 vsGA==
X-Gm-Message-State: AOAM531/rHdJsBl55IaBxv3Ev4y+Y+jFroJmGNhlSaNY3NlDkU6vS1BT
 FxMdcPfKUjzvXs1+oqsUA6KTUAxRq7bOAgznYXUGLrU2QIrWxpE+FzZFqWhRegZyHm59VcqnelR
 OJk/pRrAeE6r3GI0=
X-Received: by 2002:a17:906:e247:: with SMTP id
 gq7mr6339179ejb.107.1592382219163; 
 Wed, 17 Jun 2020 01:23:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUYmyTnGNNkKWPs1dCLQKLUa1tomW0qZxG2z5H717lKfNxglZgzu3GrklgLYHRWmBM7Or4SQ==
X-Received: by 2002:a17:906:e247:: with SMTP id
 gq7mr6339162ejb.107.1592382218958; 
 Wed, 17 Jun 2020 01:23:38 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id cn14sm11527745edb.22.2020.06.17.01.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 01:23:38 -0700 (PDT)
Subject: Re: Core dump happened when starting a VM on arm64 server
To: Andrew Jones <drjones@redhat.com>, Haibo Xu <haibo.xu@linaro.org>
References: <CAJc+Z1Eb815hroFPY+9Ai_9hh=+eje+X2ENtGj9XA+_F0XUPqg@mail.gmail.com>
 <20200611091419.e2rfcurztmlajlwr@kamzik.brq.redhat.com>
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
Message-ID: <a6740274-1bd7-460c-7011-244cdf2fc945@redhat.com>
Date: Wed, 17 Jun 2020 10:23:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200611091419.e2rfcurztmlajlwr@kamzik.brq.redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 11:14 AM, Andrew Jones wrote:
> On Thu, Jun 11, 2020 at 04:46:45PM +0800, Haibo Xu wrote:
>> Hi,
>>
>> I met a qemu core dump issue when starting a VM with cpu feature
>> "pmu=on" on an arm server.
>> The commands to start the machine is:
>>
>>   ./qemu-system-aarch64 \
>>            -cpu host,pmu=on -M virt,accel=kvm,gic-version=3 -nographic
>> -m 2048M \
>>            -kernel ./Image \
>>            -initrd /boot/initrd.img-5.6.0-rc2+ \
>>            -append "root=/dev/vda rw console=ttyAMA0" -nodefaults -serial stdio\
>>            -drive if=none,file=./xenial.rootfs.ext4,id=hd0,format=raw \
>>            -device virtio-blk-device,drive=hd0
>>
>>
>> And here is the stack dump:
>>
>>  Core was generated by `./qemu-system-aarch64 -cpu host,pmu=on -M
>> virt,accel=kvm,gic-version=3 -nograph'.
>>  Program terminated with signal SIGSEGV, Segmentation fault.
>>  #0  kvm_ioctl (s=0x0, type=type@entry=44547) at
> 
> s=0x0 means cpu->kvm_state is NULL
> 
>> The root cause is in the arm_get_pmu() operation which was introduced
>> in ae502508f83.
> 
> Actually the root cause is d70c996df23f ("target/arm/kvm: Use
> CPUState::kvm_state in kvm_arm_pmu_supported()"). ae502508f83 used
> the machine kvm_state, not the cpu kvm_state, and that allows pmu=on
> to work. d70c996df23f changed that saying that "KVMState is already
> accessible via CPUState::kvm_state, use it.", but I'm not sure why,
> since kvm_init_vcpu() doesn't run until the vcpu thread is created.
> 
> Philippe?

Sorry for some reason I missed this email. I'll look at this today.

> 
> Thanks,
> drew
> 


