Received: from eggs.gnu.org ([2001:4830:134:3::10]:56697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duGu9-0007u3-4V
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duGu5-0007Y3-UY
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:41:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1duGu5-0007XM-MN
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:41:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JBe605102319
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 07:41:23 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2yyyrywy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 07:41:23 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 12:41:21 +0100
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-2-pasic@linux.vnet.ibm.com>
	<63eabac3-0646-92ff-dede-d16391124061@linux.vnet.ibm.com>
	<20170919115321.0f3b5c57.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 13:41:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170919115321.0f3b5c57.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b75ec315-27c4-aa65-9360-85ed21796f0d@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 19/09/2017 11:53, Cornelia Huck wrote:
> On Tue, 19 Sep 2017 11:11:27 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> On 13/09/2017 13:50, Halil Pasic wrote:
>>> This is a preparation for introducing handling for indirect data
>>> addressing and modified indirect data addressing (CCW). Here we intro=
duce
>>> an interface which should make the addressing scheme transparent for =
the
>>> client code. Here we implement only the basic scheme (no IDA or MIDA).
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> ---
>>>    hw/s390x/css.c         | 55 ++++++++++++++++++++++++++++++++++++++=
+++
>>>    include/hw/s390x/css.h | 67 ++++++++++++++++++++++++++++++++++++++=
++++++++++++
>>>    2 files changed, 122 insertions(+)
>=20
>>> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
>>> index 0653d3c9be..79acaf99b7 100644
>>> --- a/include/hw/s390x/css.h
>>> +++ b/include/hw/s390x/css.h
>>> @@ -75,6 +75,29 @@ typedef struct CMBE {
>>>        uint32_t reserved[7];
>>>    } QEMU_PACKED CMBE;
>>>
>>> +typedef enum CcwDataStreamOp {
>>> +    CDS_OP_R =3D 0,
>>> +    CDS_OP_W =3D 1,
>>> +    CDS_OP_A =3D 2
>>> +} CcwDataStreamOp;
>>> +
>>> +/** normal usage is via SuchchDev.cds instead of instantiating */
>>> +typedef struct CcwDataStream {
>>> +#define CDS_F_IDA   0x01
>>> +#define CDS_F_MIDA  0x02
>>> +#define CDS_F_I2K   0x04
>>> +#define CDS_F_C64   0x08
>>> +#define CDS_F_STREAM_BROKEN  0x80
>>> +    uint8_t flags;
>>> +    uint8_t at_idaw;
>>> +    uint16_t at_byte;
>>> +    uint16_t count;
>>> +    uint32_t cda_orig;
>>> +    int (*op_handler)(struct CcwDataStream *cds, void *buff, int len=
,
>>> +                      CcwDataStreamOp op);
>>
>> I would have prefer one handler per operation instead of a operation
>> parameter.
>>
>> Is it possible to change the name of the "buf" argument to "arg".
>> I just think of the foollowing:
>> If one day we do not want to gather all IDAs into a single buffer but
>> keep them split, we can have something like an array of buffers as arg=
ument.
>=20
> It should be possible to change the internal format should we decide to
> want to do something different, so I'll leave that as-is for now.
>=20
>>
>>
>>
>>> +    hwaddr cda;
>>> +} CcwDataStream;
>>> +
>=20
>> otherwise, LGTM
>=20
> Is that an ack? :)
>=20

Sorry, yes it is.
I play a little with the code before giving a RB
Should be end of the day.


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
