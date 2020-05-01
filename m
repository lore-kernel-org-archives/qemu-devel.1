Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A919EC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704262166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZHkBn4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704262166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUZhX-0005I3-It
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 13:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUZgc-0004Ze-SP
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jUZgY-0003lH-D0
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:42:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55833
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUZgX-0003fZ-TG
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588354967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CagzegPX9P82/0sJ0/I0A3qaWQuPCopVGmkckj1kZzA=;
 b=VZHkBn4dUJ+DhBmFr859y/rUZXz8AU3i++xlpeRQ7brNYP42GaS0DVbpsitW9+oVfOww40
 2GJlR64RiTaQUgzuUO14AE0IqKO5ELs83eP8d3FGV7ZlwKxMl9Luo67GlyRfajJIGq4wGS
 9xU79NDtorr7Kr0dP/KkR+l4MvHQarQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-6tSCeVMIMMu4sqrMdOKjlw-1; Fri, 01 May 2020 13:42:46 -0400
X-MC-Unique: 6tSCeVMIMMu4sqrMdOKjlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6399D835B40
 for <qemu-devel@nongnu.org>; Fri,  1 May 2020 17:42:45 +0000 (UTC)
Received: from work-vm (ovpn-112-191.ams2.redhat.com [10.36.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 850B65C1BE;
 Fri,  1 May 2020 17:42:35 +0000 (UTC)
Date: Fri, 1 May 2020 18:42:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 0/2] virtiofsd: stay under fs.file-max sysctl limit
 (CVE-2020-10717)
Message-ID: <20200501174233.GA38251@work-vm>
References: <20200501140644.220940-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200501140644.220940-1-stefanha@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 13:42:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, vgoyal@redhat.com,
 pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> This patch series introduces the --rlimit-nofile=3DNUM option for setting=
 the
> number of open files on the virtiofsd process.  This gives users and mana=
gement
> tools more control over resource limits.
>=20
> Previously it was possible for FUSE clients on machines with less than ~1=
0 GB
> of RAM to exhaust the system-wide open file limit.  This is a denial of s=
ervice
> attack against other processes running on the host.
>=20
> This patch series updates the default RLIMIT_NOFILE calculation to take t=
he
> fs.file-max sysctl value into account.  This solves the fs.file-max DoS.

Queued.

> Stefan Hajnoczi (2):
>   virtiofsd: add --rlimit-nofile=3DNUM option
>   virtiofsd: stay below fs.file-max sysctl value (CVE-2020-10717)
>=20
>  tools/virtiofsd/fuse_lowlevel.h  |  1 +
>  tools/virtiofsd/helper.c         | 47 ++++++++++++++++++++++++++++++++
>  tools/virtiofsd/passthrough_ll.c | 22 ++++++---------
>  3 files changed, 56 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.25.3
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


