Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFC4C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908F323A34
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU+mKxjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908F323A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdlM-0004Ps-Cx
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdkK-0003kk-Nh
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdkH-0007a0-M5
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600763632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qvyUjkv8t4H1ij6w8DYR8/i335Zbxq6HBGLdSo8YFhw=;
 b=gU+mKxjG9wVGzPG+30pB5c3gluqP3T/cRoNBU5lU4CWr08njdfFQacDILyOLXqpTdk5rRp
 lQ48ZoDm6Oi7vxjrRZcizA4WqHrPDd0aADRPkYTiEWNptyfYXbfPZ/+2YxyeaMzUVnAXj+
 lLIE1GPCEMNCIVSQOtBDeMjdCONQlLY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-6o3YowaiNBWIsiO37JSiNw-1; Tue, 22 Sep 2020 04:33:50 -0400
X-MC-Unique: 6o3YowaiNBWIsiO37JSiNw-1
Received: by mail-wm1-f69.google.com with SMTP id m25so632544wmi.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qvyUjkv8t4H1ij6w8DYR8/i335Zbxq6HBGLdSo8YFhw=;
 b=aykVW0EAoCecOW720CznpD3IsDtUW+H1DbbjlNMyPsBkyOu4VpahSO9PicWuw6tBQn
 FrWlyYNYt0NWmGPYyYcv1o1e+6UkJXfwLhFpcDD/gVsvHqJGtGpXjrpz0oDTNxDxkanW
 tVw1uR5yxjg5EBMOawo2IaBaYeT2kwysxORZd9FmoRKDvzcHHFpfGQ7dYJNYPxWVRdwb
 ZLeWIfurvuRE38lAv+eojjbhTZ7XwZba7Z24pQPWiYjS3BwY23fZyBufckkoGkAf9MF2
 AR/b1upFbGS0abwTYoLCnG5OJoTekQMBh6T9z3HUo0JFqDAGop2F5RPt9OtMv4SFXUsf
 WNKA==
X-Gm-Message-State: AOAM5335Dd1/g16S73u7M/XLi/FocdAzFWHP1/mMZKvIWBLr6T96A+b0
 4o6SfRCbyEc0GAvndVoyZf5VMs+SWZoykuul7i/HgH174sNSmEkfqSXKs4gvmFi6EIhTSpN3TfQ
 SCEda6Jd6ygwOFus=
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr3236302wmb.43.1600763629168; 
 Tue, 22 Sep 2020 01:33:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6dFnNm36FEIqnuuXGz9nWZ1QUfl3u3gn03+FQFA+/1aED+MOKkBn5JsSaaGBStLCkBvBNiw==
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr3236220wmb.43.1600763628785; 
 Tue, 22 Sep 2020 01:33:48 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l17sm3448412wme.11.2020.09.22.01.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 01:33:47 -0700 (PDT)
Subject: Re: [PATCH] qemu/atomic.h: prefix qemu_ to solve <stdatomic.h>
 collisions
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200921162346.188997-1-stefanha@redhat.com>
 <160072176188.21069.7427016597134663502@66eaa9a8a123>
 <20200922081705.GB201611@stefanha-x1.localdomain>
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
Message-ID: <f70c3ae8-330f-af43-0005-86b4d3fabb2e@redhat.com>
Date: Tue, 22 Sep 2020 10:33:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922081705.GB201611@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, peter.maydell@linaro.org, sheepdog@lists.wpkg.org,
 sagark@eecs.berkeley.edu, david@redhat.com, jasowang@redhat.com,
 yuval.shaia.ml@gmail.com, armbru@redhat.com, jcmvbkbc@gmail.com,
 Alistair.Francis@wdc.com, kraxel@redhat.com, chenhc@lemote.com, jslaby@suse.cz,
 sstabellini@kernel.org, berto@igalia.com, kvm@vger.kernel.org,
 ysato@users.sourceforge.jp, quintela@redhat.com, mst@redhat.com,
 mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 aleksandar.qemu.devel@gmail.com, anthony.perard@citrix.com,
 marcandre.lureau@redhat.com, rth@twiddle.net, mjrosato@linux.ibm.com,
 thuth@redhat.com, ehabkost@redhat.com, sw@weilnetz.de, pl@kamp.de,
 dgilbert@redhat.com, paul@xen.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 namei.unix@gmail.com, berrange@redhat.com, sunilmut@microsoft.com,
 jsnow@redhat.com, zhang.zhanghailiang@huawei.com, kwolf@redhat.com,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org, kbastian@mail.uni-paderborn.de,
 cohuck@redhat.com, laurent@vivier.eu, mreitz@redhat.com, palmer@dabbelt.com,
 pbonzini@redhat.com, xen-devel@lists.xenproject.org,
 aleksandar.rikalo@syrmia.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 10:17 AM, Stefan Hajnoczi wrote:
> On Mon, Sep 21, 2020 at 01:56:08PM -0700, no-reply@patchew.org wrote:
>> ERROR: Macros with multiple statements should be enclosed in a do - while loop
>> #2968: FILE: include/qemu/atomic.h:152:
>> +#define qemu_atomic_rcu_read__nocheck(ptr, valptr)      \
>>      __atomic_load(ptr, valptr, __ATOMIC_RELAXED);       \
>>      smp_read_barrier_depends();
>>
...
>> WARNING: Block comments use a leading /* on a separate line
>> #7456: FILE: util/rcu.c:154:
>> +        /* In either case, the qemu_atomic_mb_set below blocks stores that free
>>
>> total: 7 errors, 4 warnings, 6507 lines checked
> 
> These are pre-existing coding style issues. This is a big patch that
> tries to make as few actual changes as possible so I would rather not
> try to fix them.

What I do with automated patches triggering checkpatch errors:

- run automated conversion
- fix errors until checkpatch is happy
- run automated conversion inversed
- result is the checkpatch changes, commit them
- run automated conversion again, commit


