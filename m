Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535E1C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEB6217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjWL46i9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEB6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izJC2-0001xR-8O
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1izJBO-0001Pu-2k
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1izJBM-0006qp-R2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:49:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54293
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1izJBM-0006eX-Du
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580903363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E3oNQ+/2T7H98hfraWv9Amzyk0TgfOqvhSof9Y4rL9M=;
 b=cjWL46i9yHP7PLvXx221ucieJzl/roD4okFJG/LJt3pr31d4eG2ZtWJPDYHKRZnKuI+OVY
 RMKgT9MQM+CnK70sTFRCUTPvgjS4qIBWyngDjw6sazHClna9JFDgRbtDVIXCcHLedM+tnA
 yG3MZllrXLvESIUMoZT/5TeWbkcgPXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-zZ6xp8C1NEO6iJCzl5CUGQ-1; Wed, 05 Feb 2020 06:49:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66486800D54;
 Wed,  5 Feb 2020 11:49:18 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B4F25C1B2;
 Wed,  5 Feb 2020 11:49:17 +0000 (UTC)
Date: Wed, 5 Feb 2020 12:49:14 +0100
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 20/22] tests/tcg/aarch64: add test-sve-ioctl
 guest-debug test
Message-ID: <20200205114914.heuaamk4sw2ndopw@kamzik.brq.redhat.com>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-21-alex.bennee@linaro.org>
 <2731815f-9a72-390b-0a8e-73b77c4b62b6@linaro.org>
 <87lfpi81sn.fsf@linaro.org>
 <a361a310-f6f8-9c17-6846-64e9f0b189f2@linaro.org>
MIME-Version: 1.0
In-Reply-To: <a361a310-f6f8-9c17-6846-64e9f0b189f2@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: zZ6xp8C1NEO6iJCzl5CUGQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 10:19:08AM +0000, Richard Henderson wrote:
> On 2/4/20 9:45 PM, Alex Benn=E9e wrote:
> >> Also, ZCR_EL1 it itself not correct if the
> >> hardware does not support all vector sizes.
> >>
> >> See some of Andrew Jones' qemu command-line work.  Try -cpu max,sve512=
=3Don and
> >> then use the ioctl to set vq to 3 (sve384).  The result will be an eff=
ective vq
> >> of 2 (sve256).
> >>
> >> We *really* need vg, as computed from sve_zcr_len_for_el().
> >=20
> > How come TARGET_PR_SVE_GET_VL is happy to compute directly from ZCR
> > then?
>=20
> Bug.  It didn't get updated with Andrew's changes to limit the set of sup=
ported
> sve lengths.

Yeah. Sorry about that. I don't know much about linux-user so I didn't
look closely enough at it to realize it needed changes as well. Grepping
now, I see there's a couple other places that might need updating too

  linux-user/aarch64/signal.c
    target_restore_sigframe: TARGET_SVE_MAGIC
    target_setup_frame: /* SVE state needs saving only if it exists.  */

And, like TARGET_PR_SVE_GET_VL, TARGET_PR_SVE_SET_VL needs changes in
linux-user/syscall.c as well.

Thanks,
drew

>=20
> > I'll put the vg back in but it seemed a little pointless given the
> > gdbstub ignores it.
>=20
> I'll say again that this is a gdb bug and we should simply report/fix it
> upstream.  Don't try to work around it in qemu.
>=20
>=20
> r~
>=20


