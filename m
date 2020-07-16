Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BE9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65FD2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKhjKURs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65FD2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzPq-0004Zn-V4
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 04:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvzPI-0004AT-2Y
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:38:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34088
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvzPG-0004M4-Bl
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594888697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6KCKJWkQpD3GyiC3aS9dEcDoOmBWo5U3MeW9CjKSkK8=;
 b=eKhjKURsgggwHozIWVPBWzOjZqojuTZs1KGSzM/xMQEkRP90oI94k9yHlXj8vbuHn8/r9s
 igQ+UKRTzUHqaxg9ST8vJoNAoP0nohRvHVoSj2gcD1OCaxGk05h2FcMqA7Qs7G6r7j1lA2
 ddMkIh/9RHzIjWf9gNwKg0LnTVbZzo8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-4sAArP8PPzmcgQcR5xJyoQ-1; Thu, 16 Jul 2020 04:38:15 -0400
X-MC-Unique: 4sAArP8PPzmcgQcR5xJyoQ-1
Received: by mail-wr1-f71.google.com with SMTP id y13so5123380wrp.13
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 01:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6KCKJWkQpD3GyiC3aS9dEcDoOmBWo5U3MeW9CjKSkK8=;
 b=HkwCJqWF09Zzix+VpZbifgrFOqstF3h8DBvLwU4ZQ6YuXjMJWCPi05kingJIp/4n6g
 /B+EI1FqqqyW9COlEbtsVPcCER/2OJQt0nU+iPGRGS90OkuhxV0SrfFI9j498cQRSkik
 BcvKKxT3w01fNG2jevc8F210ZkdTJElujVlgUSu3bDY+PWq00aKQNnePg3yqRODU11Uw
 VU+A8Oa+23Kq6xpOy6RFtLW2JR7AdSQu/gWMUjWKGCnOFzRe6YVPUcIVgitND1TuoR7A
 RYaJXJO/nQzt+HUDwWAnk1HbG5ci4sZ0xLKVHsiLmcV4Ini8su4RLRWcZo8jy4OrX286
 mUjA==
X-Gm-Message-State: AOAM532qNKhPzVDsQoRs03FiZoCMy2BpfI0ijQwbyjD6WHsDCgETpWkC
 t3c+jaxjjHvCv07aEXy7DM5oBChc8KIb+97LO1WiSMruAABRZfh4z6HesPbjx6bTv1Utc3tjhbC
 +pQ9U7eoTgKcYovQ=
X-Received: by 2002:adf:fa81:: with SMTP id h1mr4010173wrr.266.1594888694357; 
 Thu, 16 Jul 2020 01:38:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKt63HOb8o0gVTSk1DLOOzMukyMZfqHvAayemqp7fVublTCGqF0dPQzmbZNdaUuc3IXkUgcA==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr4010149wrr.266.1594888694014; 
 Thu, 16 Jul 2020 01:38:14 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j15sm7606852wrx.69.2020.07.16.01.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 01:38:13 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 1/5] hw/core/qdev-properties: Simplify
 get_reserved_region()
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200715175835.27744-1-philmd@redhat.com>
 <20200715175835.27744-2-philmd@redhat.com>
 <87o8ofrhgl.fsf@dusky.pond.sub.org>
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
Message-ID: <699828e5-83bd-1dfa-904a-8d38a0178e63@redhat.com>
Date: Thu, 16 Jul 2020 10:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87o8ofrhgl.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 10:29 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Use the safer g_strdup_printf() over snprintf() + abort().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/core/qdev-properties.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 098298c78e..d5f5aa150b 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -581,13 +581,10 @@ static void get_reserved_region(Object *obj, Visitor *v, const char *name,
>>      DeviceState *dev = DEVICE(obj);
>>      Property *prop = opaque;
>>      ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
>> -    char buffer[64];
>> -    char *p = buffer;
>> -    int rc;
>> +    g_autofree char *p;
>>  
>> -    rc = snprintf(buffer, sizeof(buffer), "0x%"PRIx64":0x%"PRIx64":%u",
>> -                  rr->low, rr->high, rr->type);
>> -    assert(rc < sizeof(buffer));
>> +    p = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
>> +                        rr->low, rr->high, rr->type);
>>  
>>      visit_type_str(v, name, &p, errp);
>>  }
> 
> I don't buy "safer" (the old code is already safe).

I'm suspicious when I find an assert/abort in a code reachable by
management interface, as IIUC we don't want to crash the process.
I agree this shouldn't happen and if it happens we are screwed
anyway.

> I could buy
> "simpler".
> 
> It's also less efficient, but that shouldn't matter in a property
> getter.

If we want more efficient code, we should replace all the
g_strdup_printf() calls by snprintf() + assert() in the places
where we don't expect failure. This seems counterproductive from
a maintenance PoV. At some point we should make a decision and
not allow more than 3 similar APIs at a time. We have been
recommended to use GLib instead of snprintf() because it is "safer".
Can we be consistent with recommendations? Else we should stop
recommending to use GLib and friends.

Thanks,

Phil.


