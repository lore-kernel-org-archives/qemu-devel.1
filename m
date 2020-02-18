Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044F5C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FA3207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxckuUU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FA3207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4B7H-0000c8-1a
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 17:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4B6S-0007wy-55
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4B6R-0003xV-3S
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:12:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50311
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4B6Q-0003w9-Tq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582063946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmoTZMF8Xmx7ar8KEl+dn5p1J0lvlbPGWproPqx0GUw=;
 b=TxckuUU+5eRO0EyODKFI59fwKtLpNqSxrx8swuGoM65blMEBSydx2FAd7YgTp/yKCl1Rsm
 o7xEY6b96YcudNfy1B+rhh3G9arbHTlYFTJunUlKKTUkW+2LGTE39hwFYF0yri3fBOs9Qx
 NHF0Qz/+1BpkIU+S5/E8VjhLPhAo65U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-kHVw1U71PE2l0lssiJqdgw-1; Tue, 18 Feb 2020 17:12:24 -0500
Received: by mail-qv1-f72.google.com with SMTP id z9so13314011qvo.10
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 14:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UXavvNb1MxcYpzDOPGA1i97GTq+rl4+fY2oulbKg/U8=;
 b=M5ycfXiLHlcstECdjOyimFrWOV9JXKGfcOLbBbqu7HMiyshAT3hRfUJPk3ew8FQQnQ
 ZTJGnL9nQtOSm1rnBrXUzQP5jQl7Z2Kw4g/1WLyayiLuAc5Mj9/sGWECKR6E/BPTEyLN
 OzQ4DrcodexfZ3Fh/KLMKa4Ege/MIet7PQ12AQxYauOKtNaiwpImQXl9KY8M+U8BycXp
 M2fGjhJhSFc0eZFnBej/0dMc3bK3E1TTS8tfhWsASuRjtyDAkbtwH0kv8Wn1aea1aHYj
 hEY+tSkvnXgYU/UYYnQdsQsEXxi7+zs3MSuPF7oLj03zHGO3ZwsZv1/hroHGgdYuDlCK
 hhQw==
X-Gm-Message-State: APjAAAXYMczYlWkQPfzqdLyBAUm5tTveMBflL1HJ9YxdtjtWHtHKwSN9
 J83kXZ7cb5qub0277tw2gHGzkvjLZ9bOE/SJSF3rMAWRgD7zMya/2L72dAtcw4U4ouO0RJ+67Vn
 HbPrJx+LN8eFwbm4=
X-Received: by 2002:a05:620a:909:: with SMTP id
 v9mr20469815qkv.138.1582063944147; 
 Tue, 18 Feb 2020 14:12:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsaABE4LaUJlpchYRU8vI9BR5GobaV6UqaK4wrz09Ox2QQmtEC19horFdP5EftiHT5NuYRoQ==
X-Received: by 2002:a05:620a:909:: with SMTP id
 v9mr20469804qkv.138.1582063943944; 
 Tue, 18 Feb 2020 14:12:23 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id u13sm2485077qtg.64.2020.02.18.14.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 14:12:23 -0800 (PST)
Date: Tue, 18 Feb 2020 17:12:22 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 07/16] exec: Drop "shared" parameter from
 ram_block_add()
Message-ID: <20200218221222.GK7090@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-8-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-8-david@redhat.com>
X-MC-Unique: kHVw1U71PE2l0lssiJqdgw-1
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 02:42:45PM +0100, David Hildenbrand wrote:
> Properly store it in the flags of the ram block instead (and the flag
> even already exists and is used).
>=20
> E.g., qemu_ram_is_shared() now properly succeeds on all ram blocks that a=
re
> actually shared.
>=20
> Reviewed-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


