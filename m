Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224BBC2D0E7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 05:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04C22074D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 05:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJXkj3IQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04C22074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJWIv-0004hj-1K
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 01:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jJWHx-00044f-M3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 01:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jJWHw-0003Jg-7n
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 01:51:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jJWHw-0003Gf-0d
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 01:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585720301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0iDaJYOQQVVxqR8z9N237zcybg8hPX6x4qbB9QDAnA=;
 b=VJXkj3IQfV8vZfqwzAecjy9bpa3Bia9IKaaEqsv2bv1ugGBdGg4RHgR1rqKkJ0zuYR8jfu
 IedKemJpv1VQU8NjNRpvThEF/YCYkgIlFN2Cwb5G29HwTfdzCUQJMR4OueMNFKYo4soica
 oQ0U9URTtJX4EY0A2TytqONKiCRCaeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-vIw_FEVsMVKMPfeoqzB7Zw-1; Wed, 01 Apr 2020 01:51:39 -0400
X-MC-Unique: vIw_FEVsMVKMPfeoqzB7Zw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B51E513F8;
 Wed,  1 Apr 2020 05:51:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9EA9DA0EB;
 Wed,  1 Apr 2020 05:51:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CA8A79D12; Wed,  1 Apr 2020 07:51:34 +0200 (CEST)
Date: Wed, 1 Apr 2020 07:51:34 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 5/6] acpi: serial: don't use _STA method
Message-ID: <20200401055134.iqlhaiaqxu5fzyi4@sirius.home.kraxel.org>
References: <20200327121111.1530-1-kraxel@redhat.com>
 <20200327121111.1530-6-kraxel@redhat.com>
 <20200327153340.519fac3f@redhat.com>
 <20200331152342.vdfhosgpi6popy2x@sirius.home.kraxel.org>
 <20200331215320.620c52bf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331215320.620c52bf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > Hmm, I'm wondering whenever it would be useful to have ...
> >=20
> >    ISADeviceClass->build_aml(Aml *scope, ISADevice *dev);
>=20
> in relation to iqr, you said earlier that device doesn't know to which ir=
q it's mapped.
> that might be a problem in this case, likewise for (MM)IO

Right, this is a problem for sysbus, isa seems to not have this problem
though.

> > ... then just walk all isa devices and call the handler
> > (if present).  Maybe the same for sysbus.
>=20
> There was already such idea (Paolo or Michael), i.e. to move AML code
> generation related to specific devices inside of device model (not
> only ISA or sysbus), so one would just have to enumerate present
> devices in generic way and ask them to provide AML descriptors and be
> done with building DSDT.
>=20
> Not sure if it's doable in generic way though, especially when it comes t=
o
> orchestrating _CRS between various devices.

I suspect fully generic is tricky, also because you have to get the
hierarchy right.  For isa I think it is doable without too much trouble
because all isa devices are within the same scope.

sysbus is more tricky I suspect.

> So it might take awhile to come up with approach which would work nice.
>=20
> Simplest way to get job done in case of microvm is to make board
> fill in assigned resources in some helper data structure and pass that
> to acpi code.

Well, I'd try to avoid the helper data structure indirection ...

> (another approach - arm/virt uses static 'registry' to distribute
> address space/irq and then acpi code just fetches values from there if
> device is present + a bunch of shared PCI code to make up dynamic PCI
> description)

I suspect the reason for the registry on arm is that you can generate
both acpi and device tree from it.  But maybe that makes sense for
sysbus devices (fw_cfg + virtio-mmio for microvm).

cheers,
  Gerd


