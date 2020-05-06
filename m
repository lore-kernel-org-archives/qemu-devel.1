Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0BBC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68D1206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFTDwbwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68D1206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFi5-0005ED-T8
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWFhJ-0004dT-Iq
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:46:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37171
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWFhH-0003GY-AO
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588754790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VPzUHcJdn+Ox/uLFy531urYQ6w5EJMPIk49WLq8cUwg=;
 b=RFTDwbwgcu9ktl7fmTbOVToKYLbzSa/Lpz/KhV4ATNHDh33svv2X7BQggpsTQCJ4X4ESt8
 L/ff26/HxYaOFg72Sus9r94wrySvxRykdlaFLQo7Xezbiwu8lmFdW7VVmnovbju7iAV5fw
 vZ+PJ0Y5z+AchZqSloIY9EG7E1CoCSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-CdmJ6hlqN2yPKbJIGK3_OA-1; Wed, 06 May 2020 04:46:29 -0400
X-MC-Unique: CdmJ6hlqN2yPKbJIGK3_OA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 042968018AC;
 Wed,  6 May 2020 08:46:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F335E63F90;
 Wed,  6 May 2020 08:46:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AEA891747D; Wed,  6 May 2020 10:46:20 +0200 (CEST)
Date: Wed, 6 May 2020 10:46:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 07/13] acpi: move aml builder code for parallel device
Message-ID: <20200506084620.23yw4sizyem5pro2@sirius.home.kraxel.org>
References: <20200505113843.22012-1-kraxel@redhat.com>
 <20200505113843.22012-8-kraxel@redhat.com>
 <97cd8a76-c6b8-92b6-86ae-b29d05635751@redhat.com>
MIME-Version: 1.0
In-Reply-To: <97cd8a76-c6b8-92b6-86ae-b29d05635751@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:48:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > +static void parallel_isa_build_aml(ISADevice *isadev, Aml *scope)
> > +{
> > +    ISAParallelState *isa =3D ISA_PARALLEL(isadev);
> > +    int i, uid =3D 0;
> > +    Aml *dev;
> > +    Aml *crs;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(isa_parallel_io); i++) {
> > +        if (isa->iobase =3D=3D isa_parallel_io[i]) {
> > +            uid =3D i + 1;
>=20
> I'm not sure about this check, as we can create a ISA device setting
> manually index & iobase. What about using simply "uid =3D isa->index + 1"
> instead?

Looking at the code I see isa->index is assigned unconditionally.  I
misremembered that detail.  So, yes, simply using isa->index should work
fine even with '-device isa-serial,iobase=3D<something>".  I'll fix it for
both serial and parallel.

cheers,
  Gerd


