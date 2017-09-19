Received: from eggs.gnu.org ([2001:4830:134:3::10]:34407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duIzh-0006B6-Gt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duIzb-0001iY-FK
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:55:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48460
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1duIzb-0001iL-9Y
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:55:15 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JDsuYg113813
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:55:14 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d30nvq5mg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:55:12 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 14:55:11 +0100
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-2-pasic@linux.vnet.ibm.com>
	<63eabac3-0646-92ff-dede-d16391124061@linux.vnet.ibm.com>
	<20170919115321.0f3b5c57.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 15:55:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170919115321.0f3b5c57.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <092270d2-4079-2ce0-910b-80e792499532@linux.vnet.ibm.com>
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
>=20

Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
