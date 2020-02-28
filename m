Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BFEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93CFC24695
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANfrtDhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CFC24695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7lYC-00039X-M6
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 14:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7lXP-0002fI-FC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7lXO-0003mZ-1R
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:43:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7lXN-0003jH-Tb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582918984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H94zIAbXExqfkcvP+p8ib3hvX/AZz7ux27cv78R8JKQ=;
 b=ANfrtDhCI+o+jQNt44hx31XyfLQgBZQFXUwNqjAwCqrOZBVutnjW0YimTxEWN10oOh4X1Q
 oTIsyC4Rem0rtNimeqPKfmL1Z+YQ1Iw9WB38zax4/FKg9RgeIOCykN+PirB94jjxtHOAJ4
 Ehs+VG3fEG4l0KW1vsYY5t3eSZkLHX0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-16_7I8ooOJmcQ5nVJLMU5g-1; Fri, 28 Feb 2020 14:43:00 -0500
X-MC-Unique: 16_7I8ooOJmcQ5nVJLMU5g-1
Received: by mail-qv1-f71.google.com with SMTP id e10so3427915qvq.18
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 11:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R7asH3zod8bLU4DnIn6QMsqlxeJzogKMTuyG4bJl+ZQ=;
 b=UoyKD3lFFqvavZ+3o4G5XxOzCl9qD2/pEhcp7M2ln7K2pRRJWy7eKErWW2/2vA5ZxI
 8z/wM8G2Hc6R/0YGn2mZsvDkOhCYyJKth0kO9vgmRG4d7Wwq5IYjqZDIQcjmfs7OkidH
 V6adXw/TjE26jZ5oHS0PTPJeMLm8YUkF38YZvfbjroeHp1f4U0vMgq8NMTWX8Pb6Oz91
 uwBytTzItvyH1uGjIieE5NrEF2M9kMOFR3aIMh9vaVQ2mjT8qaa+KEKLZSRpdsd3AeTw
 XuODJkGFbipA5JjY9XxGjNP+6aD00iCp/+lWilfl3kHvl0Y3Bzw12siMP8UZaTCpzlUN
 5huQ==
X-Gm-Message-State: APjAAAVbNorcjbu1mEFD5ZIJbIALJbjxgEP7Qi4gV/teflnEO/DL4722
 jhg4XM6QRp/mU196hQ/vC5pp4N4yik6UQ6fQtpKpdCxQYEZVW998BBe2XHNxW0qPLBAhpJQA7Pu
 76E/sXe77gqu/czY=
X-Received: by 2002:a37:660e:: with SMTP id a14mr3714165qkc.334.1582918980361; 
 Fri, 28 Feb 2020 11:43:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwtlXR5ZmipoGuxANb2zuzyZgUPXnOoBKB0Nk4meIjTwkCJdzqPIsi60KEqi10SiFkTMxWmhg==
X-Received: by 2002:a37:660e:: with SMTP id a14mr3714147qkc.334.1582918980071; 
 Fri, 28 Feb 2020 11:43:00 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id i132sm5797386qke.41.2020.02.28.11.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 11:42:59 -0800 (PST)
Date: Fri, 28 Feb 2020 14:42:57 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 12/15] util: vfio-helpers: Implement ram_block_resized()
Message-ID: <20200228194257.GV180973@xz-x1>
References: <20200227101205.5616-1-david@redhat.com>
 <20200227101205.5616-13-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227101205.5616-13-david@redhat.com>
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

On Thu, Feb 27, 2020 at 11:12:02AM +0100, David Hildenbrand wrote:
> Let's implement ram_block_resized(), allowing resizeable mappings.
>=20
> For resizeable mappings, we reserve $max_size IOVA address space, but onl=
y
> map $size of it. When resizing, unmap the old part and remap the new
> part. We'll need a new ioctl to do this atomically (e.g., to resize
> while the guest is running - not allowed for now).

Curious: I think it's true for now because resizing only happens
during reboot or destination VM during migration (but before
switching).  However is that guaranteed too in the future?

[...]

> @@ -631,7 +658,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, s=
ize_t size,
>                  qemu_vfio_remove_mapping(s, mapping);
>                  goto out;
>              }
> -            s->low_water_mark +=3D size;
> +            s->low_water_mark +=3D max_size;

I think it's fine to only increase the low water mark here, however
imo it would be better to also cache the max size in IOVAMapping too,
then in resize() we double check new_size <=3D max_size?  It also makes
IOVAMapping more self contained.

Thanks,

--=20
Peter Xu


