Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D92C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E65B20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I45KGw5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E65B20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGP45-0002JM-NQ
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGP34-0001IY-NA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:03:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38492
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGP32-0005H0-Sv
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599753823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WS6VZ+NhBy1u11QgqVNe2lgo08RiA/LnWkVoRs37DhM=;
 b=I45KGw5Qaw2hGRhcOa3hNbLp9UbN6H+tFGm1Ma791OyLCqxVQgHDD8b9OdexBjIGanzmDF
 /tqdbmOHt9xRq6Z3xJfQATELe/9h3nC2W1HjHZA8e9I5ZvCq/lAvTc7KiHNzNimMxDNfPW
 pXXnKUw8fJE8kDPVGs0j3P0+OKqJbAI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-nMcvoLEnNW2CqLu7s93xRA-1; Thu, 10 Sep 2020 12:03:39 -0400
X-MC-Unique: nMcvoLEnNW2CqLu7s93xRA-1
Received: by mail-wm1-f69.google.com with SMTP id m125so152321wmm.7
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 09:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WS6VZ+NhBy1u11QgqVNe2lgo08RiA/LnWkVoRs37DhM=;
 b=bHF7XCIH1C5hvuMWdDdUvxl94nW31wan/LYtZLx1eddeLQ+VRgMN2eolXbAMSt9uVn
 tpvNBhq2xhST38YqJ9kUMi0BGntrMvJw+53CanAejF+9kliev7QkrPu6agO3fGixCDxF
 6ku/kuOuetmaLv/Hq+lP6kQds2KOmwm2ewkEjY7XkZKyDCF7m0rK9eGi35wywfmSep9G
 9ZTc0Vmms4X41r1bZ8kaIxHIACO5AG7er1jlEX2tHOaASiKnQSFiT/u092xPlqB4BSiV
 6AJ19mC9x9JncPOny1CkgS+bfEkJ5eTHk7imZ6Pm59Clska0hr2UibrAiWUXgj6Y5pxv
 zY8w==
X-Gm-Message-State: AOAM531w/GKdZwycuArevm6iRrgPp33rp/RwEKaLg5fhCfSLkR8f57fU
 4RhLpqC0snnFuCQEtBDDYmiuvqWtA7gLIcuGEN3RbTCY5qUTyoaaZCsOxxaYIQ3JpPixZvh56n2
 qwua9T5t6Za350GA=
X-Received: by 2002:a1c:6254:: with SMTP id w81mr706961wmb.94.1599753817687;
 Thu, 10 Sep 2020 09:03:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxLQ9eUkXf49/qvvfquTNG44X8NOWIUkhYVvnCsvJO1oD4QzQCbcKIErhVoIftWTQh3q+F6w==
X-Received: by 2002:a1c:6254:: with SMTP id w81mr706939wmb.94.1599753817485;
 Thu, 10 Sep 2020 09:03:37 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k84sm4192824wmf.6.2020.09.10.09.03.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 09:03:36 -0700 (PDT)
Subject: Re: [PATCH 09/10] pc-bios: update the README file with
 edk2-stable202008 information
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-10-lersek@redhat.com>
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
Message-ID: <e967b4d5-bcc2-3846-0ad6-9e8f4d2f9115@redhat.com>
Date: Thu, 10 Sep 2020 18:03:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908072939.30178-10-lersek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 9:29 AM, Laszlo Ersek wrote:
> Refresh the "pc-bios/README" file with edk2 and OpenSSL release info,
> matching the edk2-stable202008 firmware images added in the previous
> patch.
> 
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Ref: https://bugs.launchpad.net/qemu/+bug/1852196
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  pc-bios/README | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/README b/pc-bios/README
> index fa8b58b7972a..2e49be607e02 100644
> --- a/pc-bios/README
> +++ b/pc-bios/README
> @@ -52,8 +52,8 @@
>    variable store templates built from the TianoCore community's EFI Development
>    Kit II project
>    <https://github.com/tianocore/tianocore.github.io/wiki/EDK-II>. The images
> -  were built at git tag "edk2-stable201905". The firmware binaries bundle parts
> -  of the OpenSSL project, at git tag "OpenSSL_1_1_1b" (the OpenSSL tag is a
> +  were built at git tag "edk2-stable202008". The firmware binaries bundle parts
> +  of the OpenSSL project, at git tag "OpenSSL_1_1_1g" (the OpenSSL tag is a
>    function of the edk2 tag). Parts of the Berkeley SoftFloat library are
>    bundled as well, at Release 3e plus a subsequent typo fix (commit
>    b64af41c3276f97f0e181920400ee056b9c88037), as an OpenSSL dependency on 32-bit
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


