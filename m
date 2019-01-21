Received: from eggs.gnu.org ([209.51.188.92]:38880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gld6p-0001z8-PV
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gld37-0005bA-QG
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:07:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33250
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gld37-0005ZG-EM
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:07:49 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0LH5F8S132589
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:07:47 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q5h1eb7ky-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:07:46 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 21 Jan 2019 17:07:46 -0000
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 21 Jan 2019 12:07:28 -0500
In-Reply-To: <20190121170731.2500692-1-stefanb@linux.ibm.com>
References: <20190121170731.2500692-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190121170731.2500692-2-stefanb@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] tpm: Zero-init structure to avoid
 uninitialized variables in valgrind log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-stable@nongnu.org, mdroth@linux.ibm.com
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>

Zero-init the ptm_loc structure so that we don't have fields that
are not initialised.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/tpm/tpm_emulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 10bc20dbec..70f4b10284 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -166,6 +166,7 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm=
_emu, uint8_t locty_number,
=20
     trace_tpm_emulator_set_locality(locty_number);
=20
+    memset(&loc, 0, sizeof(loc));
     loc.u.req.loc =3D locty_number;
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_LOCALITY, &loc,
                              sizeof(loc), sizeof(loc)) < 0) {
--=20
2.17.2
