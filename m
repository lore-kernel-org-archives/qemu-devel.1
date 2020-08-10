Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857C0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5170D206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B63chjC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5170D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54wB-00041C-Kr
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 06:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k54vM-00038V-R2
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:21:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44244
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k54vL-0000uz-Au
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597054858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pTSNoTS4QjHiTrukOmiKz3lX/isQ5r6MRrKoHMLZvaE=;
 b=B63chjC32ftcOn1v4ggpjifPGnfZe1HN1IJ0r0kzCq+fJHLfE9OYwhIEzLZILlhLaLK2R1
 M1aMb64ololUBIQZR4MAAlsS1Ovp/cPywJCuGZkkOQ1CwRAs3saGxfjjghr478J7vxI8KU
 Bu+67Z5MZIDybIMo8a4q20Vc8Wy6uHg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-C7GyozRVOLS-4YgpbJw-cQ-1; Mon, 10 Aug 2020 06:20:57 -0400
X-MC-Unique: C7GyozRVOLS-4YgpbJw-cQ-1
Received: by mail-wr1-f71.google.com with SMTP id j2so4039536wrr.14
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 03:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=pTSNoTS4QjHiTrukOmiKz3lX/isQ5r6MRrKoHMLZvaE=;
 b=lAchq9fwCrlZGtESaoFtjz90o1iRnlwsRqlg3dyloDP4sz2RFQxK0l09boRC/tM6qO
 uGnFNZB3OhZOjviUjkLUjdRWPCC5fGjchMYUSPREtsxyv8wUSl6/hg7BzSjMpA5sVc3C
 8Jgs24+ZpVvqjlbGYd+tIlKMsX12IUJruIOGk5RfYD0cxhKE8hu4ppB89nrIfSI9ZT2q
 RabpsyPafPHRWvt1P8bgwp5PizWgVtOzr9Cz70MaUrYxtAajOaaOOiKiuLx6QT72fj7Q
 0R1UWwsB+VZFjU5fvQJhDM/XxYjWA9mRz1uqxmtMv/ZTzxPZZnGOV1s/7PnioCiJm6Oi
 7cbQ==
X-Gm-Message-State: AOAM531dS5kJBtjgPyyKXzM7MMk1F1PsX2LbzR8YCi0znqe6IbC0Q9EZ
 WGJxasZvrqM5fjssO7e5VyjruttFc6pzDm2IvY5WCO9doUrbTPv52Cw3fCC1+TnJzhV+/EP1GGW
 7ap2ieMfISiEzZ3c=
X-Received: by 2002:a5d:540c:: with SMTP id g12mr23375963wrv.120.1597054855607; 
 Mon, 10 Aug 2020 03:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPOTcCqxwRMXM3eCIcwhF7QHd7nEjdwc+KA0Jz8XhjOsCxNiRC6jrgpDdbkbD3Dzmw11tzSg==
X-Received: by 2002:a5d:540c:: with SMTP id g12mr23375938wrv.120.1597054855362; 
 Mon, 10 Aug 2020 03:20:55 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id s205sm21479649wme.7.2020.08.10.03.20.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 03:20:54 -0700 (PDT)
Subject: Re: [PATCH] docs/system/s390x: Add a chapter about s390x boot devices
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20200806150507.12073-1-thuth@redhat.com>
 <20200810121847.5ab4e227.cohuck@redhat.com>
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
Message-ID: <d94f794a-1fb0-2251-38c2-7828f8cb8d9b@redhat.com>
Date: Mon, 10 Aug 2020 12:20:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200810121847.5ab4e227.cohuck@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 12:18 PM, Cornelia Huck wrote:
> On Thu,  6 Aug 2020 17:05:07 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> Booting on s390x is a little bit different compared to other architectures.
>> Let's add some information for people who are not yet used to this.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  docs/system/s390x/bootdevices.rst | 82 +++++++++++++++++++++++++++++++
>>  docs/system/target-s390x.rst      |  1 +
>>  2 files changed, 83 insertions(+)
>>  create mode 100644 docs/system/s390x/bootdevices.rst
>>
>> diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/bootdevices.rst
>> new file mode 100644
>> index 0000000000..68f0ffd450
>> --- /dev/null
>> +++ b/docs/system/s390x/bootdevices.rst
>> @@ -0,0 +1,82 @@
>> +Boot devices on s390x
>> +=====================
>> +
>> +Booting with bootindex parameter
>> +--------------------------------
>> +
>> +For classical mainframe guests (i.e. LPAR or z/VM installations), you always
>> +have to exactly specify the disk where you want to boot from (or "IPL" from,
> 
> s/exactly/explictly/ ?

Or "to explicit the disk ..."?

> 
>> +in s390x-speak -- IPL means "Initial Program Load"). Especially, there can
> 
> s/Especially/In particular/ ?
> 
>> +also be only one boot device according to the architecture specification, thus
>> +specifying multiple boot devices is not possible (yet).
>> +
>> +So for booting an s390x guest in QEMU, you should always mark the
>> +device where you want to boot from with the ``bootindex`` property, for
>> +example::
>> +
>> + qemu-system-s390x -drive if=none,id=dr1,file=guest.qcow2 \
>> +                   -device virtio-blk,drive=dr1,bootindex=1
>> +
>> +For booting from a CD-ROM ISO image (which needs to include El-Torito boot
>> +informatin for being bootable), it is recommended to specify a ``scsi-cd``
> 
> s/informatin for being/information in order to be/
> 
>> +device, for example like this::
>> +
>> + qemu-system-s390x -blockdev file,node-name=c1,filename=... \
>> +                   -device virtio-scsi \
>> +                   -device scsi-cd,drive=c1,bootindex=1
>> +
>> +Note that you really have to use the ``bootindex`` property to select the
>> +boot device. The old-fashioned ``-boot order=...`` command of QEMU (and
>> +also ``-boot once=...``) is not supported on s390x.
> 
> (...)
> 
> This looks good to me, and is certainly helpful. I can fix the nits
> myself and apply it.
> 
> There's also some documentation regarding DASD IPL in the devel guide;
> but as that is mostly helpful for people actually working with the
> code, I don't think that it makes sense to cross-reference it.
> 
> 


