Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7342FC352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4204420661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgOHSvNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4204420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgTv-0003AD-EZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1izgSq-0001l7-09
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1izgSo-0003oD-W1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:40:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43107
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1izgSo-0003l4-Qu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580992857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgaO1qcylEw1Ratw4Gx0lE+m4ReViIem7CxGHMx+5Is=;
 b=fgOHSvNrozd/opNMmwGlEvC2ARH5gIS7RtCGuU4UkbVtqyhPbA6/ugLGbLO54cKoTGJlsH
 Y0RQETCRimp6KT6mAA1KPrYI+NqC9EnKhOkLfMXcWXStA6N7rJeHzRfH/rXljJdwkd6Mk/
 FhDPQBnbhlXqxhniPGFjNjNovg/glkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-xIfokgDOPf-flTG8rjaTmg-1; Thu, 06 Feb 2020 07:40:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7C261081FA3;
 Thu,  6 Feb 2020 12:40:54 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCB5C5C1D8;
 Thu,  6 Feb 2020 12:40:50 +0000 (UTC)
Date: Thu, 6 Feb 2020 13:40:47 +0100
From: Andrew Jones <drjones@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 5/5] target/arm/cpu: Add the kvm-no-adjvtime CPU
 property
Message-ID: <20200206124047.o4sy52jgbkqeravd@kamzik.brq.redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-6-drjones@redhat.com>
 <CAP+75-Vt3apV8i64oFTC6pAATXkrE1g+tVskr_3ohBHtZ1LNdQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+75-Vt3apV8i64oFTC6pAATXkrE1g+tVskr_3ohBHtZ1LNdQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: xIfokgDOPf-flTG8rjaTmg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, bijan.mottahedeh@oracle.com,
 Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 06, 2020 at 01:08:53PM +0100, Philippe Mathieu-Daud=E9 wrote:
...
> > +/* KVM VCPU properties should be prefixed with "kvm-". */
> > +void kvm_arm_add_vcpu_properties(Object *obj)
> > +{
> > +    if (!kvm_enabled()) {
>=20
> This can't happen, right? Can we turn that into an assertion, or
> remove the check?

You're right. An assert would be more appropriate. Will you send a patch?

Thanks,
drew


