Received: from eggs.gnu.org ([2001:4830:134:3::10]:45644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cg9SS-0004ii-Tx
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cg9SO-00050F-Rj
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:22:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cg9SO-000505-Im
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:22:12 -0500
Date: Tue, 21 Feb 2017 12:22:07 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170221122207.GF2377@work-vm>
References: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
	<20170216121140.9061-4-pasic@linux.vnet.ibm.com>
	<20170217194237.GA20911@work-vm>
	<56bb4f43-9dc7-83d5-7cb9-d3e8036675e6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56bb4f43-9dc7-83d5-7cb9-d3e8036675e6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] migration/vmstate: fix array of ptr
 with nullptrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 02/17/2017 08:42 PM, Dr. David Alan Gilbert wrote:
> > * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >> Make VMS_ARRAY_OF_POINTER cope with null pointers. Previously the
> >> reward for trying to migrate an array with some null pointers in it was
> >> an illegal memory access, that is a swift and painless death of the
> >> process.  Let's make vmstate cope with this scenario.
> >>
> >> The general approach is, when we encounter a null pointer (element),
> >> instead of following the pointer to save/load the data behind it, we
> >> save/load a placeholder. This way we can detect if we expected a null
> >> pointer at the load side but not null data was saved instead.
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
> >>
> >> ---
> >> We will need this to load/save some on demand created state in the
> >> (s390x) channel subsystem (see ChannelSubSys.css in hw/s390x/css.c for
> >> an example).
> >> ---
> >>  include/migration/vmstate.h |  4 ++++
> >>  migration/vmstate.c         | 33 +++++++++++++++++++++++++++++++--
> >>  2 files changed, 35 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> >> index 63e7b02..f2dbf84 100644
> >> --- a/include/migration/vmstate.h
> >> +++ b/include/migration/vmstate.h
> >> @@ -253,6 +253,10 @@ extern const VMStateInfo vmstate_info_uint16;
> >>  extern const VMStateInfo vmstate_info_uint32;
> >>  extern const VMStateInfo vmstate_info_uint64;
> >>  
> >> +/** Put this in the stream when migrating a null pointer.*/
> >> +#define VMS_NULLPTR_MARKER (0x30U) /* '0' */
> >> +extern const VMStateInfo vmstate_info_nullptr;
> >> +
> >>  extern const VMStateInfo vmstate_info_float64;
> >>  extern const VMStateInfo vmstate_info_cpudouble;
> >>  
> >> diff --git a/migration/vmstate.c b/migration/vmstate.c
> >> index 836a7a4..cb81cef 100644
> >> --- a/migration/vmstate.c
> >> +++ b/migration/vmstate.c
> >> @@ -117,7 +117,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
> >>                      curr_elem = *(void **)curr_elem;
> >>                  }
> >> -                if (field->flags & VMS_STRUCT) {
> >> +                if (!curr_elem) {
> >> +                    /* if null pointer check placeholder and do not follow */
> >> +                    assert(field->flags & VMS_ARRAY_OF_POINTER);
> > 
> > That can return an error instead of asserting.
> > 
> >> +                    vmstate_info_nullptr.get(f, curr_elem, size, NULL);
> > 
> > You've ignored the return value of the get; that should be  ret = 
> > 
> >> +                } else if (field->flags & VMS_STRUCT) {
> >>                      ret = vmstate_load_state(f, field->vmsd, curr_elem,
> >>                                               field->vmsd->version_id);
> >>                  } else {
> >> @@ -332,7 +336,11 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> >>                      assert(curr_elem);
> >>                      curr_elem = *(void **)curr_elem;
> >>                  }
> >> -                if (field->flags & VMS_STRUCT) {
> >> +                if (!curr_elem) {
> >> +                    /* if null pointer write placeholder and do not follow */
> >> +                    assert(field->flags & VMS_ARRAY_OF_POINTER);
> >> +                    vmstate_info_nullptr.put(f, curr_elem, size, NULL, NULL);
> >> +                } else if (field->flags & VMS_STRUCT) {
> >>                      vmstate_save_state(f, field->vmsd, curr_elem, vmdesc_loop);
> >>                  } else {
> >>                      field->info->put(f, curr_elem, size, field, vmdesc_loop);
> >> @@ -747,6 +755,27 @@ const VMStateInfo vmstate_info_uint64 = {
> >>      .put  = put_uint64,
> >>  };
> >>  
> >> +static int get_nullptr(QEMUFile *f, void *pv, size_t size, VMStateField *field)
> >> +
> >> +{
> >> +    return qemu_get_byte(f) == VMS_NULLPTR_MARKER ? 0 : -EINVAL;
> >> +}
> >> +
> >> +static int put_nullptr(QEMUFile *f, void *pv, size_t size,
> >> +                        VMStateField *field, QJSON *vmdesc)
> >> +
> >> +{
> >> +    assert(pv == NULL);
> >> +    qemu_put_byte(f, VMS_NULLPTR_MARKER);
> >> +    return 0;
> >> +}
> > 
> > Again that assert could just turn into a return -EINVAL
> > 
> > Dave
> > 
> 
> @Dave: I have accidentally answered with 'reply' instead of 'reply all'
> yesterday. Sorry for the noise!
> 
> Thanks for the review! You are right, my code is messy.

It's not that bad - just a few minor issues.

> Yet I'm not sure what you propose is the best way to clean it up. My
> concern is, that we are loosing some info about what exactly went wrong
> (and where), if returning -EINVAL is not combined with additional
> logging/error reporting. 
>
> After re-checking the asserts they all indicate programming errors and
> there is not much (IMHO) client code can do to recover and the user
> should never observe. Unfortunately, I lack knowledge about how is the
> client code handling errors and if there is something we need to clean
> up. I assumed asserting is OK because of the per-existing asserts.

> You are perfectly right about ignoring the return value of
> vmstate_info_nullptr.get and at least I will have to fix that.
> IMHO we have three options to fix this code:
> a) Make vmstate_info_nullptr.get assert too as we expect null pointer
> and we got not null is pretty much an indicator that we can't proceed
> sanely. Possibly add ret = ... for aesthetic reasons. Keep the asserts.
> b) Follow your suggestions without anything on top of it.
> c) Follow your suggestions and add error_report stating what exactly
> went wrong.
> 
> My priority is to get this in, so I will do what you say, or send
> option b) late on Wednesday if no guidance until then.

It's OK to add an error_report as needed; in particular I try and avoid
assert's on the save path where possible, since the user apparently
has a happy running VM, so even if the migration code has an error in it
I'd rather the user didn't lose their VM.  The load path it's OK to
add the asserts since they've not got a working VM yet.

Dave

> 
> Regards,
> Halil
> 
> >> +
> >> +const VMStateInfo vmstate_info_nullptr = {
> >> +    .name = "uint64",
> >> +    .get  = get_nullptr,
> >> +    .put  = put_nullptr,
> >> +};
> >> +
> >>  /* 64 bit unsigned int. See that the received value is the same than the one
> >>     in the field */
> >>  
> >> -- 
> >> 2.8.4
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
