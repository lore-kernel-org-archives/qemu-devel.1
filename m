Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC5BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B8B20812
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSCc0erR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B8B20812
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZJk-0007y5-Am
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZJ9-0007Z3-B6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:08:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28536
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZJ8-0005CO-19
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591690109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tqCR4bFHEvPHENSuXN3XzWuTXXgnvpagc6k7SgfvWqQ=;
 b=HSCc0erRCt6i73EZowrEwOl/kKgVhaiWbVIf/PpPVhBtFnxG6MfTBBXqMEKqlcn82bQO4f
 ISWLFBQreZK85VinhAm65in9Ue+2e5jaYM0j0Vh+YQ/yosxg03WvGS20j8GJxtU71D2yZ6
 futZf9z4fnCeV2OQLlRLojNO+Jl8Zjg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-CCCAs01cNo-fdWlKbuOdIQ-1; Tue, 09 Jun 2020 04:08:27 -0400
X-MC-Unique: CCCAs01cNo-fdWlKbuOdIQ-1
Received: by mail-wm1-f72.google.com with SMTP id k185so393139wme.8
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 01:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tqCR4bFHEvPHENSuXN3XzWuTXXgnvpagc6k7SgfvWqQ=;
 b=fqYdDevYYNXMV2kUu9ySKxa2QwWzvxB/54HwII/n0jwMdcJG50r7EGjb2O3X88u1/2
 D7Y6pI2fuymViFflU1cgeRUU207eKyCwBMnQud2iEqXFeU1NrqGQhuNWSUQt9HkASCvx
 /aCtXQR0y7FDc8qkAizNRcexGH8O6Zext0G3RVlU8FB79OW0g6iWzBKlsSm5QsbAfimb
 OVtLnjdT1b1n+UZ/uPqb1jVe5b19gRfRSpZMX5iC1QutE0IzqVWw9C2z0GDtVBOXo9+w
 yQg9Xw79F7ACvNN8qginld6+qMz3/wqQ4J4+HcMybD1KFroCBos96E0spi5NTH2DibZ8
 qTEg==
X-Gm-Message-State: AOAM533NmI3F/2mlfTBVaqi7jfTQI8aLa8GjeELma87rbJvWL+woCPbM
 bJJwxcpm/95CknsaCIE+RcPRGRbemseNmiRKeqaB+YbYJcD+tspWfCyi9/EAgjAxgMAxJ5ktClo
 Oke32UVmtybmaF4E=
X-Received: by 2002:adf:b60b:: with SMTP id f11mr3002066wre.7.1591690105723;
 Tue, 09 Jun 2020 01:08:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7j+ya9eFP15rfROTGAb03YMbJQ8EQL8FwWTJLyeYGwYdn8tMxSoloprFfmJIZMhni/B9quQ==
X-Received: by 2002:adf:b60b:: with SMTP id f11mr3002044wre.7.1591690105491;
 Tue, 09 Jun 2020 01:08:25 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u13sm2372877wrp.53.2020.06.09.01.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 01:08:24 -0700 (PDT)
