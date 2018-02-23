Received: from eggs.gnu.org ([2001:4830:134:3::10]:47416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1epGWs-0003NV-VL
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1epGWp-00020M-75
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:49:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1epGWo-0001xg-T8
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:48:59 -0500
From: Bandan Das <bsd@redhat.com>
Date: Fri, 23 Feb 2018 11:48:24 -0500
Message-Id: <20180223164829.29683-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/5] Initial write support for MTP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, eblake@redhat.com, peter.maydell@linaro.org, berrange@redhat.com

v6:
  4/5,5/5: Cleanup some checkpatch errors. Thank you, Patchew!
  
v5:
  4/5,5/5: Add check for the RO bit and set response to STORE_READ_ONLY
  
v4:
  4/5: Remove getumask and set default permissions to 0644
  5/5: Remove usb_mtp_object_lookup_name out of #ifdef CONFIG_INOTIFY1
  Test compilation on freebsd
  
v3:
  3/5: Add a property that sets r/w to on/off (default:off)
       Restructure ifdefs
  4/5: Sort the response codes
  5/5: Use actual names for fields in the dataset
       Copy uint16_t to wchar_t and use wcstombs to get char type
       for filename
v2:
  3/5: Set mtp store flag to read only
  4/5: Fix compiler warnings and change default file permissions
  5/5: Fix file permissions

These patches implement write support for Qemu's MTP
emulation. Simple tests such as delete/move/edit/copy work ok.
Current issues/TODO:

 - File transfers > 4GB has not been tested and will probably not work
 - Some (or most) MTP clients don't advertise hidden files and folders (names
 that start with a .) even though iiuc Qemu MTP does advertise these files.
 This can confuse certain applications such as text editors or git.
 - Also related, file editors typically run fsync when saving. Depending on
 the MTP client, it may choose not to implement it (such as simple-mtpfs that 
 runs on top of fuse).
 - Needs more testing :)

Bandan Das (5):
  usb-mtp: Add one more argument when building results
  usb-mtp: print parent path in IN_IGNORED trace fn
  usb-mtp: Support delete of mtp objects
  usb-mtp: Introduce write support for MTP objects
  usb-mtp: Advertise SendObjectInfo for write support

 hw/usb/dev-mtp.c | 471 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 441 insertions(+), 30 deletions(-)

-- 
2.14.3
