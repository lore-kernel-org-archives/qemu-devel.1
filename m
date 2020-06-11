Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43BCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA3D20691
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afB87wJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA3D20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLll-0006JX-MW
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjLiF-0002WH-5P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:49:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjLiD-0003ea-Gg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591876175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=maTtLd4FZSoQ14DmsNwqYeJT8HBjyzAFs4MQosjAspY=;
 b=afB87wJM2xje8AAvsElsDFfrwAlm97Ev8fdlAaMcS/3rU5i7QMzGj52pJkqZGsiueNoyUe
 IoGi9hLZ8d83tQ+KR0OlDP55bGirB7blLIfUkJ/0ixSr9hlLLZ3WI7tCCGBYmBzOUhb6eZ
 F4WtrXKNn2/8k1EOKo5MF/B1ZDc6Uco=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-w_feQf6SOMW-T5aAcIKiVw-1; Thu, 11 Jun 2020 07:49:34 -0400
X-MC-Unique: w_feQf6SOMW-T5aAcIKiVw-1
Received: by mail-wm1-f71.google.com with SMTP id x6so1248629wmj.9
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 04:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=maTtLd4FZSoQ14DmsNwqYeJT8HBjyzAFs4MQosjAspY=;
 b=tCRVYNNxhNaJV5OfoRORuMNhVjOmyWfQV4cWCxlmvPP0Zu9vhOWG023PKH/dAeJm+Y
 ZS9/mZLwg3dGHo+UyQLy9Q9sIaNnVVxx/h0Y531PSOq2OvHXSeESAN28SX7ypzbjXOfx
 Q6JczuVrSuFYimxiwtHJJ/uBAhmafcET8yh9jNe/w52+PkNNEjktbCiX0Qgf6MzkR3WR
 GaYP/3Pqkh1jmdNPnO9PPNXY+CkdZ9YpybKH/4PshHbrySt7l1wbvyfpBdFp8AdeVvuz
 J5P14eAgkbIVkf7D05ILCy9qsTj1sSo7feakw9/buKXIHHypA3DS3uPtCi6s0xL4sIQW
 zAJA==
X-Gm-Message-State: AOAM533LMGcQT5ZfjW3H4b0Ps7hsRPESTud+TrUZk7YIh96d3pKIYrUc
 KYEXAFOGp+Wi3T941FD8o+7b9LmfTEz3mrv6w9AF33gkw2OqU/52rm+DKXV6UIZD9ID+f2mi4By
 nxE02WKbiG4ENQ5M=
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr9237317wrt.341.1591876173201; 
 Thu, 11 Jun 2020 04:49:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypD5xq7lQi1zdviavZZ5Q2SREDecMwNk320sZz5wRLB+zHNqqc2rL/0YeXWnqdgyCp93QjEg==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr9237291wrt.341.1591876172975; 
 Thu, 11 Jun 2020 04:49:32 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a124sm3892649wmh.4.2020.06.11.04.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 04:49:32 -0700 (PDT)
Subject: Re: [PATCH v7 2/5] softmmu/vl: Let -fw_cfg option take a 'gen_id'
 argument
To: Laszlo Ersek <lersek@redhat.com>, minyard@acm.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-3-philmd@redhat.com>
 <f3f6154e-bbc1-98bd-0f44-77b28c74915f@redhat.com>
 <20200609155050.GT2880@minyard.net>
 <6e4b9540-7d5b-0951-2870-bada03e29d83@redhat.com>
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
Message-ID: <8b7e8fab-9b2a-e953-b0eb-3c96d77832f6@redhat.com>
Date: Thu, 11 Jun 2020 13:49:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6e4b9540-7d5b-0951-2870-bada03e29d83@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 1:31 PM, Laszlo Ersek wrote:
> On 06/09/20 17:50, Corey Minyard wrote:
>> On Fri, May 29, 2020 at 11:50:24AM +0200, Laszlo Ersek wrote:
>>> Gerd, Corey: there's a question for you near the end, please.
>>>
>>> On 05/28/20 19:31, Philippe Mathieu-Daudé wrote:
>>
>> snip...
>>
>>>
>>>
>>> (3) I've noticed another *potential* issue, from looking at the larger
>>> context. I apologize for missing it in v6.
>>>
>>> See commit bab47d9a75a3 ("Sort the fw_cfg file list", 2016-04-07). (I'm
>>> copying Corey; Gerd is already copied.) From that commit, we have, at
>>> the end of this function:
>>>
>>>     /* For legacy, keep user files in a specific global order. */
>>>     fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
>>>     fw_cfg_add_file(fw_cfg, name, buf, size);
>>>     fw_cfg_reset_order_override(fw_cfg);
>>>
>>> This takes effect for "file" and "string", but not for "gen_id". Should
>>> we apply it to "gen_id" as well? (Sorry, I really don't understand what
>>> commit bab47d9a75a3 is about!)
>>
>> I can explain the rationale for that change, but I'm not sure of the
>> answer to your question.  That changes makes sure that the fw_cfg data
>> remains exactly the same even on newer versions of qemu if the machine
>> is set the same.  This way you can do migrations to newer qemu versions
>> and anything using fw_cfg won't get confused because the data changes.
>>
>> The reason that change was so complex was preserving the order for
>> migrating from older versions.
>>
>> This is only about migration.  I'm not sure what gen_id is, but if it's
>> migrated, it better be future proof.
> 
> Whenever introducing a new fw_cfg file (*any* new named file), how do we
> decide whether we need fw_cfg_set_order_override()?

Good idea to ask, so we can document the answer in the fw_cfg API doc.

> 
> Thanks
> Laszlo
> 
> 
>>
>> -corey
>>
>>>
>>> *IF* we want to apply the same logic to "gen_id", then we should
>>> *perhaps* do, on the "nonempty_str(gen_id)" branch:
>>>
>>>         size_t fw_cfg_size;
>>>
>>>         fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
>>>         fw_cfg_size = fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
>>>         fw_cfg_reset_order_override(fw_cfg);
>>>         return (fw_cfg_size > 0) ? 0 : -1;
>>>
>>> I think???
>>>
>>> Or maybe even use FW_CFG_ORDER_OVERRIDE_DEVICE rather than
>>> FW_CFG_ORDER_OVERRIDE_USER? I don't have the slightest clue.
>>>
>>> (I guess if I understood what commit bab47d9a75a3 was about, I'd be less
>>> in doubt now. But that commit only hints at "avoid[ing] any future
>>> issues of moving the file creation" -- I don't know what those issues
>>> were in the first place!)
>>>
>>> With (1) optionally fixed, and (2) fixed, I'd be willing to R-b this
>>> patch; but I'm really thrown off by (3).
>>>
>>> Thanks,
>>> Laszlo
>>>
>>>
>>>>      } else {
>>>>          GError *err = NULL;
>>>>          if (!g_file_get_contents(file, &buf, &size, &err)) {
>>>>
>>>
>>
> 


