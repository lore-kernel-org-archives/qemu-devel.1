Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA0DC2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C08B206F5
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpXfIyxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C08B206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLigp-0008Vk-IE
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 03:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jLicF-0005TO-N9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jLicE-0003l4-7y
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:25:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44090
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jLicE-0003jT-4Q
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586244345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFLoFf2Zz2S4HXM+15Zcf1ZXm7YCuHDUwF3z0XzR934=;
 b=YpXfIyxdABo7Y1XE/1RxS6z8zgtyuV+aoTBt28DrPLQumDRAV/9yv7NSQU+JlKP/TQyYoV
 l+M7ycI52obacHtqw6FLCdRsJ8xQybWP0ATvHX7DPRnpfZ8ko6P5ts6ReRP9AnUrhXb6eR
 U+ygs8k9FHixGaAhoro8j7VABd3RbU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-iH-BjwjGPri-lzxGtNRvwQ-1; Tue, 07 Apr 2020 03:25:42 -0400
X-MC-Unique: iH-BjwjGPri-lzxGtNRvwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 355EA107B7D4;
 Tue,  7 Apr 2020 07:25:41 +0000 (UTC)
Received: from gondolin (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 295255C64E;
 Tue,  7 Apr 2020 07:25:36 +0000 (UTC)
Date: Tue, 7 Apr 2020 09:25:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 5/8] pc-bios: s390x: Move panic() into header and add
 infinite loop
Message-ID: <20200407092534.2edb0276.cohuck@redhat.com>
In-Reply-To: <20200324150847.10476-6-frankja@linux.ibm.com>
References: <20200324150847.10476-1-frankja@linux.ibm.com>
 <20200324150847.10476-6-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 11:08:44 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> panic() was defined for the ccw and net bios, i.e. twice, so it's
> cleaner to rather put it into the header.

They were also slightly different, so unifying them makes sense.

> 
> Also let's add an infinite loop into the assembly of disabled_wait() so
> the caller doesn't need to take care of it.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c     | 7 -------
>  pc-bios/s390-ccw/netmain.c  | 8 --------
>  pc-bios/s390-ccw/s390-ccw.h | 7 ++++++-
>  pc-bios/s390-ccw/start.S    | 5 +++--
>  4 files changed, 9 insertions(+), 18 deletions(-)
> 

> @@ -91,6 +90,12 @@ bool menu_is_enabled_enum(void);
>  
>  #define MAX_BOOT_ENTRIES  31
>  
> +static inline void panic(const char *string)
> +{
> +    sclp_print(string);
> +    disabled_wait();
> +}
> +
>  static inline void fill_hex(char *out, unsigned char val)
>  {
>      const char hex[] = "0123456789abcdef";
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index aa8fceb19da2164a..35be141d8da38d07 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -47,8 +47,9 @@ memsetxc:
>   */
>  	.globl disabled_wait
>  disabled_wait:
> -        larl %r1,disabled_wait_psw
> -        lpswe   0(%r1)
> +        larl	%r1,disabled_wait_psw
> +        lpswe	0(%r1)
> +1:	j	1b
>  
>  
>  /*

Possibly dumb question: Does checking code now figure out correctly
that code flow does not continue after disabled_wait()?


