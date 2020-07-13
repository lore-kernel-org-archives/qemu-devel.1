Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1108C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01D820663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQNC2DnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01D820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2D1-0000YD-VX
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 13:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jv2Bj-0007Kg-4Q
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:24:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jv2Bh-0003GJ-81
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594661059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uAL4GMVQX3CrDxiL39eURC15mtUI6aqpnhJdXVNv2Bw=;
 b=HQNC2DnNdrdeNcl2NJLt/mibQ8Mf+CMRe0VBeBwnUUgRSEAZ2FLNitdz6aHkCXZobiVrb7
 nQxhvreb4ocEc/QiozFlfuoFo210KWv9L8KQHDwyHonQyz5y1ARAEGLGj9VqzxsIu2kibQ
 dww3fdATqxWuVc1DHQis6K7/xp8O1JU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-zNiCdOb7PVW7q2OU-rkUkw-1; Mon, 13 Jul 2020 13:24:16 -0400
X-MC-Unique: zNiCdOb7PVW7q2OU-rkUkw-1
Received: by mail-ej1-f71.google.com with SMTP id q11so19944702eja.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=uAL4GMVQX3CrDxiL39eURC15mtUI6aqpnhJdXVNv2Bw=;
 b=UdYh8E3r2VithAzJ2HwP1p+BuUSuI0MhTC7CzUnq4+JbREMraiGyQjjeG8V1r7zi3J
 vyF76t83iJjA17P2l+FdzTSZNEPR+54zid6H7za5Da455uhFKbiBgqFewYi/6uJUGdZE
 vcURvh7DV3v6oTfQtMc4oB+ROiTu70t/d9znZqOfs+UIaakB1tQ2va/31+UK/CemykNN
 8m7eoLYUh+MTJDrkaEDCK37AOYkuubGUB14yiR8j9sb3h6VGq6bhHyvGy9qCyNtMKRw1
 PCh41Sn8XmIKzGrtEQ/ubYKiqrrXzgio5IVJFKS+zBxn1e/XG1zqgiDhEwj3/eSN27C5
 iwdA==
X-Gm-Message-State: AOAM5334a9hg/rQrUqt/YmmyBOKZ/JZZNtZZLPn+7ssIH0SuLpYVmXKs
 G3RGRuhh6l6XVSMjZgJJam69G5eFW9YbmOsaTpOd+KXShjdBe9SaxNCirGpER6YwAosfRJUIJGj
 zbtEY1A2nvp6BKI8=
X-Received: by 2002:a17:906:404e:: with SMTP id
 y14mr754960ejj.260.1594661054897; 
 Mon, 13 Jul 2020 10:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqHM9o0Gg070XS/Q6MiM5vKM0SmIrQjvK85Y58vVa7/p4mq5ni3beFsVwIEvDtfWv2bLsBWg==
X-Received: by 2002:a17:906:404e:: with SMTP id
 y14mr754947ejj.260.1594661054693; 
 Mon, 13 Jul 2020 10:24:14 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id p4sm10393802eji.123.2020.07.13.10.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 10:24:14 -0700 (PDT)
Subject: Re: [PATCH v5 04/12] python/machine.py: Perform early cleanup for
 wait() calls, too
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-5-jsnow@redhat.com>
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
Message-ID: <5fe094c3-d0d3-67fe-adbb-71a225dce498@redhat.com>
Date: Mon, 13 Jul 2020 19:24:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-5-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 7:06 AM, John Snow wrote:
> This is primarily for consistency, and is a step towards wait() and
> shutdown() sharing the same implementation so that the two cleanup paths
> cannot diverge.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 4280aab380..cac466fbe6 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -369,6 +369,7 @@ def wait(self):
>          """
>          Wait for the VM to power off
>          """
> +        self._early_cleanup()
>          self._popen.wait()
>          self._post_shutdown()
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


