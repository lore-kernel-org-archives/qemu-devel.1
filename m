Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0CAC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3396B20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dK+uj1ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3396B20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFI8b-0003dX-Di
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 09:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jFI7s-0002gT-NN
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jFI7r-0004cx-Ee
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:55:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jFI7r-0004bZ-6K
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584712550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KZsDyS8du2X8IrwYy32S91ORiVnWgKiobQAIvchR8l8=;
 b=dK+uj1ld/4Kp9kBnEl66jeb1EgWwc7iYLXmTsenFaYpxSV6kSJBueoQZLQsi9ebzJy9Eva
 lnhCAkbBcBE0/zfDr3gHc1Aej1JoMixRr3eR4fEz2SrxHtpPODG3TEgFzYXiumzZ0YjsUn
 jgu4N2H+O72Qd0DM1j1eZoCRCU0MSQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-LVNdzydZM-SXDU0odix4BA-1; Fri, 20 Mar 2020 09:55:45 -0400
X-MC-Unique: LVNdzydZM-SXDU0odix4BA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDC8E8010F3;
 Fri, 20 Mar 2020 13:55:43 +0000 (UTC)
Received: from work-vm (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62D005C1D8;
 Fri, 20 Mar 2020 13:55:33 +0000 (UTC)
Date: Fri, 20 Mar 2020 13:55:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/2] lockable: replaced locks with lock guard macros
 where appropriate
Message-ID: <20200320135531.GC3464@work-vm>
References: <20200320120456.1931482-1-dnbrdsky@gmail.com>
 <20200320120456.1931482-3-dnbrdsky@gmail.com>
 <20200320123348.GA3464@work-vm>
 <CA+ZmoZVp3M0oF-qVbwkBa=OcO_Q-uTYEO8J5-hXj=G4Rnu9yNQ@mail.gmail.com>
 <20200320125634.GB3464@work-vm>
 <d6b4cbe4-4cf8-7c27-036f-6e180c45e28b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d6b4cbe4-4cf8-7c27-036f-6e180c45e28b@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Daniel Brodsky <dnbrdsky@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 20/03/20 13:56, Dr. David Alan Gilbert wrote:
> >> According to https://wiki.qemu.org/ToDo/LockGuards cases that are triv=
ial (no
> >> conditional logic) shouldn't be replaced.
> > OK
>=20
> I don't think that has to be either-or.  Trivial lock/unlock sequences
> are not the first ones that should be converted, but there's an
> advantage in having a single patch that converts all possible uses of a
> lock.  Trivial sequences certainly do not belong in a bigger patch like
> this, as they would make the patch even bigger.
>=20
> > So for what you've already got there,
> >=20
> > For migration:
> > Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >=20
>=20
> Can you just extract that and queue it yourself (for 5.1 probably)?


I can, although it would be easier if Daniel did that; there's no rush
given it's for 5.1

> Paolo
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


