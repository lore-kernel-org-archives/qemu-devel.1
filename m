Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D91C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B0821D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoPPwMsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B0821D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZHk-0006dF-6C
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQZGS-0005eq-0e
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQZGO-0004Yf-Rv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602176371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xeXIz4UH6a54axDSxlIxRcNXoPkGu/R1u88dxsyhe3U=;
 b=GoPPwMsWXcghHL6DvlzfCfeltq+OOsZihqPebB8ES9rJ52u615yOUpRhddhETMmuYjU87f
 jKt8+ssmj+cVZkWt4qAMGqlgRvJBYNJx4UdRxX//05T7w+h4/S1KImblIAa6hA91EScNJK
 FjTYh5uoSzT0XU8mhy6vXOJM56cUDm0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-VXHJqwBXPkSk2yPZ-hDr-A-1; Thu, 08 Oct 2020 12:59:30 -0400
X-MC-Unique: VXHJqwBXPkSk2yPZ-hDr-A-1
Received: by mail-wm1-f70.google.com with SMTP id s12so4266640wmj.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 09:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xeXIz4UH6a54axDSxlIxRcNXoPkGu/R1u88dxsyhe3U=;
 b=CaZ6WiVJ4PSxvPZkvjGrJaVQ/wm+JnGhXkEgaHi3KizUpI+ps5B5W4m8XjXr9pBfQ3
 95veK9b0WkUnM/GkhDxRrjrLpmb5VT73OZyoNpBDBX4CxMij07Qe6BX74guu7ZOV+/nE
 /G4jTFEK4scIubtVsciVPxTkiYtnFEv+J9MtyVeSUFhHZbFt2RFod4fI3TVxIyNDIG8a
 oC1weW/oQVyNDhEemFWwfvSrgwYKytYVTTakqGwKq7MoIBeB8AGnvETahFrDRQIAu3nG
 F7EqgMFmf4mwz79bVrhAvbNsIugbGBK3sL+7AO4/VeP80rNRnysba77zdJicCJ90YTxF
 /1SA==
X-Gm-Message-State: AOAM530OFF6BqNY37u4YoF+f4dhWdoRQ4Xd2F+OuJ/hdxhvsKOKmGPzN
 Hs+jfj1EQSZYP9t7wCRnrqMW3veDd8bOJzIkIxdYM9kBHdz/L9u6Ss04o9dqlRaXlLvr9akE6of
 CZmiDzZXfYBejtm8=
X-Received: by 2002:a1c:b7c6:: with SMTP id
 h189mr10474661wmf.154.1602176367219; 
 Thu, 08 Oct 2020 09:59:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRlGIg2uymFURRmwrRun9jESOSrje+MWdaW2kGnsqVeQWoTfL4Y8idVC6htMPqETQXFbqZZA==
X-Received: by 2002:a1c:b7c6:: with SMTP id
 h189mr10474636wmf.154.1602176366991; 
 Thu, 08 Oct 2020 09:59:26 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x65sm8499756wmg.1.2020.10.08.09.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 09:59:26 -0700 (PDT)
Subject: Re: Which qemu change corresponds to RedHat bug 1655408
To: Jakob Bohm <jb-gnumlists@wisemo.com>, qemu-discuss@nongnu.org,
 qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 John Snow <jsnow@redhat.com>
References: <2d9c8525-470f-a4e5-5d71-895046e2d782@wisemo.com>
 <653b9595-ae60-181a-2975-2e351ade9788@redhat.com>
 <43072820-c04f-b706-4b37-2d2e37e8499f@wisemo.com>
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
Message-ID: <9b7b9437-df3d-0090-1d5e-c61a9c245148@redhat.com>
Date: Thu, 8 Oct 2020 18:59:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <43072820-c04f-b706-4b37-2d2e37e8499f@wisemo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 6:49 PM, Jakob Bohm wrote:
> (Top posting because previous reply did so):

Which previous reply? Mine? I wrote "hi Jakob" then
replied in-line, maybe you missed it? See below...

> 
> If the bug was closed as "can't reproduce", why was a very similar bug
> listed as fixed in RHSA-2019:2553-01 ?
> 
> 
> On 2020-10-08 18:41, Philippe Mathieu-Daudé wrote:
>> Hi Jakob,
>>
>> On 10/8/20 6:32 PM, Jakob Bohm wrote:
>>> Red Hat bugzilla bug 1655408 against qemu is listed by Red Hat as
>>> fixed in
>>> April 2019, but I cannot find the corresponding change on qemu.org (the
>>> Changelog in the wiki is not a traditional changelog and doesn't cover
>>> bugfix releases such as 5.0.1, the git commit log is too detailed to
>>> search, the Red Hat bugzilla and security advisory pages do not link
>>> red hat bugs back to upstream (launchpad) bugs or git changes.
>>>
>>> Here is the bug title (which also affects my Debian packaged qemu 5.0):
>>>
>>> VM can not boot up due to "Failed to lock byte 100" if cdrom has been
>>> mounted on the host
>>>
>>> Further observation:
>>>
>>> The basic problem is that qemu-system refuses to start with the error
>>> message "Failed to lock byte 100" when -drive points to a read-only
>>> ISO file.  For the reporter of the Red Hat bug, that was a mount-induced
>>> read-only condition, in my case it is an NFS mount of a read-only
>>> directory.
>>>
>>> The error message itself seams meaningless, as there is no particular
>>> reason to request file locks on a read-only raw disk image.
>>>
>>> my qemu-system-x86_64 invocation contains the option (on one line):
>>>
>>> -drive if=none,id=drive-ide0-1-0,readonly=on,
>>> file=/mnt/someshare/path/gparted-live-1.1.0-5-amd64.iso,format=raw
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1655408 has been
>> closed due to lack of reproducer. Can you amend your information
>> to the BZ? It will likely be re-opened. Thanks!

... here is my reply.

Regards,

Phil.

>>
>>>
>>> Enjoy
>>>
>>> Jakob
>>> -- 
>>> Jakob Bohm, CIO, Partner, WiseMo A/S.  https://www.wisemo.com
>>> Transformervej 29, 2860 Søborg, Denmark.  Direct +45 31 13 16 10
>>> This public discussion message is non-binding and may contain errors.
>>> WiseMo - Remote Service Management for PCs, Phones and Embedded
>>>
>>
> 
> 
> Enjoy
> 
> Jakob


