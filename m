Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243C5C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8033020637
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Je2dmP3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8033020637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvrn-0001Ti-Tf
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iUvpk-0007g5-0p
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iUvpi-0008TM-SA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:49:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iUvpi-0008T0-O5
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573663770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8xyAFOsMdus7D4rGFJvNbB2xTR9kmAYPaWz+MEpoJw=;
 b=Je2dmP3eqsjO1b9FnyoKt3kVBYlWWEdlnx5rAZlj6Er5Jm11ebxXnjvwlJzrcxyl0VyYw9
 4ZPflK8+1DZ9m+TghYgOMoOjYYC6aCbFRlWb6HTIobL7/I5PMGnQ1RWIVxfSJC6EGrMTZz
 73+y90rHCPb5I5jglD3zD9LJ2/aejPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-DPPGL4oVOk2BbBFGhvceKg-1; Wed, 13 Nov 2019 11:49:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BD52803905;
 Wed, 13 Nov 2019 16:49:27 +0000 (UTC)
Received: from localhost (ovpn-116-59.gru2.redhat.com [10.97.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBF7C60563;
 Wed, 13 Nov 2019 16:49:24 +0000 (UTC)
Date: Wed, 13 Nov 2019 13:49:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] WHPX: refactor load library
Message-ID: <20191113164922.GI3812@habkost.net>
References: <MW2PR2101MB1116386CFE4628B6767D6CDBC07B0@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <MW2PR2101MB1116C3DF422DB5E301B74AEEC0770@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <20191112194738.GF3812@habkost.net>
 <017bdcd1-4058-c717-619a-d8362ac089b7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <017bdcd1-4058-c717-619a-d8362ac089b7@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: DPPGL4oVOk2BbBFGhvceKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Justin Terry \(VM\)" <juterry@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 05:35:59PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 11/12/19 8:47 PM, Eduardo Habkost wrote:
> > On Tue, Nov 12, 2019 at 06:42:00PM +0000, Sunil Muthuswamy wrote:
> > >=20
> > >=20
> > > > -----Original Message-----
> > > > From: Sunil Muthuswamy
> > > > Sent: Friday, November 8, 2019 12:32 PM
> > > > To: 'Paolo Bonzini' <pbonzini@redhat.com>; 'Richard Henderson' <rth=
@twiddle.net>; 'Eduardo Habkost' <ehabkost@redhat.com>; 'Stefan
> > > > Weil' <sw@weilnetz.de>
> > > > Cc: 'qemu-devel@nongnu.org' <qemu-devel@nongnu.org>; Justin Terry (=
VM) <juterry@microsoft.com>
> > > > Subject: [PATCH] WHPX: refactor load library
> > > >=20
> > > > This refactors the load library of WHV libraries to make it more
> > > > modular. It makes a helper routine that can be called on demand.
> > > > This allows future expansion of load library/functions to support
> > > > functionality that is depenedent on some feature being available.
> > > >=20
> > > > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > > ---
> > >=20
> > > Can I possibly get some eyes on this?
> >=20
> > I'd be glad to queue the patch if we get a Reviewed-by line from
> > somebody who understands Windows and WHPX.  Maybe Justin?
>=20
> Can we wait for approval from the Microsoft legal department first?
> So we can start testing WHPX builds, and reduce the possibilities to
> introduce regressions.
>=20
> Testing is ready, we are waiting for Microsoft to merge, see:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg646351.html

Making it easier for other people to test WHPX would be nice.
But in case this is not sorted out soon, I don't see a reason to
not merge WHPX changes if they are reviewed and approved by the
main author of that code (Justin).

--=20
Eduardo


