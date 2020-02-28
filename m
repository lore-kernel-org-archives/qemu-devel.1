Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187E7C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6DC24695
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAGnnTW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6DC24695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7lYs-0004gq-3Z
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 14:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7lY3-0003Eu-Av
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7lY1-0004Ch-Ix
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:43:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7lY1-0004CU-El
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582919024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ou+sqBFy2GdFWCOiWVLjSCrVIHJVbMF19O/EQVKVtfU=;
 b=KAGnnTW3yMjKPufIePAsF8NWF0YNBsqTEUHaVig+t1y8Gl1hbrIIDQtNEMGNDB18OOG7oJ
 8T9FTg6mVzW9KrNgK73+vL8HBffkouLiEFVvKGJYk/6Jcp1L69VNvW4UCYhXsZbS0am1wg
 QsqdKuq9p7bKHlV4MSfbkEiFnmxH1pE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-bvdSh0NxN8iKhBzNqKsq5A-1; Fri, 28 Feb 2020 14:43:42 -0500
X-MC-Unique: bvdSh0NxN8iKhBzNqKsq5A-1
Received: by mail-qt1-f199.google.com with SMTP id z19so3074952qts.21
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 11:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PK+eHrYXvojt8dZV5knT2JBDL5dzv6jWl2NDfWw4BLI=;
 b=h0/5zGG8oFpqxTxBr8KErQ4eQ1yEggZlZdGP9Aopr3WmHaBRHNXNyWDJp1bB4t6ldT
 9rrsel/mW+zspXcct+d3CrxRkg5BD52Veqi8wJrqwkaBPcdztkjofzTLBtGa9Wb1NGwB
 pzJrhoSvbQsAIYD1nnu2GiHZ1Mur8ESIzCXuS3XY9M2MnyOu9xlmeJXcIHv+H3ETWGoS
 uP4SMoVYTbc87lSMWBMZDYPnvD0P1KDzkuhZx4e9NSyoUSAHSCXS96oeRvADS4ix/3/b
 0K83aU6B/V6xdhh5kk/UCh7H/UwqcVl3U9HDdp6Zc3M5UeM6SJdQF96+EsrujcJn2t1h
 8dyw==
X-Gm-Message-State: APjAAAVTXARsnobbmHLjnViV+N65yRXdYxC7r/t5yOR4LZoZnNztO9NF
 xR76fPvOvW/rGgNFGhSufEOHtj0ahdW8JkvIW0hhS4HY3ztUcJz8mfb3B10y27D8O/cURTNEf2f
 Fe2WDIqVX78J0hDw=
X-Received: by 2002:ad4:514e:: with SMTP id g14mr5191210qvq.196.1582919021954; 
 Fri, 28 Feb 2020 11:43:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyfR+1f6OgLZkZuqFfUB8c3dHR2YFbXqhw/br3C6WMZOzHNV12Gpy9r1Bjv+Db0RO/LHvMOaQ==
X-Received: by 2002:ad4:514e:: with SMTP id g14mr5191198qvq.196.1582919021782; 
 Fri, 28 Feb 2020 11:43:41 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id c27sm3222262qka.20.2020.02.28.11.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 11:43:41 -0800 (PST)
Date: Fri, 28 Feb 2020 14:43:39 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 11/15] util/mmap-alloc: Implement resizeable mmaps
Message-ID: <20200228194339.GX180973@xz-x1>
References: <20200227101205.5616-1-david@redhat.com>
 <20200227101205.5616-12-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227101205.5616-12-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 11:12:01AM +0100, David Hildenbrand wrote:
> Implement resizeable mmaps. For now, the actual resizing is not wired up.
> Introduce qemu_ram_mmap_resizeable() and qemu_ram_mmap_resize(). Make
> qemu_ram_mmap() a wrapper of qemu_ram_mmap_resizeable().
>=20
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


