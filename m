Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F09C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946EF206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeLuymPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946EF206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRI6-0006jF-Ri
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joRH2-0005sF-4Y
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:46:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48963
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joRGz-0007jy-QK
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593089192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLY4spy2Zb1G/S8/bXL27oj0QCuDwaRBQ4cKCL6OEg8=;
 b=XeLuymPTTk7NXzUBfCh3TBExRf0b1zxZSM8LqRgfR393WTLcPoq9iCLr/vWkK72qbOeSfN
 5LTwoav+Klm7y9Y8izMU+O39AKKwFmjfDNLEgpTOGVuQEuH8DtizdzLxeTZI+Y44ylzX23
 nZ/jjlTd+0hIK38YmL7UfkOQxslkmZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-gO3bqP2BOMOnntaE51N6mA-1; Thu, 25 Jun 2020 08:46:30 -0400
X-MC-Unique: gO3bqP2BOMOnntaE51N6mA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7B3E8015F4;
 Thu, 25 Jun 2020 12:46:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83E7771660;
 Thu, 25 Jun 2020 12:46:25 +0000 (UTC)
Subject: Re: [PATCH v5 11/12] pc-bios: s390x: Fix bootmap.c passing PSWs as
 addresses
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624075226.92728-12-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <91c99232-91a6-f2f1-d2cc-af26dbb86558@redhat.com>
Date: Thu, 25 Jun 2020 14:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624075226.92728-12-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/2020 09.52, Janosch Frank wrote:
> The component entries written by zipl contain short PSWs, not
> addresses. Let's mask them and only pass the address part to
> jump_to_IPL_code(uint64_t address) because it expects an address as
> visible by the name of the argument.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.c | 5 +++--
>   pc-bios/s390-ccw/bootmap.h | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 97205674e5..8547a140df 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -10,6 +10,7 @@
>   
>   #include "libc.h"
>   #include "s390-ccw.h"
> +#include "s390-arch.h"
>   #include "bootmap.h"
>   #include "virtio.h"
>   #include "bswap.h"
> @@ -436,7 +437,7 @@ static void zipl_load_segment(ComponentEntry *entry)
>       char *blk_no = &err_msg[30]; /* where to print blockno in (those ZZs) */
>   
>       blockno = entry->data.blockno;
> -    address = entry->load_address;
> +    address = entry->psw & PSW_MASK_SHORT_ADDR;

Are you really sure about this one here? The address does not seem to be 
used for any of the jump_to_IPL() functions. And in the zipl sources, I 
can also see spots like this:

    entry->compdat.load_address = data.load_address;

... without any further short mask bits. So I somehow doubt that this 
change is really ok?

>       debug_print_int("loading segment at block", blockno);
>       debug_print_int("addr", address);
> @@ -514,7 +515,7 @@ static void zipl_run(ScsiBlockPtr *pte)
>       IPL_assert(entry->component_type == ZIPL_COMP_ENTRY_EXEC, "No EXEC entry");
>   
>       /* should not return */
> -    jump_to_IPL_code(entry->load_address);
> +    jump_to_IPL_code(entry->psw & PSW_MASK_SHORT_ADDR);

That one should be fine, I think.

>   }
>   
>   static void ipl_scsi(void)
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index 12a0166aae..e07f87e690 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -68,7 +68,7 @@ typedef struct ComponentEntry {
>       ScsiBlockPtr data;
>       uint8_t pad[7];
>       uint8_t component_type;
> -    uint64_t load_address;
> +    uint64_t psw;

I'd recommend to keep the load_address name. It's the same name as used 
in the zipl sources, and as far as I can see, the field does not always 
contain a PSW.

>   } __attribute((packed)) ComponentEntry;
>   
>   typedef struct ComponentHeader {
> 

  Thomas


