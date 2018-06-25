Received: from eggs.gnu.org ([2001:4830:134:3::10]:54679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXU2n-0003NU-Tw
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXU2k-00013W-N0
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:08:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43620
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fXU2k-000139-Hg
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:08:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5PFx2oZ133628
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 12:08:42 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ju2hu3efm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 12:08:41 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 25 Jun 2018 10:08:40 -0600
References: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
	<20180625152513.GI18580@redhat.com>
	<6adb28e6-85eb-38dc-ad24-99a5daa0f972@linux.vnet.ibm.com>
	<20180625155933.GK18580@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 25 Jun 2018 12:08:34 -0400
MIME-Version: 1.0
In-Reply-To: <20180625155933.GK18580@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <759e2eab-bc8a-a841-5016-4308c3a680bb@linux.vnet.ibm.com>
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: tpm2@lists.01.org, Kenneth Goldman <kgoldman@us.ibm.com>, Chris Friesen <chris.friesen@windriver.com>, "Qi, Yadong" <yadong.qi@intel.com>, qemu-devel <qemu-devel@nongnu.org>, "Xu, Quan" <quan.xu@intel.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 06/25/2018 11:59 AM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Jun 25, 2018 at 11:56:24AM -0400, Stefan Berger wrote:
>> On 06/25/2018 11:25 AM, Daniel P. Berrang=C3=A9 wrote:
>>> On Mon, Jun 25, 2018 at 11:05:55AM -0400, Stefan Berger wrote:
>>>> Hi!
>>>>
>>>>   =C2=A0I am sending this email to solicit input on the choice of th=
e PCR banks to
>>>> enable for swtpm's TPM 2. I have currently enabled 4 PCR banks for
>>>> SHA{1,256,384,512}. The downside of this is that running the TPM 2 w=
ith so
>>>> many PCR banks has a performance impact when the Linux integrity mea=
surement
>>>> architecture is used and has to extend measurements into all PCR ban=
ks,
>>>> which Linux does already.
>>>>
>>>> TPM 2 has the PCR_Allocate() command for a user to select the PCR ba=
nks to
>>>> use. This command allows to make some PCR banks invisible. The chang=
e has to
>>>> be done through the firmware and has the downside that the TPM2 does=
 not
>>>> support TPM2_Shutdown(SU_STATE) after this command was used. This pr=
events
>>>> suspend/resume from working properly. So, it seems that one shouldn'=
t have
>>>> to use this command, which in turn means the number of PCR banks sho=
uld be
>>>> small.
>>>>
>>>> Another complication with the swtpm is the upgrade path. Suspended V=
Ms will
>>>> expect that the PCR banks that were available before the suspend wil=
l be
>>>> available after the resume and a possible swtpm upgrade. This in tur=
n means
>>>> that the PCR banks should be chosen now and we'll have to stick with=
 them.
>>> Anything that has a risk of needing to change between versions would =
need
>>> to be tied into the machine type in some way.
>> You mean a machine type like q35? I am not sure how it would be tied i=
nto
>> QEMU since the swtpm command line options are chosen more or less
>> independently of the ones from QEMU.
> Yes, each QEMU release introduces a new versioned machine type eg
>    q35-2.10,  q35-2.11, q35-2.12, q35-3.0
>
> If anything in QEMU changes which impacts live migraiton/save/restore/e=
tc
> then we tie it to the versioned machine type. so q35-3.0 would get the
> new default value, and all previous machine types keep the old default
> value.
>
> For this to be possible with externally launched swtpm though, would
> require some way for QEMU to talk to swtpm to tell it what default
> to use for this. I don't know enough about swtpm to have an idea how
> practical this is or not.

The set of PCR banks a future TPM 2 would be 'manufactured with' would=20
be determined by parameters to swtpm_setup. That's when the TPM2 is=20
'manufactured' and the certificates are created and written into its=20
NVRAM locations. QEMU is not talking to the TPM 2 at this point. So it=20
would be parameters passed from libvirt to swtpm_setup that determine=20
the set of PCR banks. swtpm itself would get those supplied via command=20
line options when invoked by swtpm_setup. If one was to skip over the=20
swtpm_setup step, then why not use the swtpm command line options that=20
need to be there for swtpm_setup support. Though I think few people will=20
use it like that. I would not extend the protocol for this purpose.

 =C2=A0=C2=A0 Stefan

>
> Regards,
> Daniel
