Received: from eggs.gnu.org ([2001:4830:134:3::10]:41874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXTK2-0000DA-D7
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXTJz-0006IB-0e
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:22:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48912
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fXTJy-0006I3-Qr
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:22:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5PFJHUD108516
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:22:26 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ju2q6gr4t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:22:25 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 25 Jun 2018 09:22:23 -0600
References: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
	<20180625151803.GA2393@work-vm>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 25 Jun 2018 11:22:18 -0400
MIME-Version: 1.0
In-Reply-To: <20180625151803.GA2393@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <ad36fd83-8de6-1e9e-db51-1ceaf0f0269a@linux.vnet.ibm.com>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: tpm2@lists.01.org, Kenneth Goldman <kgoldman@us.ibm.com>, Chris Friesen <chris.friesen@windriver.com>, "Qi, Yadong" <yadong.qi@intel.com>, qemu-devel <qemu-devel@nongnu.org>, "Xu, Quan" <quan.xu@intel.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 06/25/2018 11:18 AM, Dr. David Alan Gilbert wrote:
> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
>> Hi!
>>
>>  =C2=A0I am sending this email to solicit input on the choice of the P=
CR banks to
>> enable for swtpm's TPM 2. I have currently enabled 4 PCR banks for
>> SHA{1,256,384,512}. The downside of this is that running the TPM 2 wit=
h so
>> many PCR banks has a performance impact when the Linux integrity measu=
rement
>> architecture is used and has to extend measurements into all PCR banks=
,
>> which Linux does already.
>>
>> TPM 2 has the PCR_Allocate() command for a user to select the PCR bank=
s to
>> use. This command allows to make some PCR banks invisible. The change =
has to
>> be done through the firmware and has the downside that the TPM2 does n=
ot
>> support TPM2_Shutdown(SU_STATE) after this command was used. This prev=
ents
>> suspend/resume from working properly. So, it seems that one shouldn't =
have
>> to use this command, which in turn means the number of PCR banks shoul=
d be
>> small.
>>
>> Another complication with the swtpm is the upgrade path. Suspended VMs=
 will
>> expect that the PCR banks that were available before the suspend will =
be
>> available after the resume and a possible swtpm upgrade. This in turn =
means
>> that the PCR banks should be chosen now and we'll have to stick with t=
hem.
>>
>> That said, my suggestion would be to enable only PCR banks for SHA256 =
for
>> 'now' and SHA512 for the future. Having two PCR banks should enable de=
cent
>> performance. If someone wants to have better performance he will have =
to go
>> through the firmware to select the PCR banks at the expense of loosing
>> suspend/resume support.
>>
>> The change of PCR banks for the current 4 PCR banks will break the sta=
te of
>> all swtpms.
>>
>> If you have suggestions, please let me know.
> Is this something that has to be set at compile time or could it be
> something chosen at run time (as options to the swtpm command line?)
It is a compile-time option...

 =C2=A0=C2=A0 Stefan

>
> Dave
>> Regards,
>>
>>  =C2=A0=C2=A0 Stefan
>>
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
