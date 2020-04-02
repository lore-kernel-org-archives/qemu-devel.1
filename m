Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1637C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAFA2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yooglni3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAFA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0Lc-0003SX-UZ
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jK0K5-00025E-Qz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jK0K4-0001nk-23
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:55:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32041
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jK0K3-0001kh-Ts
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585835755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZV9NEvn5qP2W7BQ9cyk8+ezsndFUr2YxbRfpaykVpKM=;
 b=Yooglni3aG0Kmp19aEb8ik3bpVLnzd6jdhdBi2DrKuNKQI/SYcWPxhtYrDm5VMiT2B2o6a
 cl2jUdYMTFEpSJqAUvboyYLy3t0Ja6LagS8/ce0aa1vJ3FrmX+km6FNo/OFWhLfThbGZda
 ZigLaEVSV+/5OXJ+5lt5ORL3B7pT7nY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-OYIpKYBZNuSKh-p5U_1JdQ-1; Thu, 02 Apr 2020 09:55:51 -0400
X-MC-Unique: OYIpKYBZNuSKh-p5U_1JdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1359218A6EC2;
 Thu,  2 Apr 2020 13:55:50 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 794465C1C5;
 Thu,  2 Apr 2020 13:55:49 +0000 (UTC)
Subject: Re: [PATCH for-5.0?] nbd: Attempt reconnect after server error of
 ESHUTDOWN
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200401223841.312793-1-eblake@redhat.com>
 <46a13f15-fab5-1742-5bd3-30fa59b4b430@virtuozzo.com>
 <8a44ab8d-5bb6-3ed6-59ce-9aa3aa4721c7@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <00440749-9418-b8a7-7417-b8756c221c62@redhat.com>
Date: Thu, 2 Apr 2020 08:55:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8a44ab8d-5bb6-3ed6-59ce-9aa3aa4721c7@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, rjones@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 8:33 AM, Eric Blake wrote:

>> Then, what about "SHOULD wait until no inflight requests"? We don't do=
=20
>> it either.. Should we?
>=20
> qemu as server doesn't send NBD_ESHUTDOWN.=C2=A0 It probably should (the =
way=20
> nbdkit does), but that's orthogonal to qemu as client responding to=20
> NBD_ESHUTDOWN.

Other things I want to document here based on an IRC conversation with Dave=
:

Our notion of reconnect-delay has a baked-in notion of timeout, but=20
selecting the right timeout can be difficult (how do you know it is long=20
enough to catch all the cases you care about where recovery will work,=20
but not so long that waiting for an actual timeout is not going to be=20
painful when recovery is not possible).  And the qemu block layer=20
already has the notion of pausing the guest on certain errors (whether=20
that be just on ENOSPC, or on all errors), to give the management all=20
the time it needs to resolve the problem and then resume the guest.

There's also the issue of TCP timeouts - if the server manages to send=20
shutdown(SHUT_WR) before the connection dies, the client gets an instant=20
EOF and can be pretty responsive to the need to start the retry cycle.=20
But if the connection dies without a clean shutdown, the client may be=20
stuck waiting several seconds for a TCP timeout to occur before=20
realizing that things are down (use of TCP keep-alive may or may not=20
help here) - management apps may be able to figure out from other means=20
when an NBD server is having issues long before qemu itself sees the TCP=20
connection go down.  In that case, having a way for the client to=20
trigger shutdown(SHUT_RD) in order to speed up disconnection, rather=20
than waiting for a TCP timeout, can come in handy.

Or, if we have a multipath scenario, where we know that several IP=20
addresses will serve the same underlying storage, we may just need a way=20
to reopen an existing NBD blockdev but with a different IP address to=20
the server.

All of this implies we may want to add a QMP command to force a given=20
NBD blockdev to attempt a reconnect now, rather than having to wait for=20
a TCP connection death to let us know that a reconnect is the only way=20
forward, or even as a way to make sure that we can resume the guest=20
after it was paused due to I/O error.  I don't know if the existing=20
'x-blockdev-reopen' can be extended to cover our needs, or if we need=20
something completely new.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


