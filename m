Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7213C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56EDB2085B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKNpOupI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EDB2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGgu-0004Nv-BZ
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 03:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kKGfo-0003uO-Ge; Mon, 21 Sep 2020 03:55:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kKGfm-0005jy-O9; Mon, 21 Sep 2020 03:55:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id e16so11664611wrm.2;
 Mon, 21 Sep 2020 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=VCUl6mZA9I1IjxfKwGIKo1AwE7rsxY1rJMO33gVDJLk=;
 b=tKNpOupIsqmH3uMcKNGkqoOH2RS+1VIUxL7jLhuYDK7Yhc4PLoS6HahZ5aiAfwgM95
 ba2wTnItt0lngUPaJ397XERPgwsv2TbtgKqAT7dPw/t1zf3P+xAQBNY39R8leAZ73mQi
 BUdDOLweucWb5jeixnIl54QfsVqsy1RaklrKpk+QpTA8Sdnxgcg/hwzm+sHc5lFUhD0L
 vElbiMBIcu1NVPvh8n473B2+o/0nmH3n5POhefbye6l15stNTo8wbolD2rw+Wpy8rP0c
 VW1hk8XHbQyQsl7UW6OlN3WhnTRJhebQkdhhiMZiqjDXnNhTSNAA532XlLVutJxLWScC
 wn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=VCUl6mZA9I1IjxfKwGIKo1AwE7rsxY1rJMO33gVDJLk=;
 b=eV0xmPSg1mlWOoZcUPXTbpFl5My06SyQrf6L1sZh2GWZzE/39L94xcLl7P5C2CKHN/
 R2GEiNRidYS6oJn8AhgNqTVEe6SmSgbiAJo5aoVLNzDO8DOpDRjC+OxKAM98VzmDmbvV
 dTIQ9iP0x4U7Dw8bERzvEEnUuArOMeloB6kkyhg+C9oyBPyySwZ+rmdZjHC5no3N5tt6
 KPyQeJjsEYup9bltfk5kTENkhEvZWsgeLCzKFcG2KUhM+J/U+g4jnxHrno6JhsUWkXc/
 a6NtOE2XigsVGPZccAb7HjcJ/3r8g52sWSrvjUEC3zMSd54JU6aEwHgwqP5LynA0e3pY
 awxQ==
X-Gm-Message-State: AOAM5300/TF2ov3GEOuGHfGTAtMT9USr4bUot+0fbWYNyp62eKW0Siwd
 zhPbaIcnxpZhkTbDUyXMWYk=
X-Google-Smtp-Source: ABdhPJx0WbiGzfabu+hE/fp9xnuaq9wlM1WAaqeiZNuEgFfBuEfMclTkZWiOGqM8j8Hy4TQ09CsYQQ==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr25422859wrp.13.1600674940961; 
 Mon, 21 Sep 2020 00:55:40 -0700 (PDT)
Received: from CBGR90WXYV0 (host86-176-94-160.range86-176.btcentralplus.com.
 [86.176.94.160])
 by smtp.gmail.com with ESMTPSA id j26sm21065689wrc.79.2020.09.21.00.55.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2020 00:55:40 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Anthony PERARD'" <anthony.perard@citrix.com>,
	<qemu-devel@nongnu.org>
References: <20200918145256.1886250-1-anthony.perard@citrix.com>
In-Reply-To: <20200918145256.1886250-1-anthony.perard@citrix.com>
Subject: RE: [PATCH] xen: rework pci_piix3_xen_ide_unplug
Date: Mon, 21 Sep 2020 08:55:42 +0100
Message-ID: <001d01d68fec$9ad8ed90$d08ac8b0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQJLenTAn8XE+G2FtJahdN+bos0+W6iI3zFA
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x442.google.com
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
> Sent: 18 September 2020 15:53
> To: qemu-devel@nongnu.org
> Cc: Paul Durrant <paul@xen.org>; Stefano Stabellini <sstabellini@kernel.org>; Anthony PERARD
> <anthony.perard@citrix.com>; John Snow <jsnow@redhat.com>; qemu-block@nongnu.org
> Subject: [PATCH] xen: rework pci_piix3_xen_ide_unplug
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
> ---
>  hw/ide/piix.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index b402a936362b..16fcbe58d6fe 100644
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
> +        if (blk && idebus->ifs[i%2].drive_kind != IDE_CD) {

Spaces around '%'

>              if (!(i % 2)) {
> -                idedev = pci_ide->bus[di->bus].master;
> +                idedev = idebus->master;
>              } else {
> -                idedev = pci_ide->bus[di->bus].slave;
> +                idedev = idebus->slave;
>              }

Perhaps use a ternary operator here rather than if/else. Also there are 3 uses 'i % 2' so I wonder whether a local 'device index'
variable might be neater.

  Paul

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



