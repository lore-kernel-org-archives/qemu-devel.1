Received: from eggs.gnu.org ([2001:4830:134:3::10]:38280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBm0a-000697-L2
	for qemu-devel@nongnu.org; Fri, 19 May 2017 13:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBm0W-0000xw-NL
	for qemu-devel@nongnu.org; Fri, 19 May 2017 13:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dBm0W-0000xJ-EL
	for qemu-devel@nongnu.org; Fri, 19 May 2017 13:48:08 -0400
Date: Fri, 19 May 2017 18:47:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170519174753.GS2081@work-vm>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-4-pasic@linux.vnet.ibm.com>
	<20170508164505.GG2120@work-vm>
	<3e0195e2-ada5-2efc-1feb-e2415761e7bc@linux.vnet.ibm.com>
	<20170515180129.GC2324@work-vm>
	<2bf9d9d3-86ed-da36-dc81-415065e08a91@linux.vnet.ibm.com>
	<20170519145502.GQ2081@work-vm>
	<1ef8e6c0-02c6-5208-151a-01bcbf7acfe4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef8e6c0-02c6-5208-151a-01bcbf7acfe4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] s390x/css: add vmstate entities for
 css
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 05/19/2017 04:55 PM, Dr. David Alan Gilbert wrote:
> >> We could also consider making WITH_TMP act as a normal field. 
> >> Working on the whole state looks like a bit like a corner case:
> >> we have some stuff adjacent in the migration stream, and we have
> >> to map it on multiple fields (and vice-versa). Getting the whole
> >> state with a pointer to a certain field could work via container_of.
> > You do need to know which field you're working on to be able to safely
> > use container_of, so I'm not sure how it would work for you in this
> > case.
> 
> 
> Well, if you have to write to just one field you are good because you
> already have a pointer to that field (.offset was added).
> 
> If you need to write to multiple fields in post_load then you just pick
> one of the fields you are going to write to (probably the first) and use
> container_of to gain access to the whole state. The logic is specific to
> the bunch of the fields you are going to touch anyway.
> 
> In fact any member of the state struct will do it's only important that
> you use the same when creating the VMStateField and when trying to get a
> pointer to the parent in pre_save and post_load.
> 
> I haven't tried, so I'm not 100% sure, but if you like I can try, and send
> you a patch if it's viable. 
> 
> I think the key to a good solution is really what is intended and typical
> usage, and what is corner case. My patch in the other reply shows that we
> can do without changing the ways of VMSTATE_WITH_TMP. I think we can make
> what I'm trying to do here a bit prettier at the expense of making what
> you are doing in virtio-net a bit uglier, but whether it's a good idea to
> do so, I cant tell.

Lets go with what you put in the other patch (I replied to it); I hadn't
realised that was possible (hence my comment below).
Once we have a bunch of different uses of VMSTATE_WITH_TMP in the code
base, I'll step back and see how to tidy them up.

Dave

> > 
> > The other thought I'd had was that perhaps we could change the temporary
> > structure in VMSTATE_WITH_TMP to:
> > 
> >   struct foo {
> >      struct whatever **parent;
> > 
> > so now you could write to *parent in cases like these.
> >
> 
> Sorry, I do not get your idea. If you have some WIP patch in this
> direction I would be happy to provide some feedback.
> 
>  
> >> Btw, I would rather call it get_indicator a factory method or even a
> >> constructor than an allocator, but I think we understand each-other
> >> anyway.
> > Yes; I'm not too worried about the actual name as long as it's short
> > and obvious.
> > 
> > I'd thought of 'allocator' since in most cases it's used where the
> > load-time code allocates memory for the object being loaded.
> > A constructor is normally something I think of as happening after
> > allocation; and a factory, hmm maybe.  However, if it does the right
> > thing I wouldn't object to any of those names.
> > 
> 
> I think we are on the same page.
> 
> Cheers,
> Halil
> 
> > Dave
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
