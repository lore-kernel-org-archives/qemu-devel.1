Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44614C5ACC4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7422464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBKP9SXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7422464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4YBv-0003VD-AF
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 17:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4YB8-0002rF-FI
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4YB7-0003Bf-Id
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:50:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4YB7-0003BI-EJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582152649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YNhX6ufw2Zgf+Q2VIYKxf9rpzRyLlEy09w4X70nijZ8=;
 b=aBKP9SXG7oyIBLeUOz98CJpHDVEffciO9FUsVtNM6dG0ZGBG54AOjA0OECkkCfFZo1QbcG
 Arw6eb2uve0UWHlpM7Aa7FfIenBum/qbotxFX6s2cp3MN8DxtgAi4XTkpazhGUgeVHo1m2
 abXKTjBa/NEAbg7NnRTk4ds9WcHm39w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-8bju_UYRM1WrBEmnfjHcJQ-1; Wed, 19 Feb 2020 17:50:47 -0500
Received: by mail-qk1-f200.google.com with SMTP id t186so1382610qkf.9
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 14:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jbKKySQXCC057hiGkLdyRhP51CJi2TMmTn97hX3LBdM=;
 b=VsISdcdK5Ht4SiW6JdAJYgm29SlPiOk3JnXx4Bygo0d3olbEuyGaBiVyDqmewEPAi/
 RRToq1/JJiymYCwa/UUqeJUpwKW9dMxdIUpjc6Oybp+yhZ0/T5/ETEWMSFzvfpwYNaeZ
 WU3QKlo/8sP61QBPyJJa1AjyvSpy3tpZEU5uTS2dX2z7Vtc+t0zZiR5IYktSsjioJ0Cg
 QPnIt8amG3h6Rwkf/+R06eS1yF/d3QplgAZrtOMAIl/jtCYiq82h+qkVHHl4uFt8xHA1
 Qc7LDF8ulmD3cbrkQJDnNaAxaFoUZkw5qc49UGT5kx7SfBYKzee4UZsCSJo21BeeC2Vu
 Z9+Q==
X-Gm-Message-State: APjAAAVOKZdGf/EGsho/EZoTnpadNUkXMLaojIOUtNFjlpVokvUVUoYP
 6SSzdSr3BL1q0p3eLxUnlsDY1REbnwHvJcu/SzKklVHFj6OkZ0OTWb8xPYEAqgVMdELh+C2uW4G
 t+AsGogKr1o75Xwk=
X-Received: by 2002:ac8:7357:: with SMTP id q23mr23832337qtp.12.1582152646821; 
 Wed, 19 Feb 2020 14:50:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyb3XlJsrsj8xnGrnOAk3klTnI3/bMGPtDnd9x6ohY8i/4f95Jj1pltimBmXJ3D4UrTQByiRQ==
X-Received: by 2002:ac8:7357:: with SMTP id q23mr23832322qtp.12.1582152646596; 
 Wed, 19 Feb 2020 14:50:46 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id b22sm622967qkk.20.2020.02.19.14.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 14:50:45 -0800 (PST)
Date: Wed, 19 Feb 2020 17:50:44 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 11/16] util/mmap-alloc: Prepare for resizable
 mmaps
Message-ID: <20200219225044.GD42076@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-12-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-12-david@redhat.com>
X-MC-Unique: 8bju_UYRM1WrBEmnfjHcJQ-1
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

On Wed, Feb 12, 2020 at 02:42:49PM +0100, David Hildenbrand wrote:
> @@ -178,13 +183,15 @@ void *qemu_ram_mmap(int fd,
>      size_t offset, total;
>      void *ptr, *guardptr;
> =20
> +    g_assert(QEMU_IS_ALIGNED(size, pagesize));

(NOTE: assertion is fine, but as I mentioned in previous patch, I
 think this pagesize could not be the real one that's going to be
 mapped...)

> +
>      /*
>       * Note: this always allocates at least one extra page of virtual ad=
dress
>       * space, even if size is already aligned.
>       */
>      total =3D size + align;
> =20
> -    guardptr =3D mmap_reserve(total, fd);
> +    guardptr =3D mmap_reserve(0, total, fd);

s/0/NULL/

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


