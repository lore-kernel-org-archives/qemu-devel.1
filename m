Received: from eggs.gnu.org ([2001:4830:134:3::10]:48864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@gmail.com>) id 1f0yPz-0006gv-Ih
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 19:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@gmail.com>) id 1f0yPy-0002GO-JN
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 19:54:19 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:38708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@gmail.com>) id 1f0yPy-0002Fo-ES
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 19:54:18 -0400
Received: by mail-ot0-x230.google.com with SMTP id o9-v6so732975otj.5
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 16:54:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180327142610.GC2837@work-vm>
References: <20180327113452.19613-1-dgilbert@redhat.com>
	<0cb312f6-6c36-25ac-3c9a-0d9626abac56@redhat.com>
	<20180327142610.GC2837@work-vm>
From: Ed Swierk <eswierk@gmail.com>
Date: Tue, 27 Mar 2018 16:53:36 -0700
Message-ID: <CAMCNy=DvXP2ReMotG-NOYYOGhOi9qRW0dxnNpGGm6UFCD7MKsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] e1000 migration changes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com

On Tue, Mar 27, 2018 at 7:26 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> If I understand correctly the d6244b description, there's two pieces of
> state (TSO and non-TSO) where there used to be only one.
> Now, with the new format we migrate both pieces of state, but lets think
> about what happens if we have to migrate only one piece.
>
> a) 2.11->2.11 migrated the only piece it knew about; so I guess the only
> problem was really the UDP corruption mentioned in the commit.

Right.

> b) 2.11->2.12 - it receives the wrongly merged piece of state and puts it
> in - well which of the two states does it load it into?  What's the
> effect of that?

The best we can do is copy the old props into both props and
tso_props. Copying it into just props means that e1000 would suddenly
find all zero offsets in tso_props, screwing up an ongoing TCP session
using TSO in a Windows guest. Conversely copying into just tso_props
would screw up an ongoing UDP session using non-TSO offload in a
Windows guest. Copying means we do no worse than the buggy 2.11
behavior, until both TSO and non-TSO contexts are refreshed and
everything is fine. (For Linux guests it doesn't matter since Linux
always seems to refresh both TSO and non-TSO contexts before every tx
data descriptor.)

> c) 2.12(+my mod)->2.11 ok, so 2.12 will have filled in both sets of state
> internally; but now it's only going to send one of them over to 2.11 -
> which one gets sent to 2.11? Is it the one that 2.11 is expecting?

This case is trickier. We want to copy into the old props whichever
one of props and tso_props was updated most recently by a non-TSO or
TSO context descriptor. Always copying one or the other risks screwing
up an ongoing session in a Windows guest by using outdated offsets.
(Again there's no problem for Linux guests.)

Probably the easiest solution is to add yet another flag (which
doesn't itself get migrated) that's set when tso_props is updated and
cleared when props is updated.

> d) 2.12(+my mod)->2.12(+my mod) with an old machine type, again we're only
> going to send one set of data (same as c) - but what's 2.12 going to
> make of the one piece of state received?

This is the same as (b) I think.

--Ed
