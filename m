Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE16C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7682D2137B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpSCwl4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7682D2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUbLw-0002f7-MN
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 15:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUbLG-0001q1-7o
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jUbLF-0003u5-1V
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:28:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39474
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUbLE-0003qm-IK
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588361334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LAT7NKnVZIEU9bYz1mNrCAWi1/kppmkvpU4S/a2ZqYE=;
 b=YpSCwl4GuNWpbO/vqYKn9CYriBdwL4nB12N8+1kaCTHH6nRdEnIke6tRBVoubVJyzBEsP2
 kgCAZixo7iqOVMhk5HWPAmgrufOlfsnqBUP0rPc87v6frMx0uSRgR+3OXVD6oCOON13nM+
 lsBENEwRaukngEqjYBR71s2tWHedjMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-QkHj_DnWPjGVYA2n9alQPA-1; Fri, 01 May 2020 15:28:52 -0400
X-MC-Unique: QkHj_DnWPjGVYA2n9alQPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B35328014D6;
 Fri,  1 May 2020 19:28:51 +0000 (UTC)
Received: from work-vm (ovpn-112-191.ams2.redhat.com [10.36.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C961361527;
 Fri,  1 May 2020 19:28:47 +0000 (UTC)
Date: Fri, 1 May 2020 20:28:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-stable@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 yavrahami@paloaltonetworks.com, mszeredi@redhat.com, mreitz@redhat.com
Subject: Re: [PULL 0/6] virtiofs queue
Message-ID: <20200501192845.GB3374@work-vm>
References: <20200501191500.126432-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200501191500.126432-1-dgilbert@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 12:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear Stable,
  From this series, the fixes:

       virtiofsd: add --rlimit-nofile=3DNUM option
       virtiofsd: stay below fs.file-max sysctl value (CVE-2020-10717)

and
       virtiofsd: Show submounts

should probably be backported.

Dave

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> The following changes since commit 1c47613588ccff44422d4bdeea0dc36a0a308e=
c7:
>=20
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2020-04-30 19:25:41 +0100)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.com/dagrh/qemu.git tags/pull-virtiofs-20200501
>=20
> for you to fetch changes up to 66502bbca37ca7a3bfa57e82cfc03b89a7a11eae:
>=20
>   virtiofsd: drop all capabilities in the wait parent process (2020-05-01=
 20:05:37 +0100)
>=20
> ----------------------------------------------------------------
> virtiofsd: Pull 2020-05-01 (includes CVE fix)
>=20
> This set includes a security fix, other fixes and improvements.
>=20
> Security fix:
> The security fix is for CVE-2020-10717 where, on low RAM hosts,
> the guest can potentially exceed the maximum fd limit.
> This fix adds some more configuration so that the user
> can explicitly set the limit.
> Thank you to Yuval Avrahami for reporting this.
>=20
> Fixes:
>=20
> Recursive mounting of the exported directory is now used in
> the sandbox, such that if there was a mount underneath present at
> the time the virtiofsd was started, that mount is also
> visible to the guest; in the existing code, only mounts that
> happened after startup were visible.
>=20
> Security improvements:
>=20
> The jailing for /proc/self/fd is improved - but it's something
> that shouldn't be accessible anyway.
>=20
> Most capabilities are now dropped at startup; again this shouldn't
> change any behaviour but is extra protection.
>=20
> ----------------------------------------------------------------
> Max Reitz (1):
>       virtiofsd: Show submounts
>=20
> Miklos Szeredi (1):
>       virtiofsd: jail lo->proc_self_fd
>=20
> Stefan Hajnoczi (4):
>       virtiofsd: add --rlimit-nofile=3DNUM option
>       virtiofsd: stay below fs.file-max sysctl value (CVE-2020-10717)
>       virtiofsd: only retain file system capabilities
>       virtiofsd: drop all capabilities in the wait parent process
>=20
>  tools/virtiofsd/fuse_lowlevel.h  |   1 +
>  tools/virtiofsd/helper.c         |  47 ++++++++++++++++++
>  tools/virtiofsd/passthrough_ll.c | 102 ++++++++++++++++++++++++++++++++-=
------
>  3 files changed, 133 insertions(+), 17 deletions(-)
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


