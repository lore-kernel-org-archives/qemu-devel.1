Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA68C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB3A221F0
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VshD3PUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB3A221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHl0e-0006fN-NM
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHl07-0006GT-JU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHl05-0003Pm-V8
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600076537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4QJis2xZBwwCIfKNDni/j8VByZ7n+4PTPS79hgLuu1g=;
 b=VshD3PULjoZ3uDFNr2ov14ko3xHntWc5E6knDkdUfZTE8rQKNepSOJRUZlzapQmZ+TIByY
 KOiPbY3DnCrx8CrP20qvOgkUy/k7jGcy1OlYIXuujUsXltoyvTZJo+Ty/QjYQU6V01IwYg
 2o8iMNrCN/AQPd/mGl/Oncapol45trY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-ZRgEpv6nOo-D7PLLuEkV8g-1; Mon, 14 Sep 2020 05:42:15 -0400
X-MC-Unique: ZRgEpv6nOo-D7PLLuEkV8g-1
Received: by mail-wm1-f72.google.com with SMTP id q205so1379391wme.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 02:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4QJis2xZBwwCIfKNDni/j8VByZ7n+4PTPS79hgLuu1g=;
 b=fdKiaYvXaXI0pRdayfFvm0jiNZz45nUOAVRr80CiXDY8UugEcMSp/4cAYKzZoVkeYO
 fGAILm50Y3aJfp8G4fzsVDxjWmv/JVE1e0Xb7O2RBXbCdWf+n2AfLdRYN/uESbNfVnud
 GystXchoT7krHHPSspxT7B4qSEZMpucCmDPRxIZ3R+CUu1Fq+TXzNLspUMM+rY5JchFl
 AenlvyE8EVNMdLrFnvB2KhQd++i++5sYw4lr4K7svybeW0pcpodWIIYo7n8dsx5sy4Zt
 ZNOERini9N6/bU8FHZ3iJG3SxohJ5pg0rRbBRSxwlkXvjaBBQxUXeX0D4YzHyz8hxJqJ
 VIEQ==
X-Gm-Message-State: AOAM533Is8p1KFYZz5KL/1d1vDMSarrEkmokYxWKhKW0L219SuSEtnBo
 E4r1u/Fm3ldMbydlSsDEVcCYCqeRsSclFebVvNgnAjJRZjOPoZ2bFh+By3Gp0gwi2NsbxeKRANh
 FnoAqR5nuM8mLeTc=
X-Received: by 2002:a1c:2781:: with SMTP id n123mr14153679wmn.27.1600076534382; 
 Mon, 14 Sep 2020 02:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzR6kdtokqRaKu3xDP6FcGDc8rZ9LWyo3C+5fMnTh0qY1PONv28e5U6svmgsCDFl1PiuEcDQ==
X-Received: by 2002:a1c:2781:: with SMTP id n123mr14153662wmn.27.1600076534133; 
 Mon, 14 Sep 2020 02:42:14 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a127sm18906321wmh.34.2020.09.14.02.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 02:42:13 -0700 (PDT)
Subject: Re: [PATCH v5 3/8] qapi: Restrict balloon-related commands to machine
 code
To: Markus Armbruster <armbru@redhat.com>
References: <20200913195348.1064154-1-philmd@redhat.com>
 <20200913195348.1064154-4-philmd@redhat.com>
 <87wo0wsopv.fsf@dusky.pond.sub.org>
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
Message-ID: <b9401e89-2598-74f7-5e92-885c522b7599@redhat.com>
Date: Mon, 14 Sep 2020 11:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87wo0wsopv.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Laurent and David

On 9/14/20 11:16 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Only qemu-system-FOO and qemu-storage-daemon provide QMP
>> monitors, therefore such declarations and definitions are
>> irrelevant for user-mode emulation.
>>
>> Restricting the balloon-related commands to machine.json
>> allows pulling less declarations/definitions to user-mode.
> 
> How this affects user mode is not obvious to (ignorant) me.  Can you
> provide a clue?

I guess this was discussed with David at some point.

Maybe the QMP commands are not exposed via HMP, making this
code unreachable?

Anyhow user-mode binaries don't use the memory ballooning feature,
this is specific to system-mode emulation.

Laurent/David, do you have some more trivial explanation?

Thanks,

Phil.


