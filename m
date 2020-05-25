Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8082C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDFE20812
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvbaaJUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDFE20812
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdCCM-0003km-QC
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 08:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdCBV-0003EM-QU
 for qemu-devel@nongnu.org; Mon, 25 May 2020 08:26:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdCBU-0003jP-Nb
 for qemu-devel@nongnu.org; Mon, 25 May 2020 08:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590409584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OTIl+ekkPLKdO4cj3VLhqIuhsiSWInFiQX5LoGhptUk=;
 b=UvbaaJUMq+i2+sStWAk87QRWLt+vhkX7wTwahgoWuKixkbwX14E4o/ibJcc9N7bZIhmSuO
 WVDH6BRR3ciUlgSdRgbGHOguPrFUlvlZH1w4hWIeja00MhSxPIOdej423JsTCQ04zN3wzN
 lKJ4Sn6CFJEZ/Ye9Lr1H47DlC88evTc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-X8x1nCOgNUe6PXVFxxloeQ-1; Mon, 25 May 2020 08:26:20 -0400
X-MC-Unique: X8x1nCOgNUe6PXVFxxloeQ-1
Received: by mail-wm1-f70.google.com with SMTP id l2so6653263wmi.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 05:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OTIl+ekkPLKdO4cj3VLhqIuhsiSWInFiQX5LoGhptUk=;
 b=piy+4ea2UGKTcgYHjU2aij/wf9osq/t/muZPc5nq0P3TyYw3Ar5uNX6t5BweNtJxvu
 N4oku77zoCQbp3e8oPy7FuaEk+R9NREBWtJ2QkdTcz/oq+iCoscNdWam14UeGMuauIp1
 6mws050TZLlXgZd2x4vhge7ikqflnIGOLhkIAjIx/YSgl2lYCO+m8pvWP2DfvGh7TS+5
 9gPily8ZBOci1OMawO8iuisslEw0dA3e4wXz3pzoeT1UvDVAsenRCn32VMJ5Tb0mwTmM
 bQ3CbN0ZlmDuMNTJ/j2UaLRhTGf5kdONFL8279kVoQZ0kpGxbl5iQEdo/aJIVwwEBddZ
 dZuw==
X-Gm-Message-State: AOAM532iAhHBiYQ4R2ABbxZS8SsM9mvOxKuD5cpJDlgFE5PyM1sNROma
 42B7BZNAbOyOBhlX1FCrqZjxcz44h9md/pcx+OHvjBjj1JsRRtJX+dPjTBh5ZqY5JfFitxUH/tZ
 9IYDT1IM6Ya4kLB8=
X-Received: by 2002:a1c:a905:: with SMTP id s5mr3129180wme.120.1590409579190; 
 Mon, 25 May 2020 05:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhu+roEei2N0gSlSD5O/Rwq8FO3FpTOCeK2oeRu2nptiljlOxivFi/lj6Cnjn3JLE4YxPFmg==
X-Received: by 2002:a1c:a905:: with SMTP id s5mr3129164wme.120.1590409579013; 
 Mon, 25 May 2020 05:26:19 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id y3sm17776580wrm.64.2020.05.25.05.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 05:26:18 -0700 (PDT)
Subject: Re: [PATCH v3 01/22] microvm: name qboot binary qboot.bin
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-2-kraxel@redhat.com>
 <2a9e8f07-a1eb-9c3b-5070-51d5a87d76d5@redhat.com>
 <20200525110254.ikq6anobblj4uo5a@sirius.home.kraxel.org>
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
Message-ID: <a2e1f20a-8d99-02c1-4442-3043a8ae6fd3@redhat.com>
Date: Mon, 25 May 2020 14:26:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200525110254.ikq6anobblj4uo5a@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 1:02 PM, Gerd Hoffmann wrote:
> On Wed, May 20, 2020 at 03:25:53PM +0200, Philippe Mathieu-DaudÃ© wrote:
>> Hi Gerd,
>>
>> On 5/20/20 3:19 PM, Gerd Hoffmann wrote:
>>> qboot isn't a bios and shouldnt be named that way.
>>
>> Still it resides in a directory named pc-bios =)
> 
> Yep, that should be named "firmware" but changing that is beyond the
> scope of this patch ;)
> 
>> It is used later in x86_bios_rom_init() as:
>>
>>     bios = g_malloc(sizeof(*bios));
>>     memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
>>     if (!isapc_ram_fw) {
>>         memory_region_set_readonly(bios, true);
>>     }
>>     ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
>>     if (ret != 0) {
>>     bios_error:
>>         fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
>>         exit(1);
>>     }
>>     g_free(filename);
>>
>> Many 'bios' occurrences.
>>
>> Should it be called 'qboot.rom' instead?
> 
> I don't care much, I only want bios*.bin for seabios which actually is a
> complete bios implementation ...

OK.

Preferably named 'qboot.rom':
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


