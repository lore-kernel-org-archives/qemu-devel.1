Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C985DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D9821556
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLk5BZ1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D9821556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSIa-0003Na-Bf
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGSHv-0002iN-SH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:31:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGSHt-0006eL-6z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599766275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qxF+WR3FhRo5m8f+iysNeZLNasouySliYOdhdrt4Xpo=;
 b=FLk5BZ1fGajBDPVy7tUTHpQqHjAK25cnckuPZuokuQzY22yvppLLn7IYWVP1OgIJrEUEmC
 xYUKm+6P2K5JgjAPN2DhnuUvjWBksccpPYquU/vQ/EdBrQdrTLcAcmCsYUFdVJquCn5et4
 om1eRK1p1WEtZDnecYwCbIsNPw0mxsA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-DNFYsNhpP0-iDKlNDeL9rA-1; Thu, 10 Sep 2020 15:31:11 -0400
X-MC-Unique: DNFYsNhpP0-iDKlNDeL9rA-1
Received: by mail-wr1-f72.google.com with SMTP id b7so2604492wrn.6
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 12:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qxF+WR3FhRo5m8f+iysNeZLNasouySliYOdhdrt4Xpo=;
 b=XRzyS99cirJIMPHFYQ97HHmkFC0bUpajUYaMXUn/KQ+1Jsy7hnAOFzQ/+ZeqolekbL
 eDkL5GUsD2qD/2V+cmIYBDO1O6ICMVzBlQkTNWSq6FD3GpreF+by6FgTgu2LhBiOyzfy
 p8Ax/iA7AKpj5zBn2oyrR/LOYRrFN8hSmLwAiURcfc3SpUXyRL4DwHc4I8f0BdEFPwQV
 eJSSb8owreg6XCELgGf0tKxfuYxfX+eLEb74JA1ktgIe7vF7I4hrOJXM3oAyLj1AyrN0
 cs16OvsXyFsTGwvrAizd2LAnhMZTjZG86k3LMoSNuvYjKjTigmTxMeT24J4YlK/Lm/W/
 LlHg==
X-Gm-Message-State: AOAM531BQO0Fi19YXew5UbxVcHHLboSfG/Vrpxe/EggL/3/+WcOkvP0b
 eCtH5G6fKgqvcjHtWcsxhRwjXlAQOlINDOskFfVtrHZwzHZrx57cUiWjR4F3WcXa0IfPpAfGpmW
 7/gu3TsYJ7pTnbWc=
X-Received: by 2002:a5d:444b:: with SMTP id x11mr10493294wrr.402.1599766270023; 
 Thu, 10 Sep 2020 12:31:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNHcN0vOHpcf4oHRfSJzOtcXPmb2K7GIwXYkSQMVMZByEfdFo4dMzQzOR3r/s1iprT+73XAA==
X-Received: by 2002:a5d:444b:: with SMTP id x11mr10493280wrr.402.1599766269832; 
 Thu, 10 Sep 2020 12:31:09 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b76sm5221034wme.45.2020.09.10.12.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 12:31:09 -0700 (PDT)
Subject: Re: [PATCH 00/10] edk2: adopt the edk2-stable202008 release
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20200908072939.30178-1-lersek@redhat.com>
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
Message-ID: <94ffbf3f-6168-052a-7a47-d19112ecacc8@redhat.com>
Date: Thu, 10 Sep 2020 21:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908072939.30178-1-lersek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 9:29 AM, Laszlo Ersek wrote:
> Ref:    https://bugs.launchpad.net/qemu/+bug/1852196
> Repo:   https://github.com/lersek/qemu.git
> Branch: edk2stable202008_lp_1852196
> 
> This series consumes the following upstream edk2 releases:
> 
>   https://github.com/tianocore/edk2/releases/tag/edk2-stable201908
>   https://github.com/tianocore/edk2/releases/tag/edk2-stable201911
>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202002
>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202005
>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202008
> 
> Worth mentioning (in random order):
> 
> - various CVE fixes (see shortlog)
> - OpenSSL-1.1.1g
> - UEFI HTTPS Boot for ARM/AARCH64
> - TPM2 for ARM/AARCH64
> - VCPU hotplug with SMI
> - support for Linux v5.7+ initrd and mixed mode loading
> - Fusion-MPT SCSI driver in OVMF
> - VMware PVSCSI driver in OVMF
> - PXEv4 / PXEv6 boot possible to disable on the QEMU command line
> - SEV-ES support
> 
> The IA32 and X64 binaries are now smaller -- the reason is that I buit
> them with DevToolSet 9 (gcc-9) on RHEL7, and so this is the first time
> they've undergone LTO (with the GCC5 edk2 toolchain settings).
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Thanks,
> Laszlo
> 
> Laszlo Ersek (10):
>   Makefile: remove obsolete edk2 exception from "clean" rule
>   roms/efirom, tests/uefi-test-tools: update edk2's own submodules first
>   roms/Makefile.edk2: prepare for replacing TPM2*_ENABLE macros
>   tests: acpi: tolerate "virt/SSDT.memhp" mismatch temporarily
>   roms/edk2: update submodule from edk2-stable201905 to
>     edk2-stable202008
>   roms/Makefile.edk2: complete replacing TPM2*_ENABLE macros
>   roms/Makefile.edk2: enable new ARM/AARCH64 flags up to
>     edk2-stable202008
>   pc-bios: refresh edk2 build artifacts for edk2-stable202008
>   pc-bios: update the README file with edk2-stable202008 information
>   tests: acpi: update "virt/SSDT.memhp" for edk2-stable202008
> 
>  Makefile                               |   1 -
>  pc-bios/README                         |   4 +--
>  pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1178070 -> 1507722 bytes
>  pc-bios/edk2-arm-code.fd.bz2           | Bin 1172752 -> 1503187 bytes
>  pc-bios/edk2-i386-code.fd.bz2          | Bin 1736199 -> 1646741 bytes
>  pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1943949 -> 1860546 bytes
>  pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1717094 -> 1680164 bytes
>  pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 1958037 -> 1912112 bytes
>  roms/Makefile                          |   1 +
>  roms/Makefile.edk2                     |  26 ++++++++++++--------
>  roms/edk2                              |   2 +-
>  tests/data/acpi/virt/SSDT.memhp        | Bin 736 -> 736 bytes
>  tests/uefi-test-tools/Makefile         |   1 +
>  13 files changed, 21 insertions(+), 14 deletions(-)

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

And applied to the edk2-next tree.

Thanks,

Phil.