Subject: Re: [PATCH v2 11/58] qdev: Convert uses of qdev_set_parent_bus() with
 Coccinelle
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-12-armbru@redhat.com>
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
Message-ID: <5081f7c1-1d44-1e86-a1f4-afa3a8b66f33@redhat.com>
Date: Tue, 9 Jun 2020 10:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529134523.8477-12-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 3:44 PM, Markus Armbruster wrote:
> In addition to the qdev_create() patterns converted so far, we have a
> qdev_set_parent_bus() pattern.  Mostly when we embed a device in a
> parent device rather than allocating it on the heap.
> 
> This pattern also puts devices in the dangerous "no QOM parent, but
> plugged into bus" state I explained in recent commit "qdev: New
> qdev_new(), qdev_realize(), etc."
> 
> Apply same solution: convert to qdev_realize().  Coccinelle script:
> 
>     @@
>     expression dev, bus, errp;
>     symbol true;
>     @@
>     -    qdev_set_parent_bus(DEVICE(dev), bus);
>          ...
>     -    object_property_set_bool(OBJECT(dev), true, "realized", errp);
>     +    qdev_realize(DEVICE(dev), bus, errp);
> 
>     @ depends on !(file in "qdev-monitor.c") && !(file in "hw/core/qdev.c")@
>     expression dev, bus, errp;
>     symbol true;
>     @@
>     -    qdev_set_parent_bus(dev, bus);
>          ...
>     -    object_property_set_bool(OBJECT(dev), true, "realized", errp);
>     +    qdev_realize(dev, bus, errp);
> 
>     @@
>     expression dev, bus;
>     symbol true;
>     @@
>     -    qdev_set_parent_bus(DEVICE(dev), bus);
>          ...
>     -    qdev_init_nofail(DEVICE(dev));
>     +    qdev_realize(DEVICE(dev), bus, &error_fatal);

I insist the qdev_realize() name is confusing me - all these calls work
on SysBusDevice - but the API change is very good.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Unconverted uses of qdev_set_parent_bus() remain.  They'll be
> converted later in this series.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/display/virtio-gpu-pci.c     | 3 +--
>  hw/display/virtio-vga.c         | 3 +--
>  hw/i386/amd_iommu.c             | 3 +--
>  hw/isa/piix4.c                  | 3 +--
>  hw/misc/macio/macio.c           | 7 ++-----
>  hw/pci-host/designware.c        | 3 +--
>  hw/pci-host/gpex.c              | 3 +--
>  hw/pci-host/pnv_phb3.c          | 3 +--
>  hw/pci-host/pnv_phb4.c          | 3 +--
>  hw/pci-host/q35.c               | 3 +--
>  hw/pci-host/versatile.c         | 3 +--
>  hw/pci-host/xilinx-pcie.c       | 3 +--
>  hw/s390x/vhost-vsock-ccw.c      | 3 +--
>  hw/s390x/virtio-ccw-9p.c        | 3 +--
>  hw/s390x/virtio-ccw-balloon.c   | 3 +--
>  hw/s390x/virtio-ccw-blk.c       | 3 +--
>  hw/s390x/virtio-ccw-crypto.c    | 3 +--
>  hw/s390x/virtio-ccw-gpu.c       | 3 +--
>  hw/s390x/virtio-ccw-input.c     | 3 +--
>  hw/s390x/virtio-ccw-net.c       | 3 +--
>  hw/s390x/virtio-ccw-rng.c       | 3 +--
>  hw/s390x/virtio-ccw-scsi.c      | 6 ++----
>  hw/s390x/virtio-ccw-serial.c    | 3 +--
>  hw/virtio/vhost-scsi-pci.c      | 3 +--
>  hw/virtio/vhost-user-blk-pci.c  | 3 +--
>  hw/virtio/vhost-user-fs-pci.c   | 3 +--
>  hw/virtio/vhost-user-scsi-pci.c | 3 +--
>  hw/virtio/vhost-vsock-pci.c     | 3 +--
>  hw/virtio/virtio-9p-pci.c       | 3 +--
>  hw/virtio/virtio-balloon-pci.c  | 3 +--
>  hw/virtio/virtio-blk-pci.c      | 3 +--
>  hw/virtio/virtio-crypto-pci.c   | 3 +--
>  hw/virtio/virtio-input-pci.c    | 3 +--
>  hw/virtio/virtio-iommu-pci.c    | 3 +--
>  hw/virtio/virtio-net-pci.c      | 3 +--
>  hw/virtio/virtio-pmem-pci.c     | 3 +--
>  hw/virtio/virtio-rng-pci.c      | 3 +--
>  hw/virtio/virtio-scsi-pci.c     | 3 +--
>  hw/virtio/virtio-serial-pci.c   | 3 +--
>  hw/xen/xen-legacy-backend.c     | 3 +--
>  40 files changed, 42 insertions(+), 85 deletions(-)
[...]


