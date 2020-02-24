Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C181FC11D30
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9292920880
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjrNFg5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9292920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6HjH-000297-Op
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6Heo-0006mK-Ee
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6Hem-0004lu-Tk
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:36:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23666
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6Hem-0004do-3u
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582565793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X29SxZQMJYzL5GU1cVVP3p7jYcp6YP450ZNOk6Soc1s=;
 b=JjrNFg5UYeO6ctOi7q19SgUKJmRU1gARXDTBFxV+we05ZWD/xirtt37ok4+h+bTWMjg+qI
 y1lwa5J3FyaEnBToW57IroWvifPbpOJdzG4B8/sAT4oT4ZJcwFxZrt1TeRQNBTipiRe0Fp
 lIRuJELPmqlyVcV7Tznepc4Rqp3WudA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-ltMS2VSWN8i0TDs4hFAkyw-1; Mon, 24 Feb 2020 12:36:31 -0500
X-MC-Unique: ltMS2VSWN8i0TDs4hFAkyw-1
Received: by mail-qt1-f200.google.com with SMTP id g26so11344815qts.16
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 09:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bOyOrdtUN0gfYNzBNj4JFIT8wCXJFBmYyVoMDuahFb8=;
 b=uYv+GW3HGe4KqFmKzMQA7SsePaJtbMabKpC+4gNMdTGbOFSjFlXT5qH8FXK8PkX+79
 OPo1SRijsqeAJsirwimE7n04Hjd065Y/nGB5oYc0Ihr5OCMjJ43nBWaGlRqs/d6scc7q
 3GZk+8eHtPxx15XRdRNaNL0d1QPKxARaxCV82l9lkf1rsvMKrm9UbR633c/0ZdZyyXe1
 tjo36eevPJOMyAYymq9AWjBiMMoKjyA7lZMwov9fQLjEdppsMJmJd6lrFgYZG+hd93oO
 8vM2w4KKsTCBnOR3C1xD8+QwQpiMFvPIQY6YNjFVQ+O9vglBGLSMYyL/u4m7zWYh6iNR
 NAsQ==
X-Gm-Message-State: APjAAAXN5mdLPMdCwOlmrew3SvBOop+b5M6tkdHgHmDqvTdNZtLWdOiH
 17hgG4Yhj1Sd2wse7ohfhJPWOC4nCBKcwhSQkEOsfznivHM0Gp5wiCUm+6R0tjMY2OD7Eudul1B
 XJzttm4NarPWuKsA=
X-Received: by 2002:a0c:c98c:: with SMTP id b12mr47116955qvk.240.1582565791315; 
 Mon, 24 Feb 2020 09:36:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1VFJHz00doJ3eCyc/ngtLe0fEdn65S/g2R21RGYTDtZAQTzapeZA+hi8uSzwYoFDbRq9tRQ==
X-Received: by 2002:a0c:c98c:: with SMTP id b12mr47116929qvk.240.1582565791122; 
 Mon, 24 Feb 2020 09:36:31 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id z18sm2435323qki.8.2020.02.24.09.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 09:36:30 -0800 (PST)
Date: Mon, 24 Feb 2020 12:36:28 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 08/16] util/mmap-alloc: Factor out calculation
 of pagesize to mmap_pagesize()
Message-ID: <20200224173628.GI37727@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-9-david@redhat.com>
 <20200219224616.GA42076@xz-x1>
 <94b76367-4730-33a8-59ba-6b1c978ec2ea@redhat.com>
 <7252629e-6290-5709-ea3c-d215622975ed@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7252629e-6290-5709-ea3c-d215622975ed@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 11:57:03AM +0100, David Hildenbrand wrote:
> On 24.02.20 11:50, David Hildenbrand wrote:
> > On 19.02.20 23:46, Peter Xu wrote:
> >> On Wed, Feb 12, 2020 at 02:42:46PM +0100, David Hildenbrand wrote:
> >>> Factor it out and add a comment.
> >>>
> >>> Reviewed-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> >>> Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> >>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >>> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> >>> Cc: Greg Kurz <groug@kaod.org>
> >>> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>> Cc: Igor Mammedov <imammedo@redhat.com>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>>  util/mmap-alloc.c | 21 ++++++++++++---------
> >>>  1 file changed, 12 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> >>> index 27dcccd8ec..82f02a2cec 100644
> >>> --- a/util/mmap-alloc.c
> >>> +++ b/util/mmap-alloc.c
> >>> @@ -82,17 +82,27 @@ size_t qemu_mempath_getpagesize(const char *mem_p=
ath)
> >>>      return qemu_real_host_page_size;
> >>>  }
> >>> =20
> >>> +static inline size_t mmap_pagesize(int fd)
> >>> +{
> >>> +#if defined(__powerpc64__) && defined(__linux__)
> >>> +    /* Mappings in the same segment must share the same page size */
> >>> +    return qemu_fd_getpagesize(fd);
> >>> +#else
> >>> +    return qemu_real_host_page_size;
> >>> +#endif
> >>> +}
> >>
> >> Pure question: This will return 4K even for huge pages on x86, is this
> >> what we want?
> >=20
> > (was asking myself the same question) I *think* it's intended. It's
> > mainly only used to allocate one additional guard page. The callers of
> > qemu_ram_mmap() make sure that the size is properly aligned (e.g., to
> > huge pages).
> >=20
> > Of course, a 4k guard page is sufficient - unless we can't use that
> > (special case for ppc64 here).
> >=20
> > Thanks!
> >=20
>=20
> We could rename the function to mmap_guard_pagesize(), thoughts?

Yeh this looks better.

Out of topic: Actually I'm still confused on why we'd need to do so
much to just leave an PROT_NONE page after the buffer.  If the
hypervisor is buggy, it can logically writes to anywhere after all.
It's not a stack structure but it can be any guest RAM so I'm not sure
overflow detection really matters that much...

Thanks,

--=20
Peter Xu


