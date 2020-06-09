Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79EAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CFC207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yqpn/+E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CFC207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jii7c-0005x4-U4
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihmE-0008Oo-CT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:11:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54441
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihmA-0000WV-I2
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5MDhOErzU58a1QQtIODZGhD2W0/74/lgomAigyvV9wM=;
 b=Yqpn/+E21Z7DYU2twVgP1TEsTd62tGrtydIrY9VXZGEMHemJ/kPbvV80dfdqFWum9UNf+c
 uiciOvY7JjmDrQrGbQi/ScHohO77WxYCmfk0/MwGlLoPIDOPTaqbPrOcEinBA0Zbu4L+ZI
 9iySfuatFvRLUNiFDaDslRpswDQJA2s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-zHn0helBP8a9LNmd4kECVA-1; Tue, 09 Jun 2020 13:10:58 -0400
X-MC-Unique: zHn0helBP8a9LNmd4kECVA-1
Received: by mail-wr1-f72.google.com with SMTP id a4so8845981wrp.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5MDhOErzU58a1QQtIODZGhD2W0/74/lgomAigyvV9wM=;
 b=ch8boFOou3yZYAmirIkPtCXMdFi7iPu8lAGtgi9VizKtuJ/ZjhXmGnswelAcPrEiSe
 Cwoe35syBH1CGAqjsv9QDWVXro6VsSK+W7nLUnp/Oa12OHY4IZTLRvN3ENhSW2m5/N4Y
 hsTIKDomSGrT8tsKz/63Zxa/tr17zpEUpKkbRdaZgrMMl0UySsUABTr5tcxBuw/r9X9+
 q8MiXyo62I9zics2mofL5Tet8bWO0/v2tkkmFZQjPjQKXSATus+aN3zj43HuoRFbUz9N
 nAjtqF7SEO5SK2R7Sq0r6kRW124ZzxGRuJj8boP2CcS9A56k58KZL2lYYLLnoHprxDw8
 /5mA==
X-Gm-Message-State: AOAM531CcyQFoKjM48T7mcdGktWbgHctkqjqLGRxePrzItku7h3k3xDs
 rRAYBX52ho3KCiyaPV/YDl90TkDl0iElP33EzOSAELzABCgtM48EsqcYKbKY4FvK0FXHNWs5Yqr
 wjO4nu5OHLIiJLCE=
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr5253462wme.41.1591722657345; 
 Tue, 09 Jun 2020 10:10:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+wsYjqFZssBfAKaN6BImg17iSP1agc/iv7CGGQbDS+lktRhuW5pSLj6qW67INCQ4W4Ga6KA==
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr5253441wme.41.1591722657060; 
 Tue, 09 Jun 2020 10:10:57 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k21sm4355639wrd.24.2020.06.09.10.10.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 10:10:56 -0700 (PDT)
Subject: Re: [PATCH v8 5/5] crypto/tls-cipher-suites: Produce fw_cfg
 consumable blob
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200609170727.9977-1-philmd@redhat.com>
 <20200609170727.9977-6-philmd@redhat.com>
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
Message-ID: <a4f7fc57-2b46-f43d-2449-a096b4fafaae@redhat.com>
Date: Tue, 9 Jun 2020 19:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200609170727.9977-6-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laszlo,

On 6/9/20 7:07 PM, Philippe Mathieu-Daudé wrote:
> Since our format is consumable by the fw_cfg device,
> we can implement the FW_CFG_DATA_GENERATOR interface.
> 
> Acked-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v8: Add example in qemu-options.hx

I forgot to explain why. Since the fw_cfg 'gen_id' is only added/enabled
in this patch, it seems natural to add the example here.
I kept your A-b for the logical part, but you might recheck my
description/English (or ask to add the description in the previous patch).

> ---
>  crypto/tls-cipher-suites.c | 19 +++++++++++++++++++
>  qemu-options.hx            | 19 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
> index f02a041f9a..d6ea0ed190 100644
> --- a/crypto/tls-cipher-suites.c
> +++ b/crypto/tls-cipher-suites.c
> @@ -14,6 +14,7 @@
>  #include "qemu/error-report.h"
>  #include "crypto/tlscreds.h"
>  #include "crypto/tls-cipher-suites.h"
> +#include "hw/nvram/fw_cfg.h"
>  #include "trace.h"
>  
>  static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
> @@ -99,11 +100,28 @@ static void qcrypto_tls_cipher_suites_finalize(Object *obj)
>      g_free(s->cipher_list);
>  }
>  
> +static const void *qcrypto_tls_cipher_suites_get_data(Object *obj)
> +{
> +    QCryptoTLSCipherSuites *s = QCRYPTO_TLS_CIPHER_SUITES(obj);
> +
> +    return s->cipher_list;
> +}
> +
> +static size_t qcrypto_tls_cipher_suites_get_length(Object *obj)
> +{
> +    QCryptoTLSCipherSuites *s = QCRYPTO_TLS_CIPHER_SUITES(obj);
> +
> +    return s->cipher_count * sizeof(IANA_TLS_CIPHER);
> +}
> +
>  static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc, void *data)
>  {
>      UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
> +    FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(oc);
>  
>      ucc->complete = qcrypto_tls_cipher_suites_complete;
> +    fwgc->get_data = qcrypto_tls_cipher_suites_get_data;
> +    fwgc->get_length = qcrypto_tls_cipher_suites_get_length;
>  }
>  
>  static const TypeInfo qcrypto_tls_cipher_suites_info = {
> @@ -115,6 +133,7 @@ static const TypeInfo qcrypto_tls_cipher_suites_info = {
>      .class_init = qcrypto_tls_cipher_suites_class_init,
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_USER_CREATABLE },
> +        { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
>          { }
>      }
>  };
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c74366d7cc..b12cc910e3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4585,6 +4585,25 @@ SRST
>          string as described at
>          https://gnutls.org/manual/html_node/Priority-Strings.html.
>  
> +        An example of use of this object is to enable the UEFI HTTPS Boot.
> +        The tls-cipher-suites object exposes the ordered list of permitted
> +        TLS cipher suites from the host side to the firmware, via
> +        fw_cfg. The list is represented as an array of IANA_TLS_CIPHER
> +        objects. The firmware uses the IANA_TLS_CIPHER array for configuring
> +        guest-side TLS.
> +
> +        In the following example, the priority at which the host-side policy
> +        is retrieved is given by the ``priority`` property of the new object
> +        type. ``priority=@SYSTEM`` may be used to refer to
> +        /etc/crypto-policies/back-ends/gnutls.config (given that QEMU uses
> +        GNUTLS).
> +
> +        .. parsed-literal::
> +
> +             # |qemu_system| \
> +                 -object tls-cipher-suites,id=mysuite0,priority=@SYSTEM \
> +                 -fw_cfg name=etc/edk2/https/ciphers,gen_id=mysuite0
> +
>      ``-object filter-buffer,id=id,netdev=netdevid,interval=t[,queue=all|rx|tx][,status=on|off][,position=head|tail|id=<id>][,insert=behind|before]``
>          Interval t can't be 0, this filter batches the packet delivery:
>          all packets arriving in a given interval on netdev netdevid are
> 


