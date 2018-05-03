Received: from eggs.gnu.org ([2001:4830:134:3::10]:55927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fEGhk-0003Il-CW
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fEGha-0002FQ-L3
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:03:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fEGha-0002F5-Cb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:03:26 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w43G2Ue2037426
	for <qemu-devel@nongnu.org>; Thu, 3 May 2018 12:03:25 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hr2p7gx9m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 12:03:24 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 3 May 2018 10:03:23 -0600
References: <20180502125221.4877-1-cohuck@redhat.com>
	<cbe7b21c-639c-aa64-4777-03d0aa793ac8@linux.ibm.com>
	<ea05d15c-5aa3-7a73-937f-f6e41893ad85@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 3 May 2018 12:03:18 -0400
MIME-Version: 1.0
In-Reply-To: <ea05d15c-5aa3-7a73-937f-f6e41893ad85@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <445e553c-dd76-8387-28a8-90c3eb517a17@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: force diag 308 subcode to
 unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org



On 05/03/2018 11:48 AM, Eric Blake wrote:
> On 05/03/2018 10:25 AM, Farhan Ali wrote:
>> On 05/02/2018 08:52 AM, Cornelia Huck wrote:
>>> We currently pass an integer as the subcode parameter. However,
>>> the upper bits of the register containing the subcode need to
>>> be 0, which is not guaranteed unless we explicitly specify the
>>> subcode to be an unsigned long value.
>>>
>>> Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag=20
>>> 308/6")
>>> Cc:qemu-stable@nongnu.org
>>> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
>>
>> Sorry for my ignorance, but is there a C standard that says upper bits=
=20
>> of an int is not guaranteed to be 0?
>=20
> We're outside the bounds of the C standard because of the use of asm().=
=20
> The problem here is that the compiler assigning a 32-bit int into a=20
> 64-bit register uses the shortest sequence possible (leaving the upper=20
> 64 bits garbage), because the compiler assumes you correctly wrote the=20
> assembly to only use 32-bit operations on that register (which don't=20
> care about the upper bits).=C2=A0 By using an unsigned long (a 64-bit v=
alue),=20
> the compiler instead emits assembly to write the full 64-bit register=20
> value, rather than leaving the upper bits as garbage; and this matters=20
> because we are subsequently using all 64 bits of the register in a late=
r=20
> operation.=C2=A0 We could also use a signed long, even long long, or wr=
itten=20
> it as: (store ? 6ULL : 5ULL) instead of using a temporary variable.=C2=A0=
 The=20
> crux of the fix is that you have to tell asm() that you want a 64-bit=20
> value written (the unpatched (store ? 6 : 5) is only a 32-bit value),=20
> and not whether that value is signed or unsigned (since the=20
> representation of both 6 and 5 are the same regardless of whether the=20
> type being written into the register is signed or not).
>=20

Thank you so much for the detailed explanation :).

I did not think about the instruction that will be used by the compiler=20
to handle the values. Definitely learned something new!
