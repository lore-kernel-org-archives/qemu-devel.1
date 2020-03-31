Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CB9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C051B20838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dq2A/aXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C051B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFgb-0006Xc-Vd
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJFfx-0005sh-L2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJFfw-0006rG-ME
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:07:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJFfw-0006r4-Ie
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585656444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hx3yq1j+p4QCeYSAwStM4PetWHrT/LQ0vp5v4vhLoo4=;
 b=dq2A/aXwMtSZ2DX4SsMlqEt+btE9zP8gd6gBlBXlpvBfW52Rw/YQ3xmmS1J4/nZLcXTd5Z
 0dWE5CXcggLg3ccADnathpe21KYmV3jT69bzJ/aOC4438Hri4bvCV/a6ZO870kulFDtMBE
 s4QX+zeX3c0piKtxZdPjPQEOo1cUdps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-FpSy_5o9M8SeS-8LBSInXQ-1; Tue, 31 Mar 2020 08:07:22 -0400
X-MC-Unique: FpSy_5o9M8SeS-8LBSInXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F58F18A6EC1;
 Tue, 31 Mar 2020 12:07:21 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42C955C1BB;
 Tue, 31 Mar 2020 12:07:20 +0000 (UTC)
Date: Tue, 31 Mar 2020 14:07:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Liviu Ionescu <ilg@livius.net>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200331120718.GB7030@linux.fritz.box>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com>
 <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
 <2D490715-F32F-4A34-A31F-5709B28FB6CA@livius.net>
 <CAFEAcA-KKd0bjE17MPPFv45=S+x3jUj9uA6_UQmb7ts-yu5Ong@mail.gmail.com>
 <C0360478-EBDE-419B-9917-2EFAC580BEF3@livius.net>
MIME-Version: 1.0
In-Reply-To: <C0360478-EBDE-419B-9917-2EFAC580BEF3@livius.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.03.2020 um 13:46 hat Liviu Ionescu geschrieben:
> > On 31 Mar 2020, at 13:19, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> >=20
> >=20
> > ... the behaviour
> > if they're run from some other (manually created) build directory
> > would remain as it is today.
>=20
> Great!
>=20
> Then for now a strongly worded warning displayed at the end of the
> build (to be clearly visible) should do it, and after a while a
> possible change to meson or any other solution that uses a separate
> build folder would not surprise anyone.

Thanks for declaring my workflow irrelevant, I guess...

It's interesting how you complain about a hypothetical situation where
you would have to change workflow, but are completely happy to make the
same thing happen to other people.

Kevin


