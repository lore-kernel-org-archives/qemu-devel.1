Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A41C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDBE20747
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAlYYDXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDBE20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJWH-0005tw-O4
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjJVd-0005P3-Qo
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:28:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30398
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjJVd-0003vW-2h
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591867707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pmKdMgJoEPlH8GSgESXrciXfmQ58ObeyvoZzImwC35c=;
 b=iAlYYDXVa8B75XLPl3pw1X2C66Eu0OBomyVB99EcYPLLsKrz+56AY7dXIboP9unZiBuQq/
 GYylwHdKgWg/k+Dt7mRPjTmGkq0E0K0SYGj5TdZPmWLC08iovFqNnh1dyy45jAjheI3FwO
 +dRVquBD2CDMeF9ZNU77gmTkgcvRTbM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-xZkVdRnmNJ6Ka9w-6-0DlQ-1; Thu, 11 Jun 2020 05:28:26 -0400
X-MC-Unique: xZkVdRnmNJ6Ka9w-6-0DlQ-1
Received: by mail-wr1-f71.google.com with SMTP id i6so2318478wrr.23
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 02:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=pmKdMgJoEPlH8GSgESXrciXfmQ58ObeyvoZzImwC35c=;
 b=f6H1gk05tNvU2a9dFedUrQblWoSBncv/NZEJQ3mKIgpuaHCEpUryJR/WcEaq3QOt/M
 7ETxc4dtBQ4D2Od6hrr8VTrLIYMDkfSCXmBb7I+5pr/P/24IQ2QMCDTajKtAWRil7wHZ
 /ATqMxUGhBzbWKxlXL+TOednAchJGx0Uy70zjfu6DZ/MF8hpRY2iClaIuhLoPNYGHznO
 cCH5HbMT9VAphTYx3k3/1q3FyqudQzUMtsaXp5ias/rT18t5BznYUaZ96WPVG387T31C
 bYYAA8P9YJR0+CnnU8jEUVkfu5VmU0XeriFo3U+ynNUh0PZ9HEYpBbffMOEQWOoP5pGp
 LUrA==
X-Gm-Message-State: AOAM532UkyUF9gnGiVJIwd4Bl+ny5F3Lk71rcwnBJQGLppa0AWVGyym4
 fkJmKtaDdI+yCLFOt0GMYZhMSPNFrpzv1a4v3j17L35lXVzu158b34RwV7e/TgXRdQ+tkq+p+DY
 JDgf91WsuuOY4guI=
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr7021490wme.62.1591867705054; 
 Thu, 11 Jun 2020 02:28:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgjowVYj9O5j1XgfINbVgz72iSHo3A01Jy2b+s+FiQ04UxcCz9KJrmQDW1aqFiZLdjcP36Eg==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr7021470wme.62.1591867704862; 
 Thu, 11 Jun 2020 02:28:24 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 14sm1422935wmi.20.2020.06.11.02.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 02:28:24 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] acpi: drop build_piix4_pm()
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200611072919.16638-1-kraxel@redhat.com>
 <20200611072919.16638-10-kraxel@redhat.com>
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
Message-ID: <901418a9-864c-ba85-1e8b-d2c42dc0072f@redhat.com>
Date: Thu, 11 Jun 2020 11:28:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200611072919.16638-10-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 9:29 AM, Gerd Hoffmann wrote:
> The _SB.PCI0.PX13.P13C opregion (holds isa device enable bits)
> is not used any more, remove it from DSDT.

Maybe:

"is not used any more (see previous commit), remove it from DSDT."

(if Michael can do the change when applying if you agree).

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedow <imammedo@redhat.com>
> ---
>  hw/i386/acpi-build.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 750fcf9baa37..02cf4199c2e9 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1320,21 +1320,6 @@ static void build_q35_isa_bridge(Aml *table)
>      aml_append(table, scope);
>  }
>  
> -static void build_piix4_pm(Aml *table)
> -{
> -    Aml *dev;
> -    Aml *scope;
> -
> -    scope =  aml_scope("_SB.PCI0");
> -    dev = aml_device("PX13");
> -    aml_append(dev, aml_name_decl("_ADR", aml_int(0x00010003)));
> -
> -    aml_append(dev, aml_operation_region("P13C", AML_PCI_CONFIG,
> -                                         aml_int(0x00), 0xff));
> -    aml_append(scope, dev);
> -    aml_append(table, scope);
> -}
> -
>  static void build_piix4_isa_bridge(Aml *table)
>  {
>      Aml *dev;
> @@ -1486,7 +1471,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dsdt, sb_scope);
>  
>          build_hpet_aml(dsdt);
> -        build_piix4_pm(dsdt);
>          build_piix4_isa_bridge(dsdt);
>          build_isa_devices_aml(dsdt);
>          build_piix4_pci_hotplug(dsdt);
> 


