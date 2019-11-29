Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C77DC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 20:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78A621736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 20:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLKNVBBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78A621736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iamZd-0004hV-28
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 15:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iamWk-0003C0-8D
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iamWd-0008C3-Qb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:06:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iamWd-0007yo-MR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575057953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2BH+ncZhIdQhEhHBDLTr3O2l5UNSWa/LVXLIyALssw=;
 b=BLKNVBBjHsVHuj/i/ZAGL9s0GQsA3PtkzsZjNOTikOozf0/ZvKlxS4tTKYZjPE4CWt/vNj
 LG2ct258Kzdu2D7SENQJGWMYO9Nqs37MyLI2V/YWF2hwBM4r2ZgFe07Y8RCHQXSvhYc5qa
 Lyu5TjdrHI0S7zt2pBB7aDM8MFxLzHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-ayszhi_BM4i-BYxjkg_prA-1; Fri, 29 Nov 2019 15:05:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB79A18543A0;
 Fri, 29 Nov 2019 20:05:50 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF7F600C4;
 Fri, 29 Nov 2019 20:05:47 +0000 (UTC)
Date: Fri, 29 Nov 2019 17:05:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: qom device lifecycle interaction with hotplug/hotunplug ?
Message-ID: <20191129200545.GG14595@habkost.net>
References: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
 <20191128182705.0635d1d4@redhat.com>
 <CAFEAcA-qA6n49KdHsGLqt422L_b_9xPfSaJB3tATQvRdfKt-xw@mail.gmail.com>
 <20191129132641.4c7da6c5@redhat.com>
 <CAFEAcA_gcxqu+N5iV0L5WLyWmm5yxTFNMtmqQryBgVd4CCCT8A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_gcxqu+N5iV0L5WLyWmm5yxTFNMtmqQryBgVd4CCCT8A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ayszhi_BM4i-BYxjkg_prA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 12:45:09PM +0000, Peter Maydell wrote:
> On Fri, 29 Nov 2019 at 12:26, Igor Mammedov <imammedo@redhat.com> wrote:
> > But from the my very limited understanding, on real hardware,
> > once device is uplugged it's gone (finalized) from machine
> > perspective, so it's unclear to my why someone would use
> > realize->unrealize->realize hotplug scenario.
>=20
> Well, on real hardware 'unplug' is different from 'unrealize'.
> So I think for QEMU if we wanted to allow this sort of 'unplug
> and replug the same device' we should do it by:
>=20
>  instance_init -> realize -> plug -> unplug -> plug -> unplug ->
>    unrealize -> finalize
>=20
> So unrealize/finalize is when the device is actually destroyed,
> and if you're going to replug the device you don't destroy it
> on unplug.

So, to summarize the current issues:

1) realize triggers a plug operation implicitly.
2) unplug triggers unrealize implicitly.

Do you expect to see use cases that will require us to implement
realize-without-plug?

Similarly, do you expect use cases that will require us to
implement unplug-without-unrealize?

--=20
Eduardo


