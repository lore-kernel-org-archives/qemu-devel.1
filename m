Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A49C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24067206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GG//sx79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24067206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNXi8-0003id-4c
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kNXfg-0001r8-Ap
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kNXfd-0007sx-AS
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:41:07 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601455264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=uJzf10SJSxm+ZRTiuDYGpQsT/QyTqR8iLJnGqOGcp1c=;
 b=GG//sx7900aEt2s/mCp5g+9aZuOXSZ/qSrJM8n6XP5/RnECJR0FoueVXV7kcfDb3KCYFI4
 bKeVzQTUbLasr32nhdB4JRtIAIxhAJNleWbFL9f/6+PhgsmOFlMCD//1hQfml2+TXVqOT2
 ikdugoLL/AUrW5AIHWhUSb9o/HjT6tQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-Ed8cB_0UOxefbIYd3QDBdg-1; Wed, 30 Sep 2020 04:41:01 -0400
X-MC-Unique: Ed8cB_0UOxefbIYd3QDBdg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42517839A48
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 08:41:00 +0000 (UTC)
Received: from localhost (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E29825D9D3;
 Wed, 30 Sep 2020 08:40:59 +0000 (UTC)
Date: Wed, 30 Sep 2020 09:40:59 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org, kwolf@redhat.com
Subject: Some comments on using qemu-storage-daemon
Message-ID: <20200930084058.GA29698@redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

I understand that QSD is at an early stage of development and I'm sure
you have plans to fix these things.  Nevertheless here are my comments
after trying to add an interop test with libnbd.

(1) Documentation!  (Or complete lack of it ...)  I had to ask Kevin
how to construct the command line because several things were not
obvious.  In particular the --blockdev parameters only make sense if
you're already used to constructing blockdev parameters (and these
are, separately, not well-documented).  And you have to supply the
parameters in a particular order on the command line, else it doesn't
work.

(2) There seems to be no --pid-file option, so there's no way of
knowing when the server is ready to accept connections, except to
start QSD and then "sleep for a bit".

(3) Seems to be no support for either serving requests over
stdin/stdout (qemu-nbd also lacks this, but it's common for other NBD
servers); or for systemd socket activation (qemu-nbd supports this).

(4) Some parameter names changed between 5.1 and upstream.  I
understand that you're still finalizing the command line, so this
isn't a problem in itself, but others who try to use QSD will need to
be aware of it.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/


