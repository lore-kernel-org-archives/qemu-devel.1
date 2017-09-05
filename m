Received: from eggs.gnu.org ([2001:4830:134:3::10]:48279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpGfm-0003Nl-NX
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpGfe-0004Bd-Ii
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:25:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpGfe-0004An-AH
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:25:50 -0400
Date: Tue, 5 Sep 2017 18:25:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170905182546.00457332.cohuck@redhat.com>
In-Reply-To: <7540741b-d230-e7c4-50d3-036f31997c8b@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-5-pasic@linux.vnet.ibm.com>
	<20170831115535.1e4201d3.cohuck@redhat.com>
	<7540741b-d230-e7c4-50d3-036f31997c8b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, 5 Sep 2017 17:55:17 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 08/31/2017 11:55 AM, Cornelia Huck wrote:
> > On Wed, 30 Aug 2017 18:36:04 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >  =20
> >> Simplify the error handling of the SSCH and RSCH handler avoiding
> >> arbitrary and cryptic error codes being mapped to what a subchannel is
> >> supposed to do.  Let the code detecting the condition tell how it's to=
 be
> >> handled in a less ambiguous way.  It's best to handle SSCH and RSCH in
> >> one go as the emulation of the two shares a lot of code. =20
> >=20
> > So determining the return code at the point in time where we can
> > instead of trying to map to return codes and back again makes quite a
> > bit of sense, but I'll have to look at the rest of this. =20
>=20
>=20
> Looging forward to.

Once I manage to find some quiet time for thinking :(


> >> -    ret =3D s390_ccw_cmd_request(orb, s, sch->driver_data);
> >> -    switch (ret) {
> >> -    /* Currently we don't update control block and just return the cc=
 code. */
> >> -    case 0:
> >> -        break;
> >> -    case -EBUSY:
> >> -        break;
> >> -    case -ENODEV:
> >> -        break;
> >> -    case -EFAULT:
> >> -         break;
> >> -    case -EACCES:
> >> -        /* Let's reflect an inaccessible host device by cc 3. */
> >> -    default:
> >> -        /* Let's make all other return codes map to cc 3.  */
> >> -        ret =3D -ENODEV;
> >> -    };
> >> -
> >> -    return ret;
> >> +    s390_ccw_cmd_request(sch); =20
> >=20
> > As you change the handling anyway: Don't change this logic in prior
> > patches? =20
>=20
> I preserve the logic as altered by the previous patches (at least,
> that is the intention). This is the mapping around part which is going
> away if we push the handling down.

My point is that you touch the code path twice. But we disagreed on the
original change anyway :)

> >> -int do_subchannel_work_passthrough(SubchDev *sch)
> >> +void do_subchannel_work_passthrough(SubchDev *sch)
> >>  {
> >> -    int ret;
> >>      SCSW *s =3D &sch->curr_status.scsw;
> >> =20
> >>      if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
> >>          /* TODO: Clear handling */
> >>          sch_handle_clear_func(sch);
> >> -        ret =3D 0;
> >>      } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
> >>          /* TODO: Halt handling */
> >>          sch_handle_halt_func(sch);
> >> -        ret =3D 0;
> >>      } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
> >> -        ret =3D sch_handle_start_func_passthrough(sch);
> >> +        sch_handle_start_func_passthrough(sch);
> >>      } else {
> >>          /* Cannot happen. */
> >> -        return -ENODEV;
> >> +        sch->iret.cc =3D 3; =20
> >=20
> > ftcl =3D=3D 0 should have been rejected already by the function handlers
> > here as well, shouldn't it? =20
>=20
> Which function handlers. Basically the instruction handlers set fctl
> and call do_subchannel_work to get the indicated work done.

Or set. My point is that we can't get here with fctl =3D=3D 0. So an assert
sounds better to me.


> >> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> >> index 5c5fe6b202..d093181a9e 100644
> >> --- a/include/hw/s390x/css.h
> >> +++ b/include/hw/s390x/css.h
> >> @@ -94,13 +94,31 @@ struct SubchDev {
> >>      /* transport-provided data: */
> >>      int (*ccw_cb) (SubchDev *, CCW1);
> >>      void (*disable_cb)(SubchDev *);
> >> -    int (*do_subchannel_work) (SubchDev *);
> >> +    void (*do_subchannel_work) (SubchDev *);
> >>      SenseId id;
> >>      void *driver_data;
> >> +    /* io instructions conclude according to iret */
> >> +    struct {
> >> +        /*
> >> +         * General semantic of cc codes of IO instructions is (brief):
> >> +         * 0 -- produced expected result
> >> +         * 1 -- produced alternate result
> >> +         * 2 -- ineffective, because busy with previously initiated f=
unction
> >> +         * 3 -- ineffective, not operational =20
> >=20
> > I'm not sure you can summarize this that way in all cases.
> >=20
> > Also, what does "ineffective" mean? If I get a cc 1 for, say, ssch, I
> > don't expect something either as the subchannel was already status
> > pending. =20
>=20
> You are right cc 1 would have been better off with
>  'produced alternate result or status pending'
>=20
> I've tried to make this shorter (from PoP 14-2):
> """
> Condition Code 0: Instruction execution produced
> the expected or most probable result. (See =E2=80=9CDeferred
> Condition Code (CC)=E2=80=9D on page 9 for a description of
> conditions that can be encountered subsequent to
> the presentation of condition code 0 that result in a
> nonzero deferred condition code.)
> Condition Code 1: Instruction execution produced
> the alternate or second-most-probable result, or sta-
> tus conditions were present that may or may not have
> prevented the expected result.
> Condition Code 2: Instruction execution was inef-
> fective because the designated subchannel or chan-
> nel-subsystem facility was busy with a previously
> initiated function.
> Condition Code 3: Instruction execution was inef-
> fective because the designated element was not
> operational or because some condition precluded ini-
> tiation of the normal function.
> """
>=20
> Well ineffective means not-effective ;).

Yes :)

I think the summary in the PoP is already a bit on the over-generalized
side, and condensing it further makes it rather ineffective ;) at
explaining what happens. Frankly, I'd just drop this and rely on
interested parties referring to the PoP.

>=20
> >  =20
> >> +         */
> >> +        uint32_t cc:4;
> >> +        bool pgm_chk:1; =20
> >=20
> > This looks weird?> =20
>=20
> What do you mean? Any suggestions how to do it better?

Taking one bit from a bool looks odd. I'd either use a bool normally or
take one bit from an uint8_t.

> =20
> >> +        uint32_t irq_code;
> >> +    } iret;
> >>  };
> >> =20
> >>  extern const VMStateDescription vmstate_subch_dev; =20

> But I guess, I was afraid of somebody blaming me for this
> comment (such TODOs in production code are a bit strange -- what
> does it mean: we did not bother to figure it out?).

For one, the TODO is preexisting... and we really should remember to
figure out if there's something better rather than just drop the
comment.

(And I sure hope nobody is using vfio-ccw in production yet...)
