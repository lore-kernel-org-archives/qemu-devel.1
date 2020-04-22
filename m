Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B72C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F4F20882
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlGg2cAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F4F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRK17-00060G-Ky
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 14:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRJzU-0004vS-J2
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRJzT-0001jP-TD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:20:56 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:38826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jRJzT-0001ds-D3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:20:55 -0400
Received: by mail-qv1-xf42.google.com with SMTP id t8so1399273qvw.5
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:user-agent:mime-version
 :content-transfer-encoding;
 bh=/Zs9OmZianAaaUzo9zN00eGQ9xYS/iIR1p2LN3oNe0A=;
 b=LlGg2cAPGYp7xksYqBtzoRvXXA/FZMs69DFpXHGqkQbS3racb6InLVMM/A5FnzFhNn
 uE892zWGWEbFfa7uY4ao3NwMm36Ru6lDcOUk7/idHgg1Nrsp6MKc3FiRNY/GVDUWz0BC
 z29greYh76y6lYuIyeZpPeYxVypw7pCk2T2T+Cf7R3bfCQbzx48JE//KPXyAqORU7SBI
 SzkInLxUE817ISSo7etWvDuBP6IMw6rX/0YQKXJIvq8jc6UW5NMH+XYgmhOkxYmT2Pi0
 yDuyyAj+pL2dx8zLI2nBbRrJGFCRFnseWv5Fi8ScdBxNFOTrO6LG1nttCOdioMqe3gIm
 rdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
 :mime-version:content-transfer-encoding;
 bh=/Zs9OmZianAaaUzo9zN00eGQ9xYS/iIR1p2LN3oNe0A=;
 b=QJucqomtxjCTiL0GyHw1e8IqANWZbnYyJXhHAR0g0nVWvIa4VRXyX1BI37T8ulE0Ll
 Tli2iutMTnwXEWIMxMpzm40KwiSgifJ5WKAQU8VU77Dd44CCJq0ZlMh9S1IItceMNdOE
 rYq6/1h6Dj1hzzTgwl6cNbzvLbCMvDhNzDIl7A5SSPI4kLQy022k/XjuCypYmS7w4I0P
 KnD3sztYakB5yqfPuWjD76cz8G6ibNQHjf3d4VsqADRHsZ3UxWl2vpkM6HucwdcrYOCV
 jp1yMzE1ftbb7AQK1vN9luREtNeWu7FD2Mj59AwO0+qYvjJAEPCkGg+lVX67fVqdlY9n
 g6WA==
X-Gm-Message-State: AGi0PuaCfD509PZP1qeiHxKKjyOGC3hZaofvIdLw5fDeBdNv4C148+1O
 mA4rTdzfwLHKsMdIo6/W6mU=
X-Google-Smtp-Source: APiQypKS6RlLXFK5MegYBW4SWlQb6Y8j7VLWgK0X5Fs8vYnZlleYFNPoRip94wyl9pmmnplKSc0JYg==
X-Received: by 2002:a0c:e786:: with SMTP id x6mr213813qvn.11.1587579653704;
 Wed, 22 Apr 2020 11:20:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id o13sm4491143qke.77.2020.04.22.11.20.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Apr 2020 11:20:53 -0700 (PDT)
Subject: [PATCH v21 QEMU 0/5] virtio-balloon: add support for free page
 reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Wed, 22 Apr 2020 11:20:51 -0700
Message-ID: <20200422181649.12258.37077.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=alexander.duyck@gmail.com; helo=mail-qv1-xf42.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series provides an asynchronous means of reporting free guest pages
to QEMU through virtio-balloon so that the memory associated with those
pages can be dropped and reused by other processes and/or guests on the
host. Using this it is possible to avoid unnecessary I/O to disk and
greatly improve performance in the case of memory overcommit on the host.

As of April 7th this functionality has been enabled in Linus's kernel
tree[1] and so I am submitting the QEMU pieces for inclusion.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc

Changes from v17:
Fixed typo in patch 1 title
Addressed white-space issues reported via checkpatch
Added braces {} for two if statements to match expected coding style

Changes from v18:
Updated patches 2 and 3 based on input from dhildenb
Added comment to patch 2 describing what keeps us from reporting a bad page
Added patch to address issue with ROM devices being directly writable

Changes from v19:
Added std-headers change to match changes pushed for linux kernel headers
Added patch to remove "report" from page hinting code paths
Updated comment to better explain why we disable hints w/ page poisoning
Removed code that was modifying config size for poison vs hinting
Dropped x-page-poison property
Added code to bounds check the reported region vs the RAM block
Dropped patch for ROM devices as that was already pulled in by Paolo

Changes from v20:
Rearranged patches to push Linux header sync patches to front
Removed association between free page hinting and VIRTIO_BALLOON_F_PAGE_POISON
Added code to enable VIRTIO_BALLOON_F_PAGE_POISON if page reporting is enabled
Fixed possible resource leak if poison or qemu_balloon_is_inhibited return true
Updated cover page comments

---

Alexander Duyck (5):
      linux-headers: Update to allow renaming of free_page_report_cmd_id
      linux-headers: update to contain virito-balloon free page reporting
      virtio-balloon: Replace free page hinting references to 'report' with 'hint'
      virtio-balloon: Implement support for page poison tracking feature
      virtio-balloon: Provide an interface for free page reporting


 hw/virtio/virtio-balloon.c                      |  151 +++++++++++++++++------
 include/hw/virtio/virtio-balloon.h              |   23 ++--
 include/standard-headers/linux/virtio_balloon.h |   12 ++
 3 files changed, 136 insertions(+), 50 deletions(-)

--

