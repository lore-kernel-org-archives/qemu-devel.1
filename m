Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A74C83007
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40D8206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AknJTEwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40D8206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTLwt-0004Yo-TN
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jTLtM-0003ZV-Ad
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jTLh5-00024z-Fz
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:38:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48796
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jTLh4-00024q-Vp
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588062857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BqnNMVBvmUNzhtynmKa7yzagUHsDnlU1Sz+5OIh5CgQ=;
 b=AknJTEwO3nyQ3K7imhrYIB3obchnpAoZU3NCFfBUnR/+xNlmEta8i7KUasoo2JlbIOByWU
 1RNodc1v3r04QTCzgPfE2Q/ZRMXuNneddl/tclJ7PWHv0NwrruPdTXT967KS3nEX7BoHim
 SEkvSr9wKEg20blMQ+sLri8IzMbJOgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-sIeFilLGOt61NLyupGTSMQ-1; Tue, 28 Apr 2020 04:34:15 -0400
X-MC-Unique: sIeFilLGOt61NLyupGTSMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A730800D24;
 Tue, 28 Apr 2020 08:34:14 +0000 (UTC)
Received: from gondolin (ovpn-112-178.ams2.redhat.com [10.36.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 589945D9E2;
 Tue, 28 Apr 2020 08:34:10 +0000 (UTC)
Date: Tue, 28 Apr 2020 10:34:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/3] virtio-net: remove VIRTIO_NET_HDR_F_RSC_INFO compat
 handling
Message-ID: <20200428103407.12612838.cohuck@redhat.com>
In-Reply-To: <7f703bea-2cae-dcdc-71bd-9623c7db33ac@redhat.com>
References: <20200427102415.10915-1-cohuck@redhat.com>
 <20200427102415.10915-4-cohuck@redhat.com>
 <7f703bea-2cae-dcdc-71bd-9623c7db33ac@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Apr 2020 16:19:15 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2020/4/27 =E4=B8=8B=E5=8D=886:24, Cornelia Huck wrote:
> > VIRTIO_NET_HDR_F_RSC_INFO is available in the headers now.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   hw/net/virtio-net.c | 8 --------
> >   1 file changed, 8 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index e85d902588b3..7449570c7123 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -77,14 +77,6 @@
> >      tso/gso/gro 'off'. */
> >   #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
> >  =20
> > -/* temporary until standard header include it */
> > -#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
> > -
> > -#define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields *=
/
> > -#define VIRTIO_NET_F_RSC_EXT       61
> > -
> > -#endif
> > -
> >   static inline __virtio16 *virtio_net_rsc_ext_num_packets(
> >       struct virtio_net_hdr *hdr)
> >   { =20
>=20
>=20
> I think we should not keep the those tricky num_packets/dup_acks.

No real opinion here, patch 3 is only a cleanup.

The important one is patch 1, because without it I cannot do a headers
update.


