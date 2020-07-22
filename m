Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B34D2064C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUFiHEx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B34D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy6F8-0002x0-9u
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 00:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jy6ED-0002LC-8r
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:19:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40600
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jy6E9-0007Rf-Ra
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 00:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595391572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlp1IodwrnMCR5IvRjRW7MKH00tV6JWdmYvKCqI7JBM=;
 b=RUFiHEx7Wyd25/nrEtiVAVGXu9dTWoWuZQ1KR4xvGP/GDTg1Tmih5M+EMUHeCYN7G/GcIN
 4vwREtXv70wOpG/BhcpfGchijhKIOtr/8zFqC/vJzKJpvZhA7IuobSmscNPfT3ddiSdLae
 u2MvDlXkyjW4pINA1ZAjI4Kze2wE0L4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-2eg8s77qNkSp_4uvZW3mew-1; Wed, 22 Jul 2020 00:19:27 -0400
X-MC-Unique: 2eg8s77qNkSp_4uvZW3mew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E27D800460;
 Wed, 22 Jul 2020 04:19:26 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00541BA66;
 Wed, 22 Jul 2020 04:19:25 +0000 (UTC)
Subject: Re: [RFC PATCH-for-5.1 v2] hw/ide: Cancel pending DMA requests before
 setting as inactive
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200717075317.5376-1-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <d7ebf46d-a449-6ffc-e71d-423af0accd35@redhat.com>
Date: Wed, 22 Jul 2020 00:19:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717075317.5376-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 3:53 AM, Philippe Mathieu-Daudé wrote:
> libFuzzer found a case where requests are queued for later in the
> AIO context, but a command set the bus inactive, then when finally
> the requests are processed by the DMA it aborts because it is
> inactive:
> 
>   include/hw/ide/pci.h:59: IDEState *bmdma_active_if(BMDMAState *): Assertion `bmdma->bus->retry_unit != (uint8_t)-1' failed.
> 
> Reproducer available on the BugLink.
> 
> Fix by draining the pending DMA requests before inactivating the bus.
> 
> BugLink: https://bugs.launchpad.net/qemu/+bug/1887303
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> RFC because I don't have much clue about block drive and IDE,
> so block-team please be very careful while reviewing this bug.
> ---
>   hw/ide/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index d997a78e47..f7affafb0c 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -804,7 +804,7 @@ void dma_buf_commit(IDEState *s, uint32_t tx_bytes)
>   
>   void ide_set_inactive(IDEState *s, bool more)
>   {

Generally, ide_set_inactive is meant to be used as the normative 
function to transition to the idle state; not something that performs a 
cancellation.

(It should probably assert that there are no pending BHs.)

...Let's run through the reproducer!
In my annotation here,

0x1F0 - Primary Bus I/O
0x3F6 - Primary Bus Control
   [0] Primary Bus, dev0
   [1] Primary Bus, dev1
0x170 - Secondary Bus I/O
0x376 - Secondary Bus Control
   [2] Secondary Bus, dev0
   [3] Secondary Bus, dev1


 > outw 0x176 0x3538

   [2].select = 0x38 [0011 1000]
                         ^ select secondary device
   [3].command = 0x35
                   ^ WRITE DMA EXT

outw 0x376 0x6007

   [3].control = 0x07 [0000 0111]
                             ^- +SRST
   # 0x06 goes into the void?

outw 0x376 0x6b6b

   [3].control = 0x6b; [0110 1011]
                              ^- -SRST
   # Oops, this does a Software Reset without cancelling the DMA again.
   # second write goes into the void?

outw 0x176 0x985c

   [3].select = 0x5c; [0101 1100]
   [3].command = 0x98; CHECK POWER MODE
              (Note: Deprecated in ATA4!)
   # Oops, this command shouldn't start when another one is in-process.
   # It also has the bad effect of setting the nsector register to 0xff!

outl 0xcf8 0x80000903
outl 0xcfc 0x2f2931
outl 0xcf8 0x80000920
outb 0xcfc 0x6b
		^- PCI stuff. I'm not as fast at reading hex here.
                    My brain has adapted to ATA only.

outb 0x68 0x7
   # Not entirely sure where this goes, but it seems to kick the DMA BH.
   # ... The pending DMA BH that belongs to WRITE_DMA_EXT.

outw 0x176 0x2530

     [3].select = 0x30 [0011 0000]
                           ^ select drive1
     [3].command = 0x25 (READ DMA EXT)

... At this point, it explodes because there's a pending DMA already, 
and the sector registers are all wrong.

This bug actually seems to have the same root cause as the other one: 
SRST does not perform the SRST sufficiently.


> -    s->bus->dma->aiocb = NULL;
> +    ide_cancel_dma_sync(s);
>       ide_clear_retry(s);
>       if (s->bus->dma->ops->set_inactive) {
>           s->bus->dma->ops->set_inactive(s->bus->dma, more);
> 


