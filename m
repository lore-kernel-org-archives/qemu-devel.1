Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673B7CA9EC2
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 07:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347D020830
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 07:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXbrNuGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347D020830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPLZb-0004nv-9u
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 03:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iPLYQ-0003fJ-HX
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 03:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iPLYN-0001Ax-CN
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 03:04:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55842
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iPLYN-0001A5-0E
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 03:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572332669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPbas3/90kGt65ZIolAisSzNDWlD4aHOq/Tnv05/ijc=;
 b=RXbrNuGaJzKeZPHxzDKs2XVsLe8a6M7RDN6Lk7i92nLq7mf5iVzSuxhXAUgsSptzCMWo7W
 XvzBd4KD0N0SqjEjP2cl/zb1Bm2oTMOp0e6BEd0LJ1IZGP5LoL05Sko1pGllAA8fJRCEgI
 cqyMi1azGR5S7b6wx9go8wkdxroCCWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-4sKHfeA9PbOR3Zd65TWUvA-1; Tue, 29 Oct 2019 03:04:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E22A5E6;
 Tue, 29 Oct 2019 07:04:23 +0000 (UTC)
Received: from work-vm (ovpn-116-127.ams2.redhat.com [10.36.116.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B19619C4F;
 Tue, 29 Oct 2019 07:04:21 +0000 (UTC)
Date: Tue, 29 Oct 2019 07:04:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH] migration: check length directly to make
 sure the range is aligned
Message-ID: <20191029070419.GA16329@work-vm>
References: <20190712032704.7826-1-richardw.yang@linux.intel.com>
 <20190719175400.GJ3000@work-vm>
 <0fd200f7-ad92-d753-23ca-8c89a27fd346@redhat.com>
 <20190719180651.GM3000@work-vm> <20191028011015.GA3893@richard>
MIME-Version: 1.0
In-Reply-To: <20191028011015.GA3893@richard>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4sKHfeA9PbOR3Zd65TWUvA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> On Fri, Jul 19, 2019 at 07:06:51PM +0100, Dr. David Alan Gilbert wrote:
> >* Paolo Bonzini (pbonzini@redhat.com) wrote:
> >> On 19/07/19 19:54, Dr. David Alan Gilbert wrote:
> >> >> -        if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
> >> >> -            error_report("ram_block_discard_range: Unaligned end a=
ddress: %p",
> >> >> -                         host_endaddr);
> >> >> +        if (length & (rb->page_size - 1)) {
> >> >> +            error_report("ram_block_discard_range: Unaligned lengt=
h: %lx",
> >> >> +                         length);
> >> > Yes, I *think* this is safe, we'll need to watch out for any warning=
s;
> >>=20
> >> Do you mean compiler or QEMU warning?
> >
> >No, I mean lots of these error reports being printed out in some common
> >case.
> >
>=20
> Hi, Dave
>=20
> Haven't see you for a period of time :-)

I'm here (although been busy with virtiofs) - but this patch is exec.c
so I think it needs to be picked by Paolo or rth.

Dave

> >Dave
> >
> >  The patch is safe since there's an
> >>=20
> >>     if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
> >>         error_report("ram_block_discard_range: Unaligned start address=
: %p",
> >>                      host_startaddr);
> >>         goto err;
> >>     }
> >>=20
> >> just before this context.
> >>=20
> >> Paolo
> >--
> >Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
> --=20
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


