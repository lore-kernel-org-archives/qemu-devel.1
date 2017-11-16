Received: from eggs.gnu.org ([2001:4830:134:3::10]:34867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eFHoU-0003ar-GB
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eFHoT-0007Id-Be
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:54:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eFHoT-0007H8-57
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:54:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 281915F7B9
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 10:54:28 +0000 (UTC)
Date: Thu, 16 Nov 2017 10:54:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171116105422.GG16461@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1510822546-14763-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1510822546-14763-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] tests/bios-tables-test: Fix
 endianess problems when passing data to iasl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Thu, Nov 16, 2017 at 09:55:46AM +0100, Thomas Huth wrote:
> The bios-tables-test was writing out files that we pass to iasl in
> with the wrong endianness in the header when running on a big endian
> host. So instead of storing mixed endian information in our structures,
> let's keep everything in little endian and byte-swap it only when we
> need a value in the code.
> 
> Reported-by: Daniel P. Berrange <berrange@redhat.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1724570
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/acpi-utils.h       | 27 +++++----------------------
>  tests/bios-tables-test.c | 42 ++++++++++++++++++++++--------------------
>  2 files changed, 27 insertions(+), 42 deletions(-)

This fixes bios-tables-test, but has broken vmgenid-tgst

TEST: tests/vmgenid-test... (pid=8197)
  /i386/vmgenid/vmgenid/set-guid:                                      **
ERROR:/builddir/build/BUILD/qemu-2.10.0/tests/vmgenid-test.c:62:acpi_find_vgia: assertion failed (ACPI_ASSERT_CMP_str == "RSDT"): ("" == "RSDT")
FAIL
GTester: last random seed: R02S1ab59ff8ca3a4e0f7ff4b8bbddb007f1
(pid=8204)
  /i386/vmgenid/vmgenid/set-guid-auto:                                 **
ERROR:/builddir/build/BUILD/qemu-2.10.0/tests/vmgenid-test.c:62:acpi_find_vgia: assertion failed (ACPI_ASSERT_CMP_str == "RSDT"): ("" == "RSDT")
FAIL
GTester: last random seed: R02S1c3bcc9f459161566b19571adc5cb5d1
(pid=8216)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
