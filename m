Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5531FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 19:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA492176B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 19:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgBirmi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA492176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxbEu-0006G9-BQ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 15:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jxbEB-0005Lf-Ol
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 15:13:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jxbE9-0002Hq-6i
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 15:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595272408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6u9s9wn88PVbUIM3a37ZCZ1nVXwP0BvlwR9fyqOkofg=;
 b=RgBirmi4QQquDnSThSWtfwfrTFsOOMpIB1/BzYEy8fFMu9cqe8AezR+AsoYVUL/8fsm1Qd
 FiDLdK+rahEsiqkGdECpJot2b3Iy6X4taSqBXXrXA1nHKufysQqtSsA4waI72GgwjqMdaX
 xZdU+auHqlZVe6aOBWOY1MLAnG9lS40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-Ctypq_c9ODGO346ohjPxQQ-1; Mon, 20 Jul 2020 15:13:26 -0400
X-MC-Unique: Ctypq_c9ODGO346ohjPxQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6880F8014D4;
 Mon, 20 Jul 2020 19:13:25 +0000 (UTC)
Received: from work-vm (ovpn-114-140.ams2.redhat.com [10.36.114.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32A286FDD1;
 Mon, 20 Jul 2020 19:13:21 +0000 (UTC)
Date: Mon, 20 Jul 2020 20:13:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, dhildenb@redhat.com
Subject: Re: [PATCH 2/3] exec: posix_madvise usage on SunOS.
Message-ID: <20200720191318.GM2642@work-vm>
References: <CA+XhMqwtUrSpCqNGEETBijewzvmpno8OAX_PKSShDP_gUQ-3VQ@mail.gmail.com>
 <CAFEAcA96mh_4EkKz31HgzfPOEQvhta8VTcvMV=An8Us0+x=NfQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA96mh_4EkKz31HgzfPOEQvhta8VTcvMV=An8Us0+x=NfQ@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 David CARLIER <devnexen@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(Copies in Dave Hildenbrand)

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Sat, 18 Jul 2020 at 14:21, David CARLIER <devnexen@gmail.com> wrote:
> >
> > From a9e3cced279ae55a59847ba232f7828bc2479367 Mon Sep 17 00:00:00 2001
> > From: David Carlier <devnexen@gmail.com>
> > Date: Sat, 18 Jul 2020 13:29:44 +0100
> > Subject: [PATCH 2/3] exec: posix_madvise usage on SunOS.
> >
> > with _XOPEN_SOURCE set, the older mman.h API based on caddr_t handling
> > is not accessible thus using posix_madvise here.
> >
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  exec.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/exec.c b/exec.c
> > index 6f381f98e2..0466a75b89 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -3964,7 +3964,15 @@ int ram_block_discard_range(RAMBlock *rb,
> > uint64_t start, size_t length)
> >               * fallocate'd away).
> >               */
> >  #if defined(CONFIG_MADVISE)
> > +#if !defined(CONFIG_SOLARIS)
> >              ret =  madvise(host_startaddr, length, MADV_DONTNEED);
> > +#else
> > +        /*
> > +         * mmap and its caddr_t based api is not accessible
> > +         * with _XOPEN_SOURCE set on illumos
> > +         */
> > +            ret =  posix_madvise(host_startaddr, length, POSIX_MADV_DONTNEED);
> > +#endif
> 
> Hi. I'm not sure this patch will do the right thing, because
> I don't think that Solaris's POSIX_MADV_DONTNEED provides
> the semantics that this QEMU function says it needs. The
> comment at the top of the function says:
> 
>  * Unmap pages of memory from start to start+length such that
>  * they a) read as 0, b) Trigger whatever fault mechanism
>  * the OS provides for postcopy.
>  * The pages must be unmapped by the end of the function.

This code has moved around a bit over it's life; joining the case
needed by balloon and the case needed by postcopy.

> (Aside: the use of 'unmap' in this comment is a bit confusing,
> because it clearly doesn't mean 'unmap' if it wants read-as-0.
> And the reference to faults on postcopy is incomprehensible
> to me: if memory is read-as-0 it isn't going to fault.)

I think because internally to Linux the behaviour is the same;
this causes the mapping to disappear from the TLB so it faults;
normally when reading the kernel resolves the fault and puts
a read-as-zero page there, except if userfault was enabled
for postcopy, in which case it gives us a kick and we service it.

> Linux's madvise(MADV_DONTNEED) does guarantee us this
> read-as-zero behaviour. (It's a silly API choice that Linux
> put this behaviour behind madvise, which is supposed to be
> merely advisory, but that's how it is.)

Yes, I don't think there's any equivalent to madvise
that guarantees anything.

> The Solaris
> posix_madvise() manpage says it is merely advisory and
> doesn't affect the behaviour of accesses to the memory.
> 
> If posix_madvise() behaviour was OK in this function, the
> right way to fix this would be to use qemu_madvise()
> instead, which already provides this "if host has
> madvise(), use it, otherwise use posix_madvise()" logic.
> But I suspect that the direct madvise() here is deliberate.

Yes, but I can't remember the semantics fully - I think it was because
we needed the guarantee at this point (and even Linux's
posix madvise did something different??)

I've got a note saying we didn't want to use
qemu_madvise because we wanted to be sure we didn't get
posix_madvise.

> Side note: not sure the current code is correct for the
> BSDs either -- they have madvise() but don't provide
> Linux's really-read-as-zero guarantee for MADV_DONTNEED.
> So we should probably be doing something else there, and
> whatever that something-else is is probably also what
> Solaris wants.
> 
> We use ram_block_discard_range() only in migration and
> in virtio-balloon and virtio-mem; I've cc'd some people
> who hopefully understand what the requirements on this
> function are and might have a view on what the not-Linux
> implementation should look like. (David Gilbert: git
> blame says you wrote this code :-))

Dave

> 
> thanks
> -- PMM
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


