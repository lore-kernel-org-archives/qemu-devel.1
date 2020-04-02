Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D4EC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A0E206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0ouXRBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A0E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzyx-00075A-FW
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJzyK-0006aZ-AX
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJzyI-0003yI-8B
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:33:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29421
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJzyI-0003uf-4g
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585834404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKdwN1ZbfKM26wIdzhABv8E/8viNUsyudRha7tdkDmI=;
 b=R0ouXRBdgoxFMZsKQ3qEBLYZNbhRxQLPLzd6tOXYhvXLIYxrz33YM7803B7QCN5JbLZ0jV
 shKLnR4oB7boaOy6v7rbA8ekJ7pZjcQFKRnn8xVskDrNvAS6LNyZ9tutYhF0prg7kV11nq
 4vwiAMm7IBRDUx6qeUHecGNXv2hFFW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-CmkAwBJINcO-lUrtarocJA-1; Thu, 02 Apr 2020 09:33:22 -0400
X-MC-Unique: CmkAwBJINcO-lUrtarocJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68BF4100550D;
 Thu,  2 Apr 2020 13:33:21 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9057B5C290;
 Thu,  2 Apr 2020 13:33:20 +0000 (UTC)
Subject: Re: [PATCH for-5.0?] nbd: Attempt reconnect after server error of
 ESHUTDOWN
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200401223841.312793-1-eblake@redhat.com>
 <46a13f15-fab5-1742-5bd3-30fa59b4b430@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8a44ab8d-5bb6-3ed6-59ce-9aa3aa4721c7@redhat.com>
Date: Thu, 2 Apr 2020 08:33:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <46a13f15-fab5-1742-5bd3-30fa59b4b430@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 1:41 AM, Vladimir Sementsov-Ogievskiy wrote:
> 02.04.2020 1:38, Eric Blake wrote:
>> I was trying to test qemu's reconnect-delay parameter by using nbdkit
>> as a server that I could easily make disappear and resume.=C2=A0 A bit o=
f
>> experimenting shows that when nbdkit is abruptly killed (SIGKILL),
>> qemu detects EOF on the socket and manages to reconnect just fine; but
>> when nbdkit is gracefully killed (SIGTERM), it merely fails all
>> further guest requests with NBD_ESHUTDOWN until the client disconnects
>> first, and qemu was blindly failing the I/O request with ESHUTDOWN
>> from the server instead of attempting to reconnect.
>>
>> While most NBD server failures are unlikely to change by merely
>> retrying the same transaction, our decision to not start a retry loop
>> in the common case is correct.=C2=A0 But NBD_ESHUTDOWN is rare enough, a=
nd
>> really is indicative of a transient situation, that it is worth
>> special-casing.

>=20
> Interesting. I see, that prior to this patch we don't handle ESHUTDOWN=20
> at all in nbd client..
>=20
> What does spec say?
>=20
>  > On a server shutdown, the server SHOULD wait for inflight requests to=
=20
> be serviced prior to initiating a hard disconnect. A server MAY speed=20
> this process up by issuing error replies. The error value issued in=20
> respect of these requests and any subsequently received requests SHOULD=
=20
> be NBD_ESHUTDOWN.
>  > If the client receives an NBD_ESHUTDOWN error it MUST initiate a soft=
=20
> disconnect.

Perhaps the spec should be relaxed to state that a client SHOULD=20
initiate soft disconnect (as there are existing clients that do not).=20
If a server knows it wants to initiate hard disconnect soon, it=20
shouldn't be forced to wait for a client to respond to NBD_ESHUTDOWN,=20
since not all clients do.  Then again, it is indeed nicer if the client=20
does initiate soft disconnect (as soft is always cleaner than hard).

>  > The client MAY issue a soft disconnect at any time, but SHOULD wait=20
> until there are no inflight requests first.
>  > The client and the server MUST NOT initiate any form of disconnect=20
> other than in one of the above circumstances.
>=20
> Hmm. So, actually we MUST initiate a soft disconnect, which means that=20
> we must send NBD_CMD_DISC..

With this patch as-is, qemu as client initiates hard disconnect in=20
response to NBD_ESHUTDOWN (but only if it plans on trying to reconnect).

>=20
> Then, what about "SHOULD wait until no inflight requests"? We don't do=20
> it either.. Should we?

qemu as server doesn't send NBD_ESHUTDOWN.  It probably should (the way=20
nbdkit does), but that's orthogonal to qemu as client responding to=20
NBD_ESHUTDOWN.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


