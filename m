Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3100CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7685020796
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrdFIF0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7685020796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF6uc-0004Mb-7v
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 22:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF6u1-0003qN-K2
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 22:29:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58058
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF6tz-0002Nk-Fz
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 22:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599445742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yHPDSVJqhc+xWSfd7m+QUwATvGcYRFD+sSlfraCgnbQ=;
 b=CrdFIF0cSC4B2ipw56E+SbaaPBc5I0xBKdcZwCch9uijhZThHQewZyT3C4FIfV8sgMrkE3
 a3d3CKngJP4ClgqiIEqEACy091FqL5tQbDlc+3MHYAxWZqRFSF5BsoUao/IgFcs8+EgYeJ
 TKbvypnu87ZWIoeLxq+qojZKjupVIKc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-mg_dp9eEMN6sGEDXVvpGaw-1; Sun, 06 Sep 2020 22:29:00 -0400
X-MC-Unique: mg_dp9eEMN6sGEDXVvpGaw-1
Received: by mail-wr1-f72.google.com with SMTP id r15so5133490wrt.8
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 19:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yHPDSVJqhc+xWSfd7m+QUwATvGcYRFD+sSlfraCgnbQ=;
 b=PS4WoATZZDgNZcWT4uvz9otVaQoGGk/+XXeEuAFn+b4R8CWjhiE19t3gR8UiEa0mcU
 0hJEea48Swidujsc4IIJ0qTzEnrOf2MAWkKZG9q9i3DtI8lTxK5Fzb2Usc5PM+1B0wjo
 pg7DZxho84mhCN9HCvG2N7T32tpFU6mrvCEZqQ7QZElQm4Vqoz1pwjg3FvM5DYSEFti9
 ICfZd6FicYluy8ua10q8BVqwSxzS+1oKjYqhlY5+Pmj3+6sWxF8KoZVx3PCeVMTrfQAK
 HFWUkU1kjLg8qv7c2SfjsGeI+lVMazQZf9/Hp+RYOo8YRkTJRoFgMsMPzAFtacHamvWS
 mJqA==
X-Gm-Message-State: AOAM532RcOS4KfTuC45Jt0Y7uJlEzhwd5aFUo0ssxMyUD49ud/6PmKF4
 g67l6uqCmwP1LEfavhYXKO3q2AA8n65zBLs4DREG8gTunLmVw7GkK4CpTYtwCJRD/plmPptAmRm
 vRhw/vsii/Rn+1ZQ=
X-Received: by 2002:adf:f6c2:: with SMTP id y2mr18762353wrp.79.1599445739864; 
 Sun, 06 Sep 2020 19:28:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu1Gr5qwVwYriYiZHmAc+yLEIxmgs1CN5hDpOLZLkbcBGeHVGVbXtYwMFZHDxIAGmQ3lBkIg==
X-Received: by 2002:adf:f6c2:: with SMTP id y2mr18762329wrp.79.1599445739582; 
 Sun, 06 Sep 2020 19:28:59 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id x16sm24457441wrq.62.2020.09.06.19.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Sep 2020 19:28:58 -0700 (PDT)
Subject: Re: [PATCH 17/17] hw/block/nvme: change controller pci id
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-18-its@irrelevant.dk>
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
Message-ID: <894711e0-7823-5cf0-5b5a-a84f15b458ce@redhat.com>
Date: Mon, 7 Sep 2020 04:28:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904141956.576630-18-its@irrelevant.dk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+David in case

On 9/4/20 4:19 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> There are two reasons for changing this:
> 
>   1. The nvme device currently uses an internal Intel device id.
> 
>   2. Since commits "nvme: fix write zeroes offset and count" and "nvme:
>      support multiple namespaces" the controller device no longer has
>      the quirks that the Linux kernel think it has.
> 
>      As the quirks are applied based on pci vendor and device id, change
>      them to get rid of the quirks.
> 
> To keep backward compatibility, add a new 'x-use-intel-id' parameter to
> the nvme device to force use of the Intel vendor and device id. This is
> off by default but add a compat property to set this for 5.1 machines
> and older.

So now what happens if you start a 5.1 machine with a recent kernel?
Simply the kernel will use unnecessary quirks, or are there more
changes in behavior?

> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c   | 12 ++++++++++--
>  hw/block/nvme.h   |  1 +
>  hw/core/machine.c |  1 +
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 453d3a89d475..8018f8679366 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2749,6 +2749,15 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>  
>      pci_conf[PCI_INTERRUPT_PIN] = 1;
>      pci_config_set_prog_interface(pci_conf, 0x2);
> +
> +    if (n->params.use_intel_id) {
> +        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
> +        pci_config_set_device_id(pci_conf, 0x5846);
> +    } else {
> +        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
> +        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
> +    }
> +
>      pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
>      pcie_endpoint_cap_init(pci_dev, 0x80);
>  
> @@ -2903,6 +2912,7 @@ static Property nvme_props[] = {
>      DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
>      DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
>      DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
> +    DEFINE_PROP_BOOL("x-use-intel-id", NvmeCtrl, params.use_intel_id, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -2919,8 +2929,6 @@ static void nvme_class_init(ObjectClass *oc, void *data)
>      pc->realize = nvme_realize;
>      pc->exit = nvme_exit;
>      pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
> -    pc->vendor_id = PCI_VENDOR_ID_INTEL;
> -    pc->device_id = 0x5845;
>      pc->revision = 2;
>  
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 72260f2e8ea9..a734a5e1370d 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -15,6 +15,7 @@ typedef struct NvmeParams {
>      uint8_t  aerl;
>      uint32_t aer_max_queued;
>      uint8_t  mdts;
> +    bool     use_intel_id;
>  } NvmeParams;
>  
>  typedef struct NvmeAsyncEvent {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ea26d612374d..67990232528c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,6 +34,7 @@ GlobalProperty hw_compat_5_1[] = {
>      { "vhost-user-scsi", "num_queues", "1"},
>      { "virtio-blk-device", "num-queues", "1"},
>      { "virtio-scsi-device", "num_queues", "1"},
> +    { "nvme", "x-use-intel-id", "on"},
>  };
>  const size_t hw_compat_5_1_len = G_N_ELEMENTS(hw_compat_5_1);
>  
> 


