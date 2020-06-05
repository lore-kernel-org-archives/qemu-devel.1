Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80E82077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+8K5KGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80E82077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEGr-0003hC-35
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhEG7-0002ng-DC
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:27:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhEG6-000706-A0
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591370866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hgYAoCvrd8Af5a+Gl/W+FeJJxlyy3yzQEAcm7toZULQ=;
 b=P+8K5KGMRiwMQO6ySqWhXz+6ubfFAbu/f/izvXIh89in/VIFkIOn3QWC8qi9cHEo8kLUYf
 AxUSj0ShFWHxSuxyyqKV78H8Bi4c+K0y07pZtEGQA0+SKljPeeZAxwcOPew0C6kgss7UcE
 wfVWFreTLU6XvHTi8TujFv7g5BGPe2w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-0xNUopGJOZ6I5DijCC630g-1; Fri, 05 Jun 2020 11:27:44 -0400
X-MC-Unique: 0xNUopGJOZ6I5DijCC630g-1
Received: by mail-wm1-f69.google.com with SMTP id s15so3132979wmc.8
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hgYAoCvrd8Af5a+Gl/W+FeJJxlyy3yzQEAcm7toZULQ=;
 b=ZRjfyticYJ4isSZaWTWeJEX6cfKtwqWNIExLobcRPMdETFlk5ybsBsLC1m8QprpszW
 U2ZugLhGIrzYP3wpdD53DwJTI57QgFE5vrttyGWg1YRcpxIqBjkl07Idnr1DH06CuKbY
 BMTGY8a0m1IECmd7XOq/+xJEw9vvEeiD3eqyvMrtbcPeFVV1H9CzU7hAla50feuXOJv1
 g6MpD/ueOlrUyjeDNkf9XVhroYDG0Qh5BmIuPCy+LQPV9LJif2hTVaGDksegIbBisa6v
 S4ieMsxrCKEKodDt/FhH3Y3TZ/COICfn3/1rjfof2tVi6RYGBt3tShH7gnIYOI+PT28c
 4GcA==
X-Gm-Message-State: AOAM532VQfkQEyck5xCZXoNmGC/lbjpHSQ/1xnxtBCekVcWeHmSNY0Ss
 skOoIWkTjTUqIn3mWTvqiJVqy43M2KrgUCURIBDDft4YXXsJZLiPjxilwEIRzUZPVhLwX6KXyNe
 RXKzj/0n6zHnd7Yw=
X-Received: by 2002:a1c:6006:: with SMTP id u6mr2319675wmb.39.1591370863194;
 Fri, 05 Jun 2020 08:27:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOtdPsXNxOibAQxgZDAACK41TfXjZK8iurYepae2Ks1dIvwMesGq5COYpKpA43kCxP+id8tw==
X-Received: by 2002:a1c:6006:: with SMTP id u6mr2319654wmb.39.1591370862917;
 Fri, 05 Jun 2020 08:27:42 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y5sm13001357wrs.63.2020.06.05.08.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 08:27:42 -0700 (PDT)
Subject: Re: [PATCH 05/16] fdc: Open-code fdctrl_init_isa()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200605145625.2920920-1-armbru@redhat.com>
 <20200605145625.2920920-6-armbru@redhat.com>
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
Message-ID: <c72b6334-d95d-cfd1-e3a8-a2fc7e601bfe@redhat.com>
Date: Fri, 5 Jun 2020 17:27:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605145625.2920920-6-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 4:56 PM, Markus Armbruster wrote:
> Helper function fdctrl_init_isa() is less than helpful: one of three
> places creating "isa-fdc" devices use it.  Open-code it there, and
> drop the function.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/block/fdc.h |  1 -
>  hw/block/fdc.c         | 14 --------------
>  hw/i386/pc.c           |  8 ++++++--
>  3 files changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
> index 8855d3476c..d232d3fa1e 100644
> --- a/include/hw/block/fdc.h
> +++ b/include/hw/block/fdc.h
> @@ -10,7 +10,6 @@
>  #define TYPE_ISA_FDC "isa-fdc"
>  
>  void isa_fdc_init_drives(ISADevice *fdc, DriveInfo **fds);
> -ISADevice *fdctrl_init_isa(ISABus *bus, DriveInfo **fds);
>  void fdctrl_init_sysbus(qemu_irq irq, int dma_chann,
>                          hwaddr mmio_base, DriveInfo **fds);
>  void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 8c2d0edd48..35e734b6fb 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -2562,20 +2562,6 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
>      }
>  }
>  
> -ISADevice *fdctrl_init_isa(ISABus *bus, DriveInfo **fds)
> -{
> -    ISADevice *isadev;
> -
> -    isadev = isa_try_new(TYPE_ISA_FDC);
> -    if (!isadev) {
> -        return NULL;
> -    }
> -    isa_realize_and_unref(isadev, bus, &error_fatal);
> -
> -    isa_fdc_init_drives(isadev, fds);
> -    return isadev;
> -}
> -
>  void fdctrl_init_sysbus(qemu_irq irq, int dma_chann,
>                          hwaddr mmio_base, DriveInfo **fds)
>  {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 0cffb67c2f..25c9577c15 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1141,7 +1141,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
>      int i;
>      DriveInfo *fd[MAX_FD];
>      qemu_irq *a20_line;
> -    ISADevice *i8042, *port92, *vmmouse;
> +    ISADevice *fdc, *i8042, *port92, *vmmouse;
>  
>      serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
>      parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
> @@ -1151,7 +1151,11 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
>          create_fdctrl |= !!fd[i];
>      }
>      if (create_fdctrl) {
> -        fdctrl_init_isa(isa_bus, fd);
> +        fdc = isa_new(TYPE_ISA_FDC);
> +        if (fdc) {
> +            isa_realize_and_unref(fdc, isa_bus, &error_fatal);
> +            isa_fdc_init_drives(fdc, fd);
> +        }
>      }
>  
>      i8042 = isa_create_simple(isa_bus, "i8042");
> 


