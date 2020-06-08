Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AEEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 06:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085B22067B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 06:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5BJSS6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085B22067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiB9Y-00017X-AY
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 02:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiB8k-0000cZ-0P
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 02:20:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33328
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiB8h-0005EY-La
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 02:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591597206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vuNjSdJ4AKQ0VPIlzNhOOB7JWlpQrVYjrBHlvt/3Ypo=;
 b=W5BJSS6ALAfv05WV46zEauq0fE03goauZq/9nofKuWWlSQ3JYMUHv2KX5WailLg9rvoeIz
 uFDczGS8tzVHD9XYgP3pGvJBuyjz8U4N9kGxZQG/EfxiAEhYZPezFeV+mM5g2A1HZ1Vol4
 hRZWQIlyqKSARr2hSJPMl3vn6xN5jX8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-UcmAQorIPjmRCYmbxJZLUw-1; Mon, 08 Jun 2020 02:20:04 -0400
X-MC-Unique: UcmAQorIPjmRCYmbxJZLUw-1
Received: by mail-wr1-f72.google.com with SMTP id t5so6705859wro.20
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 23:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vuNjSdJ4AKQ0VPIlzNhOOB7JWlpQrVYjrBHlvt/3Ypo=;
 b=kXGpUAE50L9FHS85ABgaiZNNv+igk/5LmYNR8S50FctNecIX+8lfWDQXHXOH3YPWYL
 LYVXfEYF4bV4L6H+13lV4GezD+s2YRrdRN159CzXo8YPqrZXuxkWPwr/iGpg3g02q9Dg
 cChV+lWv3M8hhKAGMgHwxbwnTZevaC5+d/vwhBVMLhYlPCCZ5o0iXB31A1koVV5Tq0vy
 l8/8MtK+CI0FtJ5zctM5xS4gQYzyL02cLvh2b29E72HPbHsU0x20zMEeP431wHnnCxZU
 GVsi3knGdSW0jHs2WKxMczaicbKI4+u41sQ9qKRKKa6DBk4U0Ni6KxD4tKVUO4ZlSEoT
 Zw0A==
X-Gm-Message-State: AOAM531R8AzqL25+RoQ5sBXnmyCRqH6QcngWSPwZrTghgHLPfZq1c0fE
 9jlidsboAentVzPkf25tklzxqNYXLo4vN12fC9evROaGkv9CHbFdkd7i+C9isCI4mDd4IwUpX9z
 ek88h6pgHjImoseU=
X-Received: by 2002:a1c:6884:: with SMTP id
 d126mr14826169wmc.121.1591597203151; 
 Sun, 07 Jun 2020 23:20:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNiLob97fQboV6Ogg2s4tCDVcYDmSnqNvhO4qeu3yUd7btaZMeKYB3fVOPXRTmAAkyXsAmSg==
X-Received: by 2002:a1c:6884:: with SMTP id
 d126mr14826149wmc.121.1591597202923; 
 Sun, 07 Jun 2020 23:20:02 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 23sm21841864wmo.18.2020.06.07.23.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2020 23:20:02 -0700 (PDT)
Subject: Re: [PATCH v1 7/9] plugins: add API to return a name for a IO device
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-8-alex.bennee@linaro.org> <20200608034504.GA3619843@sff>
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
Message-ID: <12dd5c71-01c9-3d7f-7299-80eb928c7f2e@redhat.com>
Date: Mon, 8 Jun 2020 08:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200608034504.GA3619843@sff>
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
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, peter.puhov@linaro.org, kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 5:45 AM, Emilio G. Cota wrote:
> On Tue, Jun 02, 2020 at 16:46:22 +0100, Alex BennÃƒÂ©e wrote:
>> This may well end up being anonymous but it should always be unique.
>>
>> Signed-off-by: Alex BennÃƒÂ©e <alex.bennee@linaro.org>
>> ---
>>  include/qemu/qemu-plugin.h |  5 +++++
>>  plugins/api.c              | 18 ++++++++++++++++++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index bab8b0d4b3a..43c6a9e857f 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -335,6 +335,11 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
>>  bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
>>  uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
>>  
>> +/*
>> + * Returns a string representing the device. Plugin must free() it
>> + */
>> +char * qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *haddr);
>> +
>>  typedef void
>>  (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
>>                               qemu_plugin_meminfo_t info, uint64_t vaddr,
>> diff --git a/plugins/api.c b/plugins/api.c
>> index bbdc5a4eb46..3c73de8c1c2 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -303,6 +303,24 @@ uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr
>>      return 0;
>>  }
>>  
>> +char * qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *haddr)
>> +{
>> +#ifdef CONFIG_SOFTMMU
>> +    if (haddr && haddr->is_io) {
>> +        MemoryRegionSection *mrs = haddr->v.io.section;
>> +        if (!mrs->mr->name) {
>> +            return g_strdup_printf("anon%08lx", 0xffffffff & (uintptr_t) mrs->mr);
>> +        } else {
>> +            return g_strdup(mrs->mr->name);
>> +        }
>> +    } else {
>> +        return g_strdup("RAM");
>> +    }
>> +#else
>> +    return g_strdup("Invalid");
>> +#endif
>> +}
> 
> I'd rather use asprintf(3) and strdup(3) here, so that plugins don't
> have to worry about glib, and on the QEMU side we don't have to worry
> about plugins calling free() instead of g_free().

It might make sense, but it should be documented in
include/qemu/qemu-plugin.h or docs/devel/tcg-plugins.rst.

> 
> Or given that this doesn't look perf-critical, perhaps an easier way out
> is to wrap the above with:
> 
> char *g_str = above();
> char *ret = strdup(g_str);
> g_free(g_str);

free() ;)

> return ret;
> 
> Not sure we should NULL-check ret, since I don't know whether
> mrs->mr->name is guaranteed to be non-NULL.
> 
> Thanks,
> 		Emilio
> 


