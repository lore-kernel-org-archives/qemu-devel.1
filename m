Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B65BC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7271C20796
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbzAUER+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7271C20796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3Rl-0003rH-8K
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kO3I6-0002Uf-5j
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kO3I3-0003g4-8B
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601576805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ug2dSzNyCknWd3vNp8ruLKo2y1jdJv8/9E1z8F3lk1s=;
 b=KbzAUER+dS6dgYDXdF8rUzN9qH4eCmfeWLS6rqOGrylcfMyA+1ah3ij3uGA1WNg79t7zzc
 O5tjJpvX6M7X+RTVoiGenl1gzfXeqeHSx5Fo7LFjSlbtXz88nsAibDx5qBnAy5FMEpoTOR
 DMHn8UJ4/kk3Kv3oVnYRoSGCdNX9WUE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-skqEdxZyPXW-9QuRUZSPDQ-1; Thu, 01 Oct 2020 14:26:44 -0400
X-MC-Unique: skqEdxZyPXW-9QuRUZSPDQ-1
Received: by mail-qk1-f197.google.com with SMTP id y17so3652408qkf.15
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 11:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uxnpeNNLiwCrYnxUHmMRHP84r6STuKUsqh9Nd7Cualk=;
 b=Tt9Wave/ZEjvapRyoSLCNMqT1zLKbFbP/EQA2w/30qAbwzzPVps4r3CbWbXCc7QPci
 /N2+0qVP0/TcazTtd44C+e3FO+XFkunkYXTGTXVgd3Bx1sJIiUNKXI1jx+tJiUUUPAGq
 i+lC3t/J3xJeGFBVtvtju0KYwxQhQYfZrLMJObVnkul2kFR6tYmfOGmxR5FV6bTNcVpb
 3Z/jhbCSOI/MzL5NMHveNyZmg49/qKR9/Xt8MZO7N6c+P2UUF8hEzpBQ+GIWEYWlnqsY
 SECvAqTuUFn4M2yDRBp/nujpo2ygk8PmYdKCVlNsc5ZylUWWEPQyJgjTaBeEq5JpTcVa
 hfAA==
X-Gm-Message-State: AOAM532LT0lgUUzHt8INShG/4tfymjykYMlYP9W1VvpOgAHDYoaEenEc
 XkR7jcMcIEsfYkdK0hNevgJDWnP7aO+icICrLbnmBSsqCUW0+FDPdcOv/xnqQAcBkOVw/3284SG
 8r7fd8G0shtiOu08=
X-Received: by 2002:a05:620a:209e:: with SMTP id
 e30mr9320474qka.373.1601576803553; 
 Thu, 01 Oct 2020 11:26:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrJTJG6y6YdU0gVfXa75w3pB2anb4Gg3UXysbVedYcl2pQxFBsCZvUOrN06n/45O5s6zfGqg==
X-Received: by 2002:a05:620a:209e:: with SMTP id
 e30mr9320440qka.373.1601576803134; 
 Thu, 01 Oct 2020 11:26:43 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
 by smtp.gmail.com with ESMTPSA id v56sm7892699qtc.49.2020.10.01.11.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 11:26:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] migration/postcopy: Sync faulted addresses after
 network recovered
Date: Thu,  1 Oct 2020 14:26:37 -0400
Message-Id: <20201001182641.80232-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:=0D
- fix build on 32bit hosts & rebase=0D
- remove r-bs for the last 2 patches for Dave due to the changes=0D
=0D
v2:=0D
- add r-bs for Dave=0D
- add patch "migration: Properly destroy variables on incoming side" as pat=
ch 1=0D
- destroy page_request_mutex in migration_incoming_state_destroy() too [Dav=
e]=0D
- use WITH_QEMU_LOCK_GUARD in two places where we can [Dave]=0D
=0D
We've seen conditional guest hangs on destination VM after postcopy recover=
ed.=0D
However the hang will resolve itself after a few minutes.=0D
=0D
The problem is: after a postcopy recovery, the prioritized postcopy queue o=
n=0D
the source VM is actually missing.  So all the faulted threads before the=
=0D
postcopy recovery happened will keep halted until (accidentally) the page g=
ot=0D
copied by the background precopy migration stream.=0D
=0D
The solution is to also refresh this information after postcopy recovery.  =
To=0D
achieve this, we need to maintain a list of faulted addresses on the=0D
destination node, so that we can resend the list when necessary.  This work=
 is=0D
done via patch 2-5.=0D
=0D
With that, the last thing we need to do is to send this extra information t=
o=0D
source VM after recovered.  Very luckily, this synchronization can be=0D
"emulated" by sending a bunch of page requests (although these pages have b=
een=0D
sent previously!) to source VM just like when we've got a page fault.  Even=
 in=0D
the 1st version of the postcopy code we'll handle duplicated pages well.  S=
o=0D
this fix does not even need a new capability bit and it'll work smoothly on=
 old=0D
QEMUs when we migrate from them to the new QEMUs.=0D
=0D
Please review, thanks.=0D
=0D
Peter Xu (4):=0D
  migration: Pass incoming state into qemu_ufd_copy_ioctl()=0D
  migration: Introduce migrate_send_rp_message_req_pages()=0D
  migration: Maintain postcopy faulted addresses=0D
  migration: Sync requested pages after postcopy recovery=0D
=0D
 migration/migration.c    | 51 +++++++++++++++++++++++++++++++++--=0D
 migration/migration.h    | 21 ++++++++++++++-=0D
 migration/postcopy-ram.c | 26 +++++++++++++-----=0D
 migration/savevm.c       | 57 ++++++++++++++++++++++++++++++++++++++++=0D
 migration/trace-events   |  3 +++=0D
 5 files changed, 149 insertions(+), 9 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


