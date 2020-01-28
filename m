Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CD5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C781624683
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEIZr59W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C781624683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwRD2-0002S7-10
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 08:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iwRC8-0001ju-4x
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iwRC6-0006Pt-Pz
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:46:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58047
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iwRC6-0006OX-Mc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580219177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23YBAuzECRIQ7Xvz8MZcpyjUXpNxpOFBZvNR72AE26o=;
 b=TEIZr59WcRbozBF7EH5FptBd98eOWI8Ynq7b2gEIAiNk6edDER2H088NUBGphp9KDjOBjp
 alLllZSpMEKiZzG0oscwsUCTrFhXjJ9GlIErpMIbtscE5jtU9wMU4yRabbyZvL2wXj5G0B
 310vPikrb+4z56PDoRe0VXpXVIhiM4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-INMM4pt0MbGDBaT59xs2TA-1; Tue, 28 Jan 2020 08:46:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59683800EBB;
 Tue, 28 Jan 2020 13:46:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.36.118.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8B8860C81;
 Tue, 28 Jan 2020 13:46:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DA6D616E2D; Tue, 28 Jan 2020 14:45:59 +0100 (CET)
Date: Tue, 28 Jan 2020 14:45:59 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200128134559.bzb3islkrppkwwtb@sirius.home.kraxel.org>
References: <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
 <20200128102855.GA6431@linux.fritz.box>
 <87mua7bvwf.fsf@dusky.pond.sub.org>
 <20200128125409.GF6431@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200128125409.GF6431@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: INMM4pt0MbGDBaT59xs2TA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > Consider chardev-add.  Example:
> >=20
> >     {"execute": "chardev-add",
> >      "arguments": {"id": "bar",
> >                    "backend": {"type": "file",
> >                                "data": {"out": "/tmp/bar.log"}}}}

> Well, first of all: Do we need compatibility?

Well, libvirt uses that, so yes.  Or at least support both old and new
(chardev-add-v2?) in parallel for while to give libvirt time to switch
over.

cheers,
  Gerd


