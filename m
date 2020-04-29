Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A31C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2523208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDmX9axw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2523208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTphA-00069k-0F
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 12:36:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTpdm-0003vA-Ex
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTpdR-0000Be-Ks
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:32:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35883
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jTpdR-0000Aj-7i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588177951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPRqGwMHYyWNEs/hhIFQyBceombwQe0ItezAjUP0P20=;
 b=YDmX9axw56bwkr94EKDepV/pAbvviUAPb6pI4HOw8zBZcUqzhja/F2AGFE27BNhyGmFfLQ
 kkwOnZLYQ6JOhi1YdyvjcKytGUowhhdFI1TFxUZasYhJ+zad4tBxE2g7TTd4laI3gdlzgj
 1tMxcd48PcwA1bDTdPO4O1M5rvu7LDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-AVXhVYhzOlqeUZ4cZCIKKQ-1; Wed, 29 Apr 2020 12:32:29 -0400
X-MC-Unique: AVXhVYhzOlqeUZ4cZCIKKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F25780572D
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 16:32:28 +0000 (UTC)
Received: from work-vm (ovpn-114-192.ams2.redhat.com [10.36.114.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1582661520;
 Wed, 29 Apr 2020 16:32:20 +0000 (UTC)
Date: Wed, 29 Apr 2020 17:32:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: jail lo->proc_self_fd
Message-ID: <20200429163218.GM2834@work-vm>
References: <20200429124733.22488-1-mszeredi@redhat.com>
 <20200429152659.GA134868@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200429152659.GA134868@stefanha-x1.localdomain>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Wed, Apr 29, 2020 at 02:47:33PM +0200, Miklos Szeredi wrote:
> > While it's not possible to escape the proc filesystem through
> > lo->proc_self_fd, it is possible to escape to the root of the proc
> > filesystem itself through "../..".
> >=20
> > Use a temporary mount for opening lo->proc_self_fd, that has it's root =
at
> > /proc/self/fd/, preventing access to the ancestor directories.
> >=20
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
>=20
> Good idea!
>=20
> It's important to note that the proc file system is already mounted
> within a new pid namespace.  Therefore the only process visible is our
> own process and we don't need to worry about /proc/$PID.  However, there
> are a bunch of other files in /proc.  Some of them are protected by
> capability checks like /proc/kcore and virtiofsd is unable to access
> them, but it's hard to guarantee that they are all off limits.  Better
> safe than sorry!
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks; I've picked this up.

Dave

> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


