Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6DEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C3C2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RybfyE+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C3C2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5X6K-0007oI-0Y
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5X5i-0007OI-8O
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5X5f-0000UF-OE
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597163130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GPQNwFRqXiEtNQx0JGAl0KPZz6EyDN5nA65aQGEeioY=;
 b=RybfyE+SLEQMVJBt/+xC0hvH1UaacecQCfeS31iXmJ9hV3hARiJfI03Sg1UgWyjeEhzNwI
 SqdYVGqLDQWWlj4hviHbQJ+tvpQt+4AJaP5CJF/Cl5ibYDnWUYSl66jEgN3D87rL9tIdfK
 E7/jetgU9m812NkKOh/w44TRLFikSrg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-Ew371junPcWqL9u-RvhwvA-1; Tue, 11 Aug 2020 12:25:28 -0400
X-MC-Unique: Ew371junPcWqL9u-RvhwvA-1
Received: by mail-wm1-f69.google.com with SMTP id z10so986622wmi.8
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 09:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GPQNwFRqXiEtNQx0JGAl0KPZz6EyDN5nA65aQGEeioY=;
 b=WzIHzje61SZSxFUZT+fMmxkm0Bshs8UUqThpkdhCcB7biFGVE1yPrPDv78OOLuhLkF
 K/7FhMz7Lj9VeEn+ZQeHVTc5AZuUvgfyANGoNIjuw4p2BWFOjkwbKDyGwBsfxt6HF8sV
 FRLh0qQWpXwQG1N++jnv/mimDC0L6L6Mb4VBok3MNT6uIajtwoKFBJpzmAcNMjbqey3H
 1e61D9CCIkQ3RVmyqUGpIbjLHdkCBSMQ6M/HYgwNBNcMkfCQx+xfiB3VEVoOUHbrkTjI
 bUeiAafZqgSkDsgVR9ivdN+kFCU2azU841FcZgoNfTxijdBUpGpc9mIQ3R5bxh8eHB6T
 90Og==
X-Gm-Message-State: AOAM532P9qUKd1LaeYAV7hktQxDw6GwMgbIqCbZ8DUTI2+gF2xT0U4Vg
 ywiyF2OQWPf2GWltK3zsfTz9Pmj33dq63G+Nbygd9CHX9wQbiGuVDhoa2OROyZs6wjrLjKOOnx0
 jWHZDF2bD49dLYIQ=
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr32991160wrn.60.1597163127400; 
 Tue, 11 Aug 2020 09:25:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaw7TRYlur1IS0ZaahUA+/pZlWe2whi3uRhLdUFIAadim4KNaHJ8p6dKsLi9vBufY9Ic6kQg==
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr32991142wrn.60.1597163127140; 
 Tue, 11 Aug 2020 09:25:27 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id h6sm26925632wrv.40.2020.08.11.09.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 09:25:26 -0700 (PDT)
Subject: Re: [PATCH 139/147] meson: replace create-config with meson
 configure_file
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-140-git-send-email-pbonzini@redhat.com>
 <21cc800d-c8bf-b737-1059-b83044ad9271@redhat.com>
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
Message-ID: <3fa2ac37-b2c1-cc90-28b0-e8361472b331@redhat.com>
Date: Tue, 11 Aug 2020 18:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <21cc800d-c8bf-b737-1059-b83044ad9271@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 05:47:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 6:20 PM, Philippe Mathieu-Daudé wrote:
> On 8/10/20 7:08 PM, Paolo Bonzini wrote:
>> Move the create-config logic to meson.build; create a
>> configuration_data object and let meson handle the
>> quoting and output.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  Makefile                       |   2 +-
>>  block.c                        |   4 +-
>>  configure                      |   9 ++-
>>  meson.build                    | 100 ++++++++++++++++++++++---------
>>  scripts/create_config          | 131 -----------------------------------------
>>  tests/qtest/bios-tables-test.c |   2 +-
>>  6 files changed, 80 insertions(+), 168 deletions(-)
>>  delete mode 100755 scripts/create_config
>>
>> diff --git a/Makefile b/Makefile
>> index cd4eeb5..1eec727 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -189,7 +189,7 @@ clean: recurse-clean
>>  	rm -f fsdev/*.pod scsi/*.pod
>>  	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
>>  
>> -VERSION ?= $(shell cat VERSION)
>> +VERSION = $(shell cat $(SRC_PATH)/VERSION)
>>  
>>  dist: qemu-$(VERSION).tar.bz2
>>  
>> diff --git a/block.c b/block.c
>> index 67c5028..67ca543 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -443,13 +443,13 @@ static int bdrv_format_is_whitelisted(const char *format_name, bool read_only)
>>          return 1;               /* no whitelist, anything goes */
>>      }
>>  
>> -    for (p = whitelist_rw; *p; p++) {
>> +    for (p = whitelist_rw; p < &whitelist_rw[ARRAY_SIZE(whitelist_rw)]; p++) {
> 
> Alexander reported [*] a problem when ARRAY_SIZE(whitelist_rw) == 0 you
> access an undefined address:

The question is why CONFIG_BDRV_RW_WHITELIST & CONFIG_BDRV_RO_WHITELIST
aren't generated by meson.build...

> 
> block.c:442:10: runtime error: index 0 out of bounds for type 'const
> char *[0]'
> 
> [*] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02066.html
> 
>>          if (!strcmp(format_name, *p)) {
>>              return 1;
>>          }
>>      }
>>      if (read_only) {
>> -        for (p = whitelist_ro; *p; p++) {
>> +        for (p = whitelist_ro; p < &whitelist_ro[ARRAY_SIZE(whitelist_ro)]; p++) {
> 
> Ditto.
> 
>>              if (!strcmp(format_name, *p)) {
>>                  return 1;
>>              }
> [...]
> 


