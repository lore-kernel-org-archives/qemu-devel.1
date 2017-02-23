Received: from eggs.gnu.org ([2001:4830:134:3::10]:37424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cguZX-000210-6O
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cguZU-0002m4-1G
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:40:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1cguZT-0002lE-PD
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:40:39 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA341C05091C
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:40:38 +0000 (UTC)
Date: Thu, 23 Feb 2017 15:40:34 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170223144034.b2bhgsvwfyyymxwk@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Adding an overlay with 'blockdev-add' fails with:
 "Parameter 'driver' is missing"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

TL;DR: Using `blockdev-add` to create an overlay file succeeds with QEMU
       2.7.0, however the *same* test fails with QEMU from Git (plus a
       couple of patch series from mailing list).  Details below.

QEMU invocation:

  $ qemu-system-x86_64 -display none \
     -nodefconfig -nodefaults -m 512 -device virtio-scsi-pci,id=scsi \
     -device virtio-serial-pci \
     -drive file=./base.qcow2,format=qcow2,if=virtio \
     -monitor stdio -qmp unix:./qmp-sock,server,nowait

With QEMU 2.7.0
---------------

$ qemu-system-x86_64 --version
QEMU emulator version 2.7.0(qemu-2.7.0-8.fc24) [...]

Create the overlay file: 

    $ qemu-img create -f qcow2 /export/target.qcow2 1G

$ ./qmp-shell -v -p /export/qmp-sock

(QEMU) blockdev-add options={"id":"virtio1","driver":"qcow2","file":{"driver":"file","filename":"/export/target.qcow2"},"backing":"virtio0"}
{
    "execute": "blockdev-add", 
    "arguments": {
        "options": {
            "backing": "virtio0", 
            "driver": "qcow2", 
            "id": "virtio1", 
            "file": {
                "driver": "file", 
                "filename": "/export/target.qcow2"
            }
        }
    }
}
{
    "return": {}
}
(QEMU) 

* * *

With Git Master (v2.8.0-1462-g612bb5d-dirty)
--------------------------------------------

Note: I applied these three patch series:

  - [PATCH v2 00/24] QemuOpts util/cutils: Fix and clean up number
    conversions"
  - [PATCH 00/14] qobject: Cleanups, mostly in tests
  - [PATCH 0/2] qapi: Improve qobject input visitor error reporting

So, I'm here:

  $ git describe
	pull-block-2017-02-21-81-g612bb5d

The same test as above (but with the QEMU from Git + above patch
series):

- Stop system QEMU
- Start QEMU built from Git (with the above patches)
- Try to add 'target.qcow2' block device via `blockdev-add`, it now
  fails as below:

  [...]
  (QEMU)
  {
      "execute": "blockdev-add", 
      "arguments": {
          "options": {
              "backing": "virtio0", 
              "driver": "qcow2", 
              "id": "virtio1", 
              "file": {
                  "driver": "file", 
                  "filename": "/export/target.qcow2"
              }
          }
      }
  }
  {
      "error": {
          "class": "GenericError", 
          "desc": "Parameter 'driver' is missing"
      }
  }
  (QEMU) 

* * *

Is this a regression or am I missing something?

-- 
/kashyap
