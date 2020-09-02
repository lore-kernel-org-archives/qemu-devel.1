Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19B7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6723B20773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4hi8hXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6723B20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOLj-0001uM-LI
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDOL4-00011D-8l
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:41:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDOL2-0006Y6-M3
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599036112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MlS91AWNNGxlZFRokJZeG3DKOYZ/5SEdVwXgBWreB1A=;
 b=H4hi8hXhrwwSPNqnla5Vg4m6As7x8/YZH7K8mMTtl7AS3J8AQZTjEtRfASzAm8aokSkNGG
 w56baUSw+68TcuWvrzP0O8fQqd2ijVSzGWXx4J/llykDWqww0wI2nwuJ2H48LKLbTdm7Jk
 JwK38DTLUFG8LzExY+uwM5HfItbmfsw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-sVpf1VsMMvmjhomIWZ4nMA-1; Wed, 02 Sep 2020 04:41:50 -0400
X-MC-Unique: sVpf1VsMMvmjhomIWZ4nMA-1
Received: by mail-wr1-f72.google.com with SMTP id e14so1671115wrr.7
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MlS91AWNNGxlZFRokJZeG3DKOYZ/5SEdVwXgBWreB1A=;
 b=U4j2+fDzffxoelQe2W/09XL4iGtiEgcLy4p9U9NJk3vopIsQYe15qEoIALJIDNsnT7
 NWJSFso24+6+nEv4tTowcfYtXNN69t4e4E8mC5aLMBw08OH2ZtRQOhTtz3pGXx5GBmMQ
 lyHkczZJ9ysYk/YeLuSEEbz5Cp88zJNi81aTXUn0efA93Gx06hBzoY+n2Ov/f1R5ovUr
 z9kbzkA0nUaZ9+UIbZ8lzv8ETRqmgq6jd1xuzRhdaqGt3drpYeyNL0EWL+Ciw6nNHZ/8
 5cXy9WP3GLFDUC49og8WnXRatxaKE983JlmpvCDS/pNz9jwHDpBEBAAgkhuEgi3yvHH2
 jQNQ==
X-Gm-Message-State: AOAM530U7/2oKdcAs99dMGPz6zA5lCQxwko3isdjgUaFxWnxuUXQJczS
 2c6e6iTStiZbn9JRr1qMr8cFp3JwN088btnT/VHdz3MTRWj/J33hurTJ5P68M1gEPkm4iDE+zsS
 ISKY0JoDRV/E9nRg=
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr6364611wrx.16.1599036109335; 
 Wed, 02 Sep 2020 01:41:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1WfediHd97l/H+Ljy4LUvyRAbCGKgYmmjKT5eiX+lWdQc88lzsJ6mGjdainMk1GSFN/cJ/g==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr6364600wrx.16.1599036109131; 
 Wed, 02 Sep 2020 01:41:49 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id v4sm5089197wml.46.2020.09.02.01.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 01:41:48 -0700 (PDT)
Subject: Re: [PATCH 08/13] vl: relocate paths to data directories
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <20200901062020.26660-9-pbonzini@redhat.com>
 <daeab859-fb07-fbb1-1b7d-79ed75578f2c@redhat.com>
 <03017cc5-8a42-5834-8b5d-263e6f1322dc@redhat.com>
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
Message-ID: <14555fe9-6780-1029-bf36-feb2bd09e557@redhat.com>
Date: Wed, 2 Sep 2020 10:41:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <03017cc5-8a42-5834-8b5d-263e6f1322dc@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 10:35 AM, Paolo Bonzini wrote:
> On 02/09/20 10:28, Philippe Mathieu-Daudé wrote:
>>>  
>>> -void qemu_add_data_dir(const char *path)
>>> +void qemu_add_data_dir(char *path)
>> But we have 'const char *data_dir[16];', why remove the const?
> 
> In order to free duplicates: before this patch the directory can be
> statically- or stack-allocated, now it's always heap-allocated.

Oh I missed that, thanks.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Paolo
> 
>>  {
>>      int i;
>>  
>> @@ -2017,10 +2017,11 @@ void qemu_add_data_dir(const char *path)
>>      }
>>      for (i = 0; i < data_dir_idx; i++) {
>>          if (strcmp(data_dir[i], path) == 0) {
>> -            return; /* duplicate */
>> +            g_free(path); /* duplicate */
>> +            return;
>>          }
>>      }
>> -    data_dir[data_dir_idx++] = g_strdup(path);
>> +    data_dir[data_dir_idx++] = path;
>>  }
> 
> Paolo
> 


