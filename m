Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA91C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65875206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpNJjRqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65875206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyY6O-00083U-Kf
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyY5Y-0007bu-AX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:04:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyY5U-00009r-13
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595498665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SSGmm6xtM69zTzKFIxXaX6TpibO/eETXRcWfdxBdnHE=;
 b=OpNJjRqMIFWfiDgBbe4uKbqXaugpdg3CiLqnJfVmdm1sqzs1MIo5BkTgu9ay9dsoTU8ZG/
 81prf6ZN+pxqXWQD/8pDCyJ3vQNQ6NkmKxt5u/s2wIlz8qXNFlpD6lTulA+iyzEb8HlK3j
 weXPp4AcsEpIvJCh0nw2IdaoC1CJKi8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-3y6Tj1sPNlWM3aJ_nm8-lw-1; Thu, 23 Jul 2020 06:04:22 -0400
X-MC-Unique: 3y6Tj1sPNlWM3aJ_nm8-lw-1
Received: by mail-wm1-f72.google.com with SMTP id v4so216956wmh.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SSGmm6xtM69zTzKFIxXaX6TpibO/eETXRcWfdxBdnHE=;
 b=BLByWXE3PHI5y3eZtAgnOYM7kvrdT1Ej4MCcVeZZ14dYyOodzT1yu0RvEAAcz8KKn+
 OIGaLVt7Tt0Vql0osyXGV/woR4whVEiWtHQc5cK9AVWL3iPeghNyidmcHDK2w3yPmjdH
 w0QRCS4LTorCX45Zy8zsiuNDoeMl/f7SLyvkHLzyZKGO2bgvSnx8kxhDPLvp8QAbtMch
 gjaTJXs+cgznBnwl35LQiN+pqY98PLoHiqzKCmj9U7LJXPZ9KX3xWQ4LvU3eL/F0PdK3
 usg2tt3SAdMFsjLGEQEdRNslb/xUaJnWNjVZWy20wSN3hP8o6IqFwNs/2NZWkqsxKdPz
 USUw==
X-Gm-Message-State: AOAM5314Q3CMgBXt5AFK8LYlsepi+74LNuJ+FopR9iNLF+ZhjXYhH70J
 XaHIfUYriIW/0qBBy979wWT2kDO3o3EgiR3mPwb/oguF5bNvJ53+5I3RIhmI88ZNtZqShmTK95x
 +AvgJwcqKNMqR3Q4=
X-Received: by 2002:a1c:b6c3:: with SMTP id g186mr3614784wmf.135.1595498661688; 
 Thu, 23 Jul 2020 03:04:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMe7VEajTEKypNioFMyCqLKWZeAB7DzXPULRIOkQxDPNyZvJjvbRMy3KCKLO01XeHGeH/qXA==
X-Received: by 2002:a1c:b6c3:: with SMTP id g186mr3614754wmf.135.1595498661350; 
 Thu, 23 Jul 2020 03:04:21 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id l14sm3430817wrn.18.2020.07.23.03.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 03:04:20 -0700 (PDT)
Subject: Re: [PATCH-for-5.1?] qapi/error: Check format string argument in
 error_propagate_prepend()
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
References: <20200723091309.18690-1-philmd@redhat.com>
 <c8068bb8-cff1-a2a6-3eff-f709822917b7@weilnetz.de>
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
Message-ID: <0b9f2a2e-0d54-08eb-60fa-237d29c2529e@redhat.com>
Date: Thu, 23 Jul 2020 12:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c8068bb8-cff1-a2a6-3eff-f709822917b7@weilnetz.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 11:44 AM, Stefan Weil wrote:
> Am 23.07.20 um 11:13 schrieb Philippe Mathieu-Daudé:
> 
>> error_propagate_prepend() "behaves like error_prepend()", and
>> error_prepend() uses "formatting @fmt, ... like printf()".
>> error_prepend() checks its format string argument, but
>> error_propagate_prepend() does not. Fix that.
>>
>> This would have catched the invalid format introduced in commit
>> b98e8d1230f:
>>
>>     CC      hw/sd/milkymist-memcard.o
>>   hw/sd/milkymist-memcard.c: In function ‘milkymist_memcard_realize’:
>>   hw/sd/milkymist-memcard.c:284:70: error: format ‘%s’ expects a matching ‘char *’ argument [-Werror=format=]
>>     284 |         error_propagate_prepend(errp, err, "failed to init SD card: %s");
>>         |                                                                     ~^
>>         |                                                                      |
>>         |                                                                      char *
>>
>> Fixes: 4b5766488f ("Fix use of error_prepend() with &error_fatal, &error_abort")
>> Inspired-by: Stefan Weil <sw@weilnetz.de>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  include/qapi/error.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>> index 7932594dce..eeeef1a34d 100644
>> --- a/include/qapi/error.h
>> +++ b/include/qapi/error.h
>> @@ -381,6 +381,7 @@ void error_propagate(Error **dst_errp, Error *local_err);
>>   *     error_propagate(dst_errp, local_err);
>>   * Please use ERRP_GUARD() and error_prepend() instead when possible.
>>   */
>> +GCC_FMT_ATTR(3, 4)
>>  void error_propagate_prepend(Error **dst_errp, Error *local_err,
>>                               const char *fmt, ...);
>>  
> 
> 
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> 
> error_vprepend is one more candidate for GCC_FMT_ATTR. Maybe you can add
> that, too.

This one is different as it uses a va_list. Now I realize it is
only called in util/error.c, and all its callers are guarded with
GCC_FMT_ATTR. Maybe we can make it static to simplify... Markus?

> 
> Regards,
> 
> Stefan
> 
> 


