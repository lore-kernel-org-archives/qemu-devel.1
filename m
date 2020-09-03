Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C36C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE752071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x1Hg/Dja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE752071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlOj-0001jm-Uh
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlNp-0000jn-74
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:18:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlNn-0007eg-9Q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:18:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839Dd4U156417;
 Thu, 3 Sep 2020 09:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=wyt7JO+Klgk+PqMXcjrZNraGiFdhixuRrsKuxYyHQWU=;
 b=x1Hg/DjaJvSutekLZQ0wVsU/rpPaH3t8bXnszjgrDORXL/E6Qm5vzHF1HdtMpMTInym6
 QyAy8LULdCMhxc2CYFC35CuCG4jB7obNRXpZwYenwW29hnXEE6EQfqMFrK9C9p4l243H
 +l2WakWpvRAb7syo2WVi+RzbKBHKRG3Rb1L01FsUja/Ca5KvQ6p8kwcz3gC2Bt8+VDB4
 dBCOzxP26Mi+bgwzSnDAqbzUxdcq5BoYlmXLo9RSX5w0hpj+g5P1CgZjGwu62lVZHydD
 OrLIkPDGaDAyqOYGS2Tzpj3WDEFWOjLCb6I0pXbqRqm/0krNmTKrrFKKzSVRW4R368DD Ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 339dmn62f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 09:18:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839AhiG153476;
 Thu, 3 Sep 2020 09:16:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 3380x9chny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 09:16:11 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0839G9EB030680;
 Thu, 3 Sep 2020 09:16:09 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 02:16:09 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 6D77B134FD9A; Thu,  3 Sep 2020 10:16:06 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/15] scripts/oss-fuzz: Add general-fuzzer configs
 for oss-fuzz
In-Reply-To: <20200819061110.1320568-13-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-13-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 10:16:06 +0100
Message-ID: <m28sdrrzjd.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0
 mlxlogscore=993 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 mlxlogscore=998 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030085
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:43:20
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
Cc: Thomas Huth <thuth@redhat.com>, f4bug@amsat.org,
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-08-19 at 02:11:07 -04, Alexander Bulekov wrote:
> Each of these entries is built into a wrapper binary that sets the
> needed environment variables and executes the general virtual-device
> fuzzer. In the future, we will need additional fields, such as arch=arm,
> timeout_per_testcase=0, reset=reboot, etc...
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  scripts/oss-fuzz/general_fuzzer_configs.yml | 103 ++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 scripts/oss-fuzz/general_fuzzer_configs.yml
>
> diff --git a/scripts/oss-fuzz/general_fuzzer_configs.yml b/scripts/oss-fuzz/general_fuzzer_configs.yml
> new file mode 100644
> index 0000000000..010e92a2a5
> --- /dev/null
> +++ b/scripts/oss-fuzz/general_fuzzer_configs.yml
> @@ -0,0 +1,103 @@
> +configs:
> +    - name: virtio-net-pci-slirp
> +      args: >
> +        -M q35 -nodefaults
> +        -device virtio-net,netdev=net0 -netdev user,id=net0
> +      objects: virtio*
> +
> +    - name: virtio-blk
> +      args: >
> +        -machine q35 -device virtio-blk,drive=disk0
> +        -drive file=null-co://,id=disk0,if=none,format=raw
> +      objects: virtio*
> +
> +    - name: virtio-scsi
> +      args: >
> +        -machine q35 -device virtio-scsi,num_queues=8
> +        -device scsi-hd,drive=disk0
> +        -drive file=null-co://,id=disk0,if=none,format=raw
> +      objects: scsi* virtio*
> +
> +    - name: virtio-gpu
> +      args: -machine q35 -nodefaults -device virtio-gpu
> +      objects: virtio*
> +
> +    - name: virtio-vga
> +      args: -machine q35 -nodefaults -device virtio-vga
> +      objects: virtio*
> +
> +    - name: virtio-rng
> +      args: -machine q35 -nodefaults -device virtio-rng
> +      objects: virtio*
> +
> +    - name: virtio-balloon
> +      args: -machine q35 -nodefaults -device virtio-balloon
> +      objects: virtio*
> +
> +    - name: virtio-serial
> +      args: -machine q35 -nodefaults -device virtio-serial
> +      objects: virtio*
> +
> +    - name: virtio-mouse
> +      args: -machine q35 -nodefaults -device virtio-mouse
> +      objects: virtio*
> +
> +    - name: e1000
> +      args: >
> +        -M q35 -nodefaults
> +        -device e1000,netdev=net0 -netdev user,id=net0
> +      objects: e1000
> +
> +    - name: e1000e
> +      args: >
> +        -M q35 -nodefaults
> +        -device e1000e,netdev=net0 -netdev user,id=net0
> +      objects: e1000e
> +
> +    - name: cirrus-vga
> +      args: -machine q35 -nodefaults -device cirrus-vga
> +      objects: cirrus*
> +
> +    - name: bochs-display
> +      args: -machine q35 -nodefaults -device bochs-display
> +      objects: bochs*
> +
> +    - name: intel-hda
> +      args: >
> +        -machine q35 -nodefaults -device intel-hda,id=hda0
> +        -device hda-output,bus=hda0.0 -device hda-micro,bus=hda0.0
> +        -device hda-duplex,bus=hda0.0
> +      objects: intel-hda
> +
> +    - name: ide-hd
> +      args: >
> +        -machine q35 -nodefaults
> +        -drive file=null-co://,if=none,format=raw,id=disk0
> +        -device ide-hd,drive=disk0
> +      objects: ahci*
> +
> +    - name: floppy
> +      args: >
> +        -machine pc -nodefaults -device floppy,id=floppy0
> +        -drive id=disk0,file=null-co://,file.read-zeroes=on,if=none
> +        -device floppy,drive=disk0,drive-type=288
> +      objects: fd* floppy*
> +
> +    - name: xhci
> +      args: >
> +        -machine q35 -nodefaults
> +        -drive file=null-co://,if=none,format=raw,id=disk0
> +        -device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 -device usb-bot
> +        -device usb-storage,drive=disk0 -chardev null,id=cd0 -chardev null,id=cd1
> +        -device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid
> +        -device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1
> +        -device usb-tablet -device usb-wacom-tablet -device usb-audio
> +      objects: "*usb* *uhci* *xhci*"
> +
> +    - name: pc-i440fx
> +      args: -machine pc
> +      objects: "*"
> +
> +    - name: pc-q35
> +      args: -machine q35
> +      objects: "*"
> -- 
> 2.27.0

