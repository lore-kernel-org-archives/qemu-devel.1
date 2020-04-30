Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FBC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B122120757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWfHgKx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B122120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7eU-0006Wy-V2
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jU7dr-00068E-8S
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jU7dq-0003Rt-1y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:46:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jU7dp-0003RO-Im
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588247167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/m/f/9yVkLqu578nRcXpwbjRGRY2huj7eqAlnF2uBs=;
 b=YWfHgKx8fZqZaPcY5SRtM+Ho2WTN0q4eolNLIURpF5eGICOseZ/L8vMCU/1u/0YYDRw/2S
 m8Z0AgRth2Me5BNnmcoybO55n/vgd78fDcUW3jzw6RsUEp6kTG19uGSgv/ymW2Zln9lk1h
 tLOd0dHxOkofEAMRBn3P6hBEXWr0YFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-T8eoytAJPri4x9nmJKG7YQ-1; Thu, 30 Apr 2020 07:46:03 -0400
X-MC-Unique: T8eoytAJPri4x9nmJKG7YQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECBA5800D24;
 Thu, 30 Apr 2020 11:46:01 +0000 (UTC)
Received: from localhost (unknown [10.40.208.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71F02396;
 Thu, 30 Apr 2020 11:46:00 +0000 (UTC)
Date: Thu, 30 Apr 2020 13:45:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: Error "cannot bind memory to host NUMA nodes: Operation not
 permitted" running inside docker
Message-ID: <20200430134558.20ef46a5@redhat.com>
In-Reply-To: <20200430085215.GD2084570@redhat.com>
References: <76d8eb61-e89e-0465-974b-6901a5fb848e@physnet.uni-hamburg.de>
 <20200430085215.GD2084570@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 09:52:15 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, Apr 29, 2020 at 11:40:32PM +0300, Manuel Hohmann wrote:
> > Hi,
> >=20
> > I encountered the following error message on the QEMU 5.0.0 release, co=
mpiled and run inside a docker image:
> >=20
> > "cannot bind memory to host NUMA nodes: Operation not permitted" =20
>=20
> The error is reporting that mbind() failed.
>=20
> mbind() man page says it gives EPERM when
>=20
>   "The  flags argument included the MPOL_MF_MOVE_ALL flag and
>    the caller does not have the CAP_SYS_NICE privilege."
>=20
> QEMU always uses the MPOL_MF_MOVE flag though.
>=20
> Looking at the kernel source,  mbind can also return EPERM if the
> process is not permitted to access the requested nodes which seems
> more plausible as a cause.
>=20
> I guess the container the bound to some sub-set of nodes and QEMU is
> trying to place the VM on different nodes that the container isn't
> allowed to accesss.


mbind call in this case should be nop since it's 'reapplying' the same defa=
ult policy
the RAM was allocated with (modulo flags which are not issue in this defaul=
t case).

It looks like there is configuration issue with container (blacklisted mbin=
d) [2]
Is it possible to try run container with '--security-opt seccomp=3Dunconfin=
ed'
to see if it's the issue.

From QEMU side we may skip mbind if hostnodes bitmap is empty to workaround
the issue.
But I'm not sure if it should be done instead of whitelisting mbind in cont=
ainer,
since usecases that are using host-nodes will still be broken due to blackl=
isted mbind.
(looks like mysql has the same [1] problem (but it just warning for them, s=
o it's not so severe issue),
and they were inclined towards fixing container config)


> > The QEMU command line to reproduce this behavior (it happens also on -x=
86_64, -arm, -aarch64 with similar command line):
> >=20
> > qemu-system-i386 -m 64 -M pc -smp 1 -display none -monitor stdio -drive=
 file=3Dmp-acpi/NOS.iso,media=3Dcdrom,id=3Dd -boot order=3Dd -d cpu_reset =
=20
>=20
> There is no reference to host mem backend or NUMA binding, so I'm
> puzzled why QEMU would be doing an mbind() at all. That seems bad.

since 5.0 all guest RAM allocation was consolidated around hostmem.

>=20
>=20
> Regards,
> Daniel

2)
     https://github.com/docker-library/mysql/issues/303
1)
     https://docs.docker.com/engine/security/seccomp/


