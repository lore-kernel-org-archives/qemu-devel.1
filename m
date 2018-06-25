Received: from eggs.gnu.org ([2001:4830:134:3::10]:58978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXUH6-0004iJ-PS
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXUH0-0008V5-F0
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:23:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fXUH0-0008Up-5y
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:23:26 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5PGJFBg057908
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 12:23:24 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ju2au4wcw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 12:23:24 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 25 Jun 2018 10:23:23 -0600
References: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
	<20180625151803.GA2393@work-vm>
	<ad36fd83-8de6-1e9e-db51-1ceaf0f0269a@linux.vnet.ibm.com>
	<20180625152916.GG2390@work-vm>
	<0bddd044-c9bf-37b9-814b-8eeaf13c9f64@linux.vnet.ibm.com>
	<20180625161147.GH2390@work-vm>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 25 Jun 2018 12:23:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180625161147.GH2390@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <8e7b0363-28ec-b2fa-19bf-c1820c8a75c7@linux.vnet.ibm.com>
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

On 06/25/2018 12:11 PM, Dr. David Alan Gilbert wrote:
> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
>> On 06/25/2018 11:29 AM, Dr. David Alan Gilbert wrote:
>>> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
>>>> On 06/25/2018 11:18 AM, Dr. David Alan Gilbert wrote:
>>>>> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
>>>>>> Hi!
>>>>>>
>>>>>>    =C2=A0I am sending this email to solicit input on the choice of=
 the PCR banks to
>>>>>> enable for swtpm's TPM 2. I have currently enabled 4 PCR banks for
>>>>>> SHA{1,256,384,512}. The downside of this is that running the TPM 2=
 with so
>>>>>> many PCR banks has a performance impact when the Linux integrity m=
easurement
>>>>>> architecture is used and has to extend measurements into all PCR b=
anks,
>>>>>> which Linux does already.
>>>>>>
>>>>>> TPM 2 has the PCR_Allocate() command for a user to select the PCR =
banks to
>>>>>> use. This command allows to make some PCR banks invisible. The cha=
nge has to
>>>>>> be done through the firmware and has the downside that the TPM2 do=
es not
>>>>>> support TPM2_Shutdown(SU_STATE) after this command was used. This =
prevents
>>>>>> suspend/resume from working properly. So, it seems that one should=
n't have
>>>>>> to use this command, which in turn means the number of PCR banks s=
hould be
>>>>>> small.
>>>>>>
>>>>>> Another complication with the swtpm is the upgrade path. Suspended=
 VMs will
>>>>>> expect that the PCR banks that were available before the suspend w=
ill be
>>>>>> available after the resume and a possible swtpm upgrade. This in t=
urn means
>>>>>> that the PCR banks should be chosen now and we'll have to stick wi=
th them.
>>>>>>
>>>>>> That said, my suggestion would be to enable only PCR banks for SHA=
256 for
>>>>>> 'now' and SHA512 for the future. Having two PCR banks should enabl=
e decent
>>>>>> performance. If someone wants to have better performance he will h=
ave to go
>>>>>> through the firmware to select the PCR banks at the expense of loo=
sing
>>>>>> suspend/resume support.
>>>>>>
>>>>>> The change of PCR banks for the current 4 PCR banks will break the=
 state of
>>>>>> all swtpms.
>>>>>>
>>>>>> If you have suggestions, please let me know.
>>>>> Is this something that has to be set at compile time or could it be
>>>>> something chosen at run time (as options to the swtpm command line?=
)
>>>> It is a compile-time option...
>>> Hmm, that's a shame - I was hoping you'd be able to switch them at
>>> runtime (or at least hide them?) then you can solve the upgrade probl=
em
>>> by running the new swtpm with a flag telling it to hide the new banks.
>>> I hope the ondisk formats for suspend/resume/migration are descriptiv=
e
>>> enough to be able to spot an error if you try and load one configured
>>> differently.4
>> The disk format does detect it and refuses to take the state if either=
 there
>> are too many PCR banks or not enough.
> What happens if there are the right number just the wrong type?

The state would be rejected since they are incompatible.

>
>> For the initial version of swtpm we would need to define a default set=
 of
>> PCR banks since the TPM 2 code uses compile time options to build in t=
hat
>> set of PCR banks.
> You talk of PCR_Allocate() above as a spec-defined command to hide PCRs
> but with the downside of breaking TPM2_Shutdown - could you implement
> something from the commandline without that downside (I don't know how
> PCR banks work).

Like I said, during swtpm_setup TPM 2 manufacturing the set of PCR banks=20
would be chosen and that set would be used by that TPM 2 from then on.=20
Though this flexibility is not supported by the code today.


>
>> A future version of swtpm could expose command line options for select=
ing
>> the PCR banks an instance of swtpm is to run with. libtpms would be co=
mpiled
>> with support for all of them and only the chosen subset would be activ=
e
>> starting with the initial creation of a particular instance of swtpm.
> Right, that would solve the upgrade half of the problem.

For now I think an initial set of banks to go with would be appropriate.

 =C2=A0=C2=A0 Stefan
