Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E1C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8383820787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUau32fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8383820787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU4wK-0005NT-M9
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU4vh-0004ph-JA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU4vg-0002il-M2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:52:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30186
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jU4vg-0002ib-9A
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588236743;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qk6r9Y/aagQuOGqM+LEtEGsMmjoTQjxQPAS9SsvqYAE=;
 b=RUau32fo4bGg35cyryyViZQ3McIk9KHxiibD9CLV3og8F5JGw9cnPQ4MokR3T8w5Hd/n5q
 I1B6fjVgo6mKgTJB/IuV57sx6SGyUdfv4MK9I8z06ZpW7kkiQC5WKHaTdFI2Ed37CGXa7J
 kC3UM46faobOFVeWx1i9poLQVDx1MF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-KJ73o3E3MXiWUtkAiG8d_Q-1; Thu, 30 Apr 2020 04:52:21 -0400
X-MC-Unique: KJ73o3E3MXiWUtkAiG8d_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28DA01054F9F;
 Thu, 30 Apr 2020 08:52:20 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BD2C5C1BE;
 Thu, 30 Apr 2020 08:52:18 +0000 (UTC)
Date: Thu, 30 Apr 2020 09:52:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>
Subject: Re: Error "cannot bind memory to host NUMA nodes: Operation not
 permitted" running inside docker
Message-ID: <20200430085215.GD2084570@redhat.com>
References: <76d8eb61-e89e-0465-974b-6901a5fb848e@physnet.uni-hamburg.de>
MIME-Version: 1.0
In-Reply-To: <76d8eb61-e89e-0465-974b-6901a5fb848e@physnet.uni-hamburg.de>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 11:40:32PM +0300, Manuel Hohmann wrote:
> Hi,
>=20
> I encountered the following error message on the QEMU 5.0.0 release, comp=
iled and run inside a docker image:
>=20
> "cannot bind memory to host NUMA nodes: Operation not permitted"

The error is reporting that mbind() failed.

mbind() man page says it gives EPERM when

  "The  flags argument included the MPOL_MF_MOVE_ALL flag and
   the caller does not have the CAP_SYS_NICE privilege."

QEMU always uses the MPOL_MF_MOVE flag though.

Looking at the kernel source,  mbind can also return EPERM if the
process is not permitted to access the requested nodes which seems
more plausible as a cause.

I guess the container the bound to some sub-set of nodes and QEMU is
trying to place the VM on different nodes that the container isn't
allowed to accesss.

>=20
> The QEMU command line to reproduce this behavior (it happens also on -x86=
_64, -arm, -aarch64 with similar command line):
>=20
> qemu-system-i386 -m 64 -M pc -smp 1 -display none -monitor stdio -drive f=
ile=3Dmp-acpi/NOS.iso,media=3Dcdrom,id=3Dd -boot order=3Dd -d cpu_reset

There is no reference to host mem backend or NUMA binding, so I'm
puzzled why QEMU would be doing an mbind() at all. That seems bad.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


