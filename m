Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB527C38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991682176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2bgDj4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991682176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45499 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MIj-0007UG-Qc
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6MCS-0005DH-GS
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6MCR-00081K-27
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:27:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6MCQ-00081B-Uh
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582583258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/bhLlUaegbPTgpi7EfZNYcItXc4X61pYVfJMcXzAxHE=;
 b=F2bgDj4Avi5MFUHl7Y3rM1BhytAtjwvH+WH8RwBKL6l42Mm8Qn/PtUJMZWGWzRnLfPWP2d
 fpGTu0b3blSdE9y33cn4HKxc/uupCPDhQCGEOrU9o9g0bpUCQ1UZKHuNplx4fkTOGWybVG
 YCB4XqYzG+JR+6s4kIfL4dSGexgv+m8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-HtNroUsFOBOiz4HoAYzREg-1; Mon, 24 Feb 2020 17:27:34 -0500
X-MC-Unique: HtNroUsFOBOiz4HoAYzREg-1
Received: by mail-qv1-f69.google.com with SMTP id r9so10567013qvs.19
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T0Cg1YgnFsah1w02/NREtZl8tIbELoF76y8DWWwzfDU=;
 b=uP8w/L9n0lwHhAQTgPu5DpjwhVj/eCSRAhhcSD7uqCJtXKLjcJKluvjPoZe4wl9OLu
 uQ1J+r2w9k/va86aafCwUSAqLXbtxzLwkOfSevdx7t3qRHEx/Jp/LXFPqgFUTGJ3R6ey
 Vm6GoSdi4sdjDELHlfH5oxE4sc/KG+yYHCsk7tOPOM4Zp/UXGrD9kzC00LAGsWql5qlM
 F/y4DO83f5j9cXuFoTxSyWuAC7i4QEORFxb8BOSmX7fiIDIbRzJoQGf6gbj2ZEvMrs6V
 UTWdNvZG9j9kh0E3bJradRVySJ+T6rKwBKXznG+bkidSuWxyotKwBD+zOhXwSe9064Ts
 j9dA==
X-Gm-Message-State: APjAAAWh6I0/ism3TgfuVlrJGPTe6IDiJ7e6/33sv0/CnlbaqYzaXTbb
 K+wwLUC6NHxDHjtUpcCDK7M/NZQRamw1X8kBEW16YREs1cxOzovx+Y8SMS92PVaFGwUAogVEI/l
 d+SU+ELmDg6vNiLo=
X-Received: by 2002:ac8:4085:: with SMTP id p5mr50976010qtl.132.1582583254416; 
 Mon, 24 Feb 2020 14:27:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqyf+aSS1pfvBs8HWjO22FkxU1E9rGDkWw5pfVKCUlBVBUNA+sDYJLcz4Pk1hdlIgUUWv9Jtgw==
X-Received: by 2002:ac8:4085:: with SMTP id p5mr50975986qtl.132.1582583254223; 
 Mon, 24 Feb 2020 14:27:34 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id d5sm59553qke.105.2020.02.24.14.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:27:33 -0800 (PST)
Date: Mon, 24 Feb 2020 17:27:32 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 06/13] exec: Relax range check in
 ram_block_discard_range()
Message-ID: <20200224222732.GC113102@xz-x1>
References: <20200221164204.105570-1-david@redhat.com>
 <20200221164204.105570-7-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200221164204.105570-7-david@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 05:41:57PM +0100, David Hildenbrand wrote:
> We want to make use of ram_block_discard_range() in the RAM block resize
> callback when growing a RAM block, *before* used_length is changed.
> Let's relax the check. We always have a reserved mapping for the whole
> max_length, so we cannot corrupt unrelated data.
>=20
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


