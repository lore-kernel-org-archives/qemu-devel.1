Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F527C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED6F206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCkj7v39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED6F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyu61-0002wd-5k
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyu5B-00024e-0P
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:33:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyu58-0007dG-Sx
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595583213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=prNmmHmS861Kv9DQ0YqMJj1Nd/K40Lma65g2yd+spV8=;
 b=GCkj7v39AbEUAIZlPRy+V+zgN9piVFs/wyg9tDJ66613q+e27kqXbcKWoApyEynxATuHup
 bLkFr+NwT9ieV+KdjkwHwAOOYFr5SMACrOsKNFckWDVeyG6ZRD2InPxFvvs5VsxfRVRFfh
 9mdP+JPD2NyBBFLNKdNmTNzxZ0kEMHM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-MgiBF3WHOOi8EpR8uDDSgA-1; Fri, 24 Jul 2020 05:33:32 -0400
X-MC-Unique: MgiBF3WHOOi8EpR8uDDSgA-1
Received: by mail-wm1-f72.google.com with SMTP id b13so3739360wme.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 02:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=prNmmHmS861Kv9DQ0YqMJj1Nd/K40Lma65g2yd+spV8=;
 b=Ytah3fS741pc9NGJ4Pg4ieVStIUNly3RRXM4C23T8nyEf/DX1Runm6iTX53ej7qcmd
 S39lgDEPkkkz+nmdr9yQyNPx7aybJHvWJMwmFzi9D9I4fo2LUT1fOixoBJmdETfEVB8u
 V09NZekfiXqbI+kKVnLY5bLmRwqyBWYU3Ohqbqd+AcitnNSyLHzIonN8nO5OKSDVVoSx
 2WTr/WNRj3ZL4R11ez9IG1FdWKbaKpYGwHxtKrDjCxubtDQRIIa4DtJYk+/8KdzXr0Ga
 1NHrNdRkRLCF1ZYsi5qPMt6rHS+oyLPKLrQ/e5xESe8aZ3zfsU5W3992zhDuT2czBcGz
 wn+w==
X-Gm-Message-State: AOAM53322B6EvPg5Ef0d+QLDZx8qV+C3jjgrvcsFT3emOfF07Wy0GbYn
 nbX8b/7lTetuwBEIYYWm4KhT+hW7N5SSQ4LbdBH5lOXTHAJfgPCY+X1S31ZCnNWcAJ4A0QkJfM2
 h0gsjNOfI0vkLMvI=
X-Received: by 2002:a1c:1dcc:: with SMTP id d195mr5353188wmd.11.1595583210998; 
 Fri, 24 Jul 2020 02:33:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbAs1e9VdqkImitsUjZ/Wonr7J5GpwbE6ai1MBJmIshKIFvCSJt2txXF2BBDkkuYoJjQ+OSA==
X-Received: by 2002:a1c:1dcc:: with SMTP id d195mr5353174wmd.11.1595583210787; 
 Fri, 24 Jul 2020 02:33:30 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k4sm672354wrd.72.2020.07.24.02.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 02:33:30 -0700 (PDT)
Subject: Re: [PATCH-for-5.1? v2] qapi/error: Check format string argument in
 error_*prepend()
To: Markus Armbruster <armbru@redhat.com>
References: <20200723171205.14949-1-philmd@redhat.com>
 <87o8o5cpbp.fsf@dusky.pond.sub.org>
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
Message-ID: <129317f1-a6fb-7eae-adbd-5b061dfddd74@redhat.com>
Date: Fri, 24 Jul 2020 11:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87o8o5cpbp.fsf@dusky.pond.sub.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:01:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 10:03 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> error_propagate_prepend() "behaves like error_prepend()", and
>> error_prepend() uses "formatting @fmt, ... like printf()".
>> error_prepend() checks its format string argument, but
>> error_propagate_prepend() does not. Fix by addint the format
> 
> s/addint/adding/
> 
>> attribute to error_propagate_prepend() and error_vprepend().
>>
>> This would have caught the bug fixed in the previous commit:
>>
>>     CC      hw/sd/milkymist-memcard.o
>>   hw/sd/milkymist-memcard.c: In function ‘milkymist_memcard_realize’:
>>   hw/sd/milkymist-memcard.c:284:70: error: format ‘%s’ expects a matching ‘char *’ argument [-Werror=format=]
>>     284 |         error_propagate_prepend(errp, err, "failed to init SD card: %s");
>>         |                                                                     ~^
>>         |                                                                      |
>>         |                                                                      char *
> 
> I see no need to repeat the details here.  If you agree, I'll drop them
> in my tree.

OK, thanks.

> 
>> Missed in commit 4b5766488f "error: Fix use of error_prepend() with
>> &error_fatal, &error_abort".
>>
>> Inspired-by: Stefan Weil <sw@weilnetz.de>
>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 


