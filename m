Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D5CC35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9938F2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hR06ts5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9938F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BIg-0007Bf-RZ
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j5BHM-0005Rb-H4
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j5BHL-00021t-Aw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:35:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27377
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j5BHK-00020n-EO
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582302950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UK11XP7TSSFY6WpmViyYU3Oki9eboLAaOS5r4pRlNNg=;
 b=hR06ts5vfuzQd8h/Npzsczime83ze0EpumHbzuC3Mq9aBZvg64/Stu6zEovu12ZV/69GP/
 atFK2d78dSnM2js4hfxcUyCWA8+ARsb8qhj1CxKik3eCX0GbeyVqhdJU+7/uAuoAs+E1z1
 gojiYnK8Grv5J5YjbKsdh4nwxndICFQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-hEx8qVJxMX-zb-VHuUXBxw-1; Fri, 21 Feb 2020 11:35:48 -0500
X-MC-Unique: hEx8qVJxMX-zb-VHuUXBxw-1
Received: by mail-qk1-f200.google.com with SMTP id o185so2067514qke.21
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qffL0KWKEw4UH1MXGx5Q2R/FW7snG92lwRBho7jdmxs=;
 b=JUpBwWhGX0ogZF209b0EKVKQszPDQCOPGuqzzoPKiGif6NTkgS3NRSUkXDjkjfu9QQ
 BS6Ck+9VaxkBw3TUnm5uA2ZLPWQLSTxzyQatKpQ/c6hzDXvV93QOKuv4rFEjVtU9YthL
 J41h6Hn1dYBsya6GZMrvUGDrxnd70z3ydDxyvRdtjEkenlr1KZEQgCfFW2SBIypxVrpP
 bG+MyETDsuYvChrCMd3+255mRhTjqw9M0qAi6p3Jy8TOcY9kiJUgZtlr7l12iK2pt9CQ
 eA7Fg8fmZNExtvkLmaQu7q9FsRb0dFYq+JxWa8hGun4M38OqTxJanN/9oeGnazENGdye
 FhlQ==
X-Gm-Message-State: APjAAAUWhbM9ngBHebbw9ZNSJJHatPWcFje91NqTtu5wA1QS/p6VC8wx
 znvbK+9S5BOuZbPQEqYt7LgXsjiKX5Fh9fiH8qsbs61fOTqZZ3leFb+WfO+bz9bL6Gy1NTWgOeW
 r3VApH5VyU1L3aoU=
X-Received: by 2002:a05:620a:1650:: with SMTP id
 c16mr35120290qko.346.1582302947748; 
 Fri, 21 Feb 2020 08:35:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHL5WBM42q1R76NceXg6J1L28mvnSUXo2M4fgQx7HgXCtPYDJmO9gGO16bG8gmhePg1Ld4Og==
X-Received: by 2002:a05:620a:1650:: with SMTP id
 c16mr35120260qko.346.1582302947509; 
 Fri, 21 Feb 2020 08:35:47 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id g9sm1745787qkl.11.2020.02.21.08.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 08:35:46 -0800 (PST)
Date: Fri, 21 Feb 2020 11:35:44 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 05/13] migrate/ram: Handle RAM block resizes during
 precopy
Message-ID: <20200221163544.GC37727@xz-x1>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-6-david@redhat.com>
 <3c3d4d50-a30d-b4e9-6256-4656f4e78cf6@redhat.com>
 <20200220201719.GC15253@xz-x1>
 <f72b81f6-1972-12b5-8113-95dc4094205b@redhat.com>
 <eacd48d3-4bce-bdd4-941d-3c098cb29034@redhat.com>
 <81ca5783-97d5-555c-c361-9b5b0ec144b3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <81ca5783-97d5-555c-c361-9b5b0ec144b3@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 11:19:58AM +0100, David Hildenbrand wrote:

[...]

> Lol, man this code is confusing.

(Yes in many places it is...)

>=20
> So, migration_is_idle() really only checks current_migration, not
> current_incoming.
>=20
> I didn't expect to be knees deep in migration code at this point ...
>=20
> if (migration_is_idle()) {
> =09return:
> }

Yes this seems to work too for postcopy, though may worth add a
comment showing the fact...  Thanks,

--=20
Peter Xu


