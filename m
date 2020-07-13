Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E486C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264FF2065E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7g+WROQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264FF2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv1Gm-0000gS-Ea
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv1Fg-00007l-O1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:24:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34230
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv1Fe-0003BT-7o
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594657455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=46Aa7HQbelRoFd6K8aVf/RQJENnJDc7oJtWPvk5gBjY=;
 b=i7g+WROQ1ITzTQD1HOSEsIkPkr5MPqxOGmBc83RmSwGzsZnYkaEeyBwQgUOdlwV2AKrOEZ
 2drQXpRVPXZzcK2x4/RWGrVtmGZmi3z3qw+SWHKvdJEjcrw4DPyzK7RhjYlSbQPGIWSI3R
 36mKV7LxJh8A4d/d0mmbL/N5ZZCgVUc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-3jbfN8oKMpS6sqA-MdZy8g-1; Mon, 13 Jul 2020 12:24:13 -0400
X-MC-Unique: 3jbfN8oKMpS6sqA-MdZy8g-1
Received: by mail-wm1-f70.google.com with SMTP id y204so68141wmd.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 09:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VmfMFWru+ksyQxzfSYOq8kbeP1yFqA4FJRlOADc6/cc=;
 b=gaCyYLqD1qra1vgdsT3BOwAqOVzd69JEl/9wNbHF/Fw5TlVRc+V8S7IkKSnyNQ71+T
 P/PY6ZL26/Qzg8B4/TIjUlAPAFniGXd5qLKeFgfWalo/NlcYGXPYMKVyf8lFw/9MSOg4
 oRNE/4UflUUmf6wNT+oOC/n7yTiL863sFbxT8dIzG59BOYJZUP3w06HgvpMuZs/zjehw
 YfxKHpWmcCTHYVuNb06bB+bI08WIFJ7sNU4BC61U0XYFWiqXXVuwnlnRTsbD0MqNgzRk
 zeoJgsrgw1YOK4PAiaqznfDTLbMoPQ1SQpwvwNvy2BXuCILY8CsijiYRQboNd4i9jJjv
 fGtg==
X-Gm-Message-State: AOAM530/dSPom6t8EanwwrS5+HlnjEtP80URP6aHy8B4fnF4po91Vd9X
 vqU4oQf/GYIeWx53Tr9NtwzbU7ddi9+izOCnxmOMO9vgqy+I+RmTSiIq8CA7XcKZj/4+pSd9o4S
 dWQUxBdqi49IDkK0=
X-Received: by 2002:a1c:2ec4:: with SMTP id u187mr159110wmu.188.1594657452306; 
 Mon, 13 Jul 2020 09:24:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuBDIkn39c0idILDD1KhXPUPDgbT1QEgpJrZePDMxdltY7TfMejo5TPEU4L57igNjZsFcCtg==
X-Received: by 2002:a1c:2ec4:: with SMTP id u187mr159094wmu.188.1594657452085; 
 Mon, 13 Jul 2020 09:24:12 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id y77sm138642wmd.36.2020.07.13.09.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 09:24:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] Migration Pull request
Date: Mon, 13 Jul 2020 18:24:07 +0200
Message-Id: <20200713162410.11577-1-quintela@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: quintela@trasno.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It includes several fixes:=0D
=0D
- fix qemu_fclose(denis)=0D
- remove superfluous breaks (liao)=0D
- fix memory leak (zheng)=0D
=0D
Please apply=0D
=0D
[v1 & v2]=0D
=0D
There was one error on the huawei address of the 1st patch and mail=0D
was bouncing.  Fixed.=0D
=0D
Denis V. Lunev (1):=0D
  migration/savevm: respect qemu_fclose() error code in save_snapshot()=0D
=0D
Liao Pingfang (1):=0D
  migration/migration.c: Remove superfluous breaks=0D
=0D
Zheng Chuan (1):=0D
  migration: fix memory leak in qmp_migrate_set_parameters=0D
=0D
 migration/migration.c | 6 ++----=0D
 migration/savevm.c    | 8 ++++++--=0D
 2 files changed, 8 insertions(+), 6 deletions(-)=0D
=0D
--=20=0D
2.25.4=0D
=0D


