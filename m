Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355D2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02153206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6+Iwu5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02153206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic1gC-00065z-42
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 01:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ic1cw-0003mo-N6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ic1cs-00085q-6D
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:25:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22639
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ic1cq-00085Q-83
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575354330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=He9rihmnxHj6GDGMEr1gk9KgbhYOhD+yXu0lokGxh4Q=;
 b=L6+Iwu5IUzV1O9kBfd9DRFZCAGkaouOpDqv2T3S2p6KUOqtkX/j3DAJK3DYqo1ixoDDP2D
 WIhyPaBq2GtTq6VTzU77Pf4OZM6VVQDxPqNWucLOw034FWj8DakxJwq20Ld2NWy7+Kk1J6
 Drg/0HKokV9gc23RTSLyMzZqY56Y07Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-IYdwkfNnPaaw7ACh4qXQhA-1; Tue, 03 Dec 2019 01:25:29 -0500
Received: by mail-qv1-f69.google.com with SMTP id bt18so1489621qvb.19
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 22:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9q/UD2rsSpz1ctszOrBLevwg6VznQdFf8L8vZR0QFrs=;
 b=RROSaorzP02YlkH/pvmY0wdUKnuSrLiK1KaYwmZYOQwIgAQd8BVSmnDThFv7hpdu6E
 nSFagfxTEaA3L17uL/Rs0uABiA8uIRAK3T4CTcMdjr4g1ziVW1CoEfMxUppJIFAfN23G
 ugj+Mad1PMOi8vhN/C2iT8EaG8hQeiykJspSqsjs7BW+EsTnE/yfmA3pBn+xGLSQjZ+a
 /fFYoOUsWOxYcuh4qKvav5iFUfOJYZGNwFVIUuHLp4mhP1lb6l7kt676VkcPX6S5F6N7
 1a5z+E0PR3wAlCFYYyyCkFAtJD06Ss2MPxy6MbGhWQRpAI+cbhowgz0+itk/y43jnQPQ
 +Y8A==
X-Gm-Message-State: APjAAAXx2l7g8zmzFQLMfxp0rWvHOc+lnq0xOfjFOxGKV8j0E4OSB6bR
 z0oWBQ+WqIQymTHrIqZKhzSPKN2eZswl2C0Vf2JDsqzg87a2F//2bLud2DH2ZV9c5ZYLQJIcp3L
 x0Hv4tuf6LCwF+KE=
X-Received: by 2002:a05:620a:1311:: with SMTP id
 o17mr3587477qkj.94.1575354328923; 
 Mon, 02 Dec 2019 22:25:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzRO1L6aO7No1c2oVvKg3AbwRmuR8FhGwfFsinOS0ml/J06ByS9oDscqG0OoEPale4VGyy4Zw==
X-Received: by 2002:a05:620a:1311:: with SMTP id
 o17mr3587451qkj.94.1575354328633; 
 Mon, 02 Dec 2019 22:25:28 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id y131sm1190721qkb.29.2019.12.02.22.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 22:25:27 -0800 (PST)
Date: Tue, 3 Dec 2019 01:25:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v20 0/8] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
Message-ID: <20191203010755-mutt-send-email-mst@kernel.org>
References: <20191129075634.682-1-tao3.xu@intel.com>
 <a31eeaf7-406f-01c4-5183-cd25835af616@intel.com>
 <20191203003445-mutt-send-email-mst@kernel.org>
 <87y2vu7xt6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87y2vu7xt6.fsf@dusky.pond.sub.org>
X-MC-Unique: IYdwkfNnPaaw7ACh4qXQhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "sw@weilnetz.de" <sw@weilnetz.de>,
 Tao Xu <tao3.xu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 03, 2019 at 07:00:53AM +0100, Markus Armbruster wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>=20
> > On Tue, Dec 03, 2019 at 08:53:30AM +0800, Tao Xu wrote:
> >> Hi Michael,
> >>=20
> >> Could this patch series be queued?
> >> Thank you very much!
> >>=20
> >> Tao
> >
> > QEMU is in freeze, so not yet. Please ping after the release.
>=20
> Just to avoid confusion: it's Michael's personal preference not to
> process patches for the next version during freeze.  Other maintainers
> do, and that's actually the project's policy:
>=20
> Subject: QEMU Summit 2017: minutes
> Message-ID: <CAFEAcA-b9oDkPfZbntWfhWSv1HOnbUf75p_xB_tF74h_NBGPmw@mail.gma=
il.com>
> https://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg04453.html
>=20
>     qemu-next:
>      * Problem 1: Contributors cannot get patches merged during freeze
>        (bad experience)
>      [...]
>      * Markus Armbruster: Problem 1 is solved if maintainers keep their o=
wn
>        -next trees
>      * Paolo Bonzini: Maintaining -next could slow down or create work fo=
r
>        -freeze (e.g. who does backports)
>      * Action: Maintainers mustn't tell submitters to go away just becaus=
e
>        we're in a release freeze (it's up to them whether they prefer to
>        maintain a "-next" tree for their subsystem with patches queued fo=
r
>        the following release, or track which patches they've accepted
>        some other way)
>      * We're not going to have an official project-wide "-next" tree, tho=
ugh
>=20
> Michael, would queuing up patches in a -next branch really be too much
> trouble for you?

Thanks for pointing this out!

I stopped asking for re-post since awhile ago.  I don't queue patches in
a public tree but I do review and do keep track of pending patches.

I tend to ask contributors to also ping because sometimes there's a
problem with rebase, I drop the patch but forget to tell the
contributor, and it tends to happen more with big patchsets posted during
freeze as there's a rush to merge changes right after that.
I usually don't bother people with this for small patches though.

I'll try to be clearer in my communication so contributors don't feel
stressed.

Would something like:

"I'll queue it for merge after the release. If possible please ping me
after the release to help make sure it didn't get dropped."

be clearer?

Hopefully windows CI efforts will soon bear fruit to the point where
they stress PCI enough to make maintaining next worth the effort.

--=20
MST


