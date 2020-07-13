Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA3C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0CF20758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZf3o8KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0CF20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwCw-0007ZG-5a
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juw9d-0003hH-7g
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:57:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40419
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juw9a-000462-UR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594637866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0dsAqSi99yvjTgIpRCl/Cp/jQqXrxdBjYOxeXf287po=;
 b=BZf3o8KMZP8kiWrYR+tkVRLllj0/toKeDCvEGmconDSjyV0G5b5Dd2KaeQNuyLvVKCTByo
 HRRtyFOlCDBOulFCjvxceChzDL1sjRa6cVFwELGmZjELCOY/mQyn5HN9sfcUIBwc6qN7Io
 cw72tCl7rtgmn7ngdlfgXFzEKThzpoU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-rA2zzX1NNDWtlCApyZS59w-1; Mon, 13 Jul 2020 06:57:42 -0400
X-MC-Unique: rA2zzX1NNDWtlCApyZS59w-1
Received: by mail-ed1-f70.google.com with SMTP id b11so20472434edx.10
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 03:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0dsAqSi99yvjTgIpRCl/Cp/jQqXrxdBjYOxeXf287po=;
 b=GFceUGYIRrPZVlOCKQ+i/vTPpHmbF1xLwoWumtpsr6WSaNG0NIpamfKTDgQ8jZ6cqi
 60rzDZp8smI/GiGz3DUT8JfnG8ORB3lFKc5C5eMvHMgUKR4LSbM0hDlNQ9dPinqab0RF
 3qQLsIin1/JbGtknEGaOrshQUeC/0WKteU7h9Rz7k1PPpEcujEnAfXNQs+ih0wUhX8qi
 Bo4qAngMC2Cutsu/UvZ7o0a9bdoAnyQu9v4FAvj037veT1VLhSf/uc+KffiZkYNuDkH3
 Kt2kXLbs09e3gUG0DfqdI2AXqY9+GaOlxVfSWZe7OmdBVSXAl8E7ki0WgCkuLeuItKIF
 upvw==
X-Gm-Message-State: AOAM533nXeEN9DB4S9CGVptXa8y/lARq39im44yL3GBaLrigLDyxwqGb
 TemxkGkBJNTXeDvazpUean5CwDuKMOuVCUf0z88a3kP6pkvR0qGGRr0xJqu+3raIVhHAvs8qESP
 qYt2Y9yzWhGGZ3b0=
X-Received: by 2002:a05:6402:1c86:: with SMTP id
 cy6mr75816743edb.30.1594637860140; 
 Mon, 13 Jul 2020 03:57:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3XnDg+LnSdB4MszxXBmMYuL4Zuy5v1fnn2m140CssL9RuP6+Elag+0wEFPORXOK+phf9axw==
X-Received: by 2002:a05:6402:1c86:: with SMTP id
 cy6mr75816731edb.30.1594637859976; 
 Mon, 13 Jul 2020 03:57:39 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id dm1sm9592601ejc.99.2020.07.13.03.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 03:57:39 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] qga: Ditch g_get_host_name()
To: Michael Roth <mdroth@linux.vnet.ibm.com>
References: <cover.1592849834.git.mprivozn@redhat.com>
 <d4a48322-a2f2-5125-15a2-6f9f9845ad0b@redhat.com>
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
Message-ID: <35cafba8-4b11-91cc-6d4a-57c852569c75@redhat.com>
Date: Mon, 13 Jul 2020 12:57:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d4a48322-a2f2-5125-15a2-6f9f9845ad0b@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org,
 vfeenstr@redhat.com, marcandre.lureau@gmail.com, sw@weilnetz.de,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping^2?

On 7/10/20 11:43 AM, Michal Privoznik wrote:
> On 6/22/20 8:19 PM, Michal Privoznik wrote:
>> v3 of:
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg06913.html
>>
>> diff to v2:
>> - don't leak @hostname in util/oslib-posix.c:qemu_get_host_name()
>> - document why we are allocating one byte more than needed
>> - switch to g_new0() from g_malloc0().
>>
>> Michal Privoznik (2):
>>    util: Introduce qemu_get_host_name()
>>    qga: Use qemu_get_host_name() instead of g_get_host_name()
>>
>>   include/qemu/osdep.h | 10 ++++++++++
>>   qga/commands.c       | 17 +++++++++++++----
>>   util/oslib-posix.c   | 35 +++++++++++++++++++++++++++++++++++
>>   util/oslib-win32.c   | 13 +++++++++++++
>>   4 files changed, 71 insertions(+), 4 deletions(-)
>>
> 
> Ping? How can I get these merged please?
> 
> Michal
> 
> 


