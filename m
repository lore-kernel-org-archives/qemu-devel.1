Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7624CC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402FC206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RS0wyjWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402FC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHyQ-0007vz-6m
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1ihHxm-0007XV-Ie
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1ihHxk-0006Ky-Qv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:52:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40725
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1ihHxk-0006Ic-Mc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576608771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8mIFHH54W0cyHvOWPvvFirXLciWH/WCxRRrxC49Sik=;
 b=RS0wyjWlJBimn47Mjt7Dms8dUR2di+iJizKfDBs3ObmPenr19IWTfnPUjfZHs10r2iIG0M
 KxNRjsm3rqQtEhFIeyycwFIldF4UAARnEC+4pPbEioRoH+FIPBnT1bdapWTIe9Ujkgdmz7
 xg6lfc1mID2hzJojOgKIRwsuyiVevKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-uon7GzVJN_ybOVll4U_6EA-1; Tue, 17 Dec 2019 13:52:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D85F1005513;
 Tue, 17 Dec 2019 18:52:48 +0000 (UTC)
Received: from x1.home (ovpn-116-53.phx2.redhat.com [10.3.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DD5C19C58;
 Tue, 17 Dec 2019 18:52:38 +0000 (UTC)
Date: Tue, 17 Dec 2019 11:52:37 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] memory: Do not allow subregion out of the parent region
 range
Message-ID: <20191217115237.18e7fc4c@x1.home>
In-Reply-To: <ab832e97-f583-c347-0b4d-0d2e11f6b2b3@redhat.com>
References: <20191214160223.20012-1-philmd@redhat.com>
 <da81a3e7-62a8-f46e-c12f-4dead2a9091f@redhat.com>
 <92bb8e12-3ece-9811-438b-8fa64d2bde66@redhat.com>
 <4a07cc6f-8762-145e-2b54-c61b0e287f19@redhat.com>
 <127AF076-D309-4952-B572-52587A93F46A@redhat.com>
 <c5c27111-efc5-0a05-bdbd-415533e5bc30@linaro.org>
 <CAFEAcA955AwoDiuYxm0mJKV1qzyBorAz06dqi0tg2kMBT9GMTA@mail.gmail.com>
 <ab832e97-f583-c347-0b4d-0d2e11f6b2b3@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: uon7GzVJN_ybOVll4U_6EA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 19:31:41 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 17/12/19 19:17, Peter Maydell wrote:
> > On Tue, 17 Dec 2019 at 16:57, Richard Henderson
> > <richard.henderson@linaro.org> wrote:  
> >>
> >> On 12/17/19 1:58 AM, Christophe de Dinechin wrote:  
> >>>
> >>>  
> >>>> On 17 Dec 2019, at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>>> Yes, the idea is that you could have for one version of the device
> >>>>
> >>>>   parent 0x000-0x7ff
> >>>>     stuff 0x000-0x3ff
> >>>>     morestuff 0x400-0x7ff
> >>>>
> >>>> and for another
> >>>>
> >>>>   parent 0x000-0x3ff
> >>>>     stuff 0x000-0x3ff
> >>>>     morestuff 0x400-0x7ff
> >>>>
> >>>> where parent is the BAR, and you can share the code to generate the tree
> >>>> underneath parent.  
> >>>
> >>> I can see why you would have code reuse reasons to do that,
> >>> but frankly it looks buggy and confusing. In the rare cases
> >>> where this is indented, maybe add a flag making it explicit?  
> >>
> >> The guest OS is programming the BAR, producing a configuration that, while it
> >> doesn't make sense, is also legal per PCI.  QEMU cannot abort for this
> >> configuration.  
> > 
> > Does guest programming of the PCI BAR size actually change the size
> > of the 'parent' region, or does it just result in the creation
> > of an appropriately sized alias into 'parent' ?  
> 
> Resizable BARs are not handled by the PCI host bridge but rather from
> the device itself, so the device is free to handle them either way.

More specifically, it's the responsibility of drivers within the guest
to resize the parent bridge aperture to make the extent of the BAR
accessible.  This does seem like an interesting way to implement a
resizable BAR in QEMU though.  Thanks,

Alex


