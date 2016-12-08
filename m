Received: from eggs.gnu.org ([2001:4830:134:3::10]:43209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEy10-0002kR-Dv
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 07:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEy0z-0001Y2-KA
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 07:41:34 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  8 Dec 2016 12:41:01 +0000
Message-Id: <20161208124103.9813-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Remove need for -iscsi argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pino Toscano <ptoscano@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

This small series removes the need for using the -iscsi argument
by directly supporting all the -iscsi options against the block
device config eg instead of

$QEMU \
  -object secret,id=sec0,data=123456 \
  -drive driver=iscsi,file=iscsi://catbus/iqn.fedora:kvm/2 \
  -iscsi initiator-name=fish,user=test,password-secret=sec0,timeout=234 

you can now do it all against -drive

$QEMU \
  -object secret,id=sec0,data=123456 \
  -drive driver=iscsi,file=iscsi://catbus/iqn.fedora:kvm/2,\
         initiator-name=fish,user=test,password-secret=sec0,timeout=234 

This fixes the problem that you cannot associate -drive instances
with -iscsi args reliably due to IQNs containing chracters that
QEMU forbids in QemuOpts ID strings.

Pino had previously sent a patch to do this for initiator-name
back in the 2.6 dev cycle

  https://lists.nongnu.org/archive/html/qemu-block/2016-04/msg00246.html

This series supports all the -iscsi option names, except for
'password' which is intentionally left out as it is insecure
and replaced by 'password-secret'.

Daniel P. Berrange (2):
  iscsi: reduce code duplication parsing -iscsi opts
  iscsi: support most -iscsi opts against block dev opts

 block/iscsi.c | 145 ++++++++++++++++++++++++++++++----------------------------
 block/iscsi.h |  79 ++++++++++++++++++++++++++++++++
 vl.c          |  36 ++++-----------
 3 files changed, 163 insertions(+), 97 deletions(-)
 create mode 100644 block/iscsi.h

-- 
2.9.3
