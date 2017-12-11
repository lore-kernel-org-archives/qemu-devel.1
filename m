Received: from eggs.gnu.org ([2001:4830:134:3::10]:54587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eOWQb-0001BM-4B
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eOWQW-0001Uv-Ux
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:20:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52620
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eOWQW-0001TF-Pw
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:19:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBBMG8I6012183
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 17:19:52 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2esyjk1ac4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 17:19:52 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 11 Dec 2017 17:19:52 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 11 Dec 2017 17:19:15 -0500
Message-Id: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/5] Interactive Boot Menu for DASD and SCSI
 Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com

Thanks for your patience. I've been bouncing back-and-forth between different
designs.

Lots-o-changes this version.  Please call me out if I missed anything from the 
previous round of review.

--- [v2] ---

libc

    - fixed up atoi and itostr and moved them to the new lib.c file

    - documentation follows gtk-doc (let me know if I'm missing something)

ipl structs

    - fixed up commit message

    - s/BootEckd*/Eckd*

boot option parsing

    - hw/s390x/ipl.c now handles *all* logic behind parsing command line values 
       and setting the appropriate values in the iplb (including interpreting 
       loadparm)

    - pc-bios/s390-ccw/main.c now only sets the boot menu fields that were read 
       from the iplb (no longer interpreting loadparm here)

    - timeout value is now stored as seconds instead of milliseconds 
       (maximum of 65535 seconds [~18 hours])

    - error reported for invalid splash-time value
        - if splash-time is invalid, then set it to 0 (wait forever)
        - if splash-time is greater than max, then set it to max

    - s/boot_menu_enabled/boot_menu_flags

    - boot_menu_flags is set to *one* of these flags:
        - BOOT_MENU_FLAG_BOOT_OPTS
            - set if -boot menu=on or -machine loadparm=prompt
        - BOOT_MENU_FLAG_ZIPL_OPTS
            - set if no boot options or loadparm are set

    - fixed ordering of the new fields in the iplb's

boot menu for eckd dasd

    - now supports zipl loader values

    - function chs removed and now using pre-existing function eckd_block_num 
       instead

    - sclp_read functionality and its helpers are now in menu.c, which is where 
       the only call to this function occurs
        - renamed to read_prompt
        - renamed read in sclp.c to sclp_read

    - introduced header menu.h

    - introduced new struct, ZiplParms that contains the following fields
       relating to zipl boot menu data:
        - flags
        - timeout
        - menu_start

    - stage2 reading cleaned up

    - no longer panic if boot menu data is not found -- instead just print a 
       message and boot default (what if the user did not configure a menu?)

boot menu for scsi

    - will only show a menu if BOOT_MENU_FLAG_BOOT_OPTS was set

--- [Summary] ---

These patches implement a boot menu for ECKD DASD and SCSI guests on s390x. 
The menu will only appear if the disk has been configured for IPL with the 
zIPL tool and with the following QEMU command line options:

    -boot menu=on[,splash-time=X] and/or -machine loadparm='prompt'

or via the following libvirt domain xml:

    <os>
      <bootmenu enable='yes' timeout='X'/>
    </os>

    or
	
    <disk>
      ...
      <boot order='1' loadparm='PROMPT'/>
    </disk>

Where X is some positive integer representing time in milliseconds.

A loadparm other than 'prompt' will disable the menu and just boot 
the specified entry.

If no boot options are specified, we will attempt to use the values
provided by zipl (ECKD DASD only).

Collin L. Walling (5):
  s390-ccw: update libc
  s390-ccw: ipl structs for eckd cdl/ldl
  s390-ccw: parse and set boot menu options
  s390-ccw: interactive boot menu for eckd dasd
  s390-ccw: interactive boot menu for scsi

 hw/s390x/ipl.c              |  55 ++++++++++
 hw/s390x/ipl.h              |   8 +-
 pc-bios/s390-ccw/Makefile   |   2 +-
 pc-bios/s390-ccw/bootmap.c  | 104 +++++++++++++++----
 pc-bios/s390-ccw/bootmap.h  |  73 ++++++++------
 pc-bios/s390-ccw/iplb.h     |   8 +-
 pc-bios/s390-ccw/libc.c     |  75 ++++++++++++++
 pc-bios/s390-ccw/libc.h     |  31 ++++++
 pc-bios/s390-ccw/main.c     |  22 ++--
 pc-bios/s390-ccw/menu.c     | 237 ++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.h     |  29 ++++++
 pc-bios/s390-ccw/s390-ccw.h |   2 +
 pc-bios/s390-ccw/sclp.c     |  30 ++++--
 pc-bios/s390-ccw/virtio.c   |   2 +-
 14 files changed, 600 insertions(+), 78 deletions(-)
 create mode 100644 pc-bios/s390-ccw/libc.c
 create mode 100644 pc-bios/s390-ccw/menu.c
 create mode 100644 pc-bios/s390-ccw/menu.h

-- 
2.7.4
