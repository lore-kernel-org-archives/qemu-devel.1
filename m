Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26DDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D685246AE
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJPgl55s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D685246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7mmQ-0007p1-Rj
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7mlj-0007OK-Ht
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7mli-0002sU-J2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:01:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26236
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7mli-0002qr-F2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582923717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2icag08FOgOd5w1C9vmEmRmrQMw5rjM8ohwNYGZeGjk=;
 b=QJPgl55svnT3zEegh9TBP7otZcemHwpGQ9xN9BN9WcqMQwhGKObXlGdKWmTpKCrOAqMQuu
 IMlpHtS70xdrMcQyvzaa+roFnTtBoyDUoAAlvu0SIcEgwnHXWyhDck8K2pvaGFmPhFJVPs
 3KVsNY7bmSxR2lHRa2+6Rdq3fyyO5tA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-w9YcRUiiOqaoJIKkg231yA-1; Fri, 28 Feb 2020 16:01:55 -0500
X-MC-Unique: w9YcRUiiOqaoJIKkg231yA-1
Received: by mail-qv1-f71.google.com with SMTP id m6so2600205qvo.11
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 13:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=zg5COqSniCUgzsW5zPB4OaKMk3i2DDD4HUmLxnEuiNo=;
 b=MbjS6cm+eG9b72T2UZurQ7/FkA2d1n60DI5JkSSvn46vjnwktuKPrmyz+1MhceylHJ
 nQKisSQFFOBXCeZ6WUQ5mL3WbXjIssGKysnjoiXpXbfVl1hNVHVcFb/NYnJpJqyC9Ujh
 e01oiJTMdsrk6oSoXjTi+QSs5e3gDhIhkBkDlxndfRVvCmu6cCouGSwVUwDlRfEdBAjz
 SegBzjv5j4RUmWvKQUpICDtarDWxTp7f1LpKSA0Fs5+LfgloqDnCp+/VhHWVsl5oNaPo
 MaHSwNcxDvlCCl0k1S4Qqi6Cg3jw9I99vx6MJHREZA9+MRIZmyYzoj9pYRYn/0taA7yo
 xWWA==
X-Gm-Message-State: APjAAAVZrQIWRTPadzyE/RWeat61+rzsh+Ru+IkFiO3Td2OuVroQDOWU
 uLsZRIFKMpyWYaxlcgPsKXtnFQAPVfue6YfK/fxZUso9pNkF9RStNdogmA2snntJUxe53StX72v
 896Qny9gJEQzsvbM=
X-Received: by 2002:ac8:145:: with SMTP id f5mr5857639qtg.194.1582923715431;
 Fri, 28 Feb 2020 13:01:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7HtA9FzU9ZxhtZk1NRgk4XtVXQRKPxg8QSwvPetARE/KaC5n1vYEPY9yC237HRMxHFqfmYA==
X-Received: by 2002:ac8:145:: with SMTP id f5mr5857623qtg.194.1582923715210;
 Fri, 28 Feb 2020 13:01:55 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id p53sm5994130qtb.85.2020.02.28.13.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 13:01:54 -0800 (PST)
Date: Fri, 28 Feb 2020 16:01:52 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 12/15] util: vfio-helpers: Implement ram_block_resized()
Message-ID: <20200228210152.GD180973@xz-x1>
References: <20200228194257.GV180973@xz-x1>
 <509A885B-055F-4EEF-96FA-2EDA759F4F2C@redhat.com>
MIME-Version: 1.0
In-Reply-To: <509A885B-055F-4EEF-96FA-2EDA759F4F2C@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 28, 2020 at 09:16:28PM +0100, David Hildenbrand wrote:
>=20

[...]

> >> @@ -631,7 +658,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host=
, size_t size,
> >>                 qemu_vfio_remove_mapping(s, mapping);
> >>                 goto out;
> >>             }
> >> -            s->low_water_mark +=3D size;
> >> +            s->low_water_mark +=3D max_size;
> >=20
> > I think it's fine to only increase the low water mark here, however
> > imo it would be better to also cache the max size in IOVAMapping too,
> > then in resize() we double check new_size <=3D max_size?  It also makes
> > IOVAMapping more self contained.
> >=20
>=20
> I=E2=80=98ll have a look how much additional code that will imply - if it=
=E2=80=98s simple, I=E2=80=98ll do it.

AFAICT it'll be as simple as introducing IOVAMapping.max_size, then
pass max_size into qemu_vfio_add_mapping().  Thanks,

--=20
Peter Xu


