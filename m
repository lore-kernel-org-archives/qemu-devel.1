Received: from eggs.gnu.org ([2001:4830:134:3::10]:36828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cvRpU-0003wu-Bc
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cvRpQ-0002y9-Hi
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:01:16 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:36480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1cvRpQ-0002xg-Er
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:01:12 -0400
Received: by mail-qt0-x234.google.com with SMTP id r45so144082929qte.3
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 10:01:12 -0700 (PDT)
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Date: Tue,  4 Apr 2017 13:01:01 -0400
Message-Id: <1491325264-14502-1-git-send-email-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] Update AppleSMC for OS X Sierra 10.12.4
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, f4bug@amsat.org, agraf@suse.de, eshelton@pobox.com

As of 10.12.4 (currently the latest Sierra update), OS X refuses to boot
unless the AppleSMC supports a third I/O port, which provides the current
error status when read.

New since v1:

	- 1/3: don't touch the default OSK string, as it's unnecessary
		at this time

	- 2/3: don't consolidate I/O regions, leave as-is for data
		and cmd; This patch now implements the error-code state
		machine, AND adds an i/o region dedicaded to the error
		status port, complete with read/write access methods.

	- 3/3: optional patch setting access width to 1-byte on data and
		cmd i/o regions. Tested on OS X versions 10.[6..12].

> This series consists of three patches:
>
>	- 1/3: indentation/whitespace cleanup for applesmc.c to the point
>		where it now passes scripts/checkpatc.pl, and allows
>		subsequent changes to look nice in diff-patch format :)
>
>	- 2/3: consolidate Port I/O into a single region, and invoke
>		appropriate read/write methods based on the offset being
>		accessed
>
>	- 3/3: implement read-only error/status port, and update
>		data and command read/write methods to correctly
>		maintain the state machine for keeping the status_1e
>		value up to date.

Gabriel L. Somlo (3):
  applesmc: cosmetic whitespace and indentation cleanup
  applesmc: implement error status port
  applesmc: fix port i/o access width

 hw/misc/applesmc.c | 219 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 155 insertions(+), 64 deletions(-)

-- 
2.7.4
