Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DFAC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C673E222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVia16eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C673E222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7FuT-0005o0-T8
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j7FtN-0005BH-Gh
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j7FtM-0005io-5M
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:55:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j7FtM-0005fN-0i
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582797338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRkSk9p71W/dW44bmSehGNilAKN5djPv3MUECmdCrOU=;
 b=jVia16eoKlsI/HWKd4AvtzFOV558uH6g4EiRKMvC9xI8PolcFXObsU1EtVvmLQRTB4YhnX
 jREokxofyT0kh1NfM2M7ePLi3sqG15NTfgV/oe94eR37z96Cxpgx2XY+kYc2hno7fA7Xn0
 mRr/DEPsDYsmCGFae5XrV5/K9VZjU3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-6Yu-G8naP8iINRfbLCplNg-1; Thu, 27 Feb 2020 04:55:36 -0500
X-MC-Unique: 6Yu-G8naP8iINRfbLCplNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BE2E100726A;
 Thu, 27 Feb 2020 09:55:35 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6D1D9298D;
 Thu, 27 Feb 2020 09:55:33 +0000 (UTC)
Date: Thu, 27 Feb 2020 10:55:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] softmmu/vl.c: fix too slow TCG regression
Message-ID: <20200227105532.0b4c730a@redhat.com>
In-Reply-To: <CAFEAcA9BTrC_OOTRboydOFn6GFsyKzqUNEExw5VRXmRsYvoXYA@mail.gmail.com>
References: <20200226163539.31960-1-imammedo@redhat.com>
 <CAFEAcA9BTrC_OOTRboydOFn6GFsyKzqUNEExw5VRXmRsYvoXYA@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 09:15:00 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 26 Feb 2020 at 16:35, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > Commit a1b18df9a4 moved -m option parsing after configure_accelerators()
> > that broke TCG accelerator initialization which accesses global ram_size
> > from size_code_gen_buffer() which is equal to 0 at that moment.
> >
> > Partially revert a1b18df9a4, by returning set_memory_options() to its
> > original location and only keep 32-bit host VA check and 'memory-backend'
> > size check introduced by fe64d06afc at current place.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >
> > PS:
> > This should take care of regression and give more time to think about
> > how to remove size_code_gen_buffer() dependency on ram_size  
> 
> > +    if (current_machine->ram_memdev_id) {
> > +        Object *backend;
> > +        ram_addr_t backend_size;
> > +
> > +        backend = object_resolve_path_type(current_machine->ram_memdev_id,
> > +                                           TYPE_MEMORY_BACKEND, NULL);
> > +        backend_size = object_property_get_uint(backend, "size",  &error_abort);
> > +        if (backend_size != ram_size) {
> > +                error_report("Size specified by -m option must match size of "
> > +                             "explicitly specified 'memory-backend' property");
> > +                exit(EXIT_FAILURE);
> > +        }
> > +        ram_size = backend_size;  
> 
> Why do we do this assignment? We've just checked that
> backend_size == ram_size so the assignment won't do
> anything, will it?
> 
> In the version of this check in set_memory_options()
> the assignment was useful because the error check
> only happened if mem_str is not NULL, ie there was
> an explicitly specified 'size' option somewhere. It
> looks like now we require the backend size to match
> even if the size is not explicitly specified by the
> user but comes from some default somewhere?

Size might come from default and in that case mem_str
was skipping the check and updating ram_size with backend's 
value.
So this patch is not correct, as it is breaking the case
where no "-m" was specified and explicit backend was
provided.



> 
> thanks
> -- PMM
> 


