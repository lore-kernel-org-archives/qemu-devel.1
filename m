Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8A7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED41F2177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQHjhqGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED41F2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHPY-0007Kc-6z
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBHOw-0006TL-C5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:53:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29626
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBHOt-0008It-QS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598532786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IrcXHUT313JfdzoUXTD7PE3y99SPkBmWvVDaZExauKE=;
 b=LQHjhqGKH0wkgeE7m0Jg8mIdpn9EetiRctJK5lcYGDxJjtny60kKtJTXMlPnYmI8e+1Hz4
 3Umj8vAyB+/A3P0CMCOkOzCMXh1Y+1RfyOqsHEWSlfYmvRKYiKzhKzTqiG25slSXEMipmw
 JBWuTsxbpe6LgQpGWTCK3GAitLji++Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-Lc1QO1MfM6G7qMwEam-B7w-1; Thu, 27 Aug 2020 08:53:02 -0400
X-MC-Unique: Lc1QO1MfM6G7qMwEam-B7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF7C980BCB0;
 Thu, 27 Aug 2020 12:53:01 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B9781974D;
 Thu, 27 Aug 2020 12:52:56 +0000 (UTC)
Subject: Re: [PATCH RFC v2 3/4] pc-bios: s390x: Save io and external new PSWs
 before overwriting them
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200827093152.3026-1-frankja@linux.ibm.com>
 <20200827093152.3026-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c5190ed1-a4f9-45c3-97b3-4924cff5da31@redhat.com>
Date: Thu, 27 Aug 2020 14:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827093152.3026-4-frankja@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/08/2020 11.31, Janosch Frank wrote:
> Currently we always overwrite the mentioned exception new PSWs before
> loading the enabled wait PSW. Let's save the PSW before overwriting
> and restore it right before starting the loaded kernel.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> Maybe we should rather statically allocate a lowcore so we don't dirty
> 0x0 at all.
> 
> ---
>  pc-bios/s390-ccw/jump2ipl.c |  3 ++
>  pc-bios/s390-ccw/start.S    | 62 +++++++++++++++++++++++++++----------
>  2 files changed, 48 insertions(+), 17 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index 143d027bf7..a44f3ab5b3 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -13,12 +13,15 @@
>  #define KERN_IMAGE_START 0x010000UL
>  #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>  
> +extern uint64_t *psw_save_io, *psw_save_ext;

I think that should be

 extern uint64_t psw_save_io[], psw_save_ext[];

instead ... otherwise you'll end up with some funny bugs here, won't you?

>  uint64_t *reset_psw = 0, save_psw, ipl_continue;
>  
>  static void jump_to_IPL_2(void)
>  {
>      /* Restore reset PSW and io and external new PSWs */

Ok, now the comment makes sense :-)

>      *reset_psw = save_psw;
> +    memcpy((void *)0x1f0, psw_save_io, 16);
> +    memcpy((void *)0x1b0, psw_save_ext, 16);

Could you use &lowcore->external_new_psw and &lowcore->io_new_psw
instead of the magic numbers?

 Thomas



