Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BC3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7FF20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOcitUAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7FF20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixgb-0007xA-Op
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 06:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jixfN-0006Pe-85
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 06:09:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jixfL-00070w-2p
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 06:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591783741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hE9Oaz24ilg7T4209xNV9IatGJG7l+0xJeWoG28nb1E=;
 b=XOcitUAhoVRuAcfzk/TubXA+/0MZBW+RztHyMuq4hTthpdVf0TkS+1nj25Ch5bOeZEXY8w
 F/mmyRuFnoAeoUkgB/iWh9W0Xp/dCp2HIGnK1i0w/tdYsPJ/A4LqXFQarlF6p7c6AwF1zb
 eiZ4sIxVstiO6HVC9kBO/D7t3JY2xS0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-09BQLPDTNySQHNA5EB-lLg-1; Wed, 10 Jun 2020 06:08:58 -0400
X-MC-Unique: 09BQLPDTNySQHNA5EB-lLg-1
Received: by mail-wr1-f72.google.com with SMTP id j16so852013wre.22
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 03:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hE9Oaz24ilg7T4209xNV9IatGJG7l+0xJeWoG28nb1E=;
 b=p2/LCTOrpB2tJEMlC2kiqw92sB3lGSnJOsMRGl5Wm4JYsRRbGNSFqAVFBJt1bNwa+h
 vxZe9rL55crofmDwUO7snnMrRptwpLeK6HEcyj+PX94DDVtabKhCl6X9bMPCqajSRtAq
 ZRsBXE60yWoY2ZPNgKHJAN+9xMfG40qmJuAKAhx4L3M+pM1FngUAZsDbi3i2WFPao+LN
 d1atL+RTIz8+CHhmI2gKkfP1+czD/Y02dF59H19CuafI+mDsFdc7Qi4hJOJan/37hhjh
 357M/la6icq/xILhty9z0otXSOGFYnY/wsO3BmPcGeWMBqLg+Xm4AYBzzhBNBMmYb0hz
 A8Xw==
X-Gm-Message-State: AOAM533CQQQpg+FohAc5NLTW7vjMdrhY/gRr8HqjOQFec/AlD9pNDAXw
 TIT1bRniMKtAoXDbaX0vutgE4tFHVxqWEbZVKz/OR/mjVv3px6aUdnJ/VN0KfYugVgeZrjyGEkV
 AbvvDGtey2fWbtB8=
X-Received: by 2002:adf:9544:: with SMTP id 62mr2745816wrs.32.1591783736854;
 Wed, 10 Jun 2020 03:08:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrsMtsRim5X/cGvZUX1UMfrqUDitqZ5vttqzCnfXftpeZa1hg/C4qf2zwuY8fO0E74o1f8Wg==
X-Received: by 2002:adf:9544:: with SMTP id 62mr2745779wrs.32.1591783736494;
 Wed, 10 Jun 2020 03:08:56 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z25sm6296656wmf.10.2020.06.10.03.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 03:08:55 -0700 (PDT)
Subject: Re: [PATCH] hw/vfio/pci-quirks: Fix broken legacy IGD passthrough
To: Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20200610035102.20192-1-thuth@redhat.com>
 <706060db-46c4-2dee-d746-eba24e6b137d@redhat.com>
 <a8195883-fb78-0cc1-5e15-e100dcb807de@redhat.com>
 <fd82556f-297d-6634-1bb2-37c4da415a50@redhat.com>
 <c3f40a57-e511-6b31-1a13-01acb38b0843@redhat.com>
 <4bdc918a-a59c-a877-680a-2925c09fc736@redhat.com>
 <04979308-3a35-4e40-35c7-836a36e47143@redhat.com>
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
Message-ID: <b771f418-64da-7922-923f-ae8cb62ce938@redhat.com>
Date: Wed, 10 Jun 2020 12:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <04979308-3a35-4e40-35c7-836a36e47143@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
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
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 11:03 AM, Thomas Huth wrote:
> On 10/06/2020 10.25, Philippe Mathieu-Daudé wrote:
>> On 6/10/20 9:59 AM, Thomas Huth wrote:
>>> On 10/06/2020 09.53, Philippe Mathieu-Daudé wrote:
>>>> On 6/10/20 9:50 AM, Thomas Huth wrote:
>>>>> On 10/06/2020 09.31, Philippe Mathieu-Daudé wrote:
>>>>>> On 6/10/20 5:51 AM, Thomas Huth wrote:
>>>>>>> The #ifdef CONFIG_VFIO_IGD in pci-quirks.c is not working since the
>>>>>>> required header config-devices.h is not included, so that the legacy
>>>>>>> IGD passthrough is currently broken. Let's include the right header
>>>>>>> to fix this issue.
>>>>>>>
>>>>>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1882784
>>>>>>> Fixes: 29d62771c81d8fd244a67c14a1d968c268d3fb19
>>>>>>>        ("hw/vfio: Move the IGD quirk code to a separate file")
>>>>>>
>>>>>> What about shorter tag?
>>>>>>
>>>>>> Fixes: 29d62771c81 ("vfio: Move the IGD quirk code to a separate file")
>>>>>
>>>>> I always forget whether to use the short or the long version for
>>>>> "Fixes:" ... this can hopefully be fixed (if necessary) when the patch
>>>>> gets picked up.
>>>>>
>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>>> ---
>>>>>>>  hw/vfio/pci-quirks.c | 1 +
>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>>>>>>> index f2155ddb1d..3158390db1 100644
>>>>>>> --- a/hw/vfio/pci-quirks.c
>>>>>>> +++ b/hw/vfio/pci-quirks.c
>>>>>>> @@ -11,6 +11,7 @@
>>>>>>>   */
>>>>>>>  
>>>>>>>  #include "qemu/osdep.h"
>>>>>>> +#include "config-devices.h"
>>>>>>
>>>>>> I've been wondering how we can avoid that mistake in the
>>>>>> future, but can find anything beside human review.
>>>>>
>>>>> I think in the long term, we should include config-devices.h in osdep.h,
>>>>> just like config-host.h and config-target.h is already included there.
>>>>> Everything else is just too confusing. But then we should also add a
>>>>> mechanism to poison the switches from config-devices.h in common code...
>>>>
>>>> We only need it for the files under hw/, right?
>>>
>>> qtest.c in the main directory includes it, too.
>>
>> hw/ and qtests could include "hw/hw.h" instead of affecting all the
>> codebase via "qemu/osdep.h".
> 
> I don't think that's a good idea - in that case, you have to make sure
> to include hw/hw.h everywhere again, so you don't gain that much
> compared to including config-devices.h directly everywhere. osdep.h is
> our header that has to be included everywhere, so if we want to make
> sure that these defines are available everywhere, we have to include it
> from osdep.h.
> Apart from that, hw/hw.h just contains one more prototype - which likely
> should be renamed to cpu_hw_error() and moved to a cpu header instead,
> so that we can finally delete hw/hw.h completely.

Yes, this discussion implied the "hw/hw.h" cleanup talked elsewhere is done.


