Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CFEC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6424E206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpBE8v6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6424E206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHryR-0000JN-LT
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jHrxh-00080M-QY
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jHrxg-0005Dq-Gt
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:36:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41523)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jHrxg-0005D3-DN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585326960;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGvmcFvskFL2QoyLFa/xybc/QFXFYo55FoW9kfBiyNk=;
 b=CpBE8v6TC0WSKLzN+vi44IW0hB3L33N8lq6dZ0RWEYrRjiLJclNxwmfXu1ofh82LkSTSvq
 RW1+ZTlhMzCuxsMKWdyYbrZidk/4GX4GBbt5cWs7TRQH1HlpL5/CCK/k06awqRO7XtM3Zo
 HcP7sE0DoFBtc+aikBUxLlpQo9YGI2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-n4AdHK_COFOthv1o3dWFww-1; Fri, 27 Mar 2020 12:35:56 -0400
X-MC-Unique: n4AdHK_COFOthv1o3dWFww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A6511007269;
 Fri, 27 Mar 2020 16:35:54 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EE4219925;
 Fri, 27 Mar 2020 16:35:51 +0000 (UTC)
Date: Fri, 27 Mar 2020 16:35:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 3/3] nbd: Use shutdown(SHUT_WR) after last item sent
Message-ID: <20200327163548.GP1619@redhat.com>
References: <20200327161936.2225989-1-eblake@redhat.com>
 <20200327161936.2225989-4-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200327161936.2225989-4-eblake@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 11:19:36AM -0500, Eric Blake wrote:
> Although the remote end should always be tolerant of a socket being
> arbitrarily closed, there are situations where it is a lot easier if
> the remote end can be guaranteed to read EOF even before the socket
> has closed.  In particular, when using gnutls, if we fail to inform
> the remote end about an impending teardown, the remote end cannot
> distinguish between our closing the socket as intended vs. a malicious
> intermediary interrupting things, and may result in spurious error
> messages.

Does this actually matter in the NBD case ?

It has an explicit NBD command for requesting shutdown, and once
that's processed, it is fine to just close the socket abruptly - I
don't see a benefit to a TLS shutdown sequence on top.
AFAIK, the TLS level clean shutdown is only required if the
application protocol does not have any way to determine an
unexpected shutdown itself.

This is relevant for HTTP where the connection data stream may not
have a well defined end condition.

In the NBD case though, we have an explicit NBD_CMD_DISC to trigger
the disconnect. After processing that message, an EOF is acceptable
regardless of whether ,
before processing that message, any EOF is a unexpected.

>           Or, we can end up with a deadlock where both ends are stuck
> on a read() from the other end but neither gets an EOF.

If the socket has been closed abruptly why would it get stuck in
read() - it should see EOF surely ?

>                                                          Thus, after
> any time a client sends NBD_OPT_ABORT or NBD_CMD_DISC, or a server has
> finished replying (where appropriate) to such a request, it is worth
> informing the channel that we will not be transmitting anything else.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


