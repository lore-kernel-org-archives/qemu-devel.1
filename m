Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91A2C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497F2207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwJxcTaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497F2207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzfF-00008T-9H
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kWzSH-0007ql-If
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kWzSB-0007xy-VC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603707014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p+IujnZWPGQj0aNiE/mW6CBg2QZPGg3hzAIjKQizlhE=;
 b=GwJxcTaDmyQP8q6CWvjG+rs36CHoqfSNpixGyKzSq0xXA9Iu36jcskEpMyBIz0km08tsPN
 VWyPJqqpVkv4/ikRSG72rhFq9m1yL2FroZHAs5D/OeLyT/0cpZcFDnnttk9vpkedauDu/l
 ZBc//3xF622LN9pkV/sON1GCYc0O+ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-CTXlfeN_NSC4xInUi-Imfw-1; Mon, 26 Oct 2020 06:10:12 -0400
X-MC-Unique: CTXlfeN_NSC4xInUi-Imfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C38AB1009E32;
 Mon, 26 Oct 2020 10:10:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DE91100238C;
 Mon, 26 Oct 2020 10:10:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BECEA113865F; Mon, 26 Oct 2020 11:10:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] qemu-storage-daemon: QAPIfy --chardev the stupid way
Date: Mon, 26 Oct 2020 11:10:01 +0100
Message-Id: <20201026101005.2940615-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin's "[PATCH v2 0/6] qemu-storage-daemon: QAPIfy --chardev"
involves surgery to the QAPI generator.  Some (most?) of it should go
away if we deprecate the "data" wrappers due to simple unions in QMP.

Do we really need to mess with the code generator to solve the problem
at hand?


Let's recapitulate the problem:

* We want to QAPIfy --chardev, i.e. define its argument as a QAPI
  type.

* We want --chardev to use the same internal interface as chardev-add.

* The obvious way is to reuse chardev-add's arguments type for
  --chardev.  We don't want to, because it's excessively nested:
  it's a struct containing a simple union, with more simple unions
  inside.  The result would be awful like this:

    --chardev id=sock0,\
    backend.type=socket,\
    backend.data.addr.type=inet,\
    backend.data.addr.data.host=0.0.0.0,\
    backend.data.addr.data.port=2445

Kevin's series solves this as follows:

1. Internal flat representation: improve the QAPI generator to
   represent simple unions more efficiently internally.

2. Optional external flat representation: improve the QAPI code
   generator and visitors to let code opt in to ditch the "data"
   wrappers of simple unions in the external format.  Depends on 1.

3. qemu-storage-daemon --chardev opts in.  This gets rid of the
   unwanted nesting except for "backend."

4. qemu-storage-daemon --chardev manually flattens "backend."

Possible future work:

5. Accept external flat representation in addition to nested,
   deprecate nested.

6. After the nested representation is gone for all simple unions,
   simplify QAPI code generators and visitors again.

7. Only then can we drop simple unions.

Note that this tackles a wider problem than just qemu-storage-daemon
--chardev: the infrastructure changes support ditching "data" wrappers
of simple unions *everywhere*, it just doesn't opt in elsewhere.
Moreover, it provides a path towards deprecation and removal of these
wrappers in QMP.

A few things give me an uneasy feeling, though:

* Given how close to the freeze we are, this feels awfully ambitious.

* The QAPI code generator changes look okay, but they do make things
  more complex.

  If we manage to kill nested representation everywhere, most (all?)
  of the complexity goes away.  To be frank, the "if" doesn't inspire
  confidence in me.  Even if we pull it off, it'll probably take quite
  some time.

* Ditching simple unions may become much harder until we kill nested
  representation everywhere.

  Right now, simple unions are a syntactical convenience.  We could
  rewrite them to flat in the schema, and simplify the QAPI code
  generator.


Let's take a step back and review the use of simple unions in our QAPI
schema.  We have just eight of them.

Three occur only in command results:

* query-named-block-nodes and query-block use ImageInfoSpecific
* query-memory-devices uses MemoryDeviceInfo
* query-tpm uses TpmTypeOptions

None of them will matter for a CLI.  Getting rid of "data" wrappers in
results is even harder than for arguments.  I doubt it's worthwhile.

Five occur only in command arguments: 

* chardev-add and chardev-change use ChardevBackend and
  SocketAddressLegacy

  This is the problem at hand.

* nbd-server-start uses SocketAddressLegacy

  This is a solved problem: qemu-storage-daemon --nbd-server uses
  SocketAddress instead.

* send-key and send-event use KeyValue
* transaction uses TransactionAction

  These are non-problems, and likely to remain non-problems forever.

The --chardev is the *only* instance of the wider "simple unions make
the CLI unbearably ugly" problem, as far as I can tell.


What's the stupidest solution that could possibly work?  The same as
we used for --nbd-server: define a new, flat QAPI type.  Only
stupider: leave the internal interface as is, and convert the new,
flat QAPI type to the old, nested one.  We should really convert the
other way, but the freeze makes me go for "stupidest" hard.

This series does exactly that.  Lightly tested.


Compare to Kevin's series:

* Diffstat less PATCH 1+2 (which the two have in common):

  mine:	        8 files changed, 315 insertions(+), 18 deletions(-)
    *.json	1 file changed, 98 insertions(+), 8 deletions(-)
    *.[ch]      6 files changed, 216 insertions(+), 10 deletions(-)

  Kevin's:     71 files changed, 504 insertions(+), 340 deletions(-)
    tests/     24 files changed, 128 insertions(+), 97 deletions(-)
    *.json      1 file changed, 2 insertions(+), 1 deletion(-)
    *.[ch]     40 files changed, 226 insertions(+), 209 deletions(-)

* The bulk of my changes is straightforward and as safe as it gets: I
  add schema definitions, and a mostly mechanical conversion function
  that is only used by qemu-storage-daemon --chardev.

  Kevin's changes are much more complex.  QAPI code generator and
  visitor changes potentially affect everything.  As far as I can
  tell, they don't, and they are solid.

  Right now, the complexity doesn't really buy us anything.  See
  "Possible future work" above for a few ideas on what it could buy us
  down the road.


Tell me what you think.


KEVIN Wolf (3):
  char/stdio: Fix QMP default for 'signal'
  char: Factor out qemu_chr_print_types()
  qemu-storage-daemon: QAPIfy --chardev

Markus Armbruster (1):
  char: Flat alternative to overly nested chardev-add arguments

 qapi/char.json                       | 109 +++++++++++++++++++--
 include/chardev/char.h               |   6 ++
 include/qemu/sockets.h               |   3 +
 chardev/char-legacy.c                | 140 +++++++++++++++++++++++++++
 chardev/char-socket.c                |   3 +-
 chardev/char-stdio.c                 |   4 +-
 chardev/char.c                       |  16 +--
 storage-daemon/qemu-storage-daemon.c |  37 +++++--
 util/qemu-sockets.c                  |  38 ++++++++
 chardev/meson.build                  |   1 +
 10 files changed, 328 insertions(+), 29 deletions(-)
 create mode 100644 chardev/char-legacy.c

-- 
2.26.2


