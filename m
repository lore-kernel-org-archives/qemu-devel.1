Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE16C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590F920838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gp0+l4XQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590F920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6tjP-0007VC-GF
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j6tiS-0006TW-Lz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j6tiR-0000WO-JG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:14:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20347
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j6tiR-0000UW-EB
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582712095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=om53qjwnSjS90lVeCMzUxfnCbW/2PR9vmbVCQeD5U9w=;
 b=gp0+l4XQNXoDEOJjz0C/HAwDhfyPuXKHZjT4hSFyQm491X3otRetvD1mymHgBiecGqGiQy
 Yd3DIxk6UYyxr5IpHeE+Z6tzhp7Ev62CThH5ZRbAA3WdUC4xw3cqB2fJp8RqoEtP4lD8Pw
 54CkmRqTKXjsAqVSAIBr/rqQ3bBXL0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-royBeu5qPTWcSnczuQIqMg-1; Wed, 26 Feb 2020 05:14:53 -0500
X-MC-Unique: royBeu5qPTWcSnczuQIqMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49A7A1005512;
 Wed, 26 Feb 2020 10:14:52 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C78B819C58;
 Wed, 26 Feb 2020 10:14:50 +0000 (UTC)
Date: Wed, 26 Feb 2020 11:14:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Subject: Re: Sudden slowdown of ARM emulation in master
Message-ID: <20200226111449.27530c6b@redhat.com>
In-Reply-To: <CABLmASFMv5MziuMKBdi0wydB9bKVZ-uYJ4_B_0a-YUQVk0nHYw@mail.gmail.com>
References: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
 <20200226101948.786be4b0@redhat.com>
 <CABLmASFMv5MziuMKBdi0wydB9bKVZ-uYJ4_B_0a-YUQVk0nHYw@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 10:32:38 +0100
Howard Spoelstra <hsp.cat7@gmail.com> wrote:

> On Wed, Feb 26, 2020 at 10:19 AM Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Wed, 26 Feb 2020 00:07:55 +0100
> > Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
> >  
> > > Hello Igor and Paolo,  
> >
> > does following hack solves issue?
> >
> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> > index a08ab11f65..ab2448c5aa 100644
> > --- a/accel/tcg/translate-all.c
> > +++ b/accel/tcg/translate-all.c
> > @@ -944,7 +944,7 @@ static inline size_t size_code_gen_buffer(size_t
> > tb_size)
> >          /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
> >             static buffer, we could size this on RESERVED_VA, on the text
> >             segment size of the executable, or continue to use the
> > default.  */
> > -        tb_size = (unsigned long)(ram_size / 4);
> > +        tb_size = MAX_CODE_GEN_BUFFER_SIZE;
> >  #endif
> >      }
> >      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
> >
> >  
> 
> Nice, for me, that brings qemu-system-ppc back up to speed. (applied to
> ppc-for-5.0)

thanks for confirming.

My patch a1b18df9a4 'vl.c: move -m parsing after memory backends has been processed'
moved ram_size parsing after accelerator init, but tcg allocates
buffer based on global ram_size and since ram_size is still 0 it
falls back to MIN_CODE_GEN_BUFFER_SIZE (see size_code_gen_buffer)
and if ram_size were too large it would cap buffet at
MAX_CODE_GEN_BUFFER_SIZE.

 *-user doesn't use ram_size, it uses DEFAULT_CODE_GEN_BUFFER_SIZE
and static buffer so it's no affected.

For softmmu it should be possible to postpone buffer allocation
till accel_setup_post(current_machine) time and fetch ram_size
from current machine dropping random access to global variable.
That would put buffer allocation after ram_size is parsed.

Does it look like a feasible approach?

> 
> Best,
> Howard


