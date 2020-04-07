Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185CEC2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1E9206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJizmHP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1E9206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkVK-0001I4-Ps
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jLkRi-0003R4-5A
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jLkRh-0001FW-2z
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:23:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45512
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jLkRg-0001F6-VK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586251380;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bIkcehhb7OPhwm/zxUQzVJyR7RK05NU6I+4eyQpuVY=;
 b=GJizmHP2aWsxzduVNa04PzA+vR5wgfctKyAk0yUqPOtyN3xIHGhYNYuP0StB1/vTYjZBOH
 BXqKcYzqH5D4yn5WoJHYz7MCF6R8xaVr4cC+MEBQ0NWYSvFvxPVZbgfgpJF5/B/xXdBqhZ
 9r5yuLMuTex4kd2QIredgUO8IbjLKaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-3dsuHItdP-OWujVKGAC3Xg-1; Tue, 07 Apr 2020 05:22:53 -0400
X-MC-Unique: 3dsuHItdP-OWujVKGAC3Xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 374FE800D50;
 Tue,  7 Apr 2020 09:22:52 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B7749D37E;
 Tue,  7 Apr 2020 09:22:50 +0000 (UTC)
Date: Tue, 7 Apr 2020 10:22:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: gokul cg <gokuljnpr@gmail.com>
Subject: Re: X86: Abnormal variation in Freebsd VM launch time w.r.t freebsd
 guest config
Message-ID: <20200407092246.GC843246@redhat.com>
References: <CAFP4jM8RpUXCxUN_J-Enkx_LZU67Vbn45voGBLHH3CG0ELi2Vg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFP4jM8RpUXCxUN_J-Enkx_LZU67Vbn45voGBLHH3CG0ELi2Vg@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 07, 2020 at 09:59:59AM +0530, gokul cg wrote:
> Hi Team,
>=20
> We are observing abnormal variation in VM launch time w.r.t guest config.
>=20
> A simple VM(2gb ram no passthrough device) creation takes usually 6sec
> (Time from execution of 'virsh create guest.xml  to get print "Welcome to
> FreeBSD"' ),but when we add a USB passthrough device launch time increase=
d
> to 18-19 sec and further increased to 39-44sec when we have increased gue=
st
> ram to 48Gb.

snip.

> Note : 1) This we have seen with legacy pci passthrough device not with
> vfio. And we have not noticed any perfoance impact other than qemu-init/v=
m
> laucn time .

Legacy pci passthrough support was deleted way back to 2017, and we had
deprecated it for 2 years before then, in favour of VFIO.

>  Any suggestions to improve launch time with legacy passthrough ?

Just stop using legacy PCI assignment. VFIO has been the recommended
impl for 5+ years now.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


