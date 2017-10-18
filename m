Received: from eggs.gnu.org ([2001:4830:134:3::10]:33969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4mCR-0003yr-Ms
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4mCN-0003Of-KQ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:07:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48684
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e4mCN-0003NO-EV
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:07:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9IB6Q1c043186
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 07:07:38 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dp20kv4eg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 07:07:38 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 18 Oct 2017 12:07:36 +0100
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-4-pasic@linux.vnet.ibm.com>
	<0a29771b-da12-76eb-ead8-34d1a8d24ce7@redhat.com>
	<20171018115219.2dafd05c.cohuck@redhat.com>
	<efc6c522-e359-0f10-2ddc-6a434da4557a@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 13:07:34 +0200
MIME-Version: 1.0
In-Reply-To: <efc6c522-e359-0f10-2ddc-6a434da4557a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <9dd53d1b-9242-d0bc-5e0f-3c0997eb5988@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/7] s390x: improve error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 10/18/2017 12:07 PM, Thomas Huth wrote:
> On 18.10.2017 11:52, Cornelia Huck wrote:
>> On Wed, 18 Oct 2017 11:30:47 +0200
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> On 17.10.2017 16:04, Halil Pasic wrote:
>>>> Simplify the error handling of the SSCH and RSCH handler avoiding
>>>> arbitrary and cryptic error codes being used to tell how the instruc=
tion
>>>> is supposed to end.  Let the code detecting the condition tell how i=
t's
>>>> to be handled in a less ambiguous way.  It's best to handle SSCH and=
 RSCH
>>>> in one go as the emulation of the two shares a lot of code.
>>>>
>>>> For passthrough this change isn't pure refactoring, but changes the =
way
>>>> kernel reported EFAULT is handled. After clarifying the kernel inter=
face
>>>> we decided that EFAULT shall be mapped to unit exception.  Same goes=
 for
>>>> unexpected error codes and absence of required ORB flags.
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> ---
>>>>  hw/s390x/css.c              | 84 +++++++++++++---------------------=
-----------
>>>>  hw/s390x/s390-ccw.c         | 11 +++---
>>>>  hw/vfio/ccw.c               | 28 +++++++++++----
>>>>  include/hw/s390x/css.h      | 23 +++++++++----
>>>>  include/hw/s390x/s390-ccw.h |  2 +-
>>>>  target/s390x/ioinst.c       | 53 ++++------------------------
>>>>  6 files changed, 75 insertions(+), 126 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>>> index aa233d5f8a..ff5a05c34b 100644
>>>> --- a/hw/s390x/css.c
>>>> +++ b/hw/s390x/css.c
>>>> @@ -1181,12 +1181,11 @@ static void sch_handle_start_func_virtual(Su=
bchDev *sch)
>>>> =20
>>>>  }
>>>> =20
>>>> -static int sch_handle_start_func_passthrough(SubchDev *sch)
>>>> +static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch=
)
>>>>  {
>>>> =20
>>>>      PMCW *p =3D &sch->curr_status.pmcw;
>>>>      SCSW *s =3D &sch->curr_status.scsw;
>>>> -    int ret;
>>>> =20
>>>>      ORB *orb =3D &sch->orb;
>>>>      if (!(s->ctrl & SCSW_ACTL_SUSP)) {
>>>> @@ -1200,31 +1199,12 @@ static int sch_handle_start_func_passthrough=
(SubchDev *sch)
>>>>       */
>>>>      if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
>>>>          !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
>>>> -        return -EINVAL;
>>>> +        warn_report("vfio-ccw requires PFCH and C64 flags set...");=
 =20
>>>
>>> Not sure, but should this maybe rather be a
>>> "qemu_log_mask(LOG_GUEST_ERROR, ...)" instead?
>>
>> Is that visible by default, though? I'd rather want the admin to be
>> able to find a hint in a log somewhere why the guest I/O is rejected.
>=20
> Well, the guest could also trigger this condition on purpose (e.g.
> kvm-unit-tests), so I wonder whether we want to see the warning in that
> case, too...
> IMHO this is exactly what qemu_log_mask(LOG_GUEST_ERROR, ...) has been
> implemented for: Log errors from the guest in case you suspect that the
> guest is doing something wrong. But that's just my 0.02 =E2=82=AC, feel=
 free to
> ignore me.
>=20
>>>> @@ -1844,27 +1816,23 @@ void css_do_schm(uint8_t mbk, int update, in=
t dct, uint64_t mbo)
>>>>      }
>>>>  }
>>>> =20
>>>> -int css_do_rsch(SubchDev *sch)
>>>> +IOInstEnding css_do_rsch(SubchDev *sch)
>>>>  {
>>>>      SCSW *s =3D &sch->curr_status.scsw;
>>>>      PMCW *p =3D &sch->curr_status.pmcw;
>>>> -    int ret;
>>>> =20
>>>>      if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) =
{
>>>> -        ret =3D -ENODEV;
>>>> -        goto out;
>>>> +        return IOINST_CC_NOT_OPERATIONAL;
>>>>      }
>>>> =20
>>>>      if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
>>>> -        ret =3D -EINPROGRESS;
>>>> -        goto out;
>>>> +        return IOINST_CC_STATUS_PRESENT;
>>>>      }
>>>> =20
>>>>      if (((s->ctrl & SCSW_CTRL_MASK_FCTL) !=3D SCSW_FCTL_START_FUNC)=
 ||
>>>>          (s->ctrl & SCSW_ACTL_RESUME_PEND) ||
>>>>          (!(s->ctrl & SCSW_ACTL_SUSP))) {
>>>> -        ret =3D -EINVAL;
>>>> -        goto out;
>>>> +        return IOINST_CC_BUSY; =20
>>>
>>> Why is EINVAL now mapped to IOINST_CC_BUSY? Shouldn't that be
>>> IOINST_CC_STATUS_PRESENT instead?
>>
>> No, that is correct (see the PoP for when cc 2 is supposed to be set b=
y
>> rsch).
>=20
> So if this is on purpose, this change in behavior should also be
> mentioned in the patch description, I think.
>=20

No. have a look at the function ioinst_handle_rsch. It used
to map -EINVAL to cc 2 (and was an oddball in this respect) so we
keep the old behavior, it's just more obvious whats happening.

Regards,
Halil

>  Thomas
>=20
