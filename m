Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF109C5B578
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 04:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B142B216B7
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 04:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCAQ+e/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B142B216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjc36-00077Z-Tf
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 00:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53241)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hjc1E-0006Ba-FM
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hjc1D-0000i1-9h
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:09:48 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
 id 1hjc1D-0000hl-2a
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:09:47 -0400
Received: by mail-pg1-x543.google.com with SMTP id s27so5078071pgl.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 21:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K0PbUUNwlQKjDXefzf4ftnqJzOIPHz8PpZV3qjdWqjE=;
 b=MCAQ+e/o//Bd71Tt6r/s4Epa1M1h4Hkx80GlAmaphHRzy5wJhod7lnHVJp+noON5q7
 PtQ+vQEFb6cHkI+rGYvNMQcPD+d5hIJIt4wXaFmP+i0qIRpBNOC33za2+k0g4o7MHwvN
 w62w7rlU2fMPZwLTTnd7dxnbAcS98EjsCkIVNQFoOg8Cy6fApOY+UbSSvmknwyUi4HTB
 0a6xayChYDwyWc0SxSgZrtREkyLN4M8hc6lrxzsJNzkObwOGvlmAWEgvrOJdmGgotgKD
 bNYodyt+8k6YYmFBW8A3V98CzcUVSMjtLhYZdKiSznvquAsegKdO37uZx2MlkEaDoX0x
 8bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K0PbUUNwlQKjDXefzf4ftnqJzOIPHz8PpZV3qjdWqjE=;
 b=hK/tsTSDZe/FtwlzaTCRepiyrkb70LmXS63rfVUMvwnT9BlEg3VzDetfRLygNLGJog
 m06y1BMKYo/rYZlcC0unr5B1SWY8tw7jJOrMGEWXJgwFlQBNOkyJq4p/lXMN5pIldi4v
 JNg3PvypfWL6W7LdU6EJUpV7SksffZEI+5EECIajzfSKOjfXoO92HxEcAoCXW9FpN6RD
 Vj794jvmHlvfB8LgA72e9SgXhyrdFHs2JEGcva4X3Hn91TWDYMnUgWws+ZfhOamJ3ZIy
 RHCAR9NPtyPk41j6jwdKc1GSPmzrEOlsgwLO5emYZvsHw3JZIWw1PoH1tnQ2RSkV4gw1
 Youg==
X-Gm-Message-State: APjAAAVgMCLlvBfFzE1flxvlAtF7RDIMaDfHe86muVAGC0/8CS2tDkjx
 NrXoJ0Ibku0DlAK7D5O3ssMa+u0C
X-Google-Smtp-Source: APXvYqx8knuir32PQBx67uOMjRwpS7a2iSh0+Z3OMKeuUUzD3hwzkQYa5cEy9WXIVgW+yK/yLPb9uA==
X-Received: by 2002:a65:4786:: with SMTP id e6mr8894013pgs.448.1562386185463; 
 Fri, 05 Jul 2019 21:09:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:22f:6255:6f39:949d:5942:eaaf])
 by smtp.gmail.com with ESMTPSA id
 q126sm17330847pfq.123.2019.07.05.21.09.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 21:09:44 -0700 (PDT)
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat,  6 Jul 2019 09:39:38 +0530
Message-Id: <20190706040940.7884-1-skrtbhtngr@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [RFC v2 0/2] Add live migration support in the PVRDMA
 device
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes in v2:

* Modify load_dsr() such that dsr mapping is not performed if dsr value
  is non-NULL. Also move free_dsr() out of load_dsr() and call it right
  before if needed. These two changes will allow us to call load_dsr()
  even when we have already done dsr mapping and would like to go on
  with the rest of mappings.

* Use VMStateDescription instead of SaveVMHandlers to describe migration
  state. Also add fields for parent PCI object and MSIX.

* Use a temporary structure (struct PVRDMAMigTmp) to hold some fields
  during migration. These fields, such as cmd_slot_dma and resp_slot_dma
  inside dsr, do not fit into VMSTATE macros as their container
  (dsr_info->dsr) will not be ready until it is mapped on the dest.

* Perform mappings to CQ and event notification rings after the state is
  loaded. This is an extension to the mappings performed in v1;
  following the flow of load_dsr(). All the mappings are succesfully
  done on the dest on state load.

Link(s) to v1:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04924.html
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04923.html


Things working now (were not working at the time of v1):

* vmxnet3 is migrating successfully. The issue was in the migration of
  its PCI configuration space, and is solved by the patch Marcel had sent:
  https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01500.html

* There is no problem due to BounceBuffers which were failing the dma mapping
  calls in state load logic earlier. Not sure exactly how it went away. I am
  guessing that adding the PCI and MSIX state to migration solved the issue.


What is still needed:

* A workaround to get libvirt to support same-host migration. Since
  the problems faced in v1 (mentioned above) are out of the way, we
  can move further, and in doing so, we will need this.

Sukrit Bhatnagar (2):
  hw/pvrdma: make DSR mapping idempotent in load_dsr()
  hw/pvrdma: add live migration support

 hw/rdma/vmw/pvrdma_main.c | 104 +++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 8 deletions(-)

-- 
2.21.0


