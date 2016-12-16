Received: from eggs.gnu.org ([2001:4830:134:3::10]:45754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHyTY-00017x-30
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHyTU-0003zD-33
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:47:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHyTT-0003xh-TM
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:47:24 -0500
Date: Fri, 16 Dec 2016 19:47:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161216194715.GG2642@work-vm>
References: <20161108095603.72301-1-pasic@linux.vnet.ibm.com>
	<20161108095603.72301-7-pasic@linux.vnet.ibm.com>
	<20161215132901.GJ2509@work-vm>
	<9e79129e-131c-987c-6c13-261be9aee769@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e79129e-131c-987c-6c13-261be9aee769@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 6/8] migration/vmstate: split up
 vmstate_base_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, Guenther Hutzl <hutzl@linux.vnet.ibm.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 12/15/2016 02:29 PM, Dr. David Alan Gilbert wrote:
> >> +            vmstate_handle_alloc(first_elem, field, opaque);
> >> +            if (field->flags & VMS_POINTER) {
> >> +                first_elem = *(void **)first_elem;
> >> +                assert(first_elem);
> >> +            }
> >>              for (i = 0; i < n_elems; i++) {
> >>                  void *curr_elem = first_elem + size * i;
> >>  
> >> @@ -310,12 +301,16 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> >>      while (field->name) {
> >>          if (!field->field_exists ||
> >>              field->field_exists(opaque, vmsd->version_id)) {
> >> -            void *first_elem = vmstate_base_addr(opaque, field, false);
> >> +            void *first_elem = opaque + field->offset;
> >>              int i, n_elems = vmstate_n_elems(opaque, field);
> >>              int size = vmstate_size(opaque, field);
> >>              int64_t old_offset, written_bytes;
> >>              QJSON *vmdesc_loop = vmdesc;
> >>  
> >> +            if (field->flags & VMS_POINTER) {
> >> +                first_elem = *(void **)first_elem;
> >> +                assert(first_elem);
> > Can you make that   assert(first_elem || !n_elems) please.
> > and same above.
> > 
> > Dave
> 
> Good catch! This could indeed be some dynamic length
> thing with 0 elements.
> 
> I'm not sure if I'm going to respin this year though.

Well I'm not going to review it this year if you do :-)
So have a good new year and lets see to it then!

Dave

> Halil
> 
> > 
> >> +            }
> >>              for (i = 0; i < n_elems; i++) {
> >>                  void *curr_elem = first_elem + size * i;
> >>  
> >> -- 
> >> 2.8.4
> >>
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
