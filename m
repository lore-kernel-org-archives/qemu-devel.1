Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E900C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A530207FF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHSo8oFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A530207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0TB-0007gE-AW
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1jK0SR-0006o5-HJ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1jK0SP-00083v-Tl
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:04:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1jK0SP-0007za-MJ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585836272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvZBl8W17W7++xGsE8P+WkkLIAjI9wa50EKnwR88Q8A=;
 b=DHSo8oFJbkngxmHjgBStDuYXULYPdOEAnE2r773NbrRKSnSA7CCUIBHyv0ODVFMtVaLHNM
 f/ea4TRnA50wceWni3jps/MEVBtlBD/orlABYgnFSess5qtOcgWtEIv7BWbd4DlT+3mJAi
 EnRqLroYH2cRZ5aapQuLwanapvF+22g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-0T2RtWAHOOWseccjGvmNoQ-1; Thu, 02 Apr 2020 10:04:29 -0400
X-MC-Unique: 0T2RtWAHOOWseccjGvmNoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D23F18A5514;
 Thu,  2 Apr 2020 14:04:28 +0000 (UTC)
Received: from localhost (ovpn-112-30.ams2.redhat.com [10.36.112.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE33E89F0A;
 Thu,  2 Apr 2020 14:04:27 +0000 (UTC)
Date: Thu, 2 Apr 2020 15:04:26 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-5.0?] nbd: Attempt reconnect after server error of
 ESHUTDOWN
Message-ID: <20200402140426.GJ3888@redhat.com>
References: <20200401223841.312793-1-eblake@redhat.com>
 <20200402083826.GY3888@redhat.com>
 <6b66952d-24a4-593c-2160-8c2877e42f49@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6b66952d-24a4-593c-2160-8c2877e42f49@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 08:41:31AM -0500, Eric Blake wrote:
> On 4/2/20 3:38 AM, Richard W.M. Jones wrote:
> >For the case I care about (long running virt-v2v conversions with an
> >intermittent network) we don't expect that nbdkit will be killed nor
> >gracefully shut down.  Instead what we expect is that nbdkit returns
> >an error such as NBD_EIO and keeps running.
> >
> >Indeed if nbdkit actually dies then reconnecting will not help since
> >there will be no server to reconnect to.

To put this in context for other people reading, virt-v2v uses this
sort of situation:

<pre>
                          +---------- same machine ----------+
                          |                                  |
  +------------+            +----------+        +----------+
  | remote     |            | nbdkit   |        | qemu-img |
  | VMware     |----------->| + VDDK   |------->| convert  |--> output
  | server     |            |          |        |          |
  +------------+            +----------+        +----------+
             VMware proprietary      NBD over Unix skt
             protocol over TCP
</pre>

The problem being addressed is that the whole task can run for many
hours, and a single interruption in the network between virt-v2v and
the remote VMware server can cause the entire process to fail.
nbdkit-retry-filter[0] attempts to address the problem by allowing the
VMware side of the protocol to be restarted without qemu-img seeing
any interruption (nor any error) on the NBD connection.

[0] http://libguestfs.org/nbdkit-retry-filter.1.html

> Hmm.  The idea of reconnect-delay in qemu is that if the connection
> to the server is dropped, we try to reconnect and then retry the I/O
> operation.  Maybe what we want is an nbdkit filter which turns EIO
> errors from the v2v plugin into forced server connection drops, but
> leave nbdkit up and running to allow the next client to connect.

Note that of the three nbdkit plugins we currently use (vddk[1], curl
and ssh) at least two of them have the property that closing and
reopening the plugin handle (which is what nbdkit-retry-filter does)
reconnects to the remote server.  To take nbdkit-ssh-plugin as a
specific example[2], the .open callback calls ssh_connect() and the
.close callback calls ssh_disconnect().  VDDK works the same way.  I'm
a bit unclear on nbdkit-curl-plugin because IIRC underlying HTTPS
connections may be managed in a pool inside Curl.

[1] All in this file, starting here:
https://github.com/libguestfs/virt-v2v/blob/8cf4488d6bcde8dd0b84c199c96ff57=
63e6a08fa/v2v/nbdkit_sources.ml#L142

[2] https://github.com/libguestfs/nbdkit/blob/d085b87dcbe05c9c2d0049f0fc613=
455490c1032/plugins/ssh/ssh.c#L468

> That's different from the existing --filter=3Dretry behavior (where we
> try to keep the client connection alive and reopen the plugin), but
> has a similar effect (because we force the connection to the client
> to drop, the client would have to reconnect to get more data, and
> reconnecting triggers a retry on connecting to the plugin).

I get that this is different from the retry filter, but isn't this
just working around behaviour in qemu's NBD client?  Couldn't qemu's
NBD client be changed to reconnect on EIO?  Or retry?  (Optionally of
course, and this would be orthogonal the current patch.)

> And it's different from --filter=3Dexitlast (that says to quit nbdkit
> altogether, rather than just the current connection with a client).

We'd certainly need a new nbdkit_* API, rather like the way we added
nbdkit_shutdown to make nbdkit-exitlast-filter possible.  However I'm
still unclear if the new filter's behaviour would be necessary.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org


