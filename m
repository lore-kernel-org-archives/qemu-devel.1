Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4591C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC7A2222C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcZI999l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC7A2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRWa-0003M9-Bf
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kXRRa-0006sF-No; Tue, 27 Oct 2020 12:03:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kXRRW-0006SK-UY; Tue, 27 Oct 2020 12:03:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id b8so2559687wrn.0;
 Tue, 27 Oct 2020 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=sW8LqdsqvdTg1P+qAX5fXAdoffXOLpsCYzIzY0O/pGA=;
 b=gcZI999ljyPBSJJ2b3/mRDOgaSoj35K7lwmMxAHVIHVfxPuv+oxXtzDk/oPTag6DS+
 zUaA/VeT5uszZ2xR8Ys3KHYvNzZ+P7XwUdCiYiMLTuPLoo25t9HjpuZTeeOolgV8mW+C
 fjdr9Q/OXxKU0RNiQWexKRxQ7H7xZxzA25nAL32IyUK1rruihIEcNJyPi5Go7dP1MB3x
 1QNxmqx0Kn3y2gSX5mFkYC6UGAhFeXSfoQ6MTNlrshFdLFi8q4aHMbnXRZeaTNe/8Uod
 +DI/moiyGJL8OlxfUfcgNVIHLIiwkJl/q3mQ4DhtPiHZPIJysr+Huug1HzlUJ5loVR1c
 F7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=sW8LqdsqvdTg1P+qAX5fXAdoffXOLpsCYzIzY0O/pGA=;
 b=s+wLYtRLIa1HRO9w8wc9PKcbEcmIeq/ejZAa8+xvnIWQKD9TLqCpo/YqfdhtK2u4PD
 C/TRdxiIUiBAt+MMaIcZVV9Xlj5ih1Z8TInME1sth5nhiho4B1xBMYZEw08erW4AqgOw
 CjTSWFy586fNgcPp294C7h5TWNz5u9C3qbaU6eXoSiREmwWwjBlTMILuFBMU50VFEo6l
 c1ouClKNSWoEQi7uAcyjRR/unAFf/aiqkiBCN3/aIbBVviHZXDbP0UJtSQe8wG+/Im4j
 dWXIgT+R+XGRqB4/twSa1wRGhntEiZITs7CYEwPvb09P+X5V/tEG776GX66hmGa3H0qC
 6rIw==
X-Gm-Message-State: AOAM532RuTUwY+GnkTT/OmdMVsnHuZmRxWmGvR1JvoXPsTwNtzpYQW+R
 63X7ORO0zutAXomAMOEvRB8=
X-Google-Smtp-Source: ABdhPJxRx+s3w1orl8e+NX2YRi1fvPtJThFsBNCiqU/JL7jI6rg1qhnHNvuU2J/wJ+z4sDVEG5mB8Q==
X-Received: by 2002:adf:df03:: with SMTP id y3mr3657957wrl.70.1603814604096;
 Tue, 27 Oct 2020 09:03:24 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id d2sm2424163wrq.34.2020.10.27.09.03.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 09:03:23 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Anthony PERARD'" <anthony.perard@citrix.com>,
	<qemu-devel@nongnu.org>
References: <20201027154058.495112-1-anthony.perard@citrix.com>
In-Reply-To: <20201027154058.495112-1-anthony.perard@citrix.com>
Subject: RE: [PATCH v2] xen: rework pci_piix3_xen_ide_unplug
Date: Tue, 27 Oct 2020 16:03:22 -0000
Message-ID: <00a201d6ac7a$b2792640$176b72c0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQIXyNIMV8JUNlnsXBQ3KKexs/tKsqkpYYpA
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: paul@xen.org
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>,
 'John Snow' <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 27 October 2020 15:41
> To: qemu-devel@nongnu.org
> Cc: Anthony PERARD <anthony.perard@citrix.com>; Paul Durrant <paul@xen.org>; Stefano Stabellini
> <sstabellini@kernel.org>; John Snow <jsnow@redhat.com>; qemu-block@nongnu.org
> Subject: [PATCH v2] xen: rework pci_piix3_xen_ide_unplug
> 
> From: Anthony PERARD <anthony.perard@citrix.com>
> 
> This is to allow IDE disks to be unplugged when adding to QEMU via:
>     -drive file=/root/disk_file,if=none,id=ide-disk0,format=raw
>     -device ide-hd,drive=ide-disk0,bus=ide.0,unit=0
> 
> as the current code only works for disk added with:
>     -drive file=/root/disk_file,if=ide,index=0,media=disk,format=raw
> 
> Since the code already have the IDE controller as `dev`, we don't need
> to use the legacy DriveInfo to find all the drive we want to unplug.
> We can simply use `blk` from the controller, as it kind of was already
> assume to be the same, by setting it to NULL.
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> 

Reviewed-by: Paul Durrant <paul@xen.org>

> ---
> v2: coding style
> 
> CC: Paul Durrant <paul@xen.org>
> CC: Stefano Stabellini <sstabellini@kernel.org>
> ---
>  hw/ide/piix.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index b402a936362b..b9860e35a5c4 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -164,30 +164,29 @@ static void pci_piix_ide_realize(PCIDevice *dev, Error **errp)
>  int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux)
>  {
>      PCIIDEState *pci_ide;
> -    DriveInfo *di;
>      int i;
>      IDEDevice *idedev;
> +    IDEBus *idebus;
> +    BlockBackend *blk;
> 
>      pci_ide = PCI_IDE(dev);
> 
>      for (i = aux ? 1 : 0; i < 4; i++) {
> -        di = drive_get_by_index(IF_IDE, i);
> -        if (di != NULL && !di->media_cd) {
> -            BlockBackend *blk = blk_by_legacy_dinfo(di);
> -            DeviceState *ds = blk_get_attached_dev(blk);
> +        idebus = &pci_ide->bus[i / 2];
> +        blk = idebus->ifs[i % 2].blk;
> 
> -            blk_drain(blk);
> -            blk_flush(blk);
> -
> -            if (ds) {
> -                blk_detach_dev(blk, ds);
> -            }
> -            pci_ide->bus[di->bus].ifs[di->unit].blk = NULL;
> +        if (blk && idebus->ifs[i % 2].drive_kind != IDE_CD) {
>              if (!(i % 2)) {
> -                idedev = pci_ide->bus[di->bus].master;
> +                idedev = idebus->master;
>              } else {
> -                idedev = pci_ide->bus[di->bus].slave;
> +                idedev = idebus->slave;
>              }
> +
> +            blk_drain(blk);
> +            blk_flush(blk);
> +
> +            blk_detach_dev(blk, DEVICE(idedev));
> +            idebus->ifs[i % 2].blk = NULL;
>              idedev->conf.blk = NULL;
>              monitor_remove_blk(blk);
>              blk_unref(blk);
> --
> Anthony PERARD



