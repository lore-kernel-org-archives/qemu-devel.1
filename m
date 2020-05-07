Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788EEC47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4307F208D6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GndBY8N/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4307F208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWjFs-0004O7-EM
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 12:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jWjEx-0003wN-Bq
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:19:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26841
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jWjEw-0002VU-2b
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588868352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQXyZfXby0uC+Gd+Q/92Y8G7Z/N+m3sT33Qo0XzpTp8=;
 b=GndBY8N/Gq+UAvsJTg0Xj4DKS0XLfdced7Ncx9DF18B2uVqFFhyy0uI6f3AkHB10pq7o2H
 KsYTMb/2lcUrKyIcnSYgCHsyDxNOqqw0RDj3fAx+vq8s8DElVMcIfifMjacfat3+Kb5y5h
 m6dqRead3Wyj0Eff7mJFV7jlLio2moA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-p32K0elkOPi5SUuOxB8rcw-1; Thu, 07 May 2020 12:19:10 -0400
X-MC-Unique: p32K0elkOPi5SUuOxB8rcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7017A461
 for <qemu-devel@nongnu.org>; Thu,  7 May 2020 16:19:09 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B44E52618B;
 Thu,  7 May 2020 16:19:00 +0000 (UTC)
Date: Thu, 7 May 2020 18:18:57 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: device hotplug & file handles
Message-ID: <20200507161857.GK2102825@angien.pipo.sk>
References: <20200507144914.4zg3753uh3kytz6g@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200507144914.4zg3753uh3kytz6g@sirius.home.kraxel.org>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 07, 2020 at 16:49:14 +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> For usb device pass-through (aka -device usb-host) it would be very
> useful to pass file handles from libvirt to qemu.  The workflow would
> change from ...
>=20
>   (1) libvirt enables access to /dev/usb/$bus/$dev
>   (2) libvirt passes $bus + $dev (using hostbus + hostaddr properties)
>       to qemu.
>   (3) qemu opens /dev/usb/$bus/$dev
>=20
> ... to ...
>=20
>   (1) libvirt opens /dev/usb/$bus/$dev
>   (2) libvirt passes filehandle to qemu.
>=20
> Question is how can we pass the file descriptor best?  My idea would be
> to simply add an fd property to usb-host:
>=20
>  * Coldplug would be "-device usb-host,fd=3D<nr>" (cmd line).
>  * Hotplug would be "device_add usb-host,fd=3D<getfd-name>" (monitor).

We have prior art for both approaches so it's fine.

>=20
> Will that work from libvirt point of view?

Sure! Just please make sure that the new approach is detectable somehow.
Either via device-list-properties or query-qmp-schema.

> Or does anyone have an better idea?
>=20
> thanks,
>   Gerd
>=20
> PS: background: https://bugzilla.redhat.com/show_bug.cgi?id=3D1595525
>=20


