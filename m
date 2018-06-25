Received: from eggs.gnu.org ([2001:4830:134:3::10]:37713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXT4C-0008G0-UX
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXT46-0000Oz-Tr
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:06:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fXT46-0000Md-KP
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:06:02 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5PExib6097639
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:06:01 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ju08hg0rj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:06:00 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 25 Jun 2018 09:05:59 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 25 Jun 2018 11:05:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Choosing PCR banks for swtpm's TPM 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tpm2@lists.01.org, Kenneth Goldman <kgoldman@us.ibm.com>
Cc: Chris Friesen <chris.friesen@windriver.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Qi, Yadong" <yadong.qi@intel.com>, "Xu, Quan" <quan.xu@intel.com>

Hi!

 =C2=A0I am sending this email to solicit input on the choice of the PCR=20
banks to enable for swtpm's TPM 2. I have currently enabled 4 PCR banks=20
for SHA{1,256,384,512}. The downside of this is that running the TPM 2=20
with so many PCR banks has a performance impact when the Linux integrity=20
measurement architecture is used and has to extend measurements into all=20
PCR banks, which Linux does already.

TPM 2 has the PCR_Allocate() command for a user to select the PCR banks=20
to use. This command allows to make some PCR banks invisible. The change=20
has to be done through the firmware and has the downside that the TPM2=20
does not support TPM2_Shutdown(SU_STATE) after this command was used.=20
This prevents suspend/resume from working properly. So, it seems that=20
one shouldn't have to use this command, which in turn means the number=20
of PCR banks should be small.

Another complication with the swtpm is the upgrade path. Suspended VMs=20
will expect that the PCR banks that were available before the suspend=20
will be available after the resume and a possible swtpm upgrade. This in=20
turn means that the PCR banks should be chosen now and we'll have to=20
stick with them.

That said, my suggestion would be to enable only PCR banks for SHA256=20
for 'now' and SHA512 for the future. Having two PCR banks should enable=20
decent performance. If someone wants to have better performance he will=20
have to go through the firmware to select the PCR banks at the expense=20
of loosing suspend/resume support.

The change of PCR banks for the current 4 PCR banks will break the state=20
of all swtpms.

If you have suggestions, please let me know.

Regards,

 =C2=A0=C2=A0 Stefan
