Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D07C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD64C20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDxV0n+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD64C20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtol-0003yq-33
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kAto6-0003OM-Ep
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:41:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37968
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kAto4-0007xP-8o
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598442091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqgZ/KS/GBGL8lK1BMW7XcnBp3uIBcfE+5gcV/8Ehbg=;
 b=CDxV0n+1h6UhuF6YWiI0jbOKUQ9+QRgY6BGZR5qS3Gqs8v3Cy8IxYk/GswinCXwVrMztvL
 mAeFGNH4VM6PzoCLAAiCm0CbtHq1PpWdYmFgGpJO4o8oTCHR3rpBK4543ox1MKBbJPTrgW
 e5k1OKQ9W6KtyW+MKe8w94DOB34DiT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-UTpE2HEkPN6vVpLN1UvKZg-1; Wed, 26 Aug 2020 07:41:29 -0400
X-MC-Unique: UTpE2HEkPN6vVpLN1UvKZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3F5718B9EC2;
 Wed, 26 Aug 2020 11:41:27 +0000 (UTC)
Received: from gondolin (ovpn-113-202.ams2.redhat.com [10.36.113.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 733195C1BB;
 Wed, 26 Aug 2020 11:41:21 +0000 (UTC)
Date: Wed, 26 Aug 2020 13:41:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH 02/12] hw/vfio/ap: Plug memleak in vfio_ap_get_group()
Message-ID: <20200826134118.07fdec61.cohuck@redhat.com>
In-Reply-To: <CAKXe6S+MV3fyCoyDbDV01CbuGoR8JO3e1=VAh4OFP5bKUVMXkA@mail.gmail.com>
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-3-pannengyuan@huawei.com>
 <CAKXe6S+MV3fyCoyDbDV01CbuGoR8JO3e1=VAh4OFP5bKUVMXkA@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 19:03:37 +0800
Li Qiang <liq3ea@gmail.com> wrote:

> Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:29=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > Missing g_error_free() in vfio_ap_get_group() error path. Fix that.
> >
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com> =20
>=20
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
>=20
> I see Cornelia Huck has merged this in his tree.

s/his/her/ :)

> Don't know whether this series will go separate maintainer's tree or
> as go only one maintainer's tree(maybe Paolo's misc tree?).

Whatever works best, but I still plan to send a pull req this week to
flush out my queue.


