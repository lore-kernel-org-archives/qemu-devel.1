Received: from eggs.gnu.org ([2001:4830:134:3::10]:50742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f828y-0002Gh-EJ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f828u-0003zN-EO
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:17:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f828u-0003xV-9m
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:17:52 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 16 Apr 2018 12:17:40 +0100
Message-Id: <20180416111743.8473-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] Remove artificial length limits when
 parsing options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

A user trying out SMBIOS "OEM strings" feature reported that the data
they are exposing to the guest was truncated at 1023 bytes, which breaks
the app consuming in the guest. After searching for the cause I
eventually found that the QemuOpts parsing is using fixed length 1024
byte array for option values and 128 byte array for key names.

We can certainly debate whether it is sane to have such long command
line argument values (it is not sane), but if the OS was capable of
exec'ing QEMU with such an ARGV array, there is little good reason for
imposing an artificial length restriction when parsing it. Even worse is
that we silently truncate without reporting an error when hitting limits
resulting in a semantically incorrect behaviour, possibly even leading
to security flaws depending on the data that was truncated.

Thus this patch series removes the artificial length limits by killing
the fixed length buffers.

Separately I intend to make it possible to read "OEM strings" data from
a file, to avoid need to have long command line args.

Daniel P. Berrang=C3=A9 (3):
  accel: use g_strsplit for parsing accelerator names
  opts: don't silently truncate long parameter keys
  opts: don't silently truncate long option values

 accel/accel.c          |  16 +++---
 hw/i386/multiboot.c    |  33 +++++++----
 include/qemu/option.h  |   3 +-
 tests/test-qemu-opts.c |  18 ------
 util/qemu-option.c     | 150 ++++++++++++++++++++++++++-----------------=
------
 5 files changed, 108 insertions(+), 112 deletions(-)

--=20
2.14.3
