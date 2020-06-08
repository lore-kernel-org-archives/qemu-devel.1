Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4987CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 05:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143D82076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 05:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEqdlMTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143D82076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiAj2-00072F-9M
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 01:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiAiG-0006X4-BU
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 01:52:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51907
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiAiE-0000bn-SD
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 01:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591595565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m6XoDrHuYuWi67c5qdfdhtIZb/nQ21ZzxKu3MUbfJno=;
 b=TEqdlMTQZcqmPhN6HpPXHcnAePuaHKVrq3cvW19NeviZ/2SHo3rM1DAvLV2Gbwzm85KW+g
 eR6hm1Z5tRH71EaLHMR1eStZWYJceOIQSxpx0gRro4nv+MY2D/pDYT8uwhrGQ46EmiyULM
 5gLekwNeqSmQUQu1olt8RfpQZrbO4Us=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-EZ4dBQ08NZaDZDBfYIGnnQ-1; Mon, 08 Jun 2020 01:52:43 -0400
X-MC-Unique: EZ4dBQ08NZaDZDBfYIGnnQ-1
Received: by mail-wm1-f71.google.com with SMTP id h6so3547094wmb.7
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 22:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=m6XoDrHuYuWi67c5qdfdhtIZb/nQ21ZzxKu3MUbfJno=;
 b=FCgz5xKXnlEBkbRjHpyB0gVm/sTRCrpZmCCW2JXOjpQJ9yvEnrEylLjPgzpQWlbWRF
 n6YL+C5rUnjOwbnppB/gO0RJLdGxDbKFJuSbjDkvnjdSHxuEyGSRADz49H3NDxE5Q6Ft
 SDpPnx03NO428RFFKEcEYJvGwZvxoYq7VOd0o4udtlWehNPhHWiFjUTQPmQ2WLh+CClo
 pB1O3pPfLdKUwtRKw8YVI0vr8vmICZavK9GnjVu9o83d22rZ2JMsdwkLyxFJklun7CCE
 RgV5ktp0kxGg/iO7vJIpSTQjHXUOpnV8eiUMCo3QbyzIo7V11ouAqwmlWtFZh1+AFaj9
 XlLA==
X-Gm-Message-State: AOAM533UczESVhG0YSfpJ+rrNsfXgI0LNQnnTTyaOAM5Tc+5dbDh+/xs
 Nc7yYKewuPqAv884iLoNsRr7Ubx8eEn7xIDPc/7nA+7jINCUMD/D0Kk4o/s3t6Qmguk2y7Upoy+
 KrDs32ngmmUTGpt8=
X-Received: by 2002:a5d:68c2:: with SMTP id p2mr21620900wrw.253.1591595562107; 
 Sun, 07 Jun 2020 22:52:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJQuLU9u0UGwp2U3Gy+UX6fWq7VaP8MmSV98Q3GV9toTs6RFbCKy6ssflfi/V2G+B2Goa8Lg==
X-Received: by 2002:a5d:68c2:: with SMTP id p2mr21620879wrw.253.1591595561769; 
 Sun, 07 Jun 2020 22:52:41 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l17sm22332074wrq.17.2020.06.07.22.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2020 22:52:41 -0700 (PDT)
Subject: Re: [PATCH 13/16] qdev: Make qdev_prop_set_drive() match the other
 helpers
To: Markus Armbruster <armbru@redhat.com>
References: <20200605145625.2920920-1-armbru@redhat.com>
 <20200605145625.2920920-14-armbru@redhat.com>
 <71a59dd5-9cea-9474-e318-4da3cb4f107b@redhat.com>
 <87v9k2xhef.fsf@dusky.pond.sub.org>
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
Message-ID: <a2e7935a-ded1-feb4-d2b3-8801a7e6266b@redhat.com>
Date: Mon, 8 Jun 2020 07:52:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87v9k2xhef.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 7:20 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 6/5/20 4:56 PM, Markus Armbruster wrote:
>>> qdev_prop_set_drive() can fail.  None of the other qdev_prop_set_FOO()
>>> can; they abort on error.
>>>
>>> To clean up this inconsistency, rename qdev_prop_set_drive() to
>>> qdev_prop_set_drive_err(), and create a qdev_prop_set_drive() that
>>> aborts on error.
>>>
>>> Coccinelle script to update callers:
>>>
>>>     @ depends on !(file in "hw/core/qdev-properties-system.c")@
>>>     expression dev, name, value;
>>>     symbol error_abort;
>>>     @@
>>>     -    qdev_prop_set_drive(dev, name, value, &error_abort);
>>>     +    qdev_prop_set_drive(dev, name, value);
>>
>> Why not open-code qdev_prop_set_drive_err(..., &error_abort)?
> 
> Consistency with qdev_prop_set_chr() and qdev_prop_set_netdev().
> 
> My starting point was "what makes block backends so different that they
> need error handling where nothing else does?"
> 
> After a considerable amount of digging, my answer is "nothing".
> qdev_prop_set_drive(), qdev_prop_set_chr() and qdev_prop_set_netdev()
> can all run into errors.  On closer examination, all programming errors
> (thus &error_abort), except for "backend is already in use", and to
> trigger that one, you have to get creative and steal the backend for
> another purpose, e.g. with -global.  This is the abridged version of a
> longwinded argument I didn't want to make in this series, so I left the
> error handling alone.
> 
> In the longer run, I want qdev_prop_set_drive_err() to die.

I agree with the longer run. I naively thought this could be done
in the same patch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>>
>>>
>>>     @@
>>>     expression dev, name, value, errp;
>>>     @@
>>>     -    qdev_prop_set_drive(dev, name, value, errp);
>>>     +    qdev_prop_set_drive_err(dev, name, value, errp);
>>>
>> [...]
> 


