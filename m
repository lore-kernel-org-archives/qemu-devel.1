Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D06C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD632064A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cH0QG+1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD632064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSznT-0002oT-8n
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jSzmq-0002H2-TZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jSzmq-0007iG-D1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:10:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20171
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jSzmq-0007hw-04
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587978646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/2L/pwvwsS+OiuPC9I/hqI9WRnvk90O+TD4cN+0JiE=;
 b=cH0QG+1Bv7Nab2nNte9D8HqWSfJUBNpl6I2CMo7FKXGmIR6xbkeS4kXPWLtaLpQDVemPXG
 1teiGLiM+DW1RDQzL3nzGKU8dDwP14fty8/LukOYqHynPCu7NXAJ4WezG+fA6/8aVEf2dW
 NZv/Dg6OxpE1u0TlPX9lPWRy0FYeuiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-sjVuvcXXMcOrNkaezAHdbw-1; Mon, 27 Apr 2020 05:10:45 -0400
X-MC-Unique: sjVuvcXXMcOrNkaezAHdbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57171100960F;
 Mon, 27 Apr 2020 09:10:44 +0000 (UTC)
Received: from gondolin (ovpn-112-184.ams2.redhat.com [10.36.112.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B5C91001281;
 Mon, 27 Apr 2020 09:10:40 +0000 (UTC)
Date: Mon, 27 Apr 2020 11:10:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: VIRTIO_NET_HDR_F_RSC_INFO in virtio-net vs headers update
Message-ID: <20200427111029.703f8703.cohuck@redhat.com>
In-Reply-To: <8a559698-fb15-1f38-2fad-ee5db27f81f4@redhat.com>
References: <20200427093345.4111acd9.cohuck@redhat.com>
 <8a559698-fb15-1f38-2fad-ee5db27f81f4@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Apr 2020 16:41:30 +0800
Jason Wang <jasowang@redhat.com> wrote:

>=20
> On 2020/4/27 =E4=B8=8B=E5=8D=883:33, Cornelia Huck wrote:
> > Hi,
> >
> > I'm currently trying to prepare a linux-headers update to 5.7-rc3,
> > which adds the definition of VIRTIO_NET_HDR_F_RSC_INFO.
> >
> > Unfortunately, this breaks the build of virtio-net, because now
> > virtio_net_rsc_ext_num_{packets,dupacks} are undefined (they are
> > guarded by existence of VIRTIO_NET_HDR_F_RSC_INFO).
> >
> > What is the right way to fix this? Remove the constants that are now
> > provided by the header and keep the definitions of
> > virtio_net_rsc_ext_num_{packets,dupacks}?
>=20
>=20
> We probably need to add a version of the above function when=20
> VIRTIO_NET_HDR_F_RSC_INFO is defined as attached.
>=20
> But I fail to understand why we need a fallback when=20
> VIRTIO_NET_HDR_F_RSC_INFO is not defined.

Yes, the current code in virtio-net looks a bit odd, which is why I
asked.

I see two options:
- do the change you proposed, do the headers update, and then rip out
   the compat handling
- do the above in a single step

I'd prefer the second option.

>=20
> Thanks
>=20
>=20
> >
> > [I'd like to queue a headers update as soon as possible, as the whole
> > s390 protected virt stuff depends on it...]
> >
> >


