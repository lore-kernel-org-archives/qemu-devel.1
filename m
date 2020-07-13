Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87194C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5356B205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WT9cLIcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5356B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzX1-0001oc-Ie
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1juzWA-0000Z5-VF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:33:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37040
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1juzW8-0001Hh-18
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594650794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1JPAwjlEZTFpdekTQ6z+ZCPs+UYx96Ma57TNQm1Cq6w=;
 b=WT9cLIcuGrd9DYF950S5nbYyqmPnr69Sfh+IidK94kZxladEcoFBUrOGJTigcTyGzgJ9Ek
 BY3rhW++ERGSs7z8BFXdSIiiceJpea7Bx0/x1FaSgNiEOJy7Dex8jznNC8ZPeMEHbeBwFa
 aKquFkDewEf/qcXSN5lhXLJ1YRvgtfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-aXo4j-O_PrqVD7xbpTmVFw-1; Mon, 13 Jul 2020 10:33:12 -0400
X-MC-Unique: aXo4j-O_PrqVD7xbpTmVFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E67D110A0;
 Mon, 13 Jul 2020 14:33:11 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-91.ams2.redhat.com [10.36.114.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B48E2DE76;
 Mon, 13 Jul 2020 14:33:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL v3] Block layer patches
Date: Mon, 13 Jul 2020 16:33:06 +0200
Message-Id: <20200713143306.311143-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 6c87d9f311dba0641bdc2df556056938a8bf2a12:

  Merge remote-tracking branch 'remotes/elmarco/tags/chardev-pull-request' into staging (2020-07-13 09:34:24 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 7637b225a8d59a3b9b0e31bbc4eb8a0788792ac5:

  block: Avoid stale pointer dereference in blk_get_aio_context() (2020-07-13 15:57:13 +0200)

----------------------------------------------------------------
Block layer patches:

- file-posix: Mitigate file fragmentation with extent size hints
- Tighten qemu-img rules on missing backing format
- qemu-img map: Don't limit block status request size
- Fix crash with virtio-scsi and iothreads

----------------------------------------------------------------
Eric Blake (10):
      qemu-img: Flush stdout before before potential stderr messages
      block: Finish deprecation of 'qemu-img convert -n -o'
      sheepdog: Add trivial backing_fmt support
      vmdk: Add trivial backing_fmt support
      qcow: Tolerate backing_fmt=
      block: Error if backing file fails during creation without -u
      qcow2: Deprecate use of qemu-img amend to change backing file
      iotests: Specify explicit backing format where sensible
      block: Add support to warn on backing file change without format
      qemu-img: Deprecate use of -b without -F

Greg Kurz (1):
      block: Avoid stale pointer dereference in blk_get_aio_context()

Kevin Wolf (3):
      qemu-img map: Don't limit block status request size
      iotests/059: Filter out disk size with more standard filter
      file-posix: Mitigate file fragmentation with extent size hints

Max Reitz (1):
      iotests: Simplify _filter_img_create() a bit

 qapi/block-core.json             |   11 +-
 docs/system/deprecated.rst       |   58 ++-
 docs/tools/qemu-img.rst          |    4 +
 include/block/block.h            |    4 +-
 include/block/block_int.h        |    1 +
 block.c                          |   53 +-
 block/block-backend.c            |    4 +-
 block/file-posix.c               |   44 ++
 block/qcow.c                     |   20 +-
 block/qcow2.c                    |    7 +-
 block/sheepdog.c                 |   18 +-
 block/stream.c                   |    2 +-
 block/vmdk.c                     |   14 +
 blockdev.c                       |    3 +-
 qemu-img.c                       |   20 +-
 tests/qemu-iotests/017           |    2 +-
 tests/qemu-iotests/017.out       |    2 +-
 tests/qemu-iotests/018           |    2 +-
 tests/qemu-iotests/018.out       |    2 +-
 tests/qemu-iotests/019           |    5 +-
 tests/qemu-iotests/019.out       |    2 +-
 tests/qemu-iotests/020           |   31 +-
 tests/qemu-iotests/020.out       |   15 +-
 tests/qemu-iotests/024           |   10 +-
 tests/qemu-iotests/024.out       |    4 +-
 tests/qemu-iotests/028           |    4 +-
 tests/qemu-iotests/028.out       |    2 +-
 tests/qemu-iotests/030           |   26 +-
 tests/qemu-iotests/034           |    2 +-
 tests/qemu-iotests/034.out       |    2 +-
 tests/qemu-iotests/037           |    2 +-
 tests/qemu-iotests/037.out       |    2 +-
 tests/qemu-iotests/038           |    2 +-
 tests/qemu-iotests/038.out       |    2 +-
 tests/qemu-iotests/039           |    3 +-
 tests/qemu-iotests/039.out       |    2 +-
 tests/qemu-iotests/040           |   47 +-
 tests/qemu-iotests/041           |   37 +-
 tests/qemu-iotests/042           |    4 +-
 tests/qemu-iotests/043           |   23 +-
 tests/qemu-iotests/043.out       |   12 +-
 tests/qemu-iotests/046           |    2 +-
 tests/qemu-iotests/046.out       |    2 +-
 tests/qemu-iotests/049.out       |    8 +-
 tests/qemu-iotests/050           |    4 +-
 tests/qemu-iotests/050.out       |    2 +-
 tests/qemu-iotests/051           |    2 +-
 tests/qemu-iotests/051.out       |    2 +-
 tests/qemu-iotests/051.pc.out    |    2 +-
 tests/qemu-iotests/054.out       |    2 +-
 tests/qemu-iotests/056           |    3 +-
 tests/qemu-iotests/059           |    2 +-
 tests/qemu-iotests/059.out       | 1009 +++++++++++++++++++-------------------
 tests/qemu-iotests/060           |    2 +-
 tests/qemu-iotests/060.out       |    2 +-
 tests/qemu-iotests/061           |   10 +-
 tests/qemu-iotests/061.out       |   11 +-
 tests/qemu-iotests/069           |    2 +-
 tests/qemu-iotests/069.out       |    2 +-
 tests/qemu-iotests/073           |    2 +-
 tests/qemu-iotests/073.out       |    2 +-
 tests/qemu-iotests/079.out       |    2 +-
 tests/qemu-iotests/082           |   10 +-
 tests/qemu-iotests/082.out       |   30 +-
 tests/qemu-iotests/085           |    4 +-
 tests/qemu-iotests/085.out       |    6 +-
 tests/qemu-iotests/089           |    2 +-
 tests/qemu-iotests/089.out       |    2 +-
 tests/qemu-iotests/095           |    4 +-
 tests/qemu-iotests/095.out       |    4 +-
 tests/qemu-iotests/097           |    4 +-
 tests/qemu-iotests/097.out       |   16 +-
 tests/qemu-iotests/098           |    2 +-
 tests/qemu-iotests/098.out       |    8 +-
 tests/qemu-iotests/106           |    7 +-
 tests/qemu-iotests/110           |    4 +-
 tests/qemu-iotests/110.out       |    4 +-
 tests/qemu-iotests/111.out       |    2 +-
 tests/qemu-iotests/112.out       |    4 +-
 tests/qemu-iotests/114           |   12 +
 tests/qemu-iotests/114.out       |    9 +
 tests/qemu-iotests/122           |   34 +-
 tests/qemu-iotests/122.out       |   12 +-
 tests/qemu-iotests/126           |    4 +-
 tests/qemu-iotests/126.out       |    4 +-
 tests/qemu-iotests/127           |    4 +-
 tests/qemu-iotests/127.out       |    4 +-
 tests/qemu-iotests/129           |    3 +-
 tests/qemu-iotests/133           |    2 +-
 tests/qemu-iotests/133.out       |    2 +-
 tests/qemu-iotests/139           |    2 +-
 tests/qemu-iotests/141           |    6 +-
 tests/qemu-iotests/141.out       |    4 +-
 tests/qemu-iotests/142           |    2 +-
 tests/qemu-iotests/142.out       |    2 +-
 tests/qemu-iotests/153           |   14 +-
 tests/qemu-iotests/153.out       |   35 +-
 tests/qemu-iotests/154           |   42 +-
 tests/qemu-iotests/154.out       |   42 +-
 tests/qemu-iotests/155           |   12 +-
 tests/qemu-iotests/156           |    9 +-
 tests/qemu-iotests/156.out       |    6 +-
 tests/qemu-iotests/158           |    2 +-
 tests/qemu-iotests/158.out       |    2 +-
 tests/qemu-iotests/161           |    8 +-
 tests/qemu-iotests/161.out       |    8 +-
 tests/qemu-iotests/175           |    6 +-
 tests/qemu-iotests/176           |    4 +-
 tests/qemu-iotests/176.out       |   32 +-
 tests/qemu-iotests/177           |    2 +-
 tests/qemu-iotests/177.out       |    2 +-
 tests/qemu-iotests/179           |    2 +-
 tests/qemu-iotests/179.out       |    2 +-
 tests/qemu-iotests/189           |    2 +-
 tests/qemu-iotests/189.out       |    2 +-
 tests/qemu-iotests/191           |   12 +-
 tests/qemu-iotests/191.out       |   12 +-
 tests/qemu-iotests/195           |    6 +-
 tests/qemu-iotests/195.out       |    6 +-
 tests/qemu-iotests/198           |    2 +-
 tests/qemu-iotests/198.out       |    3 +-
 tests/qemu-iotests/204           |    2 +-
 tests/qemu-iotests/204.out       |    2 +-
 tests/qemu-iotests/216           |    2 +-
 tests/qemu-iotests/224           |    4 +-
 tests/qemu-iotests/225           |    2 +-
 tests/qemu-iotests/225.out       |    2 +-
 tests/qemu-iotests/228           |    5 +-
 tests/qemu-iotests/243           |    7 +-
 tests/qemu-iotests/245           |    3 +-
 tests/qemu-iotests/249           |    4 +-
 tests/qemu-iotests/249.out       |    4 +-
 tests/qemu-iotests/252           |    2 +-
 tests/qemu-iotests/257           |    3 +-
 tests/qemu-iotests/259.out       |    2 +-
 tests/qemu-iotests/267           |    4 +-
 tests/qemu-iotests/267.out       |    6 +-
 tests/qemu-iotests/270           |    2 +-
 tests/qemu-iotests/270.out       |    2 +-
 tests/qemu-iotests/273           |    4 +-
 tests/qemu-iotests/273.out       |    4 +-
 tests/qemu-iotests/274           |   12 +-
 tests/qemu-iotests/274.out       |   29 +-
 tests/qemu-iotests/279           |    4 +-
 tests/qemu-iotests/279.out       |    4 +-
 tests/qemu-iotests/282.out       |    6 +-
 tests/qemu-iotests/290           |    2 +-
 tests/qemu-iotests/290.out       |    4 +-
 tests/qemu-iotests/301           |   88 ++++
 tests/qemu-iotests/301.out       |   59 +++
 tests/qemu-iotests/common.filter |   62 +--
 tests/qemu-iotests/group         |    1 +
 152 files changed, 1426 insertions(+), 990 deletions(-)
 create mode 100755 tests/qemu-iotests/301
 create mode 100644 tests/qemu-iotests/301.out


