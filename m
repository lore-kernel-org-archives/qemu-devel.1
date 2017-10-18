Received: from eggs.gnu.org ([2001:4830:134:3::10]:41391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4lGd-0007Vq-3F
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4lGY-00009A-40
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:08:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e4lGX-000088-RF
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:07:58 -0400
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-4-pasic@linux.vnet.ibm.com>
	<0a29771b-da12-76eb-ead8-34d1a8d24ce7@redhat.com>
	<20171018115219.2dafd05c.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <efc6c522-e359-0f10-2ddc-6a434da4557a@redhat.com>
Date: Wed, 18 Oct 2017 12:07:54 +0200
MIME-Version: 1.0
In-Reply-To: <20171018115219.2dafd05c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 18.10.2017 11:52, Cornelia Huck wrote:
> On Wed, 18 Oct 2017 11:30:47 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 17.10.2017 16:04, Halil Pasic wrote:
>>> Simplify the error handling of the SSCH and RSCH handler avoiding
>>> arbitrary and cryptic error codes being used to tell how the instruct=
ion
>>> is supposed to end.  Let the code detecting the condition tell how it=
's
>>> to be handled in a less ambiguous way.  It's best to handle SSCH and =
RSCH
>>> in one go as the emulation of the two shares a lot of code.
>>>
>>> For passthrough this change isn't pure refactoring, but changes the w=
ay
>>> kernel reported EFAULT is handled. After clarifying the kernel interf=
ace
>>> we decided that EFAULT shall be mapped to unit exception.  Same goes =
for
>>> unexpected error codes and absence of required ORB flags.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> ---
>>>  hw/s390x/css.c              | 84 +++++++++++++----------------------=
----------
>>>  hw/s390x/s390-ccw.c         | 11 +++---
>>>  hw/vfio/ccw.c               | 28 +++++++++++----
>>>  include/hw/s390x/css.h      | 23 +++++++++----
>>>  include/hw/s390x/s390-ccw.h |  2 +-
>>>  target/s390x/ioinst.c       | 53 ++++------------------------
>>>  6 files changed, 75 insertions(+), 126 deletions(-)
>>>
>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>> index aa233d5f8a..ff5a05c34b 100644
>>> --- a/hw/s390x/css.c
>>> +++ b/hw/s390x/css.c
>>> @@ -1181,12 +1181,11 @@ static void sch_handle_start_func_virtual(Sub=
chDev *sch)
>>> =20
>>>  }
>>> =20
>>> -static int sch_handle_start_func_passthrough(SubchDev *sch)
>>> +static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>>>  {
>>> =20
>>>      PMCW *p =3D &sch->curr_status.pmcw;
>>>      SCSW *s =3D &sch->curr_status.scsw;
>>> -    int ret;
>>> =20
>>>      ORB *orb =3D &sch->orb;
>>>      if (!(s->ctrl & SCSW_ACTL_SUSP)) {
>>> @@ -1200,31 +1199,12 @@ static int sch_handle_start_func_passthrough(=
SubchDev *sch)
>>>       */
>>>      if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
>>>          !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
>>> -        return -EINVAL;
>>> +        warn_report("vfio-ccw requires PFCH and C64 flags set..."); =
=20
>>
>> Not sure, but should this maybe rather be a
>> "qemu_log_mask(LOG_GUEST_ERROR, ...)" instead?
>=20
> Is that visible by default, though? I'd rather want the admin to be
> able to find a hint in a log somewhere why the guest I/O is rejected.

Well, the guest could also trigger this condition on purpose (e.g.
kvm-unit-tests), so I wonder whether we want to see the warning in that
case, too...
IMHO this is exactly what qemu_log_mask(LOG_GUEST_ERROR, ...) has been
implemented for: Log errors from the guest in case you suspect that the
guest is doing something wrong. But that's just my 0.02 =E2=82=AC, feel f=
ree to
ignore me.

>>> @@ -1844,27 +1816,23 @@ void css_do_schm(uint8_t mbk, int update, int=
 dct, uint64_t mbo)
>>>      }
>>>  }
>>> =20
>>> -int css_do_rsch(SubchDev *sch)
>>> +IOInstEnding css_do_rsch(SubchDev *sch)
>>>  {
>>>      SCSW *s =3D &sch->curr_status.scsw;
>>>      PMCW *p =3D &sch->curr_status.pmcw;
>>> -    int ret;
>>> =20
>>>      if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
>>> -        ret =3D -ENODEV;
>>> -        goto out;
>>> +        return IOINST_CC_NOT_OPERATIONAL;
>>>      }
>>> =20
>>>      if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
>>> -        ret =3D -EINPROGRESS;
>>> -        goto out;
>>> +        return IOINST_CC_STATUS_PRESENT;
>>>      }
>>> =20
>>>      if (((s->ctrl & SCSW_CTRL_MASK_FCTL) !=3D SCSW_FCTL_START_FUNC) =
||
>>>          (s->ctrl & SCSW_ACTL_RESUME_PEND) ||
>>>          (!(s->ctrl & SCSW_ACTL_SUSP))) {
>>> -        ret =3D -EINVAL;
>>> -        goto out;
>>> +        return IOINST_CC_BUSY; =20
>>
>> Why is EINVAL now mapped to IOINST_CC_BUSY? Shouldn't that be
>> IOINST_CC_STATUS_PRESENT instead?
>=20
> No, that is correct (see the PoP for when cc 2 is supposed to be set by
> rsch).

So if this is on purpose, this change in behavior should also be
mentioned in the patch description, I think.

 Thomas
