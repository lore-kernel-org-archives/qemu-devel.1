Received: from eggs.gnu.org ([2001:4830:134:3::10]:47828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaIV-0006xS-Lz
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaH6-0006AE-R9
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:43:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eoaH6-00068N-Cl
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:41:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1LJfDrx120719
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:41:55 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g9bjbt0at-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:41:55 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 21 Feb 2018 14:41:53 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 14:35:39 -0500
Message-Id: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v8 00/13] Interactive Boot Menu for DASD and
 SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com, mihajlov@linux.vnet.ibm.com

Due to the introduction of the QemuIplParameter block and taking some time to
revist some areas, a few chunks of code have been reworked to better align with
those changes. I also think the reworkings improve readability. The same 
functionality is still there, the code just looks a little different (and 
hopefully looks better).

--- [v8] ---

The tl;dr:

    cleaned up some early patches based on review, threw zipl boot option code
    into its own patch, refactored s390_ipl_set_boot_menu to reflect latest
    changes.

The "pls explain":

    * cleaned up "s390-ccw: refactor boot map table code"

        - removed void ptr casting in a couple of spots

    * cleaned up "s390-ccw: set cp_receive mask..." patch

        - setting the mask consumes a service interrupt, so there is no need for 
          a followup sclp_print

    * fixed uitoa based on feedback from v7

    * fixed alignment concerns in QemuIplParameters and renamed flags field

        - reasoning: necessary; better readability

        - s/boot_menu_flags/qipl_flags so this field can be (potentially) used for 
          other purposes in the future

        - when setting the boot menu parms in the bios, we take care to mask out
          the appropriate qipl_flags for boot menu specific flags

        - boot menu flags defines are renamed to be prefixed with "QIPL_FLAG_"

        - also updated comment above this struct

    * cleaned up "s390-ccw: read user input..." patch

        - defines for low core external interrupt code addr and 
          clock comparator interrupt code

        - take care to make sure buf remains null terminated when passed to read_prompt
    
    * [NEW PATCH] "s390-ccw: use zipl values when no boot menu options are present"

        - reasoning: better readability; further explanation of feature

        - *nothing new added to this patch series here*

        - zipl options flag setting and parsing *moved to* this patch

        - this attempts to better explain how these fields are used and how they get
          parsed

        - the commit message gives details on how to set these fields in the zipl
          configuration file

        - the zipl options are only set for CCW type IPL devices (since no 
          other devices actually support it)

    * refactored s390_ipl_set_boot_menu

        - reasoning: better readability

        - the idea is that we should take care to appropriately set the boot menu
          flags for each IPL device type from the beginning. We should not set
          certain flags for devices that cannot support certain features (eg SCSI 
          does not support zipl menus, so we should never set the use_zipl_opts flag
          for SCSI) 

        - since there are no longer boot menu fields specific to each IPL type,
          the switch statement is simply used to detect if the IPL device type
          is capable of a boot menu

        - since zipl flags are only set for CCW type IPL devices, I reworked 
          the logic and removed some indentation

    * s/menu_check_flags/menu_is_enabled

        - reasoning: better readability

        - no parameters

        - "if menu is enabled" reads better than "if these specific flag bits are set"

    * removed menu.h

        - reasoning: file not needed; less to maintain

        - introduction of qipl and better understanding of zipl options led to 
          this decision. by the end of these changes, this file ended up 
          housing 4 function declarations and no longer seemed necessary

        - all menu related function declarations are in s390-ccw.h

        - boot menu flags are defined in iplb.h (which aligns with hw/s390x/ipl.h)

--- [Summary] ---

These patches implement a boot menu for ECKD DASD and SCSI guests on s390x. 
The menu will only appear if the disk has been configured for IPL with the 
zIPL tool and with the following QEMU command line options:

    -boot menu=on[,splash-time=X] and/or -machine loadparm='prompt'

The following must be specified for the device to be IPL'd from:

    -device ...,bootindex=1

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

<boot order='1' ... > must be specified for the device to be IPL'd from

A loadparm other than 'prompt' will disable the menu and just boot 
the specified entry.

If no boot options are specified, we will attempt to use the values
provided by zipl (ECKD DASD only).

Collin L. Walling (13):
  s390-ccw: refactor boot map table code
  s390-ccw: refactor eckd_block_num to use CHS
  s390-ccw: refactor IPL structs
  s390-ccw: update libc
  s390-ccw: move auxiliary IPL data to separate location
  s390-ccw: parse and set boot menu options
  s390-ccw: set up interactive boot menu parameters
  s390-ccw: read stage2 boot loader data to find menu
  s390-ccw: print zipl boot menu
  s390-ccw: read user input for boot index via the SCLP console
  s390-ccw: set cp_receive mask only when needed and consume pending
    service irqs
  s390-ccw: use zipl values when no boot menu options are present
  s390-ccw: interactive boot menu for scsi

 hw/s390x/ipl.c              |  68 ++++++++++++-
 hw/s390x/ipl.h              |  31 +++++-
 pc-bios/s390-ccw/Makefile   |   2 +-
 pc-bios/s390-ccw/bootmap.c  | 184 +++++++++++++++++++++++----------
 pc-bios/s390-ccw/bootmap.h  |  91 ++++++++++-------
 pc-bios/s390-ccw/iplb.h     |  24 ++++-
 pc-bios/s390-ccw/libc.c     |  88 ++++++++++++++++
 pc-bios/s390-ccw/libc.h     |  37 ++++++-
 pc-bios/s390-ccw/main.c     |  49 +++++----
 pc-bios/s390-ccw/menu.c     | 243 ++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h |   9 ++
 pc-bios/s390-ccw/sclp.c     |  39 ++++---
 pc-bios/s390-ccw/virtio.c   |   2 +-
 13 files changed, 741 insertions(+), 126 deletions(-)
 create mode 100644 pc-bios/s390-ccw/libc.c
 create mode 100644 pc-bios/s390-ccw/menu.c

-- 
2.7.4
