Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F343C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE63621774
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTZFiwyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE63621774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaR5l-0005zZ-Q3
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 16:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iaP5f-0000MY-Iw
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iaP5T-0008Cb-JJ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:04:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52560
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iaP5O-00085f-VC
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574967854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HkIjpVMoK29zBry6sgENV6+GCi7g75x2CVM9YOheebk=;
 b=bTZFiwyANcO+qXT4adntcfKvYF+WBKb8dAmqSCs4qn2nobsp9Cp/yyPeT4PaPjWrpL98rO
 geCsFY9Ka0sw7NeJu6iUI/L9RzOZLzl3GYWEQvfRO7Iex8nlWhAAsSYiGG/qpS63JligaK
 hVA5Q/rYDWNiLcQ6Z22i/nAoak6Dbu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-cRtOlO5sNTGF13AolSc_JA-1; Thu, 28 Nov 2019 14:04:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07EA1107ACC7
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 19:04:12 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06F805D6D2;
 Thu, 28 Nov 2019 19:04:10 +0000 (UTC)
Date: Thu, 28 Nov 2019 19:04:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: libcap vs libcap-ng mess
Message-ID: <20191128190408.GC3294@work-vm>
MIME-Version: 1.0
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: cRtOlO5sNTGF13AolSc_JA-1
X-Mimecast-Spam-Score: 0
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
Cc: pbonzini@redhat.com, thuth@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
  We seem to have a bit of a mess with libcap and libcap-ng; and I'm not
sure if we should try and untangle it.

a) Our configure script has tests for both libcap and libcap-ng
  for libcap it says $cap, for libcap-ng it says $cap_ng (ok)
  If $cap is set - nothing happens?
  If $cap_ng is set - we define CONFIG_LIBCAP  (!)

b) We use both
  1) pr-helper and bridge-helper use CONFIG_LIBCAP and use cap-ng
  2) 9p's virtfs-proxy-helper uses libcap - it's got a check in
     configure to make sure you have libcap if you've asked for 9p

c) Our gitlab-ci.yml installs libcap-dev to get the 9p stuff tested
  but never installes libcap-ng-dev

I hit this because we're using libcap in virtiofsd at the moment.

So hmm how to fix?
I'm tempted to:
  x) Replace CONFIG_LIBCAP by CONFIG_LIBCAPNG to make it clear
  y) Should we flip over to only using one or the other - what
     are the advantages?
  z) We should probably add the other one to the ci.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


