Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B796C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91867222E9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GA/rEetj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91867222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWkH-0005GB-4K
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 05:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVWjF-0004lv-0b
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:17:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVWjD-00086C-21
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:17:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M9FKIf037089;
 Thu, 22 Oct 2020 09:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Hbt9/q3kVXqa24hoVMDvFr0ZUqa+jO7xjjS6jBqq9gM=;
 b=GA/rEetjVPhBTQgqLTT93jiBNXdkCyQqnleZCJGcE0SFwIJtmHlfTbtyaS8K905XE/T+
 TXTorKAR2g7czMYGaLG+wgMEKgfJBJFhALUuDlaDrPChiqVAeUylnb2jgQIpzlrwCEXf
 J5LiA1CpkG3tr00JqD46A6kgp7WU8QDqp+S4pC4c+D8+ct99riCLW+HgQlQeE8PS89b2
 f2OJo855gZ0YeIWcmJpY26uxg4FXVBoOKiqRSqT1Jx3lVaramhPhZWdmSpCxayMQfpHn
 iKMNMOXwuffHqnm5d77MYa/h4HGtx89A3qZVB26INaLjryISbRYY83IVXVOZtCpkredr 5A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 347p4b50dn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Oct 2020 09:17:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M9F2ve110469;
 Thu, 22 Oct 2020 09:15:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 348ahyja9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 09:15:43 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09M9Fggl024795;
 Thu, 22 Oct 2020 09:15:42 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 22 Oct 2020 02:15:42 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id C9BEB1D6DA69; Thu, 22 Oct 2020 10:15:37 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 14/16] fuzz: add generic-fuzz configs for oss-fuzz
In-Reply-To: <20201021210922.572955-15-alxndr@bu.edu>
References: <20201021210922.572955-1-alxndr@bu.edu>
 <20201021210922.572955-15-alxndr@bu.edu>
Date: Thu, 22 Oct 2020 10:15:37 +0100
Message-ID: <m2tuum7hae.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=933 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=950 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220062
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=darren.kenny@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:25:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 f4bug@amsat.org, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-10-21 at 17:09:20 -04, Alexander Bulekov wrote:
> Predefine some generic-fuzz configs. For each of these, we will create a
> separate FuzzTarget that can be selected through argv0 and, therefore,
> fuzzed on oss-fuzz.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  tests/qtest/fuzz/generic_fuzz_configs.h | 121 ++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 tests/qtest/fuzz/generic_fuzz_configs.h
>
> diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
> new file mode 100644
> index 0000000000..c4d925f9e6
> --- /dev/null
> +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
> @@ -0,0 +1,121 @@
> +/*
> + * Generic Virtual-Device Fuzzing Target Configs
> + *
> + * Copyright Red Hat Inc., 2020
> + *
> + * Authors:
> + *  Alexander Bulekov   <alxndr@bu.edu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef GENERIC_FUZZ_CONFIGS_H
> +#define GENERIC_FUZZ_CONFIGS_H
> +
> +#include "qemu/osdep.h"
> +
> +typedef struct generic_fuzz_config {
> +    const char *name, *args, *objects;
> +} generic_fuzz_config;
> +
> +const generic_fuzz_config predefined_configs[] = {
> +    {
> +        .name = "virtio-net-pci-slirp",
> +        .args = "-M q35 -nodefaults "
> +        "-device virtio-net,netdev=net0 -netdev user,id=net0",
> +        .objects = "virtio*",
> +    },{
> +        .name = "virtio-blk",
> +        .args = "-machine q35 -device virtio-blk,drive=disk0 "
> +        "-drive file=null-co://,id=disk0,if=none,format=raw",
> +        .objects = "virtio*",
> +    },{
> +        .name = "virtio-scsi",
> +        .args = "-machine q35 -device virtio-scsi,num_queues=8 "
> +        "-device scsi-hd,drive=disk0 "
> +        "-drive file=null-co://,id=disk0,if=none,format=raw",
> +        .objects = "scsi* virtio*",
> +    },{
> +        .name = "virtio-gpu",
> +        .args = "-machine q35 -nodefaults -device virtio-gpu",
> +        .objects = "virtio*",
> +    },{
> +        .name = "virtio-vga",
> +        .args = "-machine q35 -nodefaults -device virtio-vga",
> +        .objects = "virtio*",
> +    },{
> +        .name = "virtio-rng",
> +        .args = "-machine q35 -nodefaults -device virtio-rng",
> +        .objects = "virtio*",
> +    },{
> +        .name = "virtio-balloon",
> +        .args = "-machine q35 -nodefaults -device virtio-balloon",
> +        .objects = "virtio*",
> +    },{
> +        .name = "virtio-serial",
> +        .args = "-machine q35 -nodefaults -device virtio-serial",
> +        .objects = "virtio*",
> +    },{
> +        .name = "virtio-mouse",
> +        .args = "-machine q35 -nodefaults -device virtio-mouse",
> +        .objects = "virtio*",
> +    },{
> +        .name = "e1000",
> +        .args = "-M q35 -nodefaults "
> +        "-device e1000,netdev=net0 -netdev user,id=net0",
> +        .objects = "e1000",
> +    },{
> +        .name = "e1000e",
> +        .args = "-M q35 -nodefaults "
> +        "-device e1000e,netdev=net0 -netdev user,id=net0",
> +        .objects = "e1000e",
> +    },{
> +        .name = "cirrus-vga",
> +        .args = "-machine q35 -nodefaults -device cirrus-vga",
> +        .objects = "cirrus*",
> +    },{
> +        .name = "bochs-display",
> +        .args = "-machine q35 -nodefaults -device bochs-display",
> +        .objects = "bochs*",
> +    },{
> +        .name = "intel-hda",
> +        .args = "-machine q35 -nodefaults -device intel-hda,id=hda0 "
> +        "-device hda-output,bus=hda0.0 -device hda-micro,bus=hda0.0 "
> +        "-device hda-duplex,bus=hda0.0",
> +        .objects = "intel-hda",
> +    },{
> +        .name = "ide-hd",
> +        .args = "-machine q35 -nodefaults "
> +        "-drive file=null-co://,if=none,format=raw,id=disk0 "
> +        "-device ide-hd,drive=disk0",
> +        .objects = "ahci*",
> +    },{
> +        .name = "floppy",
> +        .args = "-machine pc -nodefaults -device floppy,id=floppy0 "
> +        "-drive id=disk0,file=null-co://,file.read-zeroes=on,if=none "
> +        "-device floppy,drive=disk0,drive-type=288",
> +        .objects = "fd* floppy*",
> +    },{
> +        .name = "xhci",
> +        .args = "-machine q35 -nodefaults "
> +        "-drive file=null-co://,if=none,format=raw,id=disk0 "
> +        "-device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 "
> +        "-device usb-bot -device usb-storage,drive=disk0 "
> +        "-chardev null,id=cd0 -chardev null,id=cd1 "
> +        "-device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid "
> +        "-device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 "
> +        "-device usb-tablet -device usb-wacom-tablet -device usb-audio",
> +        .objects = "*usb* *uhci* *xhci*",
> +    },{
> +        .name = "pc-i440fx",
> +        .args = "-machine pc",
> +        .objects = "*",
> +    },{
> +        .name = "pc-q35",
> +        .args = "-machine q35",
> +        .objects = "*",
> +    }
> +};
> +
> +#endif
> -- 
> 2.28.0

