Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E2BC32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412B321556
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2rXVcth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412B321556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvjw-0004B3-Gf
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuvj5-0003Av-UV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuvj5-0002XQ-2U
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:58:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35801
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuvj4-0002XE-Vx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579859886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0jdo5XUVGT+lUAJA1avy/XZlNPv3W9TA3B33bg/oT0=;
 b=A2rXVcthcSOCJj+5zBXvlGfnGAcdr19RfLh4Q9ritZFsYwZcuryJ9dGYaHLcsdc4Uyddy8
 3vgjbgz/DyLY17Nn+iHOYaTflVuzU7B4kbDfzQ9TqYoCZtS/d1RArGUVCk+cSJybD73XgX
 qC+L1RUlHaxOyn/quZtKHGFLjxwT0wQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-0FgFLIkFP4y64FXiwrnSIg-1; Fri, 24 Jan 2020 04:58:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FDE3100550E;
 Fri, 24 Jan 2020 09:58:02 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58D465DA75;
 Fri, 24 Jan 2020 09:57:53 +0000 (UTC)
Date: Fri, 24 Jan 2020 09:57:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2 051/109] virtiofsd: add seccomp whitelist
Message-ID: <20200124095750.GF2970@work-vm>
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-52-dgilbert@redhat.com>
 <877e1h426k.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
In-Reply-To: <877e1h426k.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 0FgFLIkFP4y64FXiwrnSIg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, misono.tomohiro@jp.fujitsu.com, stefanha@redhat.com,
 philmd@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Florian Weimer (fweimer@redhat.com) wrote:
> * David Alan Gilbert:
>=20
> > +static const int syscall_whitelist[] =3D {
> > +    /* TODO ireg sem*() syscalls */
> > +    SCMP_SYS(brk),
> > +    SCMP_SYS(capget), /* For CAP_FSETID */
> > +    SCMP_SYS(capset),
> > +    SCMP_SYS(clock_gettime),
>=20
> > +    SCMP_SYS(gettimeofday),
>=20
> Is this to suppose to work on 32-bit architectures?  Then you need to
> add the time64 system call variants as well.

Trying SCMP_SYS(time64) gives me an error for an undefined __NR_time64
on both 64 and 32 bit.

Dave

> Thanks,
> Florian
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


