Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009E0C4BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE42C206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbShZS8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE42C206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6zWp-0001eF-To
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 11:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6zWC-0001Cz-1w
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6zWA-0007Tv-Fx
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:26:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6zWA-0007Rc-Bi
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582734397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSQPY41LDxfyKmWpVXs6W61Vc9s4WVrHj9T9VN32iLc=;
 b=GbShZS8cZ4qZ9qpT+giRioKoO55P+Xi0J6K8agRBS1oAq2flEsppj9Cc0umgXE2+Fb1IzM
 DymhlMlI9LHLLDOTGXlmMA8bpAluuFDkNwTLlmwy80IcU8F7IQsH+L+eyRQlRoes5PFO1B
 qcQVF1eKgzgV95FEgcDopdLIDcFKRYA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-gzrOJwCqMPq6VpO-UhuRsw-1; Wed, 26 Feb 2020 11:26:33 -0500
X-MC-Unique: gzrOJwCqMPq6VpO-UhuRsw-1
Received: by mail-qk1-f200.google.com with SMTP id k194so1616512qke.10
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 08:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZP3jviO7g7tm6fzAOhRyhFClpiT+1aqk1Owak5LpGa4=;
 b=okYGIWNodyAlXnv+flrWqI4Ti3GL0g+oNeDEDPyDTb6C3TTudaR4PA/M+wYMv4vTxS
 oH3eFzkgIKa/xyx9UAQctRUL12h3x1SxcgfyVG6pz/aF2nz10UxUA5R0mbiKdY79WAFH
 PoQXBe79GDlMQAC1EMIMuqwzR4nZOL3kPRy8Z0+/VT8dVvNF7zYKwl+K9GExd+Jsx+tx
 QpHKDL1AHYBra5DOAQ8WXjD6UNBCPrxplsH5HddAJZ/4wDfgH4R7e4E2bdOWaVek2f3L
 2N4YvpHj2i24PRMa283PoAU/PzLDeFGixap+9qD5A0iFk85QB4xSQs4Ya655kmBIrm/0
 wl2g==
X-Gm-Message-State: APjAAAXHCMWICzTSPBWX3Swa5lyKaVSOsR10L/tRgogZNsPB3qhcSquR
 NH920loQMrH0Gh1WrrKmnKAPNfL3ipum82/tWoIJf7NCGxpte0ofvgz+N4bfDPvkY8lOgrkCJlt
 n2tonYPcsrhh8wSc=
X-Received: by 2002:a37:9e49:: with SMTP id h70mr6936562qke.40.1582734393296; 
 Wed, 26 Feb 2020 08:26:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3PmSYD8hxNmgxxRX826sBvInLyvBcxehRupTjsZ1rxfbemoMa1+NZSt4Qg2ZfYRymhNBk+g==
X-Received: by 2002:a37:9e49:: with SMTP id h70mr6936533qke.40.1582734393043; 
 Wed, 26 Feb 2020 08:26:33 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id g2sm1354823qka.42.2020.02.26.08.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 08:26:32 -0800 (PST)
Date: Wed, 26 Feb 2020 11:26:30 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 13/13] migration/ram: Tolerate partially changed
 mappings in postcopy code
Message-ID: <20200226162630.GD140200@xz-x1>
References: <20200226155304.60219-1-david@redhat.com>
 <20200226155304.60219-14-david@redhat.com>
 <20200226160611.GC140200@xz-x1>
 <85484919-1234-3191-49fe-54b2ba74178c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <85484919-1234-3191-49fe-54b2ba74178c@redhat.com>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 05:08:08PM +0100, David Hildenbrand wrote:
> On 26.02.20 17:06, Peter Xu wrote:
> > On Wed, Feb 26, 2020 at 04:53:04PM +0100, David Hildenbrand wrote:
> >> When we partially change mappings (esp., mmap over parts of an existin=
g
> >> mmap like qemu_ram_remap() does) where we have a userfaultfd handler
> >> registered, the handler will implicitly be unregistered from the parts=
 that
> >> changed.
> >>
> >> Trying to place pages onto mappings where there is no longer a handler
> >> registered will fail. Let's make sure that any waiter is woken up - we
> >> have to do that manually.
> >>
> >> Let's also document how UFFDIO_UNREGISTER will handle this scenario.
> >>
> >> This is mainly a preparation for RAM blocks with resizable allcoations=
,
> >> where the mapping of the invalid RAM range will change. The source wil=
l
> >> keep sending pages that are outside of the new (shrunk) RAM size. We h=
ave
> >> to treat these pages like they would have been migrated, but can
> >> essentially simply drop the content (ignore the placement error).
> >>
> >> Keep printing a warning when we hit EINVAL, to avoid hiding other
> >> (programming) issues. ENOENT is unique.
> >>
> >> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> Cc: Juan Quintela <quintela@redhat.com>
> >> Cc: Peter Xu <peterx@redhat.com>
> >> Cc: Andrea Arcangeli <aarcange@redhat.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >=20
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >=20
>=20
> Thanks a lot!
>=20
> BTW, while I am playing with userfaultfd, I already have patches to
> factor out all uffd handling from postcopy code into utils/uffd.c
>=20
> My list of patches does not seem to get any smaller :(

Simply because you're working on more things? :)

Thanks for working on this (and this is far better than the exit()
version, IMHO)!

--=20
Peter Xu


