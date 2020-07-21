Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97462C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 00:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C17208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 00:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVxBlMb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C17208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxgGv-00072d-LQ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 20:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxgFz-0006R5-Tw
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 20:35:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43502
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxgFw-0004pQ-4f
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 20:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595291738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=76CJR3Y4xQWFzzngBwkQOhkjzGQAN65vK7uVESFU0Ns=;
 b=IVxBlMb2yLiisNi/jDXBT4WtZuGhpIfhZG5x7Dvyh4ewa5vwfotZ6SSwP2hRBCExGecVB7
 s1fh7XB0Kb7csFD3EzGiXV6LVMHVcaxZ5+JeiNUr7b4XQLF8fpbj5I6ZwzhXhQplxkT2cU
 gsO6MfKiHgyN7KA8YeGnLCTxv1WuFK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-YdmWWuSxPpKZLFxgHp_8UA-1; Mon, 20 Jul 2020 20:35:34 -0400
X-MC-Unique: YdmWWuSxPpKZLFxgHp_8UA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 878591902EA0;
 Tue, 21 Jul 2020 00:35:33 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81C3360BF1;
 Tue, 21 Jul 2020 00:35:32 +0000 (UTC)
Subject: Re: [RFC PATCH-for-5.1 v2] hw/ide: Avoid #DIV/0! FPU exception by
 setting CD-ROM sector count
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200717133847.10974-1-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <c8827eec-68d9-6bf6-5f0f-c9ea3b2f32bd@redhat.com>
Date: Mon, 20 Jul 2020 20:35:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717133847.10974-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 20:35:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 9:38 AM, Philippe Mathieu-Daudé wrote:
> libFuzzer found an undefined behavior (#DIV/0!) in ide_set_sector()
> when using a CD-ROM (reproducer available on the BugLink):
> 
>    UndefinedBehaviorSanitizer:DEADLYSIGNAL
>    ==12163==ERROR: UndefinedBehaviorSanitizer: FPE on unknown address 0x5616279cffdc (pc 0x5616279cffdc bp 0x7ffcdaabae90 sp 0x7ffcdaabae30 T12163)
> 
> Fix by initializing the CD-ROM number of sectors in ide_dev_initfn().
> 
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: b2df431407 ("ide scsi: Mess with geometry only for hard disk devices")
> BugLink: https://bugs.launchpad.net/qemu/+bug/1887309
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Since v1:
> - Allow zero-sized drive images (not sure why we need them)
>    but display a friendly message that this is unsupported
> 
> Unrelated but interesting:
> http://www.physics.udel.edu/~watson/scen103/cdsoln.html
> ---
>   hw/ide/qdev.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 27ff1f7f66..005d73bdb9 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -201,6 +201,15 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
>                                 errp)) {
>               return;
>           }
> +    } else {
> +        uint64_t nb_sectors;
> +
> +        blk_get_geometry(dev->conf.blk, &nb_sectors);
> +        if (!nb_sectors) {
> +            warn_report("Drive image of size zero is unsupported for 'ide-cd', "
> +                        "use at your own risk ¯\\_(ツ)_/¯");
> +        }
> +        dev->conf.secs = nb_sectors;
>       }
>       if (!blkconf_apply_backend_options(&dev->conf, kind == IDE_CD,
>                                          kind != IDE_CD, errp)) {
> 

I think this patch might be wrong... or at least a misdirection.

ide_set_sector is a helper that takes a logical number and distills it 
back down into the appropriate underlying registers. The case it's 
falling down on is the non-LBA case, using CHS addressing.

Is CHS addressing meaningful for CDROMs? I'm gonna guess no...

I'm looking at the original fuzzer report.
I see two commands coming in, 0x35 and 0xA1.

0x35 is WRITE DMA EXT and is being issued to the second drive, which is 
the HD in this case.

0xA1 is IDENTIFY PACKET DEVICE and goes to the first drive, the CDROM in 
this case. This is usually a fairly straightforward command that makes 
512 bytes of data available via PIO read. (Why is this engaging a DMA 
callback?)

outw 0x176 0x3538
	device/head = 0x38 [0011 1000] <-- Set 2nd drive as active
	command = 0x35     [0011 0101] <-- WRITE DMA EXT
outl 0xcf8 0x80000903
outl 0xcfc 0x184275c
outb 0x376 0x2f
	control = 0x2f [0010 1111] <-- arm a device reset
outb 0x376 0x0
	control = 0x00 [0000 0000] <-- execute a device reset
outw 0x176 0xa1a4
	device/head = 0xa4 [1010 0100]  <-- Set 1st drive as active
	command = 0xa1     [1010 0001]	<-- IDENTIFY PACKET DEVICE
outl 0xcf8 0x80000920
outb 0xcfc 0xff
outb 0xf8 0x9


the device reset here clears the busy flags for *both* drives on the 
controller, but doesn't actually take any care to cancel any outstanding 
requests. This is the main bad thing, as it allows a second request to 
be issued to a different drive while the first request's BH is still out.

When we make a call to the second device, the BH returns but now has the 
wrong context / bus state, and does ... weird, incorrect stuff.

This register is the Device Control register and bit 2, IDE_CMD_RESET, 
is officially the SRST bit (Software Reset).

It's detailed what this bit should do in ATA4 section 9.3 "Software 
Reset." (It seems like a lot, actually?)

--js


