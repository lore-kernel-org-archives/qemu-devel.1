Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FF6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D56F206F2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abKHX2lJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D56F206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxwWL-0007vj-9U
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 13:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxwVd-0007UH-29
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 13:56:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51338
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jxwVb-00038V-FC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 13:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595354214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/04qTr+VBJg2CrmwyfsL+gyfwoiSG3h8c4PeABF6cw=;
 b=abKHX2lJnC8y9PoH5KYO6Skx4EGSxzT6bCfYCEbShYVCsOWwZ55BBIFonSQcUp5YUkkZNY
 gTFS/o3XIsP5SgBUBf7ESqmRRm7+ZQsrRokds/w9T3tCPvuBpVNK5WWZZWoZlfMaDiL4JJ
 vllbUceFyGzsRpkx/swEo1YCWeJJxSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-JQlSrqKLPA-imZFS4c_VzQ-1; Tue, 21 Jul 2020 13:56:52 -0400
X-MC-Unique: JQlSrqKLPA-imZFS4c_VzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ECEB1005510;
 Tue, 21 Jul 2020 17:56:51 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 990E25D9CA;
 Tue, 21 Jul 2020 17:56:50 +0000 (UTC)
Subject: Re: [PATCH-for-5.1] hw/ide/ahci: Do not dma_memory_unmap(NULL)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200718072854.7001-1-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <c98f64ba-45ad-66be-c2c8-22d1efd4f7bb@redhat.com>
Date: Tue, 21 Jul 2020 13:56:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200718072854.7001-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:58:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-stable@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/20 3:28 AM, Philippe Mathieu-Daudé wrote:
> libFuzzer triggered the following assertion:
> 
>    cat << EOF | qemu-system-i386 -M pc-q35-5.0 \
>      -nographic -monitor none -serial none -qtest stdio
>    outl 0xcf8 0x8000fa24
>    outl 0xcfc 0xe1068000
>    outl 0xcf8 0x8000fa04
>    outw 0xcfc 0x7
>    outl 0xcf8 0x8000fb20
>    write 0xe1068304 0x1 0x21
>    write 0xe1068318 0x1 0x21
>    write 0xe1068384 0x1 0x21
>    write 0xe1068398 0x2 0x21
>    EOF
>    qemu-system-i386: exec.c:3621: address_space_unmap: Assertion `mr != NULL' failed.
>    Aborted (core dumped)
> 
> This is because we don't check the return value from dma_memory_map()
> which can return NULL, then we call dma_memory_unmap(NULL) which is
> illegal. Fix by only unmap if the value is not NULL (and the size is
> not the expected one).
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: f6ad2e32f8 ("ahci: add ahci emulation")
> BugLink: https://bugs.launchpad.net/qemu/+bug/1884693
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/ide/ahci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 009120f88b..4f596cb9ce 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -250,7 +250,7 @@ static void map_page(AddressSpace *as, uint8_t **ptr, uint64_t addr,
>       }
>   
>       *ptr = dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE);
> -    if (len < wanted) {
> +    if (len < wanted && *ptr) {
>           dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
>           *ptr = NULL;
>       }
> 

Staged @ gitlab

https://gitlab.com/jsnow/qemu/-/commits/ide



