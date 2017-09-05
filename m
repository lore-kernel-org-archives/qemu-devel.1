Received: from eggs.gnu.org ([2001:4830:134:3::10]:60166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpGCH-0001rQ-44
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpGCB-0005Kx-IC
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:55:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51158
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpGCB-0005KZ-CR
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:55:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85Fs4GK107441
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 11:55:22 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2csv20hr7t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 11:55:22 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 16:55:20 +0100
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-5-pasic@linux.vnet.ibm.com>
	<20170831115535.1e4201d3.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 5 Sep 2017 17:55:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170831115535.1e4201d3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <7540741b-d230-e7c4-50d3-036f31997c8b@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] s390x: refactor error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 08/31/2017 11:55 AM, Cornelia Huck wrote:
> On Wed, 30 Aug 2017 18:36:04 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>=20
>> Simplify the error handling of the SSCH and RSCH handler avoiding
>> arbitrary and cryptic error codes being mapped to what a subchannel is
>> supposed to do.  Let the code detecting the condition tell how it's to=
 be
>> handled in a less ambiguous way.  It's best to handle SSCH and RSCH in
>> one go as the emulation of the two shares a lot of code.
>=20
> So determining the return code at the point in time where we can
> instead of trying to map to return codes and back again makes quite a
> bit of sense, but I'll have to look at the rest of this.


Looging forward to.

> For one thing,
> would a better split to introduce the cc-reporting infrastructure first
> and then convert the different I/O functions?
>=20

