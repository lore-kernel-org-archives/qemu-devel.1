Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DA8C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 11:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96ED238E2
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 11:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCL2M32h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96ED238E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM8IO-0006d6-Mz
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 07:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kM8HV-00064m-EF
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 07:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kM8HT-0005GW-In
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 07:22:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601119338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xrL19vi8WXvoi3wJR5wG9hBuStNz7G2lwELW4szrFs0=;
 b=iCL2M32hbSa4WczRXUe2eQ+GCpxKPPCGDT1fadnJ6HXF1Z3ikv50ydUXDJbGXh+lz55bOW
 wxqdaR2zDct6ncV8dERw9bKt9Wr9BQzeIblhkOVmipN2O5R31azfq5Iqys2hh5sJmvC+3W
 TrUQV7lqpbVq0fPJN/fgO/j2+SB7aJg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-t00kUE3EMFGpPJZy4Gj32Q-1; Sat, 26 Sep 2020 07:22:15 -0400
X-MC-Unique: t00kUE3EMFGpPJZy4Gj32Q-1
Received: by mail-wr1-f71.google.com with SMTP id o6so2278943wrp.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 04:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xrL19vi8WXvoi3wJR5wG9hBuStNz7G2lwELW4szrFs0=;
 b=uZVANXEO5OUey2oipTGPt4XF5ZvtOhrQb4ftU8kW8U9aLnzveDecCZf/OZJsvAW+xm
 /YONj0loMzE/NpheIrAPs+LI/A7NU0wc0N8hegEWc7j8GffH3G8DAXBJMumh+2EINpJq
 +yPS+kBGTDg9QbLQAYuIJsgeQXZRAuDuiLH+Nbpp4KtygZx+rAQj2shUTlE2SRD2iwXh
 xLyG2RschQWKEmWxOqJR5za1abTbLZVnw5timlaqQ1NjHJFMDh7mYPdOiceDakneiL5o
 hat7vtbkh7GBDVglJvl/yeF8jDTRme9yxA5jYX76AIMGjh7QBJm92YQ0UtJHNliWLHEB
 87dg==
X-Gm-Message-State: AOAM533FtLVoXdX9djbCNW46Qjl8bZpaFwaUWmZz91b0+X9a7jkaE71f
 rpuN0lM0LciqHw41ixFRMuwdP34bX4dL8kxJutXR/8Ijym5qd1OiS75G4tsgmlKmR9yBr+iFSTm
 urcs/hsLcUMpLtds=
X-Received: by 2002:a1c:770c:: with SMTP id t12mr2337136wmi.121.1601119333584; 
 Sat, 26 Sep 2020 04:22:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7vJWY441fbGosMcPAQr2K5o605LCMa9B1Kj/kYogePqHgSnMY5c/5bY9IXLxs42blKGpuMw==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr2337121wmi.121.1601119333354; 
 Sat, 26 Sep 2020 04:22:13 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id v128sm2365079wme.2.2020.09.26.04.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 04:22:12 -0700 (PDT)
Subject: Re: [PATCH 1/3] Include endian.h for Haiku to solve bswap* macros
 build
To: Carlo Arenas <carenas@gmail.com>, David CARLIER <devnexen@gmail.com>
References: <CA+XhMqxQ3o_h7_Fwho7gu9x9Pw5jCw=z-goVMyzJgQYqZR-cgA@mail.gmail.com>
 <CAP+75-XwpLiutpW6-J3DLKFGXOVd=tLF2fG2=0=nP9+KZ0UYug@mail.gmail.com>
 <CA+XhMqwWuMrnUsFx7re5K6Yo7UP5xdF5kNaPmVsabf-4LU9Rfw@mail.gmail.com>
 <CAPUEspiBbM1N_=2or8P7VuFtpHNWvcjD2orkUFNOFOW-ytHx8w@mail.gmail.com>
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
Message-ID: <f1cebe94-5017-562e-70a2-12b8ab9e7e8f@redhat.com>
Date: Sat, 26 Sep 2020 13:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspiBbM1N_=2or8P7VuFtpHNWvcjD2orkUFNOFOW-ytHx8w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 07:22:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.213, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/20 12:31 PM, Carlo Arenas wrote:
> FWIW the 32 bit image (haiku-r1beta2-x86_gcc2h-anyboot.zip[1]), uses
> gcc 2.95.3 as system CC
> a newer gcc (the same version that is used for the 64 bit port) is
> provided as an alternative though

This GCC is too old to build QEMU: since commit efc6c070aca
GCC 4.8 is required.

The image provided by David (Haiku shredder 1 hrev54154+115)
provides GCC 8.3.

> 
> Carlo
> 
> [1] https://www.haiku-os.org/get-haiku/r1beta2/
> 


