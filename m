Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF49C3404B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B658A207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQ3Vyg6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B658A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4B6J-0007Iq-TG
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 17:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4B4w-0006Dp-Bt
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4B4q-0000jg-DH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:10:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46201
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4B4p-0000gx-US
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582063846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aO2vfSgc4RejV9MuJi7FivSdXyl6Dpj4lMakkISqHGI=;
 b=PQ3Vyg6FcdpQ8yUX6LI6ZfwNdtOLJ/kr5ahEI9O6znCYxTJS28PqFlofDVwMCshPIiNDsS
 dtuwN+zIrz8RMPD1M6Ss4EE8r9PdzOovvFVn/ZhNmluhtzz/vw6yuS2F/QXG9mnQjxYaJ+
 eHFFGUFCzYlqLCOZuI5/jqwO4/l2GGI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-OQ273jh_PaGaYHmvuI9r9g-1; Tue, 18 Feb 2020 17:10:43 -0500
Received: by mail-qt1-f200.google.com with SMTP id p12so14100350qtu.6
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 14:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sh23cei6PO6aAYbTVqvMz/lrG3Kc7m4oFDumj3ynDso=;
 b=WwUizJWn2eVwvyNpVKoxCp4c+8x/dLEAZFUlbTMapZRP6HhcVDVFKySO7T9NatFgWe
 dALPEAawsRppi6hda41xI70u1FJLtKeMuHUYwm4a2dcVjK7uuud8cgOWkDqRem+pcmb5
 OXD+Tls1+fK1Dv0ofP9nUS7ZVfjCY6/AaZo6CvCnYWZEyj3w+QsUk+b2ohfXN4ADKbIE
 OeyK9wbTNOEek55kLK73jgoNT3ocuwahPGCZ0BOeoHs5oTmjf7NvvmY6JHh/UULD6kGz
 0UJuG7EPoxsl82BwCtulVe7EOUGCctViR+AlO+GttjvEM+Fo9jxzRQZWxF2ByzpwuYHA
 PqsA==
X-Gm-Message-State: APjAAAWCMpb2uf3Ncsnt0R50I+jaD3uzN2W2TdO9B23cOpKbN5zBRtR+
 J8LM9N0buQdsbqwY3yARSpevWIJVdGTtFCasa4sdBOKs4j5GJ/nkyGbydvlUfcjUoOyjDH/wLgp
 +rKEzqj/3MPEKYHA=
X-Received: by 2002:a05:620a:125c:: with SMTP id
 a28mr4047410qkl.49.1582063843367; 
 Tue, 18 Feb 2020 14:10:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyya1nICDzX+trLyvC6LpySTPGolZtCniYTvuAmhTw2JDzCnCCW/0g678Cj3UvlBC5qWWM5Dg==
X-Received: by 2002:a05:620a:125c:: with SMTP id
 a28mr4047391qkl.49.1582063843135; 
 Tue, 18 Feb 2020 14:10:43 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id n191sm12380qkn.6.2020.02.18.14.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 14:10:42 -0800 (PST)
Date: Tue, 18 Feb 2020 17:10:41 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 05/16] exec: Factor out setting ram settings
 (madvise ...) into qemu_ram_apply_settings()
Message-ID: <20200218221041.GI7090@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-6-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-6-david@redhat.com>
X-MC-Unique: OQ273jh_PaGaYHmvuI9r9g-1
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 02:42:43PM +0100, David Hildenbrand wrote:
> Factor all settings out into qemu_ram_apply_settings().
>=20
> For memory_try_enable_merging(), the important bit is that it won't be
> called with XEN - which is now still the case as new_block->host will
> remain NULL.
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


