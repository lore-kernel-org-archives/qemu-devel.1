Received: from eggs.gnu.org ([2001:4830:134:3::10]:58439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dO5Yd-0006Wl-JK
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dO5YZ-0002dM-G1
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dO5YZ-0002ch-5c
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:06:11 -0400
Date: Thu, 22 Jun 2017 18:06:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170622170605.GD2100@work-vm>
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-2-pasic@linux.vnet.ibm.com>
	<20170607095127.GB2099@work-vm>
	<8c0f9dac-ceef-fe88-8147-3cf043f7e109@linux.vnet.ibm.com>
	<f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
	<20170622082207.GA2100@work-vm>
	<05ebf48c-addd-a943-60ba-a2be4a49ff74@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05ebf48c-addd-a943-60ba-a2be4a49ff74@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed
 equal checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 06/22/2017 10:22 AM, Dr. David Alan Gilbert wrote:
> > * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>
> >>
> >> On 06/08/2017 01:05 PM, Halil Pasic wrote:
> >>>
> >>>
> >>> On 06/07/2017 11:51 AM, Dr. David Alan Gilbert wrote:
> >>>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>>>> In some cases a failing VMSTATE_*_EQUAL does not mean we detected a bug
> >>>>> (it's actually the best we can do). Especially in these cases a verbose
> >>>>> error message is required.
> >>>>>
> >>>>> Let's introduce infrastructure for specifying a error hint to be used if
> >>>>> equal check fails.
> >>>>>
> >>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>>>> ---
> >>>>> Macros come in part 2. Once we are happy with the macros
> >>>>> this two patches should be squashed into one. 
> >>>>> ---
> >>>>>  include/migration/vmstate.h |  1 +
> >>>>>  migration/vmstate-types.c   | 36 +++++++++++++++++++++++++++++++-----
> >>>>>  2 files changed, 32 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> >>>>> index 66895623da..d90d9b12ca 100644
> >>>>> --- a/include/migration/vmstate.h
> >>>>> +++ b/include/migration/vmstate.h
> >>>>> @@ -200,6 +200,7 @@ typedef enum {
> >>>>>  
> >>>>>  struct VMStateField {
> >>>>>      const char *name;
> >>>>> +    const char *err_hint;
> >>>>>      size_t offset;
> >>>>>      size_t size;
> >>>>>      size_t start;
> >>>>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> >>>>> index 7287c6baa6..84d0545a38 100644
> >>>>> --- a/migration/vmstate-types.c
> >>>>> +++ b/migration/vmstate-types.c
> >>>>> @@ -19,6 +19,7 @@
> >>>>>  #include "qemu/error-report.h"
> >>>>>  #include "qemu/queue.h"
> >>>>>  #include "trace.h"
> >>>>> +#include "qapi/error.h"
> >>>>>  
> >>>>>  /* bool */
> >>>>>  
> >>>>> @@ -118,6 +119,7 @@ const VMStateInfo vmstate_info_int32 = {
> >>>>>  static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
> >>>>>                             VMStateField *field)
> >>>>>  {
> >>>>> +    Error *err = NULL;
> >>>>>      int32_t *v = pv;
> >>>>>      int32_t v2;
> >>>>>      qemu_get_sbe32s(f, &v2);
> >>>>> @@ -125,7 +127,11 @@ static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
> >>>>>      if (*v == v2) {
> >>>>>          return 0;
> >>>>>      }
> >>>>> -    error_report("%" PRIx32 " != %" PRIx32, *v, v2);
> >>>>> +    error_setg(&err, "%" PRIx32 " != %" PRIx32, *v, v2);
> >>>>> +    if (field->err_hint) {
> >>>>> +        error_append_hint(&err, "%s\n", field->err_hint);
> >>>>> +    }
> >>>>> +    error_report_err(err);
> >>>>
> >>>> I'm a bit worried as to whether the error_append_hint data gets
> >>>> printed out by error_report_err if we're being driven by a QMP
> >>>> monitor.
> >>>> error_report_err uses error_printf_unless_qmp
> >>>>
> >>>> Since this code doesn't really handle Error *'s back up,
> >>>> and always prints it's errors into stderr, I'd prefer if you just
> >>>> used error_report again for the hint, something like:
> >>>>
> >>>> if (field->err_hint) {
> >>>>   error_report("%" PRIx32 " != %" PRIx32 "(%s)",
> >>>>                *v, v2, field->err_hint);
> >>>> } else {
> >>>>   error_report("%" PRIx32 " != %" PRIx32, *v, v2);
> >>>> }
> >>>>
> >>>> Dave
> >>>
> >>> One reason I choose error_report_err is to be consistent about hint
> >>> reporting (the other one is that was what Connie suggested). I do
> >>> not understand why do we omit hints if QMP, but I figured that's
> >>> our policy. So the hint I'm adding must not be printed in QMP
> >>> context -- because that's our policy. I was pretty sure what I
> >>> want to do is add a hint (and not make a very long 'core' error
> >>> message).
> >>>
> >>> Can you (or somebody else)  explain why are hints dropped in QMP
> >>> context?
> >>>
> >>> Don't misunderstand I'm open towards your proposal, it's just
> >>> that:
> >>> 1) I would like to understand.
> >>> 2) I would like to get the very same result as produced by
> >>> https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg01472.html 
> >>>
> >>> Regards,
> >>> Halil
> >>>
> >>>
> >>
> >> ping.
> >>
> >> I would like to do a v2, but I want this sorted out first.
> >>
> >> 'This' basically boils down to the question and
> >> 'Why aren't hints reported in QMP context?' and 'Why is this
> >> case special (a hint should be reported
> >> even in QMP context?'
> >>
> >> Regarding the first question hints being reported via
> >> error_printf_unless_qmp seems to come from commit
> >> 50b7b000c9 ("hmp: Allow for error message hints on HMP")
> >> --> Cc-ing Eric maybe he can help.
> > 
> > I don't understand the full logic behind error_append_hint;
> > my only concern here is that the full text ends up on stderr
> > even if the migration is driven by QMP.
> > Since we can do that just by using error_report like it's already
> > being used with the slight change I suggested, it seems easy.
> > 
> > Dave
> > 
> 
> Thanks for the reply! Since nobody else cared to explain the logic,
> I guess it is not all that important and we are fine with printing
> the hint in QMP context too.
> 
> I would like to keep the output consistent with 8ed179c937 ("s390x/css:
> catch section mismatch on load", 2017-05-18).
> 
> First I tried with (too make the err_hint look like a hint)
> 
> +    if (field->err_hint) {
> +        error_report("%" PRIx32 " != %" PRIx32 "\n%s\n",
> +                     *v, v2, field->err_hint);
> +    } else {
> +        error_report("%" PRIx32 " != %" PRIx32, *v, v2);
> +    } 
> 
> but checkpatch does not like that because newline in error
> message seems to be evil.
> 
> Would you be also OK with:
> 
>     error_report("%" PRIx32 " != %" PRIx32, *v, v2);                            
>     if (field->err_hint) {                                                      
>         error_printf("%s\n", field->err_hint);                                  
>     } 

Yes I'm OK with that - what's important to me is getting the output
into the stderr log so I've got something to work with when it fails.

> Regards,
> or are you preferring producing a single line (in that case I
> would have to sacrifice 'no change in behavior' for my vmstate
> conversion of virtio-ccw :( )?

Single line is less important to me.

Dave

> Halil
> 
> 
> >> Regards,
> >> Halil
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
