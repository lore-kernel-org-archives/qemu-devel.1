Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C38CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0BC2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1S0fi5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0BC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58409 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNx0K-0005L2-C5
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNwRC-0002DM-66
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNwQz-0006JH-Sz
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53062
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNwQz-00068o-Ly
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571997730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VU/TiAbwprKFq8DrsJsoTSgkCUOZilKj8/Eu8DZCH58=;
 b=H1S0fi5dF/2lk7AaV2memhm27/uDT1syoAgR1bjMuffQBTeJUnsFr84DEb2q/VijNFWO36
 GI/K656HvItbkKirrvCt4L9Yfptk74v8irf/ygdtPW3VORxHJ4N+lWiIBcL9HUg9pMmNwP
 981eJ0H9TY3QmD4IsLlUZxsbqWvSdRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-CUHbw7vOOrCnsUSRPZk59g-1; Fri, 25 Oct 2019 06:02:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3324D107AD31
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 10:02:02 +0000 (UTC)
Received: from localhost (unknown [10.36.118.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26F805DAAF;
 Fri, 25 Oct 2019 10:01:53 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 0/3] tests/vhost-user-fs-test: add vhost-user-fs test case
Date: Fri, 25 Oct 2019 12:01:49 +0200
Message-Id: <20191025100152.6638-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: CUHbw7vOOrCnsUSRPZk59g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds an automated test for the vhost-user-fs device using
virtiofsd.  This makes low-level testing of FUSE messages and even VIRTIO
possible.  These things can be hard to do inside a normal guest environment
where such tests require building kernel modules and can result in kernel
panics.

To get a feel for how vhost-user-fs-test.c test cases work, here is an exam=
ple:

  /* Create file on host and check its contents and metadata in guest */
  static void test_file_from_host(void *parent, void *arg, QGuestAllocator =
*alloc)
  {
      g_autofree gchar *filename =3D g_strdup_printf("%s/%s", shared_dir, "=
foo");
      const char *str =3D "This is a test\n";
      char buf[strlen(str)];
      QVirtioFS *vfs =3D parent;
      struct fuse_entry_out entry;
      int32_t error;
      uint64_t nodeid;
      uint64_t fh;
      ssize_t nread;
      gboolean ok;

      SKIP_TEST_IF_CROSS_ENDIAN();

      /* Create the test file in the shared directory */
      ok =3D g_file_set_contents(filename, str, strlen(str), NULL);
      g_assert(ok);

      fuse_init(vfs);

      error =3D fuse_lookup(vfs, FUSE_ROOT_ID, "foo", &entry);
      g_assert_cmpint(error, =3D=3D, 0);
      g_assert_cmpint(guest64(entry.attr.size), =3D=3D, strlen(str));
      nodeid =3D guest64(entry.nodeid);

      error =3D fuse_open(vfs, nodeid, O_RDONLY, &fh);
      g_assert_cmpint(error, =3D=3D, 0);

      nread =3D fuse_read(vfs, fh, 0, buf, sizeof(buf));
      g_assert_cmpint(nread, =3D=3D, sizeof(buf));
      g_assert_cmpint(memcmp(buf, str, sizeof(buf)), =3D=3D, 0);

      fuse_release(vfs, fh);
      fuse_forget(vfs, nodeid);
  }

This patch series is based on "[PATCH v4 00/16] libqos: add VIRTIO PCI 1.0
support" and the https://gitlab.com/virtio-fs/qemu virtio-fs-dev branch.  I
expect conflicts and will resend again once these dependencies have landed =
in
qemu.git/master.

Stefan Hajnoczi (3):
  WIP virtiofsd: import Linux <fuse.h> header file
  qgraph: add an "after" test callback function
  tests/vhost-user-fs-test: add vhost-user-fs test case

 tests/Makefile.include                        |   8 +-
 contrib/virtiofsd/fuse_lowlevel.h             |   2 +-
 .../standard-headers/linux/fuse.h             |   0
 tests/libqos/qgraph.h                         |   2 +
 tests/libqos/qgraph_internal.h                |   1 +
 tests/libqos/virtio-fs.h                      |  46 ++
 contrib/virtiofsd/fuse_loop_mt.c              |   2 +-
 contrib/virtiofsd/fuse_lowlevel.c             |   2 +-
 contrib/virtiofsd/fuse_virtio.c               |   2 +-
 tests/libqos/qgraph.c                         |   1 +
 tests/libqos/virtio-fs.c                      | 104 +++
 tests/qos-test.c                              |   6 +
 tests/vhost-user-fs-test.c                    | 660 ++++++++++++++++++
 scripts/update-linux-headers.sh               |   3 +-
 14 files changed, 832 insertions(+), 7 deletions(-)
 rename contrib/virtiofsd/fuse_kernel.h =3D> include/standard-headers/linux=
/fuse.h (100%)
 create mode 100644 tests/libqos/virtio-fs.h
 create mode 100644 tests/libqos/virtio-fs.c
 create mode 100644 tests/vhost-user-fs-test.c

--=20
2.21.0


