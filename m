Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BF5C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C6621841
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIZWmIoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C6621841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5Dq-00031V-KM
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1jX4tB-0003vo-Up; Fri, 08 May 2020 11:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1jX4t7-0006tA-2U; Fri, 08 May 2020 11:26:13 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
 [209.85.166.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 04CDA24980;
 Fri,  8 May 2020 15:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588951565;
 bh=WVKRkpnKWRKXSnE4Jf19NwhyhkIz7kJD+SSWpQxKgpM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=eIZWmIoQdmzNqd0B0jctotc6+m7ZWfAJYxv5Tc7RioQj5ayqrVl9V09aeTM8++1/Y
 kIfdeqaLlbj6RsiWm5E9KnxInOacxC1SGK/E461k1101K9aiy9qKhMqGgjGB5AUmJ3
 jskQSnl2ESVDy9zrLsj8HQjmtroowV/KP+uWAwWU=
Received: by mail-il1-f179.google.com with SMTP id r2so1751250ilo.6;
 Fri, 08 May 2020 08:26:04 -0700 (PDT)
X-Gm-Message-State: AGi0PubXmvnpWxvgbmy2TgGAP9w2ugG0wdPccVbzu9J6insK+L0I+J51
 RwUdB/8pOsSU97odphH7AX3V0KTjGTKR17wGo58=
X-Google-Smtp-Source: APiQypL9T8I7bcpLMvDFzMUa+i1RYnU1Q+640wt2xUVKwqxhPpu9aHIdFhZ+5CQm/Q+VYo6C9FGbhT62h4clb3eQtHc=
X-Received: by 2002:a92:39dd:: with SMTP id h90mr3465169ilf.80.1588951564458; 
 Fri, 08 May 2020 08:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200505144419.29174-1-eric.auger@redhat.com>
 <20200505144419.29174-4-eric.auger@redhat.com>
 <976a1479-4443-da02-2ad8-1e1570742caa@gmail.com>
In-Reply-To: <976a1479-4443-da02-2ad8-1e1570742caa@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 8 May 2020 17:25:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHHn9mbowEzEf3O3L7eC=e5zY3w2CqzK2qop19kKRDa=A@mail.gmail.com>
Message-ID: <CAMj1kXHHn9mbowEzEf3O3L7eC=e5zY3w2CqzK2qop19kKRDa=A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm/acpi: Add the TPM2.0 device under the DSDT
To: Shannon Zhao <shannon.zhaosl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=198.145.29.99; envelope-from=ardb@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 11:26:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 gshan@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, imammedo@redhat.com, eric.auger.pro@gmail.com,
 Laszlo Ersek <lersek@redhat.com>, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 17:24, Shannon Zhao <shannon.zhaosl@gmail.com> wrote:
>
> Hi,
>
> On 2020/5/5 22:44, Eric Auger wrote:
> > +static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
> > +{
> > +    hwaddr pbus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
> > +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> > +    MemoryRegion *sbdev_mr;
> > +    SysBusDevice *sbdev;
> > +    hwaddr tpm_base;
> > +
> > +    sbdev = (SysBusDevice *)object_dynamic_cast(OBJECT(tpm_find()),
> > +                                                TYPE_SYS_BUS_DEVICE);
>
> Does it need to check the tpm version like you do in previous patch?
>
> tpm_get_version(tpm_find()) == TPM_VERSION_2_0
>

I don't think so. The device node could in theory be used to describe
a TPM 1.2/1.3 as well, even though we never actually do that.

