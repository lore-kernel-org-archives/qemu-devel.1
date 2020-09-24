Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CDAC4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485B5239D2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHyLXbLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485B5239D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOEX-0004gf-9m
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLO5S-0006iD-U3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLO5Q-0002Xt-PA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600941768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tMav8kP+IbjUC5+xTeTGuFWVjElQ4y721mTpetQxvf4=;
 b=LHyLXbLMcNamno1rFKAHh4KwmNE8TqRQ+bgcO7zUB9qnt/5fHZO1LyRnb/Q/+b1wG3lAqx
 XeIHP7EdxisKjadgzcJcPfq2JBoQFKWRbfFux6JOW59dl1FROgQ465AfJ2CAjYjilYTDxt
 5DUX+LQtmS8qwS6n1yvxXvuzIUoWweo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-Z-qC2IUaMaGtEFs_RuvvFw-1; Thu, 24 Sep 2020 06:02:41 -0400
X-MC-Unique: Z-qC2IUaMaGtEFs_RuvvFw-1
Received: by mail-wm1-f71.google.com with SMTP id l26so681021wmg.7
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 03:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tMav8kP+IbjUC5+xTeTGuFWVjElQ4y721mTpetQxvf4=;
 b=tbiNKxNImKlnHPZYcoVYwFipDuKvK8I0rFwryS2W9xz7cxsZYcXNVGZMCNqyNOHBVH
 gfmytCLIxJMh0Looi77/wThYHQcHKupGu4xHudWJMZWKhMqXK2rhF9ZLczZxkGANIKaT
 Y0m2yAK75hW5uQedMVLVsX/8tfEBNoE0KeHzav2HKwx9VqjzG5E83LR0KPX21RTYFTBt
 VSCWCre2AUZ8GwmSeOuI/+edJNMuxyTXUFcoZgwWPBLzr2WI0FqbbHFgXlLe8jA7AUq0
 MvIvZqDzke//f0OklvGDXjCB0cFWlEVHhUwECa8aBMtHyuuEkl/tqb2sSFEhGHh85TQ+
 Uj+g==
X-Gm-Message-State: AOAM533MnpxCRCM/7tC6g5Itgl7lA5Dw7AUhBGRGvE0+UG/6KqkQmv6C
 ECfLB2Ikl3LwnPwJbk0Y1TzPvJmB2bu3l/xZWueUiWwigIbEgdzf2C0nMBYgwu37l0ZbvAapTro
 m+fgs+reqdzJISoA=
X-Received: by 2002:a05:600c:22d1:: with SMTP id
 17mr3892715wmg.58.1600941759601; 
 Thu, 24 Sep 2020 03:02:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNBuM6XkO0+ByRp0JYclpl9dIDAHDUX0wqxT8oU8UTfm7I10LfPfo7Xg82B/l4Ax9E5CBpWw==
X-Received: by 2002:a05:600c:22d1:: with SMTP id
 17mr3892687wmg.58.1600941759333; 
 Thu, 24 Sep 2020 03:02:39 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id e13sm3384386wre.60.2020.09.24.03.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 03:02:38 -0700 (PDT)
Subject: Re: [PATCH 1/3] pc-bios/s390-ccw: fix off-by-one error
To: Marc Hartmayer <mhartmay@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200924085926.21709-1-mhartmay@linux.ibm.com>
 <20200924085926.21709-2-mhartmay@linux.ibm.com>
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
Message-ID: <1382e6fb-4af4-00ff-958a-c109cadfad43@redhat.com>
Date: Thu, 24 Sep 2020 12:02:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924085926.21709-2-mhartmay@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Collin L. Walling" <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc,

On 9/24/20 10:59 AM, Marc Hartmayer wrote:
> This error takes effect when the magic value "zIPL" is located at the
> end of a block. For example if s2_cur_blk = 0x7fe18000 and the magic
> value "zIPL" is located at 0x7fe18ffc - 0x7fe18fff.
> 
> Fixes: ba831b25262a ("s390-ccw: read stage2 boot loader data to find menu")
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 97205674e59a..0d29dceaa3cc 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -163,7 +163,7 @@ static bool find_zipl_boot_menu_banner(int *offset)
>      int i;
>  
>      /* Menu banner starts with "zIPL" */
> -    for (i = 0; i < virtio_get_block_size() - 4; i++) {
> +    for (i = 0; i < virtio_get_block_size() - 3; i++) {

Easier to review as:

       for (i = 0; i <= virtio_get_block_size() - 4; i++) {

Even easier defining ZIPL_MAGIC_SIZE instead of the magic '4'.

>          if (magic_match(s2_cur_blk + i, ZIPL_MAGIC_EBCDIC)) {
>              *offset = i;
>              return true;
> 


