Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A764C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A76D20663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7ubvTA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A76D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqI78-0000Ac-CS
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqI0P-0002JS-Hb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:17:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46278
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqI0N-0007UE-CP
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593530222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TPPIxDap/uV1aYpe6/Cf/G0w57aBryIKr0ii6Fptxgc=;
 b=X7ubvTA7HntqDODlSCshx2VTy6llIv4d55WOi7whAzOE3tKvGLXr+as415YKNPzXfPm1IB
 94+8xG3DD7ydXbsja4YwFetjNaJfaOQqSAWiSuImTCsZMO+uKe5/tLxXhjedpjM3ELAImh
 QlIIrR9o7f6+e9kiZWbaKHlyRvVze1M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-K3-ucLT9Oomgar-WjEh1bA-1; Tue, 30 Jun 2020 11:16:58 -0400
X-MC-Unique: K3-ucLT9Oomgar-WjEh1bA-1
Received: by mail-ej1-f72.google.com with SMTP id e21so13280328ejr.9
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TPPIxDap/uV1aYpe6/Cf/G0w57aBryIKr0ii6Fptxgc=;
 b=dG0kqXT1oXkI5mKL1gQ0om26H8v2kwQ8umYAIzRIZxd8ngzCs0gCan6I8nbEQ1BCT1
 l9GkuRY/62EiMT8gozHdYgTLpQIEQEAj7JoRpozjELwhDYbMu5Lf9jUmsh1rTiypwvgX
 5jClXWPZgdupIsfm5W5Cw5yMRhsDS1TDB1f1qWvWqFnd45U36DiZJ5tqy8SMeZmaN4cI
 5t/vBANJXA9LebJlLedEgqbL8hj6Uq51CkXpsuq0A1wHWdp5sf4sf+3TAUpq/Fboboc+
 Hh+xl44cV83si5L9Fbf9aeZjd8OV/hnrnA110l6D84lWSYkxLbbjMWJsuuC+IjHZcuwc
 Ws6w==
X-Gm-Message-State: AOAM5335j4LeomTk8l5P0z8JZTrAZ1Gl/zcfwvWMOENSmw3nncRk/DVn
 0ykXD9u8PZ0Oc339Jila6wWbQNryj2SiBKKW0MuWZjGkHA9WrbxNRXZkPrKijbSZKqYu9HbhE21
 ll54uhOcxRe9A4Tw=
X-Received: by 2002:a17:906:494a:: with SMTP id
 f10mr19646367ejt.428.1593530216873; 
 Tue, 30 Jun 2020 08:16:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysnQ2xtqnpNLg8ZMrfRFnOJI+ZDZ5uofsDJOYtHElEeFfbRsYr/6yESmqYIk293yeiJzAXyg==
X-Received: by 2002:a17:906:494a:: with SMTP id
 f10mr19646339ejt.428.1593530216627; 
 Tue, 30 Jun 2020 08:16:56 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id i7sm3013833eds.91.2020.06.30.08.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 08:16:55 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] hw/block/nvme: Fix pmrmsc register size
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, qemu-devel@nongnu.org
References: <20200630110429.19972-1-philmd@redhat.com>
 <20200630110429.19972-4-philmd@redhat.com>
 <45a97bae-887c-2669-439e-08ec3e75113e@linux.intel.com>
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
Message-ID: <e19634b7-b4b6-dbb8-e49f-bf7f96b89e81@redhat.com>
Date: Tue, 30 Jun 2020 17:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <45a97bae-887c-2669-439e-08ec3e75113e@linux.intel.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 5:10 PM, Andrzej Jakowski wrote:
> On 6/30/20 4:04 AM, Philippe Mathieu-Daudé wrote:
>> The Persistent Memory Region Controller Memory Space Control
>> register is 64-bit wide. See 'Figure 68: Register Definition'
>> of the 'NVM Express Base Specification Revision 1.4'.
>>
>> Fixes: 6cf9413229 ("introduce PMR support from NVMe 1.4 spec")
>> Reported-by: Klaus Jensen <k.jensen@samsung.com>
>> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> Cc: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
>> ---
>>  include/block/nvme.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/block/nvme.h b/include/block/nvme.h
>> index 71c5681912..82c384614a 100644
>> --- a/include/block/nvme.h
>> +++ b/include/block/nvme.h
>> @@ -21,7 +21,7 @@ typedef struct QEMU_PACKED NvmeBar {
>>      uint32_t    pmrsts;
>>      uint32_t    pmrebs;
>>      uint32_t    pmrswtp;
>> -    uint32_t    pmrmsc;
>> +    uint64_t    pmrmsc;
>>  } NvmeBar;
>>  
>>  enum NvmeCapShift {
>> -- 2.21.3
> 
> This is good catch, though I wanted to highlight that this will still 
> need to change as this register is not aligned properly and thus not in
> compliance with spec.

I was wondering the odd alignment too. So you are saying at some time
in the future the spec will be updated to correct the alignment?

Should we use this instead?

      uint32_t    pmrmsc;
 +    uint32_t    pmrmsc_upper32; /* the spec define this, but *
 +                                 * only low 32-bit are used  */

Or eventually an unnamed struct:

 -    uint32_t    pmrmsc;
 +    struct {
 +        uint32_t pmrmsc;
 +        uint32_t pmrmsc_upper32; /* the spec define this, but *
 +                                  * only low 32-bit are used  */
 +    };

> 
> Reviewed-by Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> 


