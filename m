Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5990C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE042072E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7hRW8+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE042072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1Yv-0006b5-FC
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO1F2-0008Qy-ER
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO1Ez-0001Lu-Lq
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601568932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RsLGJhXantaM/GrBJPH0dn3HgcePgCMBV2SxHRFx5RU=;
 b=E7hRW8+Ap3fpU+boRb8/LvKBcRVCu+U2Wv8WpdVTiJU+S5BzezJw/XDZmP3D7z2zm4joOq
 ly7qxM7rgizMDdVLHiGpm7+4fuAc3BkER70bDOXV8azGvzFkpgwDMZwsE3osPQBtSt/Niy
 HmwfC4dwK1TI5z3bk9/XYdGapatoYD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-NWq1SUhOOdymTGfu92pVWw-1; Thu, 01 Oct 2020 12:15:30 -0400
X-MC-Unique: NWq1SUhOOdymTGfu92pVWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6661E10BBED1;
 Thu,  1 Oct 2020 16:15:28 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26C5F5D9D3;
 Thu,  1 Oct 2020 16:15:24 +0000 (UTC)
Date: Thu, 1 Oct 2020 12:15:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 2/3] target/i386/cpu: Restrict some of feature-words
 uses to system-mode
Message-ID: <20201001161523.GG3717385@habkost.net>
References: <20201001144152.1555659-1-philmd@redhat.com>
 <20201001144152.1555659-3-philmd@redhat.com>
 <933089b7-a088-d142-bf0c-55cae3e9bd70@redhat.com>
 <53758e35-f596-8e17-12cf-58b1a81f98e3@redhat.com>
 <20201001153725.GD3717385@habkost.net>
 <0766785b-29a5-b145-2685-781fbee86add@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0766785b-29a5-b145-2685-781fbee86add@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 01, 2020 at 05:57:14PM +0200, Philippe Mathieu-Daudé wrote:
> On 10/1/20 5:37 PM, Eduardo Habkost wrote:
> > On Thu, Oct 01, 2020 at 05:27:32PM +0200, Philippe Mathieu-Daudé wrote:
> >> On 10/1/20 5:14 PM, Paolo Bonzini wrote:
> >>> On 01/10/20 16:41, Philippe Mathieu-Daudé wrote:
> >>>> The feature-words properties are not used in user-mode emulation,
> >>>> restrict it to system-mode.
> >>>>
> >>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> >>>
> >>> This seems a bit pointless honestly.  It's going to be a few KBs of code
> >>> at most.  I would end the work with the patches that have already been
> >>> queued.
> >>
> >> I'll let Eduardo and you discuss that, as he suggested the #ifdef
> >> instead of the stub. The two options are on the list, whichever
> >> you guys prefer :)
> > 
> > Having neither the stub or the #ifdef is even better.  :)
> > 
> > I assumed the stub was necessary as a means for an end, but now I
> > don't understand why the stub was necessary in the first place.
> 
> x86_cpu_get_feature_words() calls QAPI-generated
> visit_type_X86CPUFeatureWordInfoList().
> 
> Since "Only qemu-system-FOO and qemu-storage-daemon provide QMP
> monitors", this code is unreachable on user-mode.

This is true, but you are shaving a tiny fraction of
target/i386/cpu.c code unreachable in user-mode.  I agree with
Paolo that it's pointless.

> 
> I tried to get a "no ifdef/no stub" codebase by not removing the
> QAPI uses from user-mode code, and build it without QAPI-generated
> files. I could only start the work and realized it is a huge effort.
> In particular since nobody sees the point of doing this cleanup...

I don't see the point of removing QAPI-generated files from
user-mode.  Long term, I'd expect to see more QAPI usage in QEMU,
which will probably include code used by user-mode.

-- 
Eduardo


