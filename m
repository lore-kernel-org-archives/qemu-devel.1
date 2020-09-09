Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CC1C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FF521532
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHNany3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FF521532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvZI-0003bq-GZ
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFvYB-0002zp-09
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:33:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28107
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFvY9-0006EL-FF
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599640432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4RNBDr0YfbKFPO4AGXaS6pSlMKTDeoUUEfZ9hVGR8gk=;
 b=RHNany3oEIhqynrrIxvvJqThau3nuMjxQPBIud6m4LGzYLvl+GgYLA8uJrQbk/OK15s50d
 Z4/5F9jYK4q3BMg5doHGoyi55bbOBa+lX9GTCoYUcH3v7WzENTiyN6tX8SmPC/lPEkl684
 Yja8rvJh5khI4LggDqi3VWzSSMFOAd8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-s6w1HCUqNAmsY9yJHerkOw-1; Wed, 09 Sep 2020 04:33:48 -0400
X-MC-Unique: s6w1HCUqNAmsY9yJHerkOw-1
Received: by mail-wm1-f71.google.com with SMTP id m25so528987wmi.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 01:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4RNBDr0YfbKFPO4AGXaS6pSlMKTDeoUUEfZ9hVGR8gk=;
 b=LOgf5iL2ONiYIy61/aaXkomMnK9lfsMHSaqBkFhp6jjl5/RdR4MuQvXLmU9p/BXkHa
 jq9Y2WSeBgkmoXLD+pjyNBpVEiLM3zwlQPg6HI65M8O0ec0usq7uJVjH0XaEk3Nxcc2u
 YytWhBIQQpkpOh2dLineEHmoI2dxf4LDye3bdfzLuLwpFySny3yXodZwumuz8BXRzlyA
 m6TOQUka5fH0ihU0y1fPitsYm7qwANjnO8Y5sLHv2aAiU2HiKeCXqCv/jjXg6eUQDMXD
 YthHO37USUU2eIk9ZHASd6VKqAHgq/kaHQ9xOQgURQHldNAwBW/Z79NuQdXi4/fXMpD+
 2d/g==
X-Gm-Message-State: AOAM532SnC/hMA0htMysb+wcbPYY9OvfZqjh3T1YOxWpqDq7uxUoS903
 pGmgG1CusPen0aHwzEetpGw3O+MwSqWI+cs5FURTGTD8QgwhtrhwtFXcSwxGnN5u9A0lXUj8zXn
 hr1E8t55diSotv0g=
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr2580954wrn.93.1599640426735;
 Wed, 09 Sep 2020 01:33:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjcguYZ41faPpdsU98V+Pzu8lO5taBJAaspEfYFaw4ciZIsMtUOu0Yob62ilqp1tsbpoMSqw==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr2580919wrn.93.1599640426415;
 Wed, 09 Sep 2020 01:33:46 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id s26sm1815920wmh.44.2020.09.09.01.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 01:33:45 -0700 (PDT)
Subject: Re: [PATCH 1/5] hw/smbios: support loading OEM strings values from a
 file
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200908165438.1008942-1-berrange@redhat.com>
 <20200908165438.1008942-2-berrange@redhat.com>
 <cd82e5fe-28d9-39c3-871d-1a538fc1e55b@redhat.com>
 <20200909073537.GB1011023@redhat.com>
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
Message-ID: <140839b2-8134-aef4-c0c2-1ddce88c9ab0@redhat.com>
Date: Wed, 9 Sep 2020 10:33:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909073537.GB1011023@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 9:35 AM, Daniel P. Berrangé wrote:
> On Tue, Sep 08, 2020 at 08:24:35PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Daniel,
>>
>> On 9/8/20 6:54 PM, Daniel P. Berrangé wrote:
>>> Some applications want to pass quite large values for the OEM strings
>>> entries. Rather than having huge strings on the command line, it would
>>> be better to load them from a file, as supported with -fw_cfg.
>>>
>>> This introduces the "valuefile" parameter allowing for:
>>>
>>>   $ echo -n "thisthing" > mydata.txt
>>>   $ qemu-system-x86_64 \
>>>     -smbios type=11,value=something \
>>>     -smbios type=11,valuefile=mydata.txt \
>>>     -smbios type=11,value=somemore \
>>>     ...other args...
>>>
>>> Now in the guest
>>>
>>> $ dmidecide -t 11
>>> Getting SMBIOS data from sysfs.
>>> SMBIOS 2.8 present.
>>>
>>> Handle 0x0E00, DMI type 11, 5 bytes
>>> OEM Strings
>>> 	String 1: something
>>> 	String 2: thisthing
>>> 	String 3: somemore
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>  hw/smbios/smbios.c | 72 +++++++++++++++++++++++++++++++++++++---------
>>>  1 file changed, 59 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>>> index 7cc950b41c..8450fad285 100644
>>> --- a/hw/smbios/smbios.c
>>> +++ b/hw/smbios/smbios.c
>>> @@ -110,7 +110,7 @@ static struct {
>>>  
>>>  static struct {
>>>      size_t nvalues;
>>> -    const char **values;
>>> +    char **values;
>>>  } type11;
>>>  
>>>  static struct {
>>> @@ -314,6 +314,11 @@ static const QemuOptDesc qemu_smbios_type11_opts[] = {
>>>          .type = QEMU_OPT_STRING,
>>>          .help = "OEM string data",
>>>      },
>>> +    {
>>> +        .name = "path",
>>> +        .type = QEMU_OPT_STRING,
>>> +        .help = "OEM string data from file",
>>> +    },
>>>  };
>>>  
>>>  static const QemuOptDesc qemu_smbios_type17_opts[] = {
>>> @@ -641,6 +646,8 @@ static void smbios_build_type_11_table(void)
>>>  
>>>      for (i = 0; i < type11.nvalues; i++) {
>>>          SMBIOS_TABLE_SET_STR_LIST(11, type11.values[i]);
>>> +        g_free(type11.values[i]);
>>> +        type11.values[i] = NULL;
>>>      }
>>>  
>>>      SMBIOS_BUILD_TABLE_POST;
>>> @@ -940,9 +947,8 @@ static void save_opt(const char **dest, QemuOpts *opts, const char *name)
>>>  
>>>  
>>>  struct opt_list {
>>> -    const char *name;
>>>      size_t *ndest;
>>> -    const char ***dest;
>>> +    char ***dest;
>>>  };
>>>  
>>>  static int save_opt_one(void *opaque,
>>> @@ -951,23 +957,61 @@ static int save_opt_one(void *opaque,
>>>  {
>>>      struct opt_list *opt = opaque;
>>>  
>>> -    if (!g_str_equal(name, opt->name)) {
>>> -        return 0;
>>> +    if (g_str_equal(name, "path")) {
>>> +        g_autoptr(GByteArray) data = g_byte_array_new();
>>> +        g_autofree char *buf = g_new(char, 4096);
>>> +        ssize_t ret;
>>> +        int fd = qemu_open(value, O_RDONLY);
>>
>> While not use g_file_get_contents()?
> 
> qemu_open lets mgmt apps pass in pre-opened FDs using /dev/fdset/NN
> syntax.

OK, I was expecting a specific reason from a GLib advocate like you :)

Maybe add a comment on the 'qemu_open()' line? Else one can be tempted
to convert it to g_file_get_contents().

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


