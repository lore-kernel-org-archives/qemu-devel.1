Received: from eggs.gnu.org ([2001:4830:134:3::10]:39296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhetD-0000Ir-E1
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhetA-000365-Bm
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:40:23 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhetA-00034r-5y
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:40:20 -0400
Received: by mail-qt0-x243.google.com with SMTP id u19so1216217qtc.0
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:40:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 15 Aug 2017 13:39:57 -0300
Message-Id: <20170815163959.6632-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/2] tests: avoid kvm accel when it is not
 accessible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This series reduce warnings when kvm is not accessible:

- kernel without kvm:

    # make check-qtest-x86_64
      GTESTER check-qtest-x86_64
    Could not access KVM kernel module: No such device
    qemu-system-x86_64: failed to initialize KVM: No such device
    qemu-system-x86_64: Back to tcg accelerator
    [... many of these ...]

- tests ran as user:

    $ make check-qtest-x86_64
      GTESTER check-qtest-x86_64
    Could not access KVM kernel module: Permission denied
    qemu-system-x86_64: failed to initialize KVM: Permission denied
    qemu-system-x86_64: Back to tcg accelerator
    [... many of these ...]

Once applied:

    $ make check-qtest-x86_64
      GTESTER check-qtest-x86_64
    kvm not accessible, using tcg
    kvm not accessible, using tcg
    kvm not accessible, using tcg
    kvm not accessible, using tcg
    kvm not accessible, using tcg

Philippe Mathieu-Daudé (2):
  libqtest: add qtest_accel() to avoid warnings when kvm is not
    available
  tests: use qtest_accel()

 tests/libqtest.h         |  8 ++++++++
 tests/bios-tables-test.c |  2 +-
 tests/boot-serial-test.c |  5 +++--
 tests/libqtest.c         | 18 ++++++++++++++++++
 tests/postcopy-test.c    | 10 ++++++----
 tests/pxe-test.c         |  5 +++--
 tests/vmgenid-test.c     |  4 ++--
 7 files changed, 41 insertions(+), 11 deletions(-)

-- 
2.14.1
