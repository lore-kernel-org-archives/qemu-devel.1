Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF5DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983602082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSj1Ldg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983602082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCEQ-00033h-SM
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ixCDq-0002bn-9G
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ixCDp-0002Tt-7Y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:59:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ixCDp-0002TY-44
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580399952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RLPqIjzuMgorxYnRKPxXG639vgiDbvCGqcSSC/hg4CY=;
 b=BSj1Ldg5+8NiBim3xO6M4bNBgLP3xp8r9Q7R6zmzmT1gUR8ACihf8S6YGVrvEpDe4oAuVH
 p858nadVicg93V9PzEmYhIui1etk+7BpoNhaV9hBGAQJ1ij+7uk/owDRPRg2q88hHz2UbE
 yeLFCh7VvWbLeoQ0iyXQgyHOPjG4ggc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-nQAgdkUkMKSpHxta70KGKQ-1; Thu, 30 Jan 2020 10:58:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC0028018C3;
 Thu, 30 Jan 2020 15:58:54 +0000 (UTC)
Received: from gondolin (ovpn-117-199.ams2.redhat.com [10.36.117.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB44884BCE;
 Thu, 30 Jan 2020 15:58:50 +0000 (UTC)
Date: Thu, 30 Jan 2020 16:58:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] target/s390x/translate: Fix RNSBG instruction
Message-ID: <20200130165848.797e946a.cohuck@redhat.com>
In-Reply-To: <20200130133417.10531-1-thuth@redhat.com>
References: <20200130133417.10531-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nQAgdkUkMKSpHxta70KGKQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 14:34:17 +0100
Thomas Huth <thuth@redhat.com> wrote:

> RNSBG is handled via the op_rosbg() helper function. But RNSBG has
> the opcode 0xEC54, i.e. 0x54 as second byte, while op_rosbg() currently
> checks for 0x55. This seems to be a typo, fix it to use 0x54 instead,
> so that op_rosbg() does not abort() anymore if a program uses RNSBG.
> 
> I've checked with a simply test function that I now get the same results

s/simply/simple/

> with KVM and with TCG:
> 
>  static void test_rnsbg(void)
>  {
> 	uint64_t r1, r2;
> 
> 	r2 = 0xffff000000000000UL;
> 	r1 = 0x123456789bdfaaaaUL;
> 	asm volatile (" rnsbg %0,%1,12,61,16 " : "+r"(r1) : "r"(r2));
> 
> 	printf("r1 afterwards: 0x%lx\n", r1);
>  }
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1860920
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 0bd2073718..4f6f1e31cd 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3874,7 +3874,7 @@ static DisasJumpType op_rosbg(DisasContext *s, DisasOps *o)
>  
>      /* Operate.  */
>      switch (s->fields.op2) {
> -    case 0x55: /* AND */
> +    case 0x54: /* AND */
>          tcg_gen_ori_i64(o->in2, o->in2, ~mask);
>          tcg_gen_and_i64(o->out, o->out, o->in2);
>          break;

Thanks, applied.


