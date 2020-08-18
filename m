Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23542C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01EB204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUyo9/ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01EB204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7yzQ-0002F4-4m
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7yyk-0001oM-IF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:36:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7yyi-0002RW-NJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597746987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s6yMNawV+3dKfwsuwvyt2WGokkI3QoWckZEczwXjTic=;
 b=QUyo9/ij7qI5zk+i9nvrqREUIVVpqV8gnVKEMN20tdFjGqy+RJqcE9AOeeBakKFZatXJRE
 +LuDrbfHHS4FNGOuVBDC3MMJpg+YtNZVCIg9cx/RJcYM67gGxk+mYhBtLbQdFrobALGXbz
 1zYqmXYvmP/RJeNTPLhxdM7yTjQpR1o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-6kz9m7CkOIS-H6DawSnNXg-1; Tue, 18 Aug 2020 06:36:25 -0400
X-MC-Unique: 6kz9m7CkOIS-H6DawSnNXg-1
Received: by mail-wr1-f70.google.com with SMTP id z12so8092505wrl.16
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 03:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=s6yMNawV+3dKfwsuwvyt2WGokkI3QoWckZEczwXjTic=;
 b=nMGql0aRtLiUK7z4uzLmeS6AHVzPUwUFfMj6NbnRahAItbSTeZXFx/24GsewSqSX+w
 erGjkKGsHsMQFYgGl/Moy2DWv/e+GxG6SdLQ7Kkh8hcmPqBFLfi/EjY+MNCA/RV2r8fU
 lsJiO1ViAqg4YaPU6XnpUsWX99aBdvSzrtXYf9pgcdc1z2m5fxhNVUeTLVPdURA6czF0
 jpksA7B47nxl0CNvvYDeRiLia0sDCurEGiJWTb2nfMIIwJAXoaIoSZ8qRm3bE7+F1sSx
 md8anbx8FLdDJkzbHxg4SVb9zMS5p1mauX+9WflDMCTm4ArvR4WnwuYLDMw5rU5YfJu4
 Eckw==
X-Gm-Message-State: AOAM533e/HRA/FDQq4RmaIpyM5wug2xcTQ+omkMiGTqnpbdAml76uPv6
 S0VDhEr2TzhrpgmgQQZb5jatFFZaqXelW6+FEPRUHMQZfpFFqwF1XEoUfJpN1uOmFlbAVQAqp4Q
 tlw0vBV6IRh005u4=
X-Received: by 2002:a5d:6692:: with SMTP id l18mr19372277wru.211.1597746984713; 
 Tue, 18 Aug 2020 03:36:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWgChyufQUHIcsLGi8gk+iooUXdUHCd9qPuhj8MenWBG5wlkFLgkcwaekxDWv6dMF9l1JxeA==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr19372257wru.211.1597746984405; 
 Tue, 18 Aug 2020 03:36:24 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d7sm35772885wra.29.2020.08.18.03.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 03:36:23 -0700 (PDT)
Subject: Re: [PATCH 103/150] meson: convert hw/pci
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200817143723.343284-1-pbonzini@redhat.com>
 <20200817144053.345107-8-pbonzini@redhat.com>
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
Message-ID: <fd122225-edf7-e3a8-3b5d-d179a18dbcee@redhat.com>
Date: Tue, 18 Aug 2020 12:36:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817144053.345107-8-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
>  hw/Makefile.objs     |  1 -
>  hw/meson.build       |  1 +
>  hw/pci/Makefile.objs | 14 --------------
>  hw/pci/meson.build   | 19 +++++++++++++++++++
>  4 files changed, 20 insertions(+), 15 deletions(-)
>  delete mode 100644 hw/pci/Makefile.objs
>  create mode 100644 hw/pci/meson.build
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 3513040d4a..20832841d2 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -21,7 +21,6 @@ devices-dirs-y += misc/
>  devices-dirs-y += net/
>  devices-dirs-y += rdma/
>  devices-dirs-y += nvram/
> -devices-dirs-y += pci/
>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/meson.build b/hw/meson.build
> index a7301f21e8..53c347c395 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -1,6 +1,7 @@
>  subdir('core')
>  subdir('mem')
>  subdir('nubus')
> +subdir('pci')
>  subdir('pci-bridge')
>  subdir('pci-host')
>  subdir('pcmcia')
> diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
> deleted file mode 100644
> index c78f2fb24b..0000000000
> --- a/hw/pci/Makefile.objs
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -common-obj-$(CONFIG_PCI) += pci.o pci_bridge.o
> -common-obj-$(CONFIG_PCI) += msix.o msi.o
> -common-obj-$(CONFIG_PCI) += shpc.o
> -common-obj-$(CONFIG_PCI) += slotid_cap.o
> -common-obj-$(CONFIG_PCI) += pci_host.o
> -
> -# The functions in these modules can be used by devices too.  Since we
> -# allow plugging PCIe devices into PCI buses, include them even if
> -# CONFIG_PCI_EXPRESS=n.
> -common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o
> -common-obj-$(CONFIG_PCI_EXPRESS) += pcie_port.o pcie_host.o
> -
> -common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
> -common-obj-$(CONFIG_ALL) += pci-stub.o
> diff --git a/hw/pci/meson.build b/hw/pci/meson.build
> new file mode 100644
> index 0000000000..5c4bbac817
> --- /dev/null
> +++ b/hw/pci/meson.build
> @@ -0,0 +1,19 @@
> +pci_ss = ss.source_set()
> +pci_ss.add(files(
> +  'msi.c',
> +  'msix.c',
> +  'pci.c',
> +  'pci_bridge.c',
> +  'pci_host.c',
> +  'shpc.c',
> +  'slotid_cap.c'
> +))

I'd have written this simply as:

softmmu_ss.add(when: 'CONFIG_PCI', if_true: files(
  'msi.c',
  'msix.c',
  'pci.c',
  'pci_bridge.c',
  'pci_host.c',
  'shpc.c',
  'slotid_cap.c',
  # The functions in these modules can be used by devices too.  Since we
  # allow plugging PCIe devices into PCI buses, include them even if
  # CONFIG_PCI_EXPRESS=n.
  'pcie.c',
  'pcie_aer.c'
))
softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files(
  'pcie_port.c',
  'pcie_host.c'
))

And keep the pci-stub.c lines.

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +# The functions in these modules can be used by devices too.  Since we
> +# allow plugging PCIe devices into PCI buses, include them even if
> +# CONFIG_PCI_EXPRESS=n.
> +pci_ss.add(files('pcie.c', 'pcie_aer.c'))
> +softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
> +softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
> +
> +softmmu_ss.add(when: 'CONFIG_PCI', if_false: files('pci-stub.c'))
> +softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('pci-stub.c'))
> 


