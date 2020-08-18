Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540D9C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F6820674
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1yTBTxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F6820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ysj-0007TJ-BW
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7yqr-00059w-UU
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7yqj-0001Bc-Dm
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597746492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9Z3dtVgg6xsc12hVW0Zai7S0/Ak5iMfDhJShWYuPS+c=;
 b=A1yTBTxTA6Q7DvFt5NfwleUlSIijA6/AfI61GHUdyUWlyGPaRw0iJXO9YYUtjOGKbYWJZ+
 riYnynLg1oFYg17uaF/i9UyUYLIZD/pTMTSs8sytUxRxs7/m7P8BhM3zrixZomm2rDYB/K
 THzOSVA+DJtnBOT2iowYPnbTCjLBzT8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-SoqPbr_HPhqicjVyOt0NMg-1; Tue, 18 Aug 2020 06:28:11 -0400
X-MC-Unique: SoqPbr_HPhqicjVyOt0NMg-1
Received: by mail-wr1-f71.google.com with SMTP id t3so8071676wrr.5
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 03:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=9Z3dtVgg6xsc12hVW0Zai7S0/Ak5iMfDhJShWYuPS+c=;
 b=QnZok7VmfJLUpyn+J7FtI/hZWnubSzHxD7jG8zTEhKExIVGoUO0o0O4t8FQhodUcpS
 WK4h++LMyAjHbthmMHE0ZICL/vHP1pF1RXjKCm5zxwp7pC+sHnx1L9zH+JwLeOK8+ilI
 TTPhe+HIVVCae788O2wxvmPwL2TjaZ/Add9pEBFXnhepTuoEGVz9qC/sHSnUpSEboReK
 06KmCHisDnkqaFnTb0PqGJoGYxmiQr67nIKGnqxXQLH+JKFrJ+g1mwf5YvJ2B5hUvuR1
 Uw+6IsuECZc774kGG7RgAnT0//rGHO/O3I9Ktr0j8JA8AsAU+bNT05vS1juIUfxmbZFb
 rlTg==
X-Gm-Message-State: AOAM53073pI2G+vg7uvek7Kl9LwCMqnt6CADa/dYt60UVPbGOJV8MFga
 BzPFDjR+UZ6LCDSSyee2/en8dvRnj796vSjWsRnpYmaiAp5QrIUoLBKjlKMRDr5VuR4dvbGgwU+
 cUHfUaGGYxm/bryo=
X-Received: by 2002:a1c:62d6:: with SMTP id
 w205mr19965461wmb.154.1597746490053; 
 Tue, 18 Aug 2020 03:28:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwgv3ESo2/IxOtkA66iJxlA8mYcVO2mlL4ZTLmVMwCv0J7jghTCFSZydqpZVl+YmTTYHHpxg==
X-Received: by 2002:a1c:62d6:: with SMTP id
 w205mr19965453wmb.154.1597746489888; 
 Tue, 18 Aug 2020 03:28:09 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id s16sm23599129wme.13.2020.08.18.03.28.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 03:28:09 -0700 (PDT)
Subject: Re: [PATCH 105/150] meson: convert hw/rdma
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200817143723.343284-1-pbonzini@redhat.com>
 <20200817144053.345107-10-pbonzini@redhat.com>
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
Message-ID: <f54ce4f6-e285-2814-c36b-8e82c32f18a8@redhat.com>
Date: Tue, 18 Aug 2020 12:28:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817144053.345107-10-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 4:40 PM, Paolo Bonzini wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/Makefile.objs      |  1 -
>  hw/meson.build        |  1 +
>  hw/rdma/Makefile.objs |  3 ---
>  hw/rdma/meson.build   | 10 ++++++++++
>  4 files changed, 11 insertions(+), 4 deletions(-)
>  delete mode 100644 hw/rdma/Makefile.objs
>  create mode 100644 hw/rdma/meson.build
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 78860ae9c7..748a718b0f 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -19,7 +19,6 @@ devices-dirs-$(CONFIG_IPMI) += ipmi/
>  devices-dirs-y += isa/
>  devices-dirs-y += misc/
>  devices-dirs-y += net/
> -devices-dirs-y += rdma/
>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/meson.build b/hw/meson.build
> index 0bdd6a2613..f704e51361 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -6,6 +6,7 @@ subdir('pci')
>  subdir('pci-bridge')
>  subdir('pci-host')
>  subdir('pcmcia')
> +subdir('rdma')
>  subdir('rtc')
>  subdir('scsi')
>  subdir('sd')
> diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
> deleted file mode 100644
> index 819bb12a35..0000000000
> --- a/hw/rdma/Makefile.objs
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -obj-$(CONFIG_VMW_PVRDMA) += rdma_utils.o rdma_backend.o rdma_rm.o rdma.o
> -obj-$(CONFIG_VMW_PVRDMA) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
> -                     vmw/pvrdma_qp_ops.o vmw/pvrdma_main.o
> diff --git a/hw/rdma/meson.build b/hw/rdma/meson.build
> new file mode 100644
> index 0000000000..7325f40c32
> --- /dev/null
> +++ b/hw/rdma/meson.build
> @@ -0,0 +1,10 @@
> +specific_ss.add(when: 'CONFIG_VMW_PVRDMA', if_true: files(
> +  'rdma.c',
> +  'rdma_backend.c',
> +  'rdma_rm.c',
> +  'rdma_utils.c',
> +  'vmw/pvrdma_cmd.c',
> +  'vmw/pvrdma_dev_ring.c',
> +  'vmw/pvrdma_main.c',
> +  'vmw/pvrdma_qp_ops.c',
> +))
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


