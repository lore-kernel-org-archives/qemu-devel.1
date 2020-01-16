Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E26C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1116E20748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dfc9ku3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1116E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6bZ-0007Et-84
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1is6au-0006Q2-4X
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1is6aq-0007yR-Jc
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:58:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1is6aq-0007y4-GZ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579186675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i60m9e8tMfEi+qimoetZDnfJap1BHGDS5lxvOYe9I6w=;
 b=Dfc9ku3xWNuaR66ucEA46EMvORxzkFAqOFXPvUYhi4v850bRgE2tRpvf5i9t90jxW1gVJi
 fp/wmgoHgWaXxiZnXqI0uMCOl7lHg/MdhzfGahmy7G8es7sWZHZip+0NwqYm9ohih2I+BA
 CV8h+A9n5cIM5RXgcXk1N82G1WHuMio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-rHMw8OvnPa2P0QMXZnMKNQ-1; Thu, 16 Jan 2020 09:57:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBE02113784D;
 Thu, 16 Jan 2020 14:57:51 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63F2719488;
 Thu, 16 Jan 2020 14:57:51 +0000 (UTC)
Subject: Re: Bug? qemu-img convert to preallocated image makes it sparse
To: Max Reitz <mreitz@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mlevitsk@redhat.com,
 sgarzare@redhat.com
References: <20200116141352.GA32053@redhat.com>
 <962aa54b-f6e5-bb43-50a0-c4cad59cd22e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <75daaf8f-0bfe-d3f6-5df4-88c29b2d9b07@redhat.com>
Date: Thu, 16 Jan 2020 08:57:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <962aa54b-f6e5-bb43-50a0-c4cad59cd22e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: rHMw8OvnPa2P0QMXZnMKNQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 8:47 AM, Max Reitz wrote:

> So when you convert to the target image, you have to make sure all areas
> that are zero in the source are zero in the target, too.  The way we do
> that is to write zeroes to the target.  The problem is that this
> operation disregards the previous preallocation and discards the
> preallocated space.
>=20
> As for fixing the bug...  Can we fix it in qemu(-img)?
>=20
> We could try to detect whether areas that are zero in the source are
> zero in the (preallocated) target image, too.  But doing so what require
> reading the data from those areas and comparing it to zero.  That would
> take time and it isn=E2=80=99t trivial.  So that=E2=80=99s something I=E2=
=80=99d rather avoid.

Can't we also use block status queries on the destination, as that is=20
likely to be faster than actual reads and comparison to zero?


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


