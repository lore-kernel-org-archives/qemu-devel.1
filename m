Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FDECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B742084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3XPFRzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B742084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMq4Z-0001RA-2d
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iMq2L-0000CS-14
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iMq2I-0002da-1B
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:01:03 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iMq26-0002Js-O5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:00:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id v9so5831690wrq.5
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=AcCASEYH1hCVMf9hLghEauBrYxu+AYXXjLB+5xAbk9g=;
 b=l3XPFRzN7mSq7gY5Iw0AVsm6zTRCLM0/ApJCfZmlzGG5IKeR0CN+OwpJehBw/weZm7
 9DM5/BzDLdtFAHkrIQXdbiak/ovAB4DPXrc+igavBNCRoX0a49PlUjMStgidczA+dWco
 HFIk2Jf/DFDXPM08Cii1a7BNlcMdwjI/F98ne01PYUcV6dcd1JWhk+xnp2sU/FS4kfWO
 iBlaDExbJ00hy5Nv1LbAAJirfJXfLt/u/og75EvJX5sXs28qHP8nRQQOa9egAljAJ6Mj
 MIIiHqF2+o5tMYyNt2b3ujw6x0MoowKgZuSM66DIYuFWbxGzp0itcr1DdBt5Cp2V8wRz
 q4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=AcCASEYH1hCVMf9hLghEauBrYxu+AYXXjLB+5xAbk9g=;
 b=rde63w1YK/48DwcHCvSdeyRWvHMwJ9YcMx1+iIwMeThyeBP65EAMIfH4TN9Woignxr
 syHRgiAgd9i6Yfc3J/wu13ixAGCTIroIpwj9QSuju4t5UrKMWgHiUajwAu90wSpnblwW
 qMhPbMdV774WOemvVgRaUYA9tG0FaTf8Scxjt1d4hC92pL5N+wn0TUZD1Om+aT0xVdcs
 OvEp7eJ9xyA1Md3IQp4HVFF5uxf3QPC8hHaRB6nGjCcMhBXisLnQjptLFpIBNiht+FKl
 LqCiPTnRBP/zwZuvgayvX9z3PtWDk4Pn0cOH4hUTSaeYmQz7fzvZlQgBsh9uHEr85Ggb
 nygA==
X-Gm-Message-State: APjAAAUkItg7I/IAinvMzUYdkEQuPQN/wfNF3SaHQk2NczILwJR0qP1V
 kbQeFN6x47/WF6FtgzK2gR4=
X-Google-Smtp-Source: APXvYqzDBWzMcj3qvajXKJJQFwA59fI+V/ry/U2ff3NahnjgViH3kkXLRz4Nu2Hf2D00Fq1UU6J79w==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr2369212wrp.56.1571734843691; 
 Tue, 22 Oct 2019 02:00:43 -0700 (PDT)
Received: from ?IPv6:2a01:c23:604c:2a00:af2b:2e92:39f9:c05b?
 ([2a01:c23:604c:2a00:af2b:2e92:39f9:c05b])
 by smtp.gmail.com with ESMTPSA id a9sm24261324wmf.14.2019.10.22.02.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 02:00:43 -0700 (PDT)
Message-ID: <686191b4f6a91d85bf6a458e586533225905baea.camel@gmail.com>
Subject: Re: [PATCH v2 05/20] piix4: Rename PIIX4 object to piix4-isa
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, 
 qemu-devel@nongnu.org
Date: Tue, 22 Oct 2019 10:57:12 +0200
In-Reply-To: <20191018134754.16362-6-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-6-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El vie, 18-10-2019 a las 15:47 +0200, Philippe Mathieu-Daudé escribió:
> From: Hervé Poussineau <hpoussin@reactos.org>
> 
> Other piix4 parts are already named piix4-ide and piix4-usb-uhci.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> Message-Id: <20171216090228.28505-15-hpoussin@reactos.org>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> [PMD: rebased]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/isa/piix4.c       | 1 -
>  hw/mips/mips_malta.c | 2 +-
>  include/hw/isa/isa.h | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 9c37c85ae2..ac9383a658 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -45,7 +45,6 @@ typedef struct PIIX4State {
>      uint8_t rcr;
>  } PIIX4State;
>  
> -#define TYPE_PIIX4_PCI_DEVICE "PIIX4"
>  #define PIIX4_PCI_DEVICE(obj) \
>      OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)
>  
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 7d25ab6c23..e499b7a6bb 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1414,7 +1414,7 @@ void mips_malta_init(MachineState *machine)
>      ide_drive_get(hd, ARRAY_SIZE(hd));
>  
>      pci = pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
> -                                          true, "PIIX4");
> +                                          true,
> TYPE_PIIX4_PCI_DEVICE);
>      dev = DEVICE(pci);
>      isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>      piix4_devfn = pci->devfn;
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index 018ada4f6f..79f703fd6c 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -147,4 +147,6 @@ static inline ISABus
> *isa_bus_from_device(ISADevice *d)
>      return ISA_BUS(qdev_get_parent_bus(DEVICE(d)));
>  }
>  
> +#define TYPE_PIIX4_PCI_DEVICE "piix4-isa"
> +
>  #endif
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>


