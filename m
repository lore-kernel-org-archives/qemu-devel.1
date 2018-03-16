Received: from eggs.gnu.org ([2001:4830:134:3::10]:36800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewxBX-00035V-6m
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 17:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewxBU-0003V3-2K
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 17:46:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38634
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ewxBT-0003Ty-Sp
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 17:46:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GLio3V073814
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:46:42 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2grhf09vt9-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:46:42 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 15:46:41 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 17:46:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1521236796-24551-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 for 2.13 0/4] tpm: Extend TPM with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This series of patches implements support for migrating the state of the
external 'swtpm' TPM emulator as well as that of the TIS interface.=20

For testing of TPM 2 (migration) please use the following git repos and
branches:

libtpms:=20
   - repo: https://github.com/stefanberger/libtpms
   - branch: tpm2-preview.rev146.v2

swtpm:
   - repo: https://github.com/stefanberger/swtpm
   - branch: tpm2-preview.rev146.v2

Regards,
  Stefan

Changes:
 v4->v5:
   - followed Marc-Andr=C3=A9's and Alan's comments where possible; some =
comments
     were not addressed and reasons posted to mailing list
   - converted debug statements to tracing
   - qemu_chr_fe_read_all does not return errno, so displaying expected v=
ersus
     received number of bytes rather than strerror(errno)
   - added test cases
   - added documentation for migration to docs/spec/tpm.txt

 v3->v4:
   - dropped the size limit enforcement on blobs received from the swtpm
   - the .post_load migration function requires errno's to be returned.
     -> some of the functions have been converted to return a better errn=
o


Stefan Berger (4):
  tpm: extend TPM emulator with state migration support
  tpm: extend TPM TIS with state migration support
  docs: tpm: add VM save/restore example and troubleshooting guide
  tpm: Add test cases that uses the external swtpm with CRB interface

 docs/specs/tpm.txt         | 106 +++++++++++++++
 hw/tpm/tpm_emulator.c      | 318 +++++++++++++++++++++++++++++++++++++++=
++++--
 hw/tpm/tpm_tis.c           |  52 +++++++-
 hw/tpm/trace-events        |   9 +-
 tests/Makefile.include     |   3 +
 tests/tpm-crb-swtpm-test.c | 243 ++++++++++++++++++++++++++++++++++
 6 files changed, 717 insertions(+), 14 deletions(-)
 create mode 100644 tests/tpm-crb-swtpm-test.c

--=20
2.5.5
