Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE39C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DB121D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJHEDmDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DB121D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j74TD-00040K-8f
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 16:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j74SV-0003SF-M6
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j74ST-0001Vn-T7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:43:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49827
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j74ST-0001Sa-Jz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582753388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d8UFU7LACjbl7GOakU0eK1xtN0+bkdSm5FZppkMQJcA=;
 b=MJHEDmDVgVszHBtEmmteZiT03D0AC3UBf8rMPr751qSXZcWXoOedHAVQT6d0YWxaKCCuEy
 Zl48GUTSqEXAfpXMqHTZ+0od3qP1P1UoNqY0q7r83inhYjcDGpJrkQc3L2QbRce2Fk0qa3
 kpLfSWx8VJ7d8OVpIcH7uBgzcRJJ4xU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-Yj4vFq6oOgGviOUQ4k8-1g-1; Wed, 26 Feb 2020 16:43:07 -0500
X-MC-Unique: Yj4vFq6oOgGviOUQ4k8-1g-1
Received: by mail-qv1-f72.google.com with SMTP id l1so880330qvu.13
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 13:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FTPRBXY2Ub1X/FK6561PHf1BKgQVQN/ZdThkc+uN2Ec=;
 b=imOZsMNdOzgWfif3Jv7uqBAavLifmtjj7lKRzxxcwSaT2hlktfiS2j8qK1emtucxXu
 7mwgvXsGc7mIG+fNPWjfQxtO3UDAkdKhc+291u/0LAZ7gLDMJg2aHStPQ5iuqjYC3ST5
 4dh7h7gdxfIiMI2VGATxlvLAZL93KgR3R+TVcZvZjD2mj4rjClpgy/eDs0td8Msl5NDp
 0oNKxGRt4s70kdDRDftCJGIUCT4OfliOx0J64R1JX2JzhcbXvNSDWRpYNndfUur4UZRn
 OyghLWjmsav0lYPNLeHAByZGFDXt6w+p8Nb6xBxjuM5xP8wy4DyYMKzkglBYFkl/xniD
 CA7A==
X-Gm-Message-State: APjAAAWyyQsU1Ys04RgM7eNjpvLPTuKbTKHZ+9sn7Jtx+AhUBXykkLt/
 +MUhCh5h+wzEYacVQnpn4rQRjUlfYB7fK4Ff244n78CswF61dXEsCCGUxOk3+wq9k65ujzxV6jc
 KoOVu733fZsYbKVc=
X-Received: by 2002:a05:6214:a48:: with SMTP id
 ee8mr1340941qvb.90.1582753386526; 
 Wed, 26 Feb 2020 13:43:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXoYRp8cm5ORMAV4UDyxKHuAm4M6pgK2T42Gzs6Wq2yVGDgkWh8H3Es/y3o0kkjYFkfS67bw==
X-Received: by 2002:a05:6214:a48:: with SMTP id
 ee8mr1340921qvb.90.1582753386334; 
 Wed, 26 Feb 2020 13:43:06 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id v10sm1847664qtj.26.2020.02.26.13.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 13:43:05 -0800 (PST)
Date: Wed, 26 Feb 2020 16:43:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] hw/i386/intel_iommu: Simplify
 vtd_find_as_from_bus_num() logic
Message-ID: <20200226214304.GC180973@xz-x1>
References: <20200226201030.22583-1-philmd@redhat.com>
 <20200226202054.GA180973@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200226202054.GA180973@xz-x1>
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
Cc: Liu Yi L <yi.l.liu@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 03:20:54PM -0500, Peter Xu wrote:

[...]

> (However we'll need to read below after all... :)
>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>

As pointed out by Eric: it seems this patch cannot apply too...  I
think it's the extra "git diff -w" output that confused git-am.

Phil, would you mind repost without those?  My r-b stands if the
content keeps the same.

Thanks,

--=20
Peter Xu


