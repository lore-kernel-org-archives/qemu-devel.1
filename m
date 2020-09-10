Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ACAC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0E221556
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDaOnKfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0E221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSTH-00008X-Ez
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGSSa-0007gx-Ma
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:42:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGSSY-00088n-Cc
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599766937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FOncUyZipDQJ0af0nbs3Xj0sNv+vC0gKYQqup1Uyssk=;
 b=eDaOnKfL/+rKKeJZKF0R4kQbGbjyQ5C9rKRN/8G2w1QHtBBJw+9Ow2twHf2MnMC61/TcFb
 Yh5DlzTw0kZx8TH/JgTrAX46z7Wd4NiYNjlUo80xQ/mAAujThLMyZMx106mp265LB5lidp
 l8RCu42YoEU+565pqENm4QDflioFIXk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-Dr8_0laCON2zkdWzMq91jg-1; Thu, 10 Sep 2020 15:42:15 -0400
X-MC-Unique: Dr8_0laCON2zkdWzMq91jg-1
Received: by mail-wr1-f70.google.com with SMTP id l9so2590934wrq.20
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 12:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=FOncUyZipDQJ0af0nbs3Xj0sNv+vC0gKYQqup1Uyssk=;
 b=e4FB3+l2gCjVoEDskYqMXDjBbVM4S7OfE2ErBTy1eB7vc/+zewKM8u01fhm8HD8oC2
 SOix7fnYeB0V0QWSh0LL0hC1fZk5MWccMinqJDxYs6qBZNBh1njsuRMRANOvnOuA6+l6
 OMYDQZqySUP4H6Qyjw1zj5yPKqgbtyFGTluvPcUlpoOKjXNDl6JBxdqiJOTkIpo6SGRo
 5SBUDodeD8ExeWJaDZC+9dqSyhEdtROF6yQitn2LDpXGwCF2j/Fm4vwHgvqtCDagI9hU
 GQWmxA1RwBR05ZF2HMATMPd6OJvqVEObVq2D3NBBeMmpHT4+8AcUDPWzGTaiMbr+sg2t
 M1gw==
X-Gm-Message-State: AOAM531jJwb5bi6YjQg4rp76VxxbtaQi3ZvMXrSwAzIxuzkW+Fq2SfkD
 pJ2viTidb9c2ErzysjjFETwFuI4EQIGZVZW0ww1mSwyNJ8o2Iu1wOT1t6UfAjuda11bWRASZZ19
 BWlJHbWAiOXi8rDA=
X-Received: by 2002:a5d:6946:: with SMTP id r6mr10916018wrw.308.1599766934150; 
 Thu, 10 Sep 2020 12:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPvQpZiKbVZ+fPR3eNORNlQzyuU6YR78+o/YLxWoF1eF+jXcj7noMqovDiHZTTFZfQUolnJg==
X-Received: by 2002:a5d:6946:: with SMTP id r6mr10915994wrw.308.1599766933944; 
 Thu, 10 Sep 2020 12:42:13 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l4sm3498508wme.43.2020.09.10.12.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 12:42:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] Introduce (x86) CPU model deprecation API
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1591843676-102054-1-git-send-email-robert.hu@linux.intel.com>
 <20200909181506.GM1618070@habkost.net>
 <3f823308-149c-6759-35ae-4df7d0116cb6@redhat.com>
 <20200910191251.GN1618070@habkost.net>
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
Message-ID: <f82bc4a0-58c5-fb2f-6cc1-8776f4772215@redhat.com>
Date: Thu, 10 Sep 2020 21:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910191251.GN1618070@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, chenyi.qiang@intel.com,
 armbru@redhat.com, pbonzini@redhat.com, robert.hu@intel.com,
 Robert Hoo <robert.hu@linux.intel.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 9:12 PM, Eduardo Habkost wrote:
> On Thu, Sep 10, 2020 at 07:29:03AM +0200, Philippe Mathieu-Daudé wrote:
>> On 9/9/20 8:15 PM, Eduardo Habkost wrote:
>>> Hi,
>>>
>>> Thanks for the patch, and sorry for taking so long to review
>>> this.  I'm finally getting to the patches that were postponed to
>>> 5.2.
>>
>> Sorry I missed that patch too.
>>
>> Why restrict this to CPUClass, and not provide this feature to
>> all ObjectClass?
> 
> We could do it, but the field would be left unused for anything
> that's not a CPU model or machine type, as there are no other QMP
> interfaces for querying deprecation status yet.
> 
> A QMP interface for querying deprecation status of device types
> in general would be useful, though.

OK we can move that later, thanks.


