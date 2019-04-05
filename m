Received: from eggs.gnu.org ([209.51.188.92]:42680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCM6Y-0004ls-A2
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCM6V-0001OP-Mw
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:29:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCM6R-0001DN-DT
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:29:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so6090465wmj.3
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 03:29:42 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e5fb5172-983a-c8a0-1d86-8406fe8ff99c@redhat.com>
Date: Fri, 5 Apr 2019 12:29:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] How to correctly use more than 2 floppy drives?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi,

I am trying to understand the possible values for the MAX_FD variable
used by the floppy controller model (hw/block/fdc.c).

Looking at git history:

- 2004-01-05 7138fcfbf7dd + 8977f3c107ef (Jocelyn Mayer):
  FDC introduced with "#define MAX_FD 2"

- 2008-04-29 78ae820cfeb0 (Hervé Poussineau):
  Supports up to 4 floppy drives if MAX_FD is set to 4
  Migration stream knows about runtime value of MAX_FD

- 2009-09-10 d7a6c2703577 (Juan Quintela):
  FDC vmstate-ified
  Migration stream use compile time value of MAX_FD

Since 7138fcfbf7dd MAX_FD has always been defined as 2.

Since d7a6c2703577 MAX_FD can not be different than 2 without breaking
migration.

If I understand correctly migration, first we should change in
vmstate_fdc the user-definable MAX_FD by a constant 2 value.

Then to be able to use >2 floppy disks I have to modify the the
vmstate.version_id, and

1/ add a new field in the vmstate_fdc containing the number of drives
and add code to check >2 and adapt

or

2/ change MAX_FD to 4 for all the codebase, adding some code to migrate
to older FDC with only 2 disks...

Another option I don't like is:

3/ get ride of MAX_FD != 2 and clean the codebase...

$ git grep '#if MAX_FD'
hw/block/fdc.c:744:#if MAX_FD == 4
hw/block/fdc.c:758:#if MAX_FD == 4
hw/block/fdc.c:1317:#if MAX_FD == 4
hw/block/fdc.c:1340:#if MAX_FD == 4
hw/block/fdc.c:2041:#if MAX_FD == 4
hw/block/fdc.c:2079:#if MAX_FD == 4
hw/block/fdc.c:2104:#if MAX_FD == 4

Hervé, what board are/were you using with 4 floppy drives?

BTW this link is somehow interesting :)
https://www.seasip.info/VintagePC/floppies.html

Thanks,

Phil.
