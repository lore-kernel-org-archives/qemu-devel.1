Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278A2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E728D20679
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrOhwlJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E728D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrSZ-0005eH-7a
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkrRl-0005BB-QQ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:54:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkrRj-0007k4-Ft
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592236490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5coBa5fq5i9zsLr9Nt7evAPrdguMDuSSVzFoxqu8LNc=;
 b=PrOhwlJDlxiQp5Hn5YEF9zihT1EuGEq75kMlBskdInm54OIzYaspRLx28iMYPU9HN0hIFh
 PylD3D3ZzHb3X3/Iiupq69gjkYwI6rjESxhDgf51FOCJDeuKUc4lOYVlOLYPYy+ZA+Z8sq
 H6YEInu2XcFuzDil+ZZCr9LJ9zwcNIw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-DYjSFxKSNHCf6N_SPeLYmg-1; Mon, 15 Jun 2020 11:54:48 -0400
X-MC-Unique: DYjSFxKSNHCf6N_SPeLYmg-1
Received: by mail-ej1-f70.google.com with SMTP id s4so8003255eju.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5coBa5fq5i9zsLr9Nt7evAPrdguMDuSSVzFoxqu8LNc=;
 b=NP8t39PMvZYvkXqmqUp4Wt2NoMos+t9CVQV7Ka8XgZ6f0HKU/DD9cmdWWJjXab34UP
 HZ9GyfCyv23ZedUuYrUUy52GU2aka5D9Zd52/llWEMCObnZUUpiniz6HQZznowNE/tIs
 1UhD4IncBjjsTsV4L6eNTyHquMxiwBta7U6RzgJ1Y/3GkscBYEH8v8mX09enZ+Toy+lv
 1p4I7mvzKG0+5NXnzjMtMN+gozoq5UCOd2GhxEzjofU3yPX6oa9QGZGag3FrLxmv/EJE
 vLimI85wumypUCTBOl9rcnxBT0G6x04y88Lm4zmg+UOSsOREMSu3JXeFOIo1tHjASdEZ
 3dLA==
X-Gm-Message-State: AOAM532qWuw+OfuTotOSkrbNgf3DMO2O5nnCmRklTU3DEuD17pJl1IKF
 GSXwVt3e7wRiWq+XGnHf6cdXhlZ90dFOuvd5m27H2AJ+WQaDGRdhQooEbmFtwv/A7MrzcQ81xdT
 fsnfk90uETNgDdDM=
X-Received: by 2002:aa7:d717:: with SMTP id t23mr23406586edq.304.1592236487287; 
 Mon, 15 Jun 2020 08:54:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPKlOUgXQvAIsqLvxtrcqP0CXICpO5Y9SZJkKcIN0hriajRiE6ARWDqyJLkjcWdbVFW3INEw==
X-Received: by 2002:aa7:d717:: with SMTP id t23mr23406565edq.304.1592236487011; 
 Mon, 15 Jun 2020 08:54:47 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c4sm1853178ejb.17.2020.06.15.08.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 08:54:46 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] tpm: Extend TPMIfClass with get_irqnum() function
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
 <20200615142327.671546-3-stefanb@linux.vnet.ibm.com>
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
Message-ID: <755b35ea-fae7-e683-bb7b-6496f14bd66c@redhat.com>
Date: Mon, 15 Jun 2020 17:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200615142327.671546-3-stefanb@linux.vnet.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
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
Cc: Stefan Berger <stefanb@sbct-2.pok.ibm.com>, eric.auger@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mkedzier@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 4:23 PM, Stefan Berger wrote:
> From: Stefan Berger <stefanb@sbct-2.pok.ibm.com>
> 
> Implement get_irqnum() as part of the TPMIfClass to be get the assigned
> IRQ number.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  hw/tpm/tpm_tis_isa.c    |  9 +++++++++
>  hw/tpm/tpm_tis_sysbus.c |  9 +++++++++
>  include/sysemu/tpm.h    | 10 ++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 30ba37079d..63b62f4c21 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_isa_get_tpm_version(TPMIf *ti)
>      return tpm_tis_get_tpm_version(s);
>  }
>  
> +static uint8_t tpm_tis_isa_get_irqnum(TPMIf *ti)
> +{
> +    TPMStateISA *isadev = TPM_TIS_ISA(ti);
> +    TPMState *s = &isadev->state;
> +
> +    return s->irq_num;
> +}
> +
>  static void tpm_tis_isa_reset(DeviceState *dev)
>  {
>      TPMStateISA *isadev = TPM_TIS_ISA(dev);
> @@ -148,6 +156,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass, void *data)
>      dc->reset = tpm_tis_isa_reset;
>      tc->request_completed = tpm_tis_isa_request_completed;
>      tc->get_version = tpm_tis_isa_get_tpm_version;
> +    tc->get_irqnum = tpm_tis_isa_get_irqnum;
>  }
>  
>  static const TypeInfo tpm_tis_isa_info = {
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index eced1fc843..6cf45e5057 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_sysbus_get_tpm_version(TPMIf *ti)
>      return tpm_tis_get_tpm_version(s);
>  }
>  
> +static uint8_t tpm_tis_sysbus_get_irqnum(TPMIf *ti)
> +{
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(ti);
> +    TPMState *s = &sbdev->state;
> +
> +    return s->irq_num;
> +}
> +
>  static void tpm_tis_sysbus_reset(DeviceState *dev)
>  {
>      TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
> @@ -137,6 +145,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
>      dc->reset = tpm_tis_sysbus_reset;
>      tc->request_completed = tpm_tis_sysbus_request_completed;
>      tc->get_version = tpm_tis_sysbus_get_tpm_version;
> +    tc->get_irqnum = tpm_tis_sysbus_get_irqnum;
>  }
>  
>  static const TypeInfo tpm_tis_sysbus_info = {
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 03fb25941c..b94a8a2b16 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -41,6 +41,7 @@ typedef struct TPMIfClass {
>      enum TpmModel model;
>      void (*request_completed)(TPMIf *obj, int ret);
>      enum TPMVersion (*get_version)(TPMIf *obj);
> +    uint8_t (*get_irqnum)(TPMIf *obj);
>  } TPMIfClass;
>  
>  #define TYPE_TPM_TIS_ISA            "tpm-tis"
> @@ -74,4 +75,13 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
>      return TPM_IF_GET_CLASS(ti)->get_version(ti);
>  }
>  
> +static inline uint8_t tpm_get_irqnum(TPMIf *ti)
> +{
> +    if (!ti || !TPM_IF_GET_CLASS(ti)->get_irqnum) {
> +        return 0;

0 is valid...

Shouldn't we use an Error* argument?

Else return -1 when invalid?

> +    }
> +
> +    return TPM_IF_GET_CLASS(ti)->get_irqnum(ti);
> +}
> +
>  #endif /* QEMU_TPM_H */
> 


