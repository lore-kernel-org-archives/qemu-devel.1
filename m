Received: from eggs.gnu.org ([2001:4830:134:3::10]:40186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVxww-0008GU-TY
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVxwt-0004GO-Ph
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:40:26 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:41398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVxwt-0004G7-6Y
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:40:23 -0400
Received: by mail-qk0-x244.google.com with SMTP id w23-v6so1514261qkb.8
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 04:40:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 08:40:12 -0300
Message-Id: <20180621114015.9207-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/3] qapi/error: converts
 error_setg(&error_fatal) to error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Hi,

This series converts error_setg(&error_fatal) to error_report() + exit() as
suggested by the "qapi/error.h" documentation.

This reduce Coverity and Clang static analyzer positive falses.

See http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07585.html:

    On 07/24/2017 04:52 PM, Eric Blake wrote:
    That's a shame.  Rather, we should patch this file (and others) to avoid
    all the inconsistent uses of error_setg(&error_*), to comply with the
    error.h documentation.

Since v2:
- added R-b, A-b (Markus, John, David)
- fixed incorrect update of sysbus-fdt patch between v1->v2 (Markus)

Since v1:
- patch #1: use assert() directly (Markus explanation)
- patch #2: use abort() without error_report() (Markus 'no lipstick')
- patch #3: replaced exit() by assert() (Markus)
- patch #4: no change, added R-b

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  hw/block/fdc: Replace error_setg(&error_abort) by assert()
  hw/arm/sysbus-fdt: Replace error_setg(&error_fatal) by error_report()
    + exit()
  device_tree: Replace error_setg(&error_fatal) by error_report() +
    exit()

 device_tree.c       | 23 +++++++++++++----------
 hw/arm/sysbus-fdt.c | 45 ++++++++++++++++++++++++++-------------------
 hw/block/fdc.c      |  9 +--------
 3 files changed, 40 insertions(+), 37 deletions(-)

-- 
2.18.0.rc2
