Received: from eggs.gnu.org ([2001:4830:134:3::10]:38946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ebma0-0001DD-Ru
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ebmZx-0002KB-Lk
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:12:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41502
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ebmZx-0002Jj-Fz
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:12:29 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0HCCSim059017
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 07:12:28 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fj5frjg96-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 07:12:28 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 17 Jan 2018 07:12:26 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-5-git-send-email-walling@linux.vnet.ibm.com>
	<6e4c6445-0b78-1709-b724-e35daeefb1c1@redhat.com>
	<e92dd0a3-422a-57a5-f0a4-c9fbb620a1c4@linux.vnet.ibm.com>
	<79634fce-eebe-4377-ef62-df8ef53b22d9@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Wed, 17 Jan 2018 07:12:21 -0500
MIME-Version: 1.0
In-Reply-To: <79634fce-eebe-4377-ef62-df8ef53b22d9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b1794732-5a88-737c-a734-5aeaf6cf8c50@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 4/8] s390-ccw: interactive
 boot menu for eckd dasd (menu setup)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, borntraeger@de.ibm.com, alifm@linux.vnet.ibm.com, david@redhat.com, cohuck@redhat.com

On 01/17/2018 01:11 AM, Thomas Huth wrote:
> On 16.01.2018 20:37, Collin L. Walling wrote:
>> On 01/16/2018 01:23 PM, Thomas Huth wrote:
>>> On 15.01.2018 17:44, Collin L. Walling wrote:
>>>> Reads boot menu flag and timeout values from the iplb and
>>>> sets the respective fields for the menu.
>>>>
>>>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>>>> ---
>>> [...]
>>>> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
>>>> index fe909d2..da29e6e 100644
>>>> --- a/pc-bios/s390-ccw/iplb.h
>>>> +++ b/pc-bios/s390-ccw/iplb.h
>>>> @@ -81,6 +81,9 @@ extern IplParameterBlock iplb
>>>> __attribute__((__aligned__(PAGE_SIZE)));
>>>>  =C2=A0 #define S390_IPL_TYPE_CCW 0x02
>>>>  =C2=A0 #define S390_IPL_TYPE_QEMU_SCSI 0xff
>>>>  =C2=A0 +#define LOADPARM_PROMPT "PROMPT=C2=A0 "
>>>> +#define LOADPARM_EMPTY=C2=A0 "........"
>>> I've got a question: Is there a (public) specification document
>>> available somewhere for the loadparm field?
>> Unfortunately there does not seems to be any kind of documentation
>> regarding loadparm for
>> KVM on IBM z.=C2=A0 Most of the information available on the IBM Knowl=
edge
>> Center focuses on
>> z/VM, which isn't very helpful in this case :(
> Ok, too bad :-(
>
>> Are there any specific questions that I can help with?
> I was just wondering whether there are pre-defined values for this
> field, e.g. is "PROMPT" something you came up with, or is this a value
> that has been documented in a specification somewhere? ... I'm just
> curious: If there is a list of pre-defined values somewhere, what are
> the other values that the s390-ccw bios does not support yet?


We're mimicking zipl's behavior.=C2=A0 It currently supports two use case=
s for
loadparm: setting an explicit boot index (by providing a valid integer),
and showing the boot menu without a timeout (by providing the string
'prompt').


>   Thomas
>


--=20
- Collin L Walling
