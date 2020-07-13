Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BDCC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12464206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8eWxj1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12464206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juteK-0006W2-AP
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jutdl-00066j-TN
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:16:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45859
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jutdj-0005V2-Lh
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594628201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GtQfAvaqlkQiYd/H7T11sfPuPZ4uRq+2QQrEL7ZpQvQ=;
 b=d8eWxj1gey3P5mM/KqhazpP/hPeCrjZO6CMrD/b1/+OUi5ooxCLo8qSBCpdjMWw7Y1iSne
 kQREA3TX5ev1yInz/efGckd7eP+2BAp7/DMxU8R/JvUW+UxnDPMo/pwrrQehYRnshelska
 m/y4O8KJ1wTyCsAHv/5i2GM+xACs5Qw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-PUq_Kn2gOeGphUUXwbeeLg-1; Mon, 13 Jul 2020 04:16:40 -0400
X-MC-Unique: PUq_Kn2gOeGphUUXwbeeLg-1
Received: by mail-wr1-f71.google.com with SMTP id y13so16847315wrp.13
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 01:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GtQfAvaqlkQiYd/H7T11sfPuPZ4uRq+2QQrEL7ZpQvQ=;
 b=QhRWx+1ImaudAPPzyjk9hCCPvssxey2ZpQM9QeAmy8ST2+YjTo/fJBRe8GdHIpO6P0
 WlmxSJBWlWqVbdcupYmT+vYZ4qz6idJBvdPG3w95om6jsBMbVO1rC3hTpCP75guYAqrY
 j60ZjE6bctmuBfv8GiaQiRa1EPqWYauCCGgPaRbcgrCGj2mSk4hWfOTXnuMPpMDBDgD6
 3S6tIf12CwgTQ6AcqxVaqnUttC6WTh3rdSNBIbuzivwscy7666ZZgDpPgigyfsQD4slH
 MFl2e0XtbdTi8gGMskv6mkR8SddiW9XpcKcwGgV2R4ITY58w/G3R9ZBJHDvjIko6npdE
 faVw==
X-Gm-Message-State: AOAM531QoEOYA6JDy8vW1ysVXuX06KVqH/kYsWSl+St+vDCcpNZTuKxn
 ap8tWWp1HFjKitN787OLoJc8twHUzFKyQV2zH2/dj6ZhuLCU8HzlezJvnpNVkYqU5ShDpYKbnsC
 /S/t2u3ZrzA1M5L4=
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr17906651wmh.68.1594628198988; 
 Mon, 13 Jul 2020 01:16:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgjxKVQuCHtv0KgGLVBLVeUcET9oLctx7rbR0KZXHGgjhBNMGcOLjHLCNDqrl2VCMTj6mOFg==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr17906632wmh.68.1594628198728; 
 Mon, 13 Jul 2020 01:16:38 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id x185sm22093311wmg.41.2020.07.13.01.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 01:16:38 -0700 (PDT)
Subject: Re: cve patch wanted
To: =?UTF-8?B?5p6X5aWV5biG?= <19210240159@fudan.edu.cn>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
References: <42a0ee9.78e1.1733dd8c113.Coremail.19210240159@fudan.edu.cn>
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
Message-ID: <6160dba5-fd15-2467-fe53-14c391b2ce30@redhat.com>
Date: Mon, 13 Jul 2020 10:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <42a0ee9.78e1.1733dd8c113.Coremail.19210240159@fudan.edu.cn>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 7/11/20 2:28 PM, 林奕帆 wrote:
> Hello
>    I am a student from Fudan University in China. I am doing research on
> CVE patch recently. But i can not find the PATCH COMMIT of
> CVE-2019-12247 cve-2019-12155 cve-2019-6778.Can you give me the commit
> fix this cve?

* CVE-2019-12247

I don't know about this one, maybe related to CVE-2018-12617 fixed
by commit 1329651fb4 ("qga: Restrict guest-file-read count to 48 MB")
Cc'ing Michael for CVE-2019-12247.

* CVE-2019-12155

I don't have access to the information (still marked 'private'
one year after), but I *guess* it has been fixed by commit
d52680fc93 ("qxl: check release info object").
Cc'ing Gerd and Prasad.

* CVE-2019-6778

This one is in SLiRP, Cc'ing Samuel and Marc-André.


