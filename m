Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558DDC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2365C217BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqYshQl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2365C217BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadeX-0003Im-BJ
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iadI9-0004QP-Ud
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iadI2-000497-P5
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:14:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48174
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iadI2-0003wj-Kx
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575022455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYy74gDlbeHSqacfoEmueH5/XMv8A6ZPolIeyc92pO4=;
 b=cqYshQl1Q5ou+9z90ZJZ5yY2LlYcSaZZ9IIaxfFVjkbX1w+A6154bJaGfmiXq3SZfQEg28
 /HW9hz2T+qxEPjQsri7XQcdhYtFL8lJJW90Y5UC3x7mmhjiUm9uZ//eUlDE1n2GO/03tv+
 m4nD8fR8hZl/l+j30wFXqZyoZ8felEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-FRFUVT6ONsCGM5EYIBtc5A-1; Fri, 29 Nov 2019 05:14:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A0D3DBA5;
 Fri, 29 Nov 2019 10:14:10 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A3275C219;
 Fri, 29 Nov 2019 10:13:58 +0000 (UTC)
Date: Fri, 29 Nov 2019 11:13:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191129111357.0256ec2a@redhat.com>
In-Reply-To: <6b441014-1852-3257-2bc5-897cc51d08dc@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
 <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
 <20191129092713.GA2260471@redhat.com>
 <6b441014-1852-3257-2bc5-897cc51d08dc@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FRFUVT6ONsCGM5EYIBtc5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 10:33:39 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 29/11/19 10:27, Daniel P. Berrang=C3=A9 wrote:
> >> Yes, with a fallback path currently using a temporary file under /tmp
> >> (we may want to use shm_open() instead, or a different location such
> >> as XDG_RUNTIME_DIR? - and use O_TMPFILE) =20
> > We can't assume either /tmp or XDG_RUNTIME_DIR is on tmpfs as that is n=
o
> > where near standard across all OS distros, and even if on tmpfs these
> > dirs can be size limited to a significant subset of available RAM. IOW
> > we can't safely use them unless explicitly told to. =20
>=20
> Agreed, mkstemp+shm_open seems better.  Perhaps this could be done in
> hostmem-memfd.c though, basically as a fallback option?  In principle
> one could even use getmntent to search for a hugetlbfs mount.

So far fall backs proved to be a pain to deal with, as end users can't
be sure what machine they are getting eventually.
I'd prefer if we fail cleanly if asked config isn't possible and
let user fix vm configuration instead.

> Paolo
>=20
>=20


