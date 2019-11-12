Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B4CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFCF21783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSbStywH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFCF21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUal-0001fI-Ky
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iUUW6-0005t7-8M
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iUUW5-0003HQ-87
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:39:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49340
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iUUW5-0003HF-4I
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573558764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zbj464CEZ0mq9CN5nTQpqhp4Y/J5FATmBxTphmBe8vo=;
 b=QSbStywHf0jaLWTsrYg/5WYvq0Y7st89+cYBCkPJxfAIteUwtjh0rBC6vzFAVbMnT+iirt
 pErG4mb7jPgpak4e0QEqjzoD00by9Ib0D7x8SuHARQKDLtZbB/d2p5FQmHY9f29ynVrpUH
 Q5tImzp0H7JQvWQiWyJx1yaJT8AHaWU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-uj7xomP9PhK2G727NIsvsQ-1; Tue, 12 Nov 2019 06:39:23 -0500
Received: by mail-qt1-f200.google.com with SMTP id j18so695634qtp.15
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 03:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G7vfK+So+1KS9Ji60fE66Mpa7XjCoE8SThUV71L22ZA=;
 b=sJ5oRNplyaWB4SLVaoc1gz7/tjM9eewjBIZ35W9OJhDt3DSQbhta5X4tXORKwZiiO2
 HCnOwdE+hiyWbBmbO31kUsYPGpww5dfn80RuK8qZ/HyhJ3P4IHBzfc1cz9vTCqNs1lG6
 pd+iRbbBmwKIotpZmi4CGVQZ5w/TBOq8SYic4VLj60AE1JzypI132szSTrreullUhnuq
 GLPEItC9UvyVhvIBhh+KuQge9gB9kU1l6RLE+PvJfjzc/wO49VlZnRApzGDcdWSV6dsq
 6/bl1MsuIYARY86MC5YnLqASH0/MNcRQfbEjlnFOP/gDs6heBty/rqIBIa3teCpI+CnH
 x2Sw==
X-Gm-Message-State: APjAAAW8ZZV5xokGYshS+nguPMHHjxgwrb6C5AREGF+A48/K3f1hG8DQ
 lZjARxeLS8m2Zja2+Icy7jGC4g9QDOemzj+GDIuFYXxu7JE2D99hdb5iJqJk4WYgbJFXIMJJueE
 6zniycquHxly0eQk=
X-Received: by 2002:ac8:4a93:: with SMTP id l19mr787213qtq.121.1573558763019; 
 Tue, 12 Nov 2019 03:39:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwY8zAO40e4sfiPujc8kSY8fSPJu1N6r/RfzsSPBatkbZwmZ7nbmpSFAzIHprRxhzCY/64PzQ==
X-Received: by 2002:ac8:4a93:: with SMTP id l19mr787194qtq.121.1573558762818; 
 Tue, 12 Nov 2019 03:39:22 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id g17sm10939096qte.89.2019.11.12.03.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 03:39:21 -0800 (PST)
Date: Tue, 12 Nov 2019 06:39:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v3 0/2] virtio: make seg_max virtqueue size dependent
Message-ID: <20191112063838-mutt-send-email-mst@kernel.org>
References: <20191112111354.26324-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191112111354.26324-1-dplotnikov@virtuozzo.com>
X-MC-Unique: uj7xomP9PhK2G727NIsvsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 02:13:52PM +0300, Denis Plotnikov wrote:
> v3:
>   * add property to set in machine type [MST]
>   * add min queue size check [Stefan]
>   * add avocado based test [Max, Stefan, Eduardo, Cleber]
>=20
> v2:
>   * the standalone patch to make seg_max virtqueue size dependent
>   * other patches are postponed

Looks good. I think it's best to apply this after the release,
so when release is out pls rebase and repost.
Thanks!

> v1:
>   the initial series
>=20
> Denis Plotnikov (2):
>   virtio: make seg_max virtqueue size dependent
>   tests: add virtio-scsi and virtio-blk seg_max_adjust test
>=20
>  hw/block/virtio-blk.c                     |   9 +-
>  hw/core/machine.c                         |   3 +
>  hw/scsi/vhost-scsi.c                      |   2 +
>  hw/scsi/virtio-scsi.c                     |  10 +-
>  include/hw/virtio/virtio-blk.h            |   1 +
>  include/hw/virtio/virtio-scsi.h           |   1 +
>  tests/acceptance/virtio_seg_max_adjust.py | 135 ++++++++++++++++++++++
>  7 files changed, 159 insertions(+), 2 deletions(-)
>  create mode 100755 tests/acceptance/virtio_seg_max_adjust.py
>=20
> --=20
> 2.17.0


