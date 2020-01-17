Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204ACC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53E120842
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IK6DmodF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53E120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWbp-0005hQ-1d
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isWb0-0005Bm-8c
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isWay-0003z7-Bl
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:43:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59007
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isWau-0003uq-OV
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579286623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2nleGmcIKVmDnkxj8DGMl3thpVl6D7h4XTl3zTd5J04=;
 b=IK6DmodFHM8P2YsKmdIevNRZ9bnxswHfpv7EBDtQ03jTRruogYnjOEGX9SLRiy08BsP/l6
 4gWCVnjf8vK5kR9Cy9Ymmp1sYABKRYLMJdEYYy2Vt6Xc3lnIBmicquiFIRe/5wgYXrFWIf
 iAPeXyyBQQf6JdGOiX/Syf6hK27wTcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-Hzaq_i3ZPpaLoLQiH6pZaA-1; Fri, 17 Jan 2020 13:43:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A32BF107ACC5;
 Fri, 17 Jan 2020 18:43:39 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE5D55C1B2;
 Fri, 17 Jan 2020 18:43:35 +0000 (UTC)
Date: Fri, 17 Jan 2020 18:43:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 072/104] virtiofsd: passthrough_ll: fix refcounting on
 remove/rename
Message-ID: <20200117184333.GR3209@work-vm>
References: <20191212163904.159893-73-dgilbert@redhat.com>
 <20200116115603.5415-1-misono.tomohiro@jp.fujitsu.com>
 <20200116164511.GJ3108@work-vm>
 <CAOssrKfO1PZkR-Fonxae_b2oAOQMgx0=vU8A2UvCNKsgthKMbg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOssrKfO1PZkR-Fonxae_b2oAOQMgx0=vU8A2UvCNKsgthKMbg@mail.gmail.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Hzaq_i3ZPpaLoLQiH6pZaA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
 Vivek Goyal <vgoyal@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Miklos Szeredi (mszeredi@redhat.com) wrote:
> On Thu, Jan 16, 2020 at 5:45 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > >
> > > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > >
> > > I'm not familiar with qemu convention but shouldn't we put
> > > at least one line of description like linux kernel?
> >
> > Miklos: would you like to suggest a better commit message?
>=20
> Hmm, the patch doesn't really make sense, since the looked up inode is no=
t used.
>=20
> Not sure what happened here, this seems to be for supporting shared
> versions, and these changes are part of commit 06f78a397f00
> ("virtiofsd: add initial support for shared versions") in our gitlab
> qemu tree.  Was this intentionally split out?

I think the reason I kept this here is because Stefan's
  'introduce inode refcount to prevent use-after-free'

does use the the inodes in lo_rename; is it also dependent on having
done the in lo_rmdir and lo_unlink?

Dave


> Thanks,
> Miklos
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


