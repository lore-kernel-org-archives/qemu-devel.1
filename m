Received: from eggs.gnu.org ([2001:4830:134:3::10]:59991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1elHEj-0004Vl-Ox
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1elHEf-0002Kl-Ao
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:45:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1elHEf-0002JI-2Q
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:45:45 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1CGighF005931
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 11:45:43 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g3ckaxbjj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 11:45:42 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Mon, 12 Feb 2018 16:45:40 -0000
Date: Mon, 12 Feb 2018 17:45:36 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <d95d8112-9d0b-e471-b45a-51c50850feab@redhat.com>
References: <20180212154903.8859-1-dgilbert@redhat.com>
	<d95d8112-9d0b-e471-b45a-51c50850feab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180212174536.6e3a72b6@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390/stattrib: Make SaveVMHandlers data
 static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>

On Mon, 12 Feb 2018 16:52:08 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 12.02.2018 16:49, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > There's no need for this to be dynamic, make it static.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/s390x/s390-stattrib.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> > index a1d2135a60..adf07ef312 100644
> > --- a/hw/s390x/s390-stattrib.c
> > +++ b/hw/s390x/s390-stattrib.c
> > @@ -365,22 +365,22 @@ static inline void
> > s390_stattrib_set_migration_enabled(Object *obj, bool value,
> > s->migration_enabled = value; }
> >  
> > +static SaveVMHandlers savevm_s390_stattrib_handlers = {
> > +    .save_setup = cmma_save_setup,
> > +    .save_live_iterate = cmma_save_iterate,
> > +    .save_live_complete_precopy = cmma_save_complete,
> > +    .save_live_pending = cmma_save_pending,
> > +    .save_cleanup = cmma_save_cleanup,
> > +    .load_state = cmma_load,
> > +    .is_active = cmma_active,
> > +};
> > +
> >  static void s390_stattrib_instance_init(Object *obj)
> >  {
> >      S390StAttribState *sas = S390_STATTRIB(obj);
> > -    SaveVMHandlers *ops;
> > -
> > -    /* ops will always be freed by qemu when unregistering */
> > -    ops = g_new0(SaveVMHandlers, 1);
> > -
> > -    ops->save_setup = cmma_save_setup;
> > -    ops->save_live_iterate = cmma_save_iterate;
> > -    ops->save_live_complete_precopy = cmma_save_complete;
> > -    ops->save_live_pending = cmma_save_pending;
> > -    ops->save_cleanup = cmma_save_cleanup;
> > -    ops->load_state = cmma_load;
> > -    ops->is_active = cmma_active;
> > -    register_savevm_live(NULL, TYPE_S390_STATTRIB, 0, 0, ops, sas);
> > +
> > +    register_savevm_live(NULL, TYPE_S390_STATTRIB, 0, 0,
> > +                         &savevm_s390_stattrib_handlers, sas);
> >  
> >      object_property_add_bool(obj, "migration-enabled",
> >                               s390_stattrib_get_migration_enabled,
> >   
> 
> Looks sane to me.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>


Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
