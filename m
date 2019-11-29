Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1359BC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C026D208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwFcvjL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C026D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iamOl-0007FH-VN
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 14:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iamL6-0006Nn-6J
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iamKx-00041i-0Y
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:53:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37311
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iamKw-0003o2-KO
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575057230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmHq+YFxN3DY3xqP1XWjX5duitCannB88Axd3SYKgIk=;
 b=GwFcvjL4kTw1APN3oYdJrVFWTlLgTOOW26u2NG00Zs+l7qd8c5mFf9L+HBbnYmjxxSAbYR
 EZBRirDFuPTm36nHldD6VY4b/nFWBGmIV0QYSwOXCddiSef5U31TnQ+0IjWoYluGC5LeUY
 wMJ5T46yysf3+IvoWeTfqO2lwc57rps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-H2z79NOWNGKz3ah8RkmDTQ-1; Fri, 29 Nov 2019 14:53:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 336AB1005509;
 Fri, 29 Nov 2019 19:53:48 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21C7460856;
 Fri, 29 Nov 2019 19:53:44 +0000 (UTC)
Date: Fri, 29 Nov 2019 16:53:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: qom device lifecycle interaction with hotplug/hotunplug ?
Message-ID: <20191129195343.GF14595@habkost.net>
References: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
 <20191128163358.GC14595@habkost.net>
 <20191129134055.08f27e7a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191129134055.08f27e7a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: H2z79NOWNGKz3ah8RkmDTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 01:40:55PM +0100, Igor Mammedov wrote:
> On Thu, 28 Nov 2019 13:33:58 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Thu, Nov 28, 2019 at 04:00:06PM +0000, Peter Maydell wrote:
> > > Hi; this is a question which came up in Damien's reset series
> > > which I don't know the answer to:
> > >=20
> > > What is the interaction of the QOM device lifecycle (instance_init/re=
alize/
> > > unrealize/instance_finalize) with hotplug and hot-unplug ? I couldn't
> > > find any documentation of this but maybe I was looking in the wrong
> > > place...
> > >=20
> > > Looking at device_set_realized() it seems like we treat "realize"
> > > as meaning "and also do the hot-plug if this is a device we're
> > > trying to hotplug". On the other hand hot-unplug is I think the
> > > other way around: when we get a hot-unplug event we assume that
> > > it should also imply an "unrealize" (but just unrealizing doesn't
> > > auto-hot-unplug) ? =20
> >=20
> > Your description seems accurate, and I agree it is confusing.
> >=20
> > It would be more consistent if realized=3Dtrue didn't plug the
> > device automatically, and qdev_device_add() asked the hotplug
> > handler to plug the device instead.
> agreed, it's confusing. But that would not allow to
>   o =3D object_new()
>   set props
>   o.realize()
> reuse the same plug handlers.
>=20

I thought we had very few places that set realized=3Dtrue directly,
so changing this behavior would be easy.

I was mistaken.  Grepping for 'set_bool.*"realized"' found more
than 300 matches.

> we potentially can convert it to device_add input arguments
> and then call qdev_device_add() instead, which would then
> handle plug handlers, not sure it's doable though.
> Other than that I don't have any ideas how to make it less confusing.

We could introduce a "plugged" property which implicitly calls
the hotplug handler, and run a global s/"realized"/"plugged"/
substitution in the whole tree.  Would it be worth the trouble,
though?

--=20
Eduardo


