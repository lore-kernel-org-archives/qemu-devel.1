Received: from eggs.gnu.org ([2001:4830:134:3::10]:54317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXXPn-0006Kr-VP
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 15:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXXPj-0005g9-0A
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 15:44:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fXXPi-0005fe-NE
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 15:44:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5PJDWoB094892
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 15:44:37 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ju60sj1a9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 15:44:37 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 25 Jun 2018 15:44:36 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
Date: Mon, 25 Jun 2018 15:44:32 -0400
MIME-Version: 1.0
In-Reply-To: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <01ecb9fd-dae2-269f-ba34-94530ed6ec7d@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Choosing PCR banks for swtpm's TPM 2
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

On 06/25/2018 11:05 AM, Stefan Berger wrote:
> Hi!
>
> =C2=A0I am sending this email to solicit input on the choice of the PCR=
=20
> banks to enable for swtpm's TPM 2. I have currently enabled 4 PCR=20
> banks for SHA{1,256,384,512}. The downside of this is that running the=20
> TPM 2 with so many PCR banks has a performance impact when the Linux=20
> integrity measurement architecture is used and has to extend=20
> measurements into all PCR banks, which Linux does already.
>
> TPM 2 has the PCR_Allocate() command for a user to select the PCR=20
> banks to use. This command allows to make some PCR banks invisible.=20
> The change has to be done through the firmware and has the downside=20
> that the TPM2 does not support TPM2_Shutdown(SU_STATE) after this=20
> command was used. This prevents suspend/resume from working properly.=20
> So, it seems that one shouldn't have to use this command, which in=20
> turn means the number of PCR banks should be small.

Actually that was my interpretation of the specs and from what it looks=20
like I was wrong assuming that once PCR_Allocate() was used that=20
TPM2_Shutdown(SU_STATE) cannot be used anymore at all. The text is a bit=20
ambiguous about it. This command can be sent, but the machine needs to=20
be rebooted and with that the TPM 2 reset.

The next issue is that the IBM TSS2 is hard coded for 3 PCR banks and a=20
few commands are breaking because of that. Now the solution would be to:

- compile-time disable the SHA512 bank; this will break existing state=20
but for as long as it's in preview, I hope this is ok; we cannot easily=20
enable SHA512 then in the future.

- swtpm_setup gets a --pcr-banks <PCR banks> option that=20
PCR_Allocate()'s the active PCR banks for the swtpm. The default will be=20
SHA 1 and SHA 256, which disables the SHA 384 PCR bank; Users can choose=20
their banks if they run this command directly. SHA1 and SHA256 seems to=20
be a reasonable set of active PCR banks for now.

 =C2=A0=C2=A0 Stefan



>
> Another complication with the swtpm is the upgrade path. Suspended VMs=20
> will expect that the PCR banks that were available before the suspend=20
> will be available after the resume and a possible swtpm upgrade. This=20
> in turn means that the PCR banks should be chosen now and we'll have=20
> to stick with them.
>
> That said, my suggestion would be to enable only PCR banks for SHA256=20
> for 'now' and SHA512 for the future. Having two PCR banks should=20
> enable decent performance. If someone wants to have better performance=20
> he will have to go through the firmware to select the PCR banks at the=20
> expense of loosing suspend/resume support.
>
> The change of PCR banks for the current 4 PCR banks will break the=20
> state of all swtpms.
>
> If you have suggestions, please let me know.
>
> Regards,
>
> =C2=A0=C2=A0 Stefan
>
>
