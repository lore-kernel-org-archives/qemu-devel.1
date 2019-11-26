Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC7CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09FA920727
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcN0uQkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FA920727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZXVQ-0007fC-5w
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iZXQV-0003Wh-FX
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iZXQT-0000yM-Dl
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:46:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53661
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iZXQR-0000wV-GO
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574761584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jV0ugXoafpy68CxAJAY2m4WY7gYw8lEv4kXIfKRDffM=;
 b=fcN0uQkTR1IsAaTTb8Udplriu+tjZ6H++kPfhukTTvbK2JKEUqNSCoWjMiKc02kgkOMv04
 1YGmMguCdocHiIa/hxAF7GOb/4UPiMH1eokMPNAlEfdIIX9sAGa8gVcgv/b/9vx1S9F9s7
 C11FphIlPFh4newWSEsqZVBFcxIG53I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-YxISRUdDPG-uT8uo2sJ_tg-1; Tue, 26 Nov 2019 04:46:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 224658017CC;
 Tue, 26 Nov 2019 09:46:19 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EBE610027A1;
 Tue, 26 Nov 2019 09:46:12 +0000 (UTC)
Date: Tue, 26 Nov 2019 10:46:09 +0100
From: Andrew Jones <drjones@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 0/5] ARM virt: Add NVDIMM support
Message-ID: <20191126094609.bbll2vvsd4grexl7@kamzik.brq.redhat.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <a133d4c4-3f60-2bb1-a7d7-35cdb06af265@redhat.com>
 <441c818f24084b4191315cf2a6267cef@huawei.com>
 <20191125164541.3f0a593f@redhat.com>
 <444efcb441fe42e5aff58b3af3ab14b4@huawei.com>
 <20191126095655.27227f59@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191126095655.27227f59@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: YxISRUdDPG-uT8uo2sJ_tg-1
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 Auger Eric <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 09:56:55AM +0100, Igor Mammedov wrote:
> On Mon, 25 Nov 2019 16:25:54 +0000
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
> > > -    Name (MEMA, 0xBFBFD000)
> > > +    Name (MEMA, 0xFFFF0000)
> > >=20
> > > However value here is suspicious. If I recall right it should
> > > point to DMS buffer allocated by firmware somewhere in the guest RAM.=
 =20
> >=20
> > But then it will be horribly wrong and will result in inconsistent beha=
vior
> > as well, right?
>=20
> I'd thinks so. I'm not sure what happens but RAM starts at 0x100000000
> which is above the address you have in MEMA so you shouldn't have
> sensible data there and access probably should raise some sort of error.
>=20
> CCing Drew

RAM starts at 0x40000000 (the 1G boundary). So 0xffff0000 is OK, assuming
you want this just below the 3G boundary. With TCG, a data abort exception
will be injected for any access to an unmapped region. With KVM, unless
paging is enabled in the guest, then reads of unmapped regions will return
zero and writes will be ignored.

Thanks,
drew


