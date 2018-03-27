Received: from eggs.gnu.org ([2001:4830:134:3::10]:55026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0rlY-000424-JH
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0rlV-00064a-Sb
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:48:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37712 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f0rlV-00064I-Nw
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:48:05 -0400
Date: Tue, 27 Mar 2018 17:47:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180327164753.GF2837@work-vm>
References: <20180327113452.19613-1-dgilbert@redhat.com>
	<20180327113452.19613-4-dgilbert@redhat.com>
	<0bfadead-a3c2-9bce-3e53-8ca3a258a57a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bfadead-a3c2-9bce-3e53-8ca3a258a57a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] e1000: Old machine types,
 turn new subsection off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, eswierk@skyportsystems.com, jasowang@redhat.com, peterx@redhat.com, quintela@redhat.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 27/03/2018 13:34, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Turn the newly added subsection off for old machine types
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  include/hw/compat.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/hw/compat.h b/include/hw/compat.h
> > index bc9e3a6627..13242b831a 100644
> > --- a/include/hw/compat.h
> > +++ b/include/hw/compat.h
> > @@ -14,6 +14,10 @@
> >          .driver   = "vhost-user-blk-pci",\
> >          .property = "vectors",\
> >          .value    = "2",\
> > +    },{\
> > +        .driver   = "e1000",\
> > +        .property = "migrate_tso_props",\
> > +        .value    = "off",\
> >      },
> >  
> >  #define HW_COMPAT_2_10 \
> > 
> 
> Unfortunately it's not that easy, because on old machine types
> tx.tso_props was stored in tx.props.

OK, this pretty much sounds like the answer to the question I asked on
the cover letter.

> So if the subsection is absent you
> have to migrate either tx.tso_props or tx.props, depending on s->tx.cptse.

Do you mean when sending you have to decide which set to send in the
non-subsection data?  And with cptse true that means use tso_props?

> Likewise if you migrate from older versions: if s->tx.props.tse &&
> s->tx.cptse, you have to copy s->tx.props to s->tx.tso_props and clear
> s->tx.props.


I don't see any equivalent code in the existing non-subsection postload to
do this; so I'm guessing there are some cases of 2.11->2.12 that will
break at the moment?

> My understanding is that s->tx.tso_props.tse will be 1 if
> and only if the source sent s->tx.tso_props.

I don't see anything in the current code that migrates tso_props.tse -
where does it come from?

> This seems most easily done with a new field (e.g. vmstate_fixed_props)
> that is written in pre_save and set in post_load.

It might need a VMSTATE_WITH_TMP to be able to do the saving part;
when saving we can't change the current state when migrating
to an old destination in case the migration fails and we just continue.

How would I test this lot?

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
