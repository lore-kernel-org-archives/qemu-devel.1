Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F955C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C925214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azb8I0qC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C925214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvsk-0007ez-7O
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fweimer@redhat.com>) id 1iuvrU-0006Eb-3K
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fweimer@redhat.com>) id 1iuvrT-0002XF-24
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:06:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58064
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fweimer@redhat.com>) id 1iuvrS-0002X7-V8
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579860406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74C+5iWMNbx/6qzkfaGhSiws9DNP9mgMM2ZEaHlfVvw=;
 b=Azb8I0qCXT1FrbWxEuGc2WwsA1i/m5fcPjb5v//5UK6OVHxlOTdwOdxrQ/CHnGc39AdaCf
 5iSOc2im6bjjt4thzJ+0YvAA/YMhLNeyJRGWfEZwGWgW9pHkE7n2tzSoHD3Bl2Mrohexkh
 YkqCAQAChFG4Cby8roMRZUcA4fKJfok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-w7YJt3BHN5StT3PbXL9q5A-1; Fri, 24 Jan 2020 05:06:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E43C3DBF0;
 Fri, 24 Jan 2020 10:06:41 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-227.str.redhat.com
 [10.33.192.227])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C84719C69;
 Fri, 24 Jan 2020 10:06:33 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 051/109] virtiofsd: add seccomp whitelist
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-52-dgilbert@redhat.com>
 <877e1h426k.fsf@oldenburg2.str.redhat.com>
 <20200124095750.GF2970@work-vm>
Date: Fri, 24 Jan 2020 11:06:32 +0100
In-Reply-To: <20200124095750.GF2970@work-vm> (David Alan Gilbert's message of
 "Fri, 24 Jan 2020 09:57:50 +0000")
Message-ID: <87tv4l2mon.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: w7YJt3BHN5StT3PbXL9q5A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, misono.tomohiro@jp.fujitsu.com, stefanha@redhat.com,
 philmd@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Alan Gilbert:

> * Florian Weimer (fweimer@redhat.com) wrote:
>> * David Alan Gilbert:
>>=20
>> > +static const int syscall_whitelist[] =3D {
>> > +    /* TODO ireg sem*() syscalls */
>> > +    SCMP_SYS(brk),
>> > +    SCMP_SYS(capget), /* For CAP_FSETID */
>> > +    SCMP_SYS(capset),
>> > +    SCMP_SYS(clock_gettime),
>>=20
>> > +    SCMP_SYS(gettimeofday),
>>=20
>> Is this to suppose to work on 32-bit architectures?  Then you need to
>> add the time64 system call variants as well.
>
> Trying SCMP_SYS(time64) gives me an error for an undefined __NR_time64
> on both 64 and 32 bit.

Sorry, time64 does not exist, Userspace is supposed to use
clock_gettime64 with CLOCK_REALTIME_COARSE.

I actually meant that you'll also need futex_time64, ppoll_time64,
recvmmsg_time64, utimensat_time64.  (Based on cursory checking against
the permit list you posted.)

And for a port to 32-bit RISC-V, I think the 32-bit syscalls need to be
protected by #ifdef because new 32-bit architectures do not have them
anymore.

Thanks,
Florian


