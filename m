Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF1EC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C54E20842
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9trqlih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C54E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isTH7-0008QA-7r
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 10:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isTGO-0007us-Gr
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isTGJ-0006sD-UO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:10:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isTGI-0006qT-P2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579273813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2DY4j93tXIVFncA4lAI3dKxOHGP8OOque1jQcH8GKk=;
 b=c9trqlih/+r6PaMIvjSRh2lJvuWyKJbM9JtxtPz7nAvuoVMRsajqkoo51ny+OMngTi8N1+
 1ez6q9dO5bTRDMlglNLpL0ynegGJv+ZO7eWBfEBORQl6NQr3vn2JW0kcLp32TOviqgbBg0
 ccOxBlOIzadEHth8AFk5gFD6Y10bAG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-mDaST11YP1G7vE48CFif6Q-1; Fri, 17 Jan 2020 10:10:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 237C7477
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 15:10:11 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53D2E84343;
 Fri, 17 Jan 2020 15:10:07 +0000 (UTC)
Date: Fri, 17 Jan 2020 15:10:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/2] vhost: Only align sections for vhost-user
Message-ID: <20200117151004.GI3209@work-vm>
References: <20200116202414.157959-1-dgilbert@redhat.com>
 <20200116202414.157959-3-dgilbert@redhat.com>
 <4bf72509-3e60-0d78-c2ba-665a71a978e1@redhat.com>
 <20200117083232-mutt-send-email-mst@kernel.org>
 <ca54fc82-828b-158b-fadb-07abfbb9418f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ca54fc82-828b-158b-fadb-07abfbb9418f@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: mDaST11YP1G7vE48CFif6Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: jasowang@redhat.com, vkuznets@redhat.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 17/01/20 14:40, Michael S. Tsirkin wrote:
> > We don't really need v2 just to add a field. Compatibility is maintaine=
d
> > using feature bits. Adding that is a subject for another patch.
> > But I'm not sure I understand why does remote need to know about alignm=
ent.
> > This patch seems to handle it locally ...
>=20
> Because the remote vhost here will not be able to use the synic regions.
>  If it did, it would have the same overlap problem as vhost-kernel.
>=20
> The alignment is needed because, even if you are mapping only [768k,1M)
> of a 2M hugepage, you need to mmap [0,2M).  You can then discard the
> rest, but IIUC if you only mmap [768k,1M) then the kernel will fail the
> mmap.

The vhost-user problem is worse than that.

Lets ignore the synic regions for a minute;  imagine a normal PC,
0-512k ish, and a 512k-1GB map; the client side can do the alignment
to allow an mmap to work for each of those two mappings, you then
end up with two mmap's on the client, both aligned at 0, each covering
part of the same range.  If the client is careful in normal use it can
make sure it's OK, but you do end up with two mappings which is odd.
Once you add userfault for psotcopy, having those two mappings of the same
range gets even more problematic when we wait for one of the pages
to become available.

The other problem is that there's a limited number of slots for mappings
in the vhost-user protocol; and they easily get filled up if you
break up the memory ranges.

Doing the aggregation on the qemu side keeps your slot usage down and
also removes the problem of the double mappings.

The client can't easily resolve the double mapping alignment because it
can't tell if the two fd's it's been passed actually refer to the
same backing file; so it can't aggregate (from memory).

Dave



> Paolo
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


