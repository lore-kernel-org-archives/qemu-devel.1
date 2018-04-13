Received: from eggs.gnu.org ([2001:4830:134:3::10]:43841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f7399-0003qT-P2
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f7396-0004nq-Hi
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:10:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45346
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1f7396-0004ne-CB
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:10:00 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3DHxt3D042007
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 14:09:59 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hb0tphu7y-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 14:09:59 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Fri, 13 Apr 2018 14:09:58 -0400
References: <1523629847-22369-1-git-send-email-thuth@redhat.com>
	<df1a9534-c1ca-972b-91a6-359685a671df@linux.vnet.ibm.com>
	<f3d7c3d0-26fe-37db-abb3-0e99373ae315@redhat.com>
	<6b294d1a-5f3b-aa9c-c0e4-db9da04c4548@linux.vnet.ibm.com>
	<fb58d12d-92b3-2a68-af10-f8f5608f5237@amsat.org>
From: Collin Walling <walling@linux.ibm.com>
Date: Fri, 13 Apr 2018 14:09:55 -0400
MIME-Version: 1.0
In-Reply-To: <fb58d12d-92b3-2a68-af10-f8f5608f5237@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <c7dec4d0-2674-e51e-9698-571c7f02b6a7@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: size_t should
 be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 04/13/2018 02:06 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 04/13/2018 01:59 PM, Halil Pasic wrote:
>>>> On 04/13/2018 04:30 PM, Thomas Huth wrote:
>>>>> "size_t" should be an unsigned type - the signed counterpart is cal=
led
>>>>> "ssize_t" in the C standard instead. Thus we should also use this
>>>> The first sentence sounds like ssize_t is too a type defined by some
>>>> C standard. Is it or does ssize_t come form somewhere else?
>>> Arrr, seems like ssize_t is rather coming from POSIX than from the C
>>> standard, thanks for the hint. I'll rephrase the first sentence to:
>>>
>>> "size_t" should be an unsigned type according to the C standard, and
>>> most libc implementations provide a signed counterpart called "ssize_=
t".
>>>
>>> OK?
>>>
>>
>> This ssize_t seems to be an rather interesting type. For instance POSI=
X says
>> """
>> size_t
>>     Used for sizes of objects.
>> ssize_t
>>     Used for a count of bytes or an error indication.
>> """
>> and
>> """
>> The type ssize_t shall be capable of storing values at least in the ra=
nge [-1, {SSIZE_MAX}].
>> """
>>
>> And it does not mandate SSIZE_MIN in limits (but of course mandates SS=
IZE_MAX.
>>
>> I don't like this 'counterpart' word here, because AFAIU these don't h=
ave to
>> be counterparts in any sense. That is SSIZE_MAX << SIZE_MAX is possibl=
e for
>> example. I'm not sure about the every positive has a negative thing, b=
ut
>> that's not important here.
>>
>> The code in question kind of uses both signed and unsigned size for
>> the same (the string). We even have a signed to unsigned comparison wh=
ich
>> could result in warnings. I still think the change is OK in practice, =
but
>> maybe avoiding introducing ssize_t (until we really need it) is a bett=
er
>> course of action. I think uitoa can be easily rewritten so it does not
>> need the ssize_t.
>>
>> How about that?
>=20
> This seems clever indeed.
>=20

This whole issue stems from my misuse of size_t in the first place. If it=
 makes
things easier, let's just make num_idx of type "signed long".

After reading this discussion, I think it makes sense to drop ssize_t. No=
 need
to make it available for just one function unless there are strong claims=
 to
also use this type elsewhere in the pc-bios (I can't find any).

--=20
Respectfully,
- Collin Walling
