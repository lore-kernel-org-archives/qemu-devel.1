Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B35C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 07:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1471221842
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 07:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="nDC6qLec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1471221842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hppQT-0001r7-6G
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 03:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45678)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hppQG-0001M8-W8
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hppQF-0005rJ-Om
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:41:20 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hppQF-0005qH-9T
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:41:19 -0400
Received: by mail-pf1-x441.google.com with SMTP id 19so18697805pfa.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 00:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T1rf1c679FbjkI2XAUcpoRQ39+vfJadLck72KK3FkKY=;
 b=nDC6qLecjhlMYnELzZB86/uvWBSL6Izk1fKwRysnlm8UDPj1CHiduMmfbdcwuh4FBK
 GiiTU3P7GgF0moGCsSw2US1EFZ8xiwsdgWLeBNC3Z/g3VF7s9Ru+XXSuEvPNybjokqyN
 lT7KcNxu0wzl91RKiqC6YYlXDu+rC+x5KJNNOb5mUSnr4ZtWdxSjaJsaUL/KN0pa3uAk
 7dt5CucLB0VMGgHM5E8jdz4W5drg2hWEIpxWy2jiaPu6lilEvznAyrHWwN6CSG5SmgcN
 2in0X0PyQEgxZVJ1nqEfxwlfvrjvPoWzL0z/bGZjPNGJ6NMBpdOSa4MpECQceiwDxmry
 /0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T1rf1c679FbjkI2XAUcpoRQ39+vfJadLck72KK3FkKY=;
 b=E+Nx0iWYqXErJc27UXkEEvHqysEP8Os4sZiU6stC38k3dKpWi/Sh8IT/ToMGWmTLgl
 tCQFe9aGNJzARAvHpHJ/Q+hxkIqh1RTPOI2JMwCgxyPCRa/vPzICD+FMGgCWCP6rUnCt
 dEa+siUs/uSnhgbcoaTDlLQOIXlS3qQMGc/ZMkEDgLEs9Q92bbEvpv5boLyYftRTvEEp
 meXDeS/RziP4tTfpZIBAOwY3xtuZjQmpppMh7ytL8vzec8kR7BFrda5y3NTdItT3l72n
 +Qrn2+iN/lAxN7pc7VLMfQv5kOWCfNhNYT77z17NTH83NtQxRY1AZRePT8EoTEc/F9Fb
 ohVw==
X-Gm-Message-State: APjAAAWBit/MniP6GyaOSMT8413FMDe8VX41/anIhkrGyTGmTtJBYuqt
 wc3h2qNcT0Xsig1ZNa2sUpiSR4mb8GA=
X-Google-Smtp-Source: APXvYqy0qp/ygR0Kuyjo38ng1t1+6Yk99Xz/i7BAO/0zz46UcBD2dBxkqALFOUC5C11zBnMnQcxXng==
X-Received: by 2002:a63:df06:: with SMTP id u6mr22150128pgg.96.1563867677887; 
 Tue, 23 Jul 2019 00:41:17 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id p20sm19180464pgi.81.2019.07.23.00.41.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 00:41:16 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190720012850.14369-1-aik@ozlabs.ru>
 <20190720012850.14369-4-aik@ozlabs.ru>
 <20190723035330.GQ25073@umbus.fritz.box>
 <181b65ae-866f-7e0b-1042-7695e7c2ddda@ozlabs.ru>
 <20190723061443.GS25073@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <832fdbee-5494-8c82-bee1-21f9ba2de0cd@ozlabs.ru>
Date: Tue, 23 Jul 2019 17:41:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723061443.GS25073@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH qemu RFC 3/4] spapr: Advertise H_RTAS to
 the guest
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
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 23/07/2019 16:14, David Gibson wrote:
> On Tue, Jul 23, 2019 at 03:48:34PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 23/07/2019 13:53, David Gibson wrote:
>>> On Sat, Jul 20, 2019 at 11:28:49AM +1000, Alexey Kardashevskiy wrote:
>>>> Since day 1 QEMU implemented RTAS as a custom hypercall wrapped into
>>>> a small 20 bytes blob which guest would call to enter RTAS. Although
>>>> it works fine, it is still a separate binary image which requires signing
>>>> at no additional benefit.
>>>>
>>>> This adds a flag into /chosen to tell a modified guest that if the flag
>>>> is there, it can call H_RTAS directly and avoid calling into the RTAS
>>>> blob.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>    hw/ppc/spapr.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 81ad6a6f28de..b097a99951f1 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -1230,6 +1230,9 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>>>>            _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
>>>>        }
>>>> +    /* We always implemented RTAS as hcall, tell guests to call it directly */
>>>> +    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,h_rtas", 1));
>>>
>>> Rather than creating a new property for this we could use the
>>> qemu,hypertas-functions property which is already used to advertise
>>> some KVM specific hcalls.
>>
>> True, this is another way of doing it. We will also need a proper number for
>> it rather that custom 0xf000,
> 
> So, I take from this you're considering making this a supported method
> of operation, maybe even incorporating it into PAPR?


This was discussed as well since we are adding things in this area 
anyway (there is instantiate-rtas-64 coming), we could add this H_RTAS too.


>> Paul suggested we could tell the guest this
>> number via the "qemu,h_rtas" property.
> 
> Hm, we could, but introducing dynamic hypercall numbers for this seems
> an odd thing to do; both PAPR standardized and qemu specific
> hypercalls we currently operate on the guest just knowing the numbers.
>
> It seems to me that the obvious way to handle this is to have a tag in
> qemu,hypertas-functions which indicates the presence of the existing
> 0xf00 H_RTAS.  If/when we have a PAPR (or pseudo-PAPR) standardized
> number, that would get a tag in ibm,hypertas-functions to advertise
> it.

Makes sense to me, will update.


-- 
Alexey

