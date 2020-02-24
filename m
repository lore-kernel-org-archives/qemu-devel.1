Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE96AC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B655B20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vm01woji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B655B20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MOF-0005OQ-U2
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6MD1-00062j-QX
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6MCz-0008BB-MY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:28:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6MCz-0008Au-Ha
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582583292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zgI1K+21peNRJDmnDadGsOvelt93XQuoWiPQeH5ctyI=;
 b=Vm01wojig9notzgV9uWO/27Q3kUdT3T6KmfNamkGOdU1RRvrY8o2ORN53kDfMHs2QOREFt
 H/TJ9uCn+DUtVqpwYp5GrHLc6bkC7/E3wXqc+6Kqsa8KcwbDrsvmzIM6uE7aqFxM1xzsYf
 gf9LNs2aSWHSmd2SHRrfSkVH9MuTPCc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-tqBPDoZpP12uaH8XuM8Y3Q-1; Mon, 24 Feb 2020 17:28:10 -0500
X-MC-Unique: tqBPDoZpP12uaH8XuM8Y3Q-1
Received: by mail-qt1-f200.google.com with SMTP id t4so12376392qtd.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=olLjovBa1OUDw4zqoxz3s1flPeig+b61lXv7UqNAknY=;
 b=DSsgLHknEN8lndcCHnsKO97O9PqtUjWB/ITUiQXnORrLa54PwjNQ5Ofmyic3PkThnA
 AnCXqjpTJznDY/59tVbr3+KhKK8T5RfKIqQIb5VcNyH/3czuAM/Eqh/2XdKiDgqE++N8
 emD+Q2h7AUEOhog+jv0qBOo2nKvlRDA7NT8+9z22jgAzw6AVnezY+lAa3pp+5R39ewsK
 XIZk8e+4KWS83yFeSZWrPHDtE+sE9eAP134ZlYmYzM0cYWEsQvN0CbIEmbwPNC4voPvg
 tMwsrlEFWLIJva7AQH62HkBe9PmdbajWd86UGFEuFpzxg0MH5BtMjoQtMxA+PIn4LfjX
 gIvw==
X-Gm-Message-State: APjAAAVD1cb7Yi025n6M9LcbCZQmwSA7dEqhDtdEiFjI52zz5HpBBt3S
 lq6M1NtAXadj19ECxA5jYUXLyC+hobsp9WgEulLpfFdo9V5TNQqYyCs/dM+/bSR9DFMO6f+2iFj
 1d/SmRc+cqvf9hzc=
X-Received: by 2002:aed:2266:: with SMTP id o35mr50250275qtc.392.1582583289881; 
 Mon, 24 Feb 2020 14:28:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHMhrwa4OWzkQCr8ve81WReztE7GcW2JtmBOOFZZk4TbpQbSj111jWOaKr+BtngR10iUtvEQ==
X-Received: by 2002:aed:2266:: with SMTP id o35mr50250261qtc.392.1582583289679; 
 Mon, 24 Feb 2020 14:28:09 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id o16sm1318176qke.35.2020.02.24.14.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:28:08 -0800 (PST)
Date: Mon, 24 Feb 2020 17:28:07 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 07/13] migration/ram: Discard RAM when growing RAM
 blocks after ram_postcopy_incoming_init()
Message-ID: <20200224222807.GD113102@xz-x1>
References: <20200221164204.105570-1-david@redhat.com>
 <20200221164204.105570-8-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200221164204.105570-8-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 05:41:58PM +0100, David Hildenbrand wrote:
> In case we grow our RAM after ram_postcopy_incoming_init() (e.g., when
> synchronizing the RAM block state with the migration source), the resized
> part would not get discarded. Let's perform that when being notified
> about a resize while postcopy has been advised, but is not listening
> yet. With precopy, the process is as following:
>=20
> 1. VM created
> - RAM blocks are created
> 2. Incomming migration started
> - Postcopy is advised
> - All pages in RAM blocks are discarded
> 3. Precopy starts
> - RAM blocks are resized to match the size on the migration source.
> - RAM pages from precopy stream are loaded
> - Uffd handler is registered, postcopy starts listening
> 3. Guest started, postcopy running
> - Pagefaults get resolved, pages get placed
>=20
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


