Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A6CC4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1A32084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0VjLWaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1A32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6zD7-0003Wz-R2
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 11:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6zCW-000359-Ox
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6zCU-0002Jo-4N
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:06:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44251
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6zCT-0002J8-Vb
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582733177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XSczUtV593mAGg6Yr6Y23L8DkGtKRX8uouEnGZkQyw=;
 b=A0VjLWafAjFhfzNFTljE6saKEpx/tMGu2RwyIkfSd7lOnrHwqkRLdER5mIDZyr7wpoZ2/+
 8SHh2W2MviIXfgoT4eLnynJLZcqcHn1hFzMAKEl6QjVsJX4aCjRkKt6wSV8TDup+T9OZSj
 aELBS7AkkLE1SG2oCJfcUSdyybfaIcI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-TIANMEDDOOq_guEfpgBcVA-1; Wed, 26 Feb 2020 11:06:15 -0500
X-MC-Unique: TIANMEDDOOq_guEfpgBcVA-1
Received: by mail-qv1-f72.google.com with SMTP id g15so4323023qvk.11
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 08:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Uozqmnu3LajKHZOhnTSczLp8E+oORO/cueVtor9d74Q=;
 b=cm3Xe0H+eO1mzCngNCxc9XUWNU6lhpvQDs70sCS5Bgcl80qEXfTrGL9yOxny3PLsqm
 +8MEt1yCcQIaCii6K7RC+klcvpC/oJYeBsfAXOCAnmrzx7VTRFK8uj6Sbdbwi4ihPnxz
 T8i9fJjffVXSq5CojhHOq/JHcglR9MLOoxnQZAKOS3q8FXeuBmUXiTAT2S+iVQRqZLq3
 i/cAt3HNsHzP9bnzecz8xNQLLmyLACq2iO9cNfFPbTt968pzwOkd9Wf3m1WiMZcONOMI
 jSkR0lWh6XmDV36h6P7SuwehNQXEpIvrrkjNth4gy9oS/jx9sypjJ3fV0TkC02BeKf6c
 VNwA==
X-Gm-Message-State: APjAAAUopE7eSLQGELTOtr2+g95t+385LTIktcc/6XrAU3crEMH5GSp3
 Ey+Y+03S2ZtavWaHEPnCWBeAb9OWOFC4AxJd+AbzBIuEuOjKWjWDVtb3/Owi/jJh3qyeXPS15tu
 zHw6Tpt7saWEgN7w=
X-Received: by 2002:a37:92c4:: with SMTP id u187mr1177781qkd.466.1582733174765; 
 Wed, 26 Feb 2020 08:06:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuVT8DEvxaqJckR3wjRauS1X1h1Ga0lvapeZo8+tL7Xj6FEZIg0xdRDS5N35/ILIq9FMXSrg==
X-Received: by 2002:a37:92c4:: with SMTP id u187mr1177755qkd.466.1582733174548; 
 Wed, 26 Feb 2020 08:06:14 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id b25sm1348460qkh.6.2020.02.26.08.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 08:06:13 -0800 (PST)
Date: Wed, 26 Feb 2020 11:06:11 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 13/13] migration/ram: Tolerate partially changed
 mappings in postcopy code
Message-ID: <20200226160611.GC140200@xz-x1>
References: <20200226155304.60219-1-david@redhat.com>
 <20200226155304.60219-14-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226155304.60219-14-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 04:53:04PM +0100, David Hildenbrand wrote:
> When we partially change mappings (esp., mmap over parts of an existing
> mmap like qemu_ram_remap() does) where we have a userfaultfd handler
> registered, the handler will implicitly be unregistered from the parts th=
at
> changed.
>=20
> Trying to place pages onto mappings where there is no longer a handler
> registered will fail. Let's make sure that any waiter is woken up - we
> have to do that manually.
>=20
> Let's also document how UFFDIO_UNREGISTER will handle this scenario.
>=20
> This is mainly a preparation for RAM blocks with resizable allcoations,
> where the mapping of the invalid RAM range will change. The source will
> keep sending pages that are outside of the new (shrunk) RAM size. We have
> to treat these pages like they would have been migrated, but can
> essentially simply drop the content (ignore the placement error).
>=20
> Keep printing a warning when we hit EINVAL, to avoid hiding other
> (programming) issues. ENOENT is unique.
>=20
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


