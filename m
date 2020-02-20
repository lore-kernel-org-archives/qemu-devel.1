Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AF3C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E7D2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dX6gvD1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E7D2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4o4X-0001b8-Bo
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j4o3S-0000tn-Cp
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j4o3Q-00042N-O6
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:47:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49909
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j4o3Q-00041o-JR
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582213675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uhtMXF5FFxc2/unL+RRKcNbEnonRIkrURtv56szQebQ=;
 b=dX6gvD1ft3KVmzEUI/TjTwkhNDGOSzHVQVv8WqHRc4cBJBEwpGHOcCNkGF0pfFMQHSDa0m
 Zn1zxL6rVY+GSqMSd/Y6ea5W4CMtJTbUb8YVW/mDXWCzkN8IIcHzXiKmejY9b+HCYp9v89
 kbf3AlhVNA2s5GDHSKuY0JLfTBUCXyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358--BSToj-OOgK1o-CTEm7UcQ-1; Thu, 20 Feb 2020 10:47:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB55A800D54;
 Thu, 20 Feb 2020 15:47:46 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DFD45C1B0;
 Thu, 20 Feb 2020 15:47:45 +0000 (UTC)
Date: Thu, 20 Feb 2020 15:47:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: wuchenye1995 <wuchenye1995@gmail.com>
Subject: Re: A problem with live migration of UEFI virtual machines
Message-ID: <20200220154742.GC2882@work-vm>
References: <tencent_3CD8845EC159F0161725898B@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_3CD8845EC159F0161725898B@qq.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: -BSToj-OOgK1o-CTEm7UcQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "devel@edk2.groups.io" <devel@edk2.groups.io>,
 edk2-devel <edk2-devel@lists.01.org>, zhoujianjay <zhoujianjay@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* wuchenye1995 (wuchenye1995@gmail.com) wrote:

> We found a problem with live migration of UEFI virtual machines due to si=
ze of OVMF.fd changes.</div><div class=3D" selfdiv" style=3D"height: 79.687=
5px; width: auto !important;"
> Specifically, the size of OVMF.fd in edk with low version such as edk-2.0=
-25 is <b>2MB</b> while the size of it in higher version such as edk-2.0-30=
 is <b>4MB</b>.
>   When we migrate a UEFI virtual machine from the host with low version o=
f edk2 to the host with higher one, qemu component will report an error in =
function
> qemu_ram_resize while
>checking size of ovmf_pcbios: Length mismatch: pc.bios: 0x200000 in !=3D 0=
x400000: Invalid argument.
>We want to know how to solve this problem after updating the version of ed=
k2.

When you migrate, you must migrate between identical configurations; so
you need ROM images (including edk2) that are the same size.
There's two answers;
   a) Stick with the same version of the ROM between VMs you want to
migrate
   b) Pad your ROM images to some larger size (e.g. 8MB) so that
even if they grow a little bigger then you don't hit the problem.

Dave
P.S. Please use plain text email

Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


