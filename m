Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC7EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7282A204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYyR9Dag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7282A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7fM7-0002Yg-NW
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 09:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7fLa-00029s-KG
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:38:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40889
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7fLY-0007Gz-OA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597671523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XpFtVKXpCKmBKB1xDWPJ5+hUZ4f3H2BiGVbdJfQdydc=;
 b=iYyR9DagU0b22HJzPmuBwjhTV44MkWy8KJjyodQxJ3IGjvqcUi2Ix91h0blWVM+BjDt5rQ
 BH2JieO0ni41hB6fXltUKtd7ISIewbltMyTcymSzz1hKUSBHII1iDNmGPV5OiZemx30WR/
 nvRg5yUqmf0wfgF/d1OTRvKUYZmg2es=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-qkaTvGiPNh2BEv8umX_SbA-1; Mon, 17 Aug 2020 09:38:31 -0400
X-MC-Unique: qkaTvGiPNh2BEv8umX_SbA-1
Received: by mail-wr1-f69.google.com with SMTP id k11so7076672wrv.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 06:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XpFtVKXpCKmBKB1xDWPJ5+hUZ4f3H2BiGVbdJfQdydc=;
 b=UvWz9xHYrLcnwbFLPQFwir4skmfJJxzq2bYxuoxoXN32H5EvzBsQHsdLJzdttVQQgJ
 I5z2UyJklqiTWvgA7IzbxKBEdeWO1BR0QY8xqBwGCp0GsijWQHe+BiFKoMOfSJv/zQW1
 OIj66hs5vnVm6r8dNFlH+ToC/nCkRl6z+Q3kN7Op6UaQajjj6igXdeyOIJoBO433/pO4
 zfrRUvMpBETNgfl88CIZ49hC1T/D9O4N/ox5v3XxAIbjUyUypn8V9u/QNzIIAmM29DsL
 m96FJflvcB0oqDb9ky+7KQypsvhrotBp89kSyDi+mXlfXnvnUCE8rW2CS6fv61uYEz1+
 wxdQ==
X-Gm-Message-State: AOAM532P0fhoBMt0wrvNAcKFnJD6EeYwcuqHCbTWSG2+MO4+0xcmsEf1
 r+ng8mX7nkgIpZA1B00bqWd21njJ4bpFet5mSx5DtgGndY6TSqkMMmoMtzSyFeAUx3G/VGHQzOf
 DUHmqlzldXDwblg8=
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr15386842wru.222.1597671510383; 
 Mon, 17 Aug 2020 06:38:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKnbw+Z2jGis3wxNEdJpk8sWHIVPvcsSsbgRQrelv43HehW4NA8XXhCWFS3EmT4rSPGepcsA==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr15386821wru.222.1597671510184; 
 Mon, 17 Aug 2020 06:38:30 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t189sm30984760wmf.47.2020.08.17.06.38.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 06:38:29 -0700 (PDT)
Subject: Re: [PATCH 025/150] libqemuutil, qapi, trace: convert to meson
To: Roman Bolshakov <r.bolshakov@yadro.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
 <20200814091326.16173-26-pbonzini@redhat.com>
 <20200817111000.GB98227@SPB-NB-133.local>
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
Message-ID: <3b8912cb-510e-fe84-39d4-276d12687538@redhat.com>
Date: Mon, 17 Aug 2020 15:38:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817111000.GB98227@SPB-NB-133.local>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:10 PM, Roman Bolshakov wrote:
> On Fri, Aug 14, 2020 at 05:11:21AM -0400, Paolo Bonzini wrote:
>> This shows how to do some "computations" in meson.build using its array
>> and dictionary data structures, and also a basic usage of the sourceset
>> module for conditional compilation.
>>
>> [...]
>> +  trace_ss.add(trace_h, trace_c)
>> +  if 'CONFIG_TRACE_DTRACE' in config_host
>> +    trace_dtrace = custom_target(fmt.format('trace-dtrace', 'dtrace'),
>> +                                 output: fmt.format('trace-dtrace', 'dtrace'),
>> +                                 input: trace_events_file,
>> +                                 command: [ tracetool, group, '--format=d', '@INPUT@' ],
>> +                                 capture: true)
>> +    trace_dtrace_h = custom_target(fmt.format('trace-dtrace', 'h'),
>> +                                   output: fmt.format('trace-dtrace', 'h'),
>> +                                   input: trace_dtrace,
>> +                                   command: [ 'dtrace', '-o', '@OUTPUT@', '-h', '-s', '@INPUT@' ])
>> +    trace_dtrace_o = custom_target(fmt.format('trace-dtrace', 'o'),
>> +                                   output: fmt.format('trace-dtrace', 'o'),
>> +                                   input: trace_dtrace,
>> +                                   command: [ 'dtrace', '-o', '@OUTPUT@', '-G', '-s', '@INPUT@' ])
>> +
>> +    trace_ss.add(trace_dtrace_h, trace_dtrace_o)
> 
> The patch conflicts with the latest tracing PULL request,

Which isn't merged ;)

It is simpler for the reviewer to test using a series that
apply on current master.

> object files shouldn't be generated on darwin:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02493.html
> 
> Thanks,
> Roman


