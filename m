Received: from eggs.gnu.org ([2001:4830:134:3::10]:52391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duJTd-00054Z-MW
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duJTb-0003lY-0J
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:26:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42830
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1duJTa-0003lB-Re
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:26:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JEP1IT141503
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 10:26:14 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d33dret08-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 10:26:13 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 15:26:12 +0100
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
	<20170913132752.8484-2-pasic@linux.vnet.ibm.com>
	<20170914162603.1cdabd09.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 16:26:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170914162603.1cdabd09.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <7f8340e7-068d-3740-81ac-c9d22fd6b6c7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 14/09/2017 16:26, Cornelia Huck wrote:
> On Wed, 13 Sep 2017 15:27:51 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>=20
>> Add a fake device meant for testing the correctness of our css emulati=
on.
>>
>> What we currently have is writing a Fibonacci sequence of uint32_t to =
the
>> device via ccw write. The write is going to fail if it ain't a Fibonac=
ci
>> and indicate a device exception in scsw together with the proper resid=
ual
>> count.
>>
>> Of course lot's of invalid inputs (besides basic data processing) can =
be
>> tested with that as well.
>>
>> Usage:
>> 1) fire up a qemu with something like -device ccw-tester,devno=3Dfe.0.=
0001
>>     on the command line
>> 2) exercise the device from the guest
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>
>> Depends on the series 'add CCW indirect data access support'
>>
>> ---
>>   hw/s390x/Makefile.objs |   1 +
>>   hw/s390x/ccw-tester.c  | 179 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   2 files changed, 180 insertions(+)
>>   create mode 100644 hw/s390x/ccw-tester.c
>>
>=20
>> +static int  ccw_tester_write_fib(SubchDev *sch, CCW1 ccw)
>> +{
>> +    CcwTesterDevice *d =3D sch->driver_data;
>> +    bool is_fib =3D true;
>> +    uint32_t sum;
>> +    int ret =3D 0;
>> +
>> +    ccw_dstream_init(&sch->cds, &ccw, &sch->orb);
>> +    d->fib.next =3D 0;
>> +    while (ccw_dstream_avail(&sch->cds) > 0) {
>> +        ret =3D ccw_dstream_read(&sch->cds,
>> +                               d->fib.ring[abs_to_ring(d->fib.next)])=
;
>> +        if (ret) {
>> +            error(0, -ret, "fib");
>> +            break;
>> +        }
>> +        if (d->fib.next > 2) {
>> +            sum =3D (d->fib.ring[abs_to_ring(d->fib.next - 1)]
>> +                  + d->fib.ring[abs_to_ring(d->fib.next - 2)]);
>> +            is_fib =3D sum =3D=3D  d->fib.ring[abs_to_ring(d->fib.nex=
t)];
>=20
> This is not endian-safe (noticed while testing on my laptop). Trivial
> to fix:
>=20
> diff --git a/hw/s390x/ccw-tester.c b/hw/s390x/ccw-tester.c
> index c8017818c4..a425daaa34 100644
> --- a/hw/s390x/ccw-tester.c
> +++ b/hw/s390x/ccw-tester.c
> @@ -58,9 +58,9 @@ static int  ccw_tester_write_fib(SubchDev *sch, CCW1 =
ccw)
>               break;
>           }
>           if (d->fib.next > 2) {
> -            sum =3D (d->fib.ring[abs_to_ring(d->fib.next - 1)]
> -                  + d->fib.ring[abs_to_ring(d->fib.next - 2)]);
> -            is_fib =3D sum =3D=3D  d->fib.ring[abs_to_ring(d->fib.next=
)];
> +            sum =3D be32_to_cpu(d->fib.ring[abs_to_ring(d->fib.next - =
1)])
> +                + be32_to_cpu(d->fib.ring[abs_to_ring(d->fib.next - 2)=
]);
> +            is_fib =3D sum =3D=3D be32_to_cpu(d->fib.ring[abs_to_ring(=
d->fib.next)]);
>               if (!is_fib) {
>                   break;
>               }
>=20
>> +            if (!is_fib) {
>> +                break;
>> +            }
>> +        }
>> +        ++(d->fib.next);
>> +    }
>> +    if (!is_fib) {
>> +        sch->curr_status.scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
>> +        sch->curr_status.scsw.ctrl |=3D SCSW_STCTL_PRIMARY |
>> +                                      SCSW_STCTL_SECONDARY |
>> +                                      SCSW_STCTL_ALERT |
>> +                                      SCSW_STCTL_STATUS_PEND;
>> +        sch->curr_status.scsw.count =3D ccw_dstream_residual_count(&s=
ch->cds);
>> +        sch->curr_status.scsw.cpa =3D sch->channel_prog + 8;
>> +        sch->curr_status.scsw.dstat =3D  SCSW_DSTAT_UNIT_EXCEP;
>> +        return -EIO;
>> +    }
>> +    return ret;
>> +}
>> +
> (...)
>> +static Property ccw_tester_properties[] =3D {
>> +    DEFINE_PROP_UINT16("cu_type", CcwTesterDevice, cu_type,
>> +                        0x3831),
>=20
> 0x4711 would be nice :)

The C0C0 channel would be nice too.
Sorry.

>=20
> If we want to follow up on that testdev idea (and I think we should),
> it might make sense to have a proper type reserve to prevent accidental
> clashes.
>=20
> (Or is there already something reserved for "hypervisor use" or
> whatever?)
>=20
>> +    DEFINE_PROP_UINT8("chpid_type", CcwTesterDevice, chpid_type,
>> +                       0x98),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>=20
> IIUC, pci-testdev provides some unit tests to testers (like kvm-tests)
> itself. This might be an idea to follow up on for ccw as well.
>=20
> There's quite some potential in this. We may want to make this a
> permanent addition.
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
