Received: from eggs.gnu.org ([2001:4830:134:3::10]:55806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@gmail.com>) id 1f0z0N-0000H2-EJ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@gmail.com>) id 1f0z0M-0003zf-CN
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:31:55 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:35470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@gmail.com>) id 1f0z0M-0003zV-6a
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:31:54 -0400
Received: by mail-oi0-x233.google.com with SMTP id z8-v6so660155oix.2
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 17:31:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8c238385-5cab-2c7d-6550-d6d0866570eb@redhat.com>
References: <20180327113452.19613-1-dgilbert@redhat.com>
	<20180327113452.19613-4-dgilbert@redhat.com>
	<0bfadead-a3c2-9bce-3e53-8ca3a258a57a@redhat.com>
	<20180327164753.GF2837@work-vm>
	<8c238385-5cab-2c7d-6550-d6d0866570eb@redhat.com>
From: Ed Swierk <eswierk@gmail.com>
Date: Tue, 27 Mar 2018 17:31:12 -0700
Message-ID: <CAMCNy=BXw18H6sjAgEETDgo4XN_PpD0qAtrvEarm56JJFN3PYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, peterx@redhat.com, quintela@redhat.com

On Tue, Mar 27, 2018 at 10:28 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 27/03/2018 18:47, Dr. David Alan Gilbert wrote:
>>> So if the subsection is absent you
>>> have to migrate either tx.tso_props or tx.props, depending on s->tx.cptse.
>> Do you mean when sending you have to decide which set to send in the
>> non-subsection data?  And with cptse true that means use tso_props?
>
> Yes.
>
>>> Likewise if you migrate from older versions: if s->tx.props.tse &&
>>> s->tx.cptse, you have to copy s->tx.props to s->tx.tso_props and clear
>>> s->tx.props.
>>
>> I don't see any equivalent code in the existing non-subsection postload to
>> do this; so I'm guessing there are some cases of 2.11->2.12 that will
>> break at the moment?
>
> Yes, I think so.
>
>>> My understanding is that s->tx.tso_props.tse will be 1 if
>>> and only if the source sent s->tx.tso_props.
>> I don't see anything in the current code that migrates tso_props.tse -
>> where does it come from?
>
> Ouch... The tse field is more or less dead in current code AFAICS, but
> it was used in the previous version.  What's the best way then to find
> if the subsection was transmitted?  Do we have anything like a post_load
> callback in the subsection itself?

The TSE flag in the cmd_and_length field of the context descriptor is
useful only as an indication of which context is being updated: TSO
(tso_props) or non-TSO (props). There is no reason to store it or
migrate it, and all prior uses of the stored field were based on an
incorrect understanding of its meaning. Now props.tse is always 0, and
tso_props.tse is always 1 after the first TSO context is processed.

> To find out which "props" to transmit to older QEMU, you can add a
> tp->use_tso_for_migration = tp->cptse just before "if (!(txd_lower &
> E1000_TXD_CMD_EOP))" in process_tx_desc...

tp->cptse only indicates whether the current tx data descriptor should
be segmented using parameters from the last TSO context descriptor.
It's perfectly legal for the guest to set up a TSO context and then
use it for some but not all subsequent data descriptors. tp->cptse
doesn't help in deciding what to migrate.

Whether to migrate props or tso_props back to 2.11 should be instead
based on which was updated last by a context descriptor. Something
like

if (dtype == E1000_TXD_CMD_DEXT) {    /* context descriptor */
    if (le32_to_cpu(xp->cmd_and_length) & E1000_TXD_CMD_TSE) {
        e1000x_read_tx_ctx_descr(xp, &tp->tso_props);
        tp->use_tso_for_migration = 1;
        tp->tso_frames = 0;
    } else {
        e1000x_read_tx_ctx_descr(xp, &tp->props);
        tp->use_tso_for_migration = 0;
    }
    return;

--Ed