Speaks nothing against it, although I don't see anything wrong with
not introducing unused infrastructure (that is introducing
the infrastructure and it's first user together). As you prefer.

>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
>>
>> ---
>> Notes:
>> Funny, we had a different swich-case for SSCH and RSCH. For
>> virtual it did not matter, but for passtrough it could. In practice
>> -EINVAL from the kernel would have been mapped to cc 2 in case of
>> RSCH and to cc 1 in case of SSHC which is absurd. Same goes for
>> -EBUSY from kernel which is correctly mapped to cc 2 in case of
>> SSCH, but for RSCH it gets mapped to cc 1 which is also absurd.
>> ---
>>  hw/s390x/css.c              | 86 ++++++++++++++----------------------=
---------
>>  hw/s390x/s390-ccw.c         |  8 ++---
>>  hw/vfio/ccw.c               | 32 +++++++++++++----
>>  include/hw/s390x/css.h      | 30 ++++++++++++----
>>  include/hw/s390x/s390-ccw.h |  2 +-
>>  target/s390x/ioinst.c       | 61 +++++++++-----------------------
>>  6 files changed, 97 insertions(+), 122 deletions(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index bc47bf5b20..1102642c10 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -1015,12 +1015,11 @@ static void sch_handle_start_func_virtual(Subc=
hDev *sch)
>> =20
>>  }
>> =20
>> -static int sch_handle_start_func_passthrough(SubchDev *sch)
>> +static void sch_handle_start_func_passthrough(SubchDev *sch)
>>  {
>> =20
>>      PMCW *p =3D &sch->curr_status.pmcw;
>>      SCSW *s =3D &sch->curr_status.scsw;
>> -    int ret;
>> =20
>>      ORB *orb =3D &sch->orb;
>>      if (!(s->ctrl & SCSW_ACTL_SUSP)) {
>> @@ -1034,28 +1033,10 @@ static int sch_handle_start_func_passthrough(S=
ubchDev *sch)
>>       */
>>      if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
>>          !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
>> -        return -ENODEV;
>> +        sch->iret.cc =3D 3;
>=20
> Same as already commented: I don't think cc 3 is a good match.
>=20

Yeah, this is just dumb conversion.

>>      }
>> =20
>> -    ret =3D s390_ccw_cmd_request(orb, s, sch->driver_data);
>> -    switch (ret) {
>> -    /* Currently we don't update control block and just return the cc=
 code. */
>> -    case 0:
>> -        break;
>> -    case -EBUSY:
>> -        break;
>> -    case -ENODEV:
>> -        break;
>> -    case -EFAULT:
>> -         break;
>> -    case -EACCES:
>> -        /* Let's reflect an inaccessible host device by cc 3. */
>> -    default:
>> -        /* Let's make all other return codes map to cc 3.  */
>> -        ret =3D -ENODEV;
>> -    };
>> -
>> -    return ret;
>> +    s390_ccw_cmd_request(sch);
>=20
> As you change the handling anyway: Don't change this logic in prior
> patches?

I preserve the logic as altered by the previous patches (at least,
that is the intention). This is the mapping around part which is going
away if we push the handling down.

>=20
>>  }
>> =20
>>  /*
>> @@ -1064,7 +1045,7 @@ static int sch_handle_start_func_passthrough(Sub=
chDev *sch)
>>   * read/writes) asynchronous later on if we start supporting more tha=
n
>>   * our current very simple devices.
>>   */
>> -int do_subchannel_work_virtual(SubchDev *sch)
>> +void do_subchannel_work_virtual(SubchDev *sch)
>>  {
>> =20
>>      SCSW *s =3D &sch->curr_status.scsw;
>> @@ -1078,41 +1059,35 @@ int do_subchannel_work_virtual(SubchDev *sch)
>>          sch_handle_start_func_virtual(sch);
>>      } else {
>>          /* Cannot happen. */
>> -        return -ENODEV;
>> +        sch->iret.cc =3D 3;
>=20
> See comment for the last patch.
>=20

Again just a conversion. If we don't do it in the previous patch
it has to be done differently in this patch.

>>      }
>>      css_inject_io_interrupt(sch);
>> -    return 0;
>>  }
>> =20
>> -int do_subchannel_work_passthrough(SubchDev *sch)
>> +void do_subchannel_work_passthrough(SubchDev *sch)
>>  {
>> -    int ret;
>>      SCSW *s =3D &sch->curr_status.scsw;
>> =20
>>      if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
>>          /* TODO: Clear handling */
>>          sch_handle_clear_func(sch);
>> -        ret =3D 0;
>>      } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
>>          /* TODO: Halt handling */
>>          sch_handle_halt_func(sch);
>> -        ret =3D 0;
>>      } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
>> -        ret =3D sch_handle_start_func_passthrough(sch);
>> +        sch_handle_start_func_passthrough(sch);
>>      } else {
>>          /* Cannot happen. */
>> -        return -ENODEV;
>> +        sch->iret.cc =3D 3;
>=20
> ftcl =3D=3D 0 should have been rejected already by the function handler=
s
> here as well, shouldn't it?

Which function handlers. Basically the instruction handlers set fctl
and call do_subchannel_work to get the indicated work done.

>=20
>>      }
>> -
>> -    return ret;
>>  }
>> =20
>> -static int do_subchannel_work(SubchDev *sch)
>> +static void do_subchannel_work(SubchDev *sch)
>>  {
>>      if (sch->do_subchannel_work) {
>> -        return sch->do_subchannel_work(sch);
>> +        sch->do_subchannel_work(sch);
>>      } else {
>> -        return -ENODEV;
>> +        sch->iret.cc =3D 3;
>=20
> See my comment for a prior patch.
>

Nod.

=20
>>      }
>>  }
>> =20
>=20
> (...)
>=20
>> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
>> index 5c5fe6b202..d093181a9e 100644
>> --- a/include/hw/s390x/css.h
>> +++ b/include/hw/s390x/css.h
>> @@ -94,13 +94,31 @@ struct SubchDev {
>>      /* transport-provided data: */
>>      int (*ccw_cb) (SubchDev *, CCW1);
>>      void (*disable_cb)(SubchDev *);
>> -    int (*do_subchannel_work) (SubchDev *);
>> +    void (*do_subchannel_work) (SubchDev *);
>>      SenseId id;
>>      void *driver_data;
>> +    /* io instructions conclude according to iret */
>> +    struct {
>> +        /*
>> +         * General semantic of cc codes of IO instructions is (brief)=
:
>> +         * 0 -- produced expected result
>> +         * 1 -- produced alternate result
>> +         * 2 -- ineffective, because busy with previously initiated f=
unction
>> +         * 3 -- ineffective, not operational
>=20
> I'm not sure you can summarize this that way in all cases.
>=20
> Also, what does "ineffective" mean? If I get a cc 1 for, say, ssch, I
> don't expect something either as the subchannel was already status
> pending.

You are right cc 1 would have been better off with
 'produced alternate result or status pending'

I've tried to make this shorter (from PoP 14-2):
"""
Condition Code 0: Instruction execution produced
the expected or most probable result. (See =E2=80=9CDeferred
Condition Code (CC)=E2=80=9D on page 9 for a description of
conditions that can be encountered subsequent to
the presentation of condition code 0 that result in a
nonzero deferred condition code.)
Condition Code 1: Instruction execution produced
the alternate or second-most-probable result, or sta-
tus conditions were present that may or may not have
prevented the expected result.
Condition Code 2: Instruction execution was inef-
fective because the designated subchannel or chan-
nel-subsystem facility was busy with a previously
initiated function.
Condition Code 3: Instruction execution was inef-
fective because the designated element was not
operational or because some condition precluded ini-
tiation of the normal function.
"""

Well ineffective means not-effective ;).

>=20
>> +         */
>> +        uint32_t cc:4;
>> +        bool pgm_chk:1;
>=20
> This looks weird?>

What do you mean? Any suggestions how to do it better?
=20
>> +        uint32_t irq_code;
>> +    } iret;
>>  };
>> =20
>>  extern const VMStateDescription vmstate_subch_dev;
>=20
> (...)
>=20
>> @@ -238,33 +236,17 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t r=
eg1, uint32_t ipb)
>>      }
>>      trace_ioinst_sch_id("ssch", cssid, ssid, schid);
>>      sch =3D css_find_subch(m, cssid, ssid, schid);
>> -    if (sch && css_subch_visible(sch)) {
>> -        ret =3D css_do_ssch(sch, &orb);
>> +    if (!sch || !css_subch_visible(sch)) {
>> +        setcc(cpu, 3);
>> +        return;
>>      }
>> -    switch (ret) {
>> -    case -ENODEV:
>> -        cc =3D 3;
>> -        break;
>> -    case -EBUSY:
>> -        cc =3D 2;
>> -        break;
>> -    case -EFAULT:
>> -        /*
>> -         * TODO:
>> -         * I'm wondering whether there is something better
>> -         * to do for us here (like setting some device or
>> -         * subchannel status).
>> -         */
>=20
> You removed the TODO :(
>=20
> There still might be a better way to reflect this...
>=20

OK I should have pushed it down to=20
@@ -71,10 +72,27 @@ again:
             goto again;
         }
         error_report("vfio-ccw: wirte I/O region failed with errno=3D%d"=
, errno);
-        return -errno;
+        ret =3D -errno;
+    } else {
+        ret =3D region->ret_code;
+    }
+    switch (-ret) {
+    /* Currently we don't update control block and just return the cc co=
de. */
+    case 0:
+        sch->iret.cc =3D 0;
+        break;
+    case EBUSY:
+        sch->iret.cc =3D 2;
+        break;
+    case EFAULT:

Like this:

+        /*
+         * TODO:
+         * I'm wondering whether there is something better
+         * to do for us here (like setting some device or
+         * subchannel status).
+         */
+        sch->iret.pgm_chk =3D true;
+        sch->iret.irq_code =3D PGM_ADDRESSING;
+        break;
+    case ENODEV:
+    case EACCES:
+    default:
+        sch->iret.cc =3D 3;
     }
-
-    return region->ret_code;
 }

 static void vfio_ccw_reset(DeviceState *dev)

(deleted in your mail, file hw/vfio/ccw.c).

But I guess, I was afraid of somebody blaming me for this
comment (such TODOs in production code are a bit strange -- what
does it mean: we did not bother to figure it out?).

>> -        program_interrupt(env, PGM_ADDRESSING, 4);
>> +    css_subch_clear_iret(sch);
>> +    css_do_ssch(sch, &orb);
>> +    if (sch->iret.pgm_chk) {
>> +        program_interrupt(env, sch->iret.irq_code, 4);
>>          return;
>> -    case 0:
>> -        cc =3D 0;
>> -        break;
>> -    default:
>> -        cc =3D 1;
>> -        break;
>>      }
>> -    setcc(cpu, cc);
>> +    setcc(cpu, sch->iret.cc);
>>  }
>> =20
>>  void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb)
>=20

Looking forward to the rest of the feedback.

Halil
