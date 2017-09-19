Received: from eggs.gnu.org ([2001:4830:134:3::10]:53125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duHSJ-00089A-Tu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duHSE-0005nd-Tb
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:16:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1duHSE-0005mX-L5
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:16:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JCE4oL047218
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 08:16:41 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2yyqb22y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 08:16:41 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 13:16:38 +0100
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-2-pasic@linux.vnet.ibm.com>
	<63eabac3-0646-92ff-dede-d16391124061@linux.vnet.ibm.com>
	<20170919115321.0f3b5c57.cohuck@redhat.com>
	<b75ec315-27c4-aa65-9360-85ed21796f0d@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 14:16:36 +0200
MIME-Version: 1.0
In-Reply-To: <b75ec315-27c4-aa65-9360-85ed21796f0d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <3fb74715-e807-7316-99e8-c111702b8d44@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] s390x/css: introduce css data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/19/2017 01:41 PM, Pierre Morel wrote:
> On 19/09/2017 11:53, Cornelia Huck wrote:
>> On Tue, 19 Sep 2017 11:11:27 +0200
>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>
>>> On 13/09/2017 13:50, Halil Pasic wrote:
>>>> This is a preparation for introducing handling for indirect data
>>>> addressing and modified indirect data addressing (CCW). Here we intr=
oduce
>>>> an interface which should make the addressing scheme transparent for=
 the
>>>> client code. Here we implement only the basic scheme (no IDA or MIDA=
).
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> ---
>>>> =C2=A0=C2=A0 hw/s390x/css.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 55 +++++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0=C2=A0 include/hw/s390x/css.h | 67 +++++++++++++++++++++++++++=
+++++++++++++++++++++++
>>>> =C2=A0=C2=A0 2 files changed, 122 insertions(+)
>>
>>>> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
>>>> index 0653d3c9be..79acaf99b7 100644
>>>> --- a/include/hw/s390x/css.h
>>>> +++ b/include/hw/s390x/css.h
>>>> @@ -75,6 +75,29 @@ typedef struct CMBE {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t reserved[7];
>>>> =C2=A0=C2=A0 } QEMU_PACKED CMBE;
>>>>
>>>> +typedef enum CcwDataStreamOp {
>>>> +=C2=A0=C2=A0=C2=A0 CDS_OP_R =3D 0,
>>>> +=C2=A0=C2=A0=C2=A0 CDS_OP_W =3D 1,
>>>> +=C2=A0=C2=A0=C2=A0 CDS_OP_A =3D 2
>>>> +} CcwDataStreamOp;
>>>> +
>>>> +/** normal usage is via SuchchDev.cds instead of instantiating */
>>>> +typedef struct CcwDataStream {
>>>> +#define CDS_F_IDA=C2=A0=C2=A0 0x01
>>>> +#define CDS_F_MIDA=C2=A0 0x02
>>>> +#define CDS_F_I2K=C2=A0=C2=A0 0x04
>>>> +#define CDS_F_C64=C2=A0=C2=A0 0x08
>>>> +#define CDS_F_STREAM_BROKEN=C2=A0 0x80
>>>> +=C2=A0=C2=A0=C2=A0 uint8_t flags;
>>>> +=C2=A0=C2=A0=C2=A0 uint8_t at_idaw;
>>>> +=C2=A0=C2=A0=C2=A0 uint16_t at_byte;
>>>> +=C2=A0=C2=A0=C2=A0 uint16_t count;
>>>> +=C2=A0=C2=A0=C2=A0 uint32_t cda_orig;
>>>> +=C2=A0=C2=A0=C2=A0 int (*op_handler)(struct CcwDataStream *cds, voi=
d *buff, int len,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CcwDataStreamOp=
 op);
>>>
>>> I would have prefer one handler per operation instead of a operation
>>> parameter.
>>>
>>> Is it possible to change the name of the "buf" argument to "arg".
>>> I just think of the foollowing:
>>> If one day we do not want to gather all IDAs into a single buffer but
>>> keep them split, we can have something like an array of buffers as ar=
gument.
>>

I had a similar idea: basically indirect data access is kind of a scatter=
-
gather mechanism. If one just has to mediate the data (e.g. between some
backed taking sg or some facility provided by the kernel) creating a copy
of the data (what CcwDataStream currently does) is not necessarily optima=
l.

I've realized that while looking at the 3270 code.

So some kind of a turn a CcwDataStream into a scatter-gather list may
come along the road. But I would like to have an use-case for that first.

>> It should be possible to change the internal format should we decide t=
o
>> want to do something different, so I'll leave that as-is for now.
>>

Fully agree! This is internal stuff we have under full control. We can
decide any time to do something completely different looking (if we are
willing to change all the client code). So I think taking out the crystal=
 orb
(pun intended) ain't necessary (or very productive).

>>>
>>>
>>>
>>>> +=C2=A0=C2=A0=C2=A0 hwaddr cda;
>>>> +} CcwDataStream;
>>>> +
>>
>>> otherwise, LGTM
>>
>> Is that an ack? :)
>>
>=20
> Sorry, yes it is.
> I play a little with the code before giving a RB
> Should be end of the day.
>=20
>=20
