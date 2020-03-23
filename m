Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC0C10F26
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 04:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0796520722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 04:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTEpAAsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0796520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGEth-0002Mc-1z
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 00:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jGEss-0001ut-SU
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 00:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jGEsr-0005Hm-AM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 00:40:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:28883)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jGEsr-0005HE-5p
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 00:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584938416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bKw23fxp0CRKwcvIx1aFggeg5uPKigr+rE0QKbCiat8=;
 b=JTEpAAsZYz+Zzp2e6pzQQTcVdOJhDDwXcsaniyPYBRGJb5mkc2pQVYzEpOQRAOyJzxIffH
 H3xx4Oks6v7El0ySRiJc/nsEVKwWPbh7ODw9BAhFapjASNdLOU1lANUujbLxkGjTvT/0hS
 q7/EtkP3J90o9X6lrFeJJFqyVGO6q94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-NHxu0OOXPyey_xyZQAHk0A-1; Mon, 23 Mar 2020 00:40:13 -0400
X-MC-Unique: NHxu0OOXPyey_xyZQAHk0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEEB918B5F6A;
 Mon, 23 Mar 2020 04:40:11 +0000 (UTC)
Received: from kaapi (ovpn-112-176.phx2.redhat.com [10.3.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5AD194973;
 Mon, 23 Mar 2020 04:40:08 +0000 (UTC)
Date: Mon, 23 Mar 2020 10:10:06 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v5 0/3] net: tulip: add checks to avoid OOB access
In-Reply-To: <26c0091a-89f1-c956-efba-d1b2e4a13d76@redhat.com>
Message-ID: <nycvar.YSQ.7.76.2003231008390.5086@xnncv>
References: <20200319174050.759794-1-ppandit@redhat.com>
 <20f29d89-6d52-2edc-ef7e-13124908256a@redhat.com>
 <26c0091a-89f1-c956-efba-d1b2e4a13d76@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-2066220115-1584938411=:5086"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 Li Qiang <pangpei.lq@antfin.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---1463810047-2066220115-1584938411=:5086
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

+-- On Mon, 23 Mar 2020, Jason Wang wrote --+
| hw/net/tulip.c:305:20: error: initialization of =E2=80=98_Bool (*)(NetCli=
entState *)=E2=80=99
| {aka =E2=80=98_Bool (*)(struct NetClientState *)=E2=80=99} from incompati=
ble pointer type =E2=80=98int
| (*)(NetClientState *)=E2=80=99 {aka =E2=80=98int (*)(struct NetClientStat=
e *)=E2=80=99}
| [-Werror=3Dincompatible-pointer-types]
| =C2=A0=C2=A0=C2=A0=C2=A0 .can_receive =3D tulip_can_receive,
| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~

Strange, I did not get it.

| Prasad, please fix this and post a new version.
|=20
| While at it, I prefer to squash patch 3 into patch 2 since patch 3 fixes =
the
| issue introduced by patch 2.

Okay, sending your way shortly.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-2066220115-1584938411=:5086--


