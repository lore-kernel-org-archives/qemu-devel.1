Received: from eggs.gnu.org ([2001:4830:134:3::10]:43730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0suc-0005os-Uv
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0suZ-0005Dz-1r
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:01:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40226 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f0suY-0005DZ-SM
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:01:30 -0400
Date: Tue, 27 Mar 2018 19:01:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180327180115.GH2837@work-vm>
References: <20180327113452.19613-1-dgilbert@redhat.com>
	<20180327113452.19613-4-dgilbert@redhat.com>
	<0bfadead-a3c2-9bce-3e53-8ca3a258a57a@redhat.com>
	<20180327164753.GF2837@work-vm>
	<8c238385-5cab-2c7d-6550-d6d0866570eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c238385-5cab-2c7d-6550-d6d0866570eb@redhat.com>
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
> On 27/03/2018 18:47, Dr. David Alan Gilbert wrote:
> >> So if the subsection is absent you
> >> have to migrate either tx.tso_props or tx.props, depending on s->tx.cptse.
> > Do you mean when sending you have to decide which set to send in the
> > non-subsection data?  And with cptse true that means use tso_props?
> 
> Yes.
> 
> >> Likewise if you migrate from older versions: if s->tx.props.tse &&
> >> s->tx.cptse, you have to copy s->tx.props to s->tx.tso_props and clear
> >> s->tx.props.
> > 
> > I don't see any equivalent code in the existing non-subsection postload to
> > do this; so I'm guessing there are some cases of 2.11->2.12 that will
> > break at the moment?
> 
> Yes, I think so.

OK, so we'd better fix that for 2.12.

> >> My understanding is that s->tx.tso_props.tse will be 1 if
> >> and only if the source sent s->tx.tso_props.
> > I don't see anything in the current code that migrates tso_props.tse -
> > where does it come from?
> 
> Ouch... The tse field is more or less dead in current code AFAICS, but
> it was used in the previous version.  What's the best way then to find
> if the subsection was transmitted?  Do we have anything like a post_load
> callback in the subsection itself?

Yes, if I just add a .post_load field in the subsection it should get
called.

> To find out which "props" to transmit to older QEMU, you can add a
> tp->use_tso_for_migration = tp->cptse just before "if (!(txd_lower &
> E1000_TXD_CMD_EOP))" in process_tx_desc...

OK.

> >> This seems most easily done with a new field (e.g. vmstate_fixed_props)
> >> that is written in pre_save and set in post_load.
> > It might need a VMSTATE_WITH_TMP to be able to do the saving part;
> > when saving we can't change the current state when migrating
> > to an old destination in case the migration fails and we just continue.
> 
> Perhaps you can just copy props/tso_props to a new field, and change all the
> 
>         VMSTATE_UINT8(tx.props.ipcss, E1000State),
>         VMSTATE_UINT8(tx.props.ipcso, E1000State),
>         VMSTATE_UINT16(tx.props.ipcse, E1000State),
> 
> to
> 
>         VMSTATE_UINT8(tx_legacy_vmstate_props.ipcss, E1000State),
> 	...
> 
> and then add tx.props to the subsection together with tso.props.
> 
> New->old migration will place tx_legacy_vmstate_props in tx.props on the
> destination; new->new will realize the subsection was transmitted and
> ignore the tx_legacy_vmstate_props; old->new will not find data from the
> subsection and copy the tx_legacy_vmstate_props into one of tx.props and
> tx.tso_props.

Yeh, adding a legacy_props field should do it; although we never need
to transmit more than 2 copies.  

I'll look at this more tomorrow; I am a bit worried about testing it
though.

Dave


> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
