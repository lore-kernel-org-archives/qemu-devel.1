Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150DCC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3A42068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTpgl/BD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3A42068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7QL-0006RJ-0y
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7OV-0004rA-Pn
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7OS-0000hs-Lc
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zQ4bmEIBY00lsT0aN9BEUEYGWs/jZxiMoowXTzHTQ38=;
 b=TTpgl/BDiBmmdjIONt1lxyRR27G6rnK/rj5XEgpv6xSGvBryV2p33siHsuRYLXTqabGH2O
 7fRDhrGCG6iO2PouNOoa+oYK2qm0HTYzJyc44hpwzMGz/og/kqEWQH1FZdDJaEhc7F4sGe
 /9fd2DYPNNQFBi0/CjGQnkQS/8bOXRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-PZReZDjXMby9Gue1QkcwpQ-1; Mon, 09 Nov 2020 08:39:33 -0500
X-MC-Unique: PZReZDjXMby9Gue1QkcwpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 508D61018F73
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 13:39:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 032EB6EF48;
 Mon,  9 Nov 2020 13:39:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 for-5.2 0/6] Deprecate or forbid crazy QemuOpts cases
Date: Mon,  9 Nov 2020 08:39:25 -0500
Message-Id: <20201109133931.979563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's very hard to make QemuOpts fail.  It's also very easy
to write command lines that QemuOpts accept but make no sense.

This series deals with three cases:

- QemuOpts accepts ids even for options that are meant to be singletons.
As a result, a command line option like "-M q35,id=ff" is ignored silently.

- QemuOpts simply matches "help" or "?" against the option name to
determine whether the user asked for help.  Something like "nohelp" or
"?=please" will print the help message.

- QemuOpts lets you write boolean options in "short form" where "abc"
means "abc=on" and "noabc" means "abc=off".  This is confusing, since it
is not done for the first key=value pair (but only if there is an implied
key); it can also be grossly misused, as in the previous example, because
it is not type safe.  In case you need confirmation, "-device e1000,noid"
will create a device with id equal to "off".

Unfortunately, this last idiom has found wide use with -chardev (think
"server,nowait") and to a lesser extent -spice, so it can only be
deprecated.  The other two are removed.

Patches 1-3 are cleanups.  Patches 4-6 deal with the above issues one
by one.  I have a seventh patch to remove the third argument to
qemu_opts_create, but it touches a few dozen files.

Paolo

Supersedes: <20201105142731.623428-1-pbonzini@redhat.com>

Paolo Bonzini (6):
  qemu-option: simplify search for end of key
  qemu-option: pass QemuOptsList to opts_accepts_any
  qemu-option: restrict qemu_opts_set to merge-lists QemuOpts
  qemu-option: clean up id vs. list->merge_lists
  qemu-option: move help handling to get_opt_name_value
  qemu-option: warn for short-form boolean options

 docs/system/deprecated.rst |   6 ++
 include/qemu/option.h      |   3 +-
 softmmu/vl.c               |  19 ++---
 tests/test-qemu-opts.c     |  26 ++++++-
 util/qemu-option.c         | 149 +++++++++++++++++++------------------
 5 files changed, 113 insertions(+), 90 deletions(-)

-- 
2.26.2


