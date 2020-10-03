Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7ABC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4244206B5
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VftILZCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4244206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOlR4-00041r-Pz
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOlPU-0003Y7-AK
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOlPR-00021E-To
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601746404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QaF2A0Shwqa8L80X0GF8qQGsfqdPpxTfFD26IrFKTFQ=;
 b=VftILZCw2ogKK/IyJwazwIoGxctpTkNK10Fo9shgRZSTLSwEykLQoEY89593hlYmznW9we
 5DYwgiYa6+PPKaSvy6ChibL07sbsc/f83omZAQQk6jpFj4A2/nApR2XPrBddEhdo7ZP8Js
 RfqTsJz2kxWvdMMDg1lisONIevAhaoE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-tfnI2g22NLy34I-zoZyS-g-1; Sat, 03 Oct 2020 13:33:22 -0400
X-MC-Unique: tfnI2g22NLy34I-zoZyS-g-1
Received: by mail-wr1-f71.google.com with SMTP id y3so1995684wrl.21
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 10:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QaF2A0Shwqa8L80X0GF8qQGsfqdPpxTfFD26IrFKTFQ=;
 b=IKktfFzgCyDibGrO+nkXnRiuP62+ML9Qc8aANiVLSPnwCgo0If7rHAu6U9MsRFOWIB
 FVXL7KZgn4l4relDHlU63vFu8HtPUnPzg+v+iboMGGJi+/6DUi7TwXqSwkQcgyMEeUjh
 e9TsijuNl6IwiUfAiomWMp+X2xWF+DF+xY0ZFjWahi8AnUhmJAxquvrxFBldpFOJ5xOU
 8WyK8GZDZsG+v3dtb3M/JjDP9ZKOHOTPA/tm+vDW87O5gtdr5grPqSspZ3Nvmgj/yaiO
 umzAz5+joi6nooDn5igFhjwc9fb5vPQu0vUA98T6R5TtYgAojrWBY0L4/iMdujMM5k8y
 hAeQ==
X-Gm-Message-State: AOAM531RxKt9u1DUpT+8B99dudfH32Eoi9qrVh0kWtcKhIw6EVHMdrJE
 I4gDlKj1IOKEiq/4smlX49eGxcifi4aPBanZolR/5x9oMn3oUNH5Bxg1TtX8ZfjrCk6fUd4oScM
 PCTZa48BpS6DRsTo=
X-Received: by 2002:adf:f082:: with SMTP id n2mr2977330wro.35.1601746401385;
 Sat, 03 Oct 2020 10:33:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9BIscvcOU9IJ+GLyABchFgn2W3VNL3aeU1rLHpAJEIT5kJePOA2BhMKd4SfKW3Vry3eSjdQ==
X-Received: by 2002:adf:f082:: with SMTP id n2mr2977313wro.35.1601746401083;
 Sat, 03 Oct 2020 10:33:21 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id v2sm6126736wrm.16.2020.10.03.10.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 10:33:20 -0700 (PDT)
Subject: Re: [PATCH v2] scripts/qmp/qom-set: Allow setting integer value
To: =?UTF-8?Q?Jonatan_P=c3=a5lsson?= <jonatan.p@gmail.com>
References: <20201002205200.276477-1-jonatan.p@gmail.com>
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
Message-ID: <2f65b14a-7073-300f-df86-4df55675e1ca@redhat.com>
Date: Sat, 3 Oct 2020 19:33:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002205200.276477-1-jonatan.p@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 13:33:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.252, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jonatan,

On 10/2/20 10:52 PM, Jonatan Pålsson wrote:
> If the value appears to be an integer, parse it as such.
> 
> This allows the following:
> 
>     qmp/qom-set -s ~/qmp.sock sensor.temperature 20000

Maybe instead:

Fix the following error:

  $ scripts/qmp/qom-set -s ~/qmp.sock sensor.temperature 20000
  Traceback (most recent call last):
    File "scripts/qmp/qom-set", line 66, in <module>
      print(srv.command('qom-set', path=path, property=prop, value=value))
    File "scripts/qmp/../../python/qemu/qmp.py", line 274, in command
      raise QMPResponseError(ret)
  qemu.qmp.QMPResponseError: Invalid parameter type for 'temperature',
expected: integer

> 
> .. where sensor is a tmp105 device, and temperature is an integer
> property.
> 
> Signed-off-by: Jonatan Pålsson <jonatan.p@gmail.com>
> ---
>  scripts/qmp/qom-set | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
> index 240a78187f..49eebe4924 100755
> --- a/scripts/qmp/qom-set
> +++ b/scripts/qmp/qom-set
> @@ -56,7 +56,10 @@ if len(args) > 1:
>          path, prop = args[0].rsplit('.', 1)
>      except:
>          usage_error("invalid format for path/property/value")
> -    value = args[1]
> +    try:
> +        value = int(args[1])

Maybe 'long' is safer?

> +    except ValueError:
> +        value = args[1]
>  else:
>      usage_error("not enough arguments")
>  
> 


