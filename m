Received: from eggs.gnu.org ([2001:4830:134:3::10]:38364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1faxBt-0005Mh-Q2
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1faxBs-0003Cl-Nt
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:52:29 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1faxBs-0003B8-GZ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:52:28 -0400
Received: by mail-oi0-x244.google.com with SMTP id n84-v6so14545155oib.9
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 22:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180615222855.44421-1-mst@redhat.com>
	<20180615222855.44421-2-mst@redhat.com>
	<b59883c6-1dc0-4e81-439c-587c8f2d3e83@redhat.com>
	<f87772ab-7d59-4ab2-59e3-c1ac77eaf725@redhat.com>
	<20180620030236-mutt-send-email-mst@kernel.org>
	<CANRm+CyZyo49ga=-dM-VES8fTEYiv+FM0WZdsf5F+jhnLbcLtw@mail.gmail.com>
	<20180620053855-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180620053855-mutt-send-email-mst@kernel.org>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 5 Jul 2018 13:52:29 +0800
Message-ID: <CANRm+Cz956boUFODZRAfrLHXiAFbDZ2Yu3oiVroy58CTg7veNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] kvm: support -dedicated
 cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eblake@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm <kvm@vger.kernel.org>, Richard Henderson <rth@twiddle.net>

On Wed, 20 Jun 2018 at 10:41, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jun 20, 2018 at 08:46:10AM +0800, Wanpeng Li wrote:
> > On Wed, 20 Jun 2018 at 08:07, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Jun 19, 2018 at 05:07:46PM -0500, Eric Blake wrote:
> > > > On 06/19/2018 10:17 AM, Paolo Bonzini wrote:
> > > > > On 16/06/2018 00:29, Michael S. Tsirkin wrote:
> > > > > > +static QemuOptsList qemu_dedicated_opts = {
> > > > > > +    .name = "dedicated",
> > > > > > +    .head = QTAILQ_HEAD_INITIALIZER(qemu_dedicated_opts.head),
> > > > > > +    .desc = {
> > > > > > +        {
> > > > > > +            .name = "mem-lock",
> > > > > > +            .type = QEMU_OPT_BOOL,
> > > > > > +        },
> > > > > > +        {
> > > > > > +            .name = "cpu-pm",
> > > > > > +            .type = QEMU_OPT_BOOL,
> > > > > > +        },
> > > > > > +        { /* end of list */ }
> > > > > > +    },
> > > > > > +};
> > > > > > +
> > > > >
> > > > > Let the bikeshedding begin!
> > > > >
> > > > > 1) Should we deprecate -realtime?
> > > > >
> > > > > 2) Maybe -hostresource?
> > > >
> > > > What further things might we add in the future?
> > > >
> > > > -dedicated sounds wrong (it is an adjective, while most of our options are
> > > > nouns - thing -machine, -drive, -object, ...)
> > > >
> > > > -hostresource at least sounds like a noun, but is long to type.  But at
> > > > least '-hostresource cpu-pm=on' reads reasonably well.
> > >
> > > Yes but host resource what? I feel it says nothing at all about what
> > > one can expect to find in this flag.
> > >
> > > > About the only other noun I could think of would be '-feature cpu-pm=on'.
> > >
> > > If we have nothing at all to say about what is grouping these things,
> > > we don't need a new flag. We can make it a machine property.
> > >
> > > It's user's hint that some host resource is dedicated to a VM.
> >
> > The commit 633711e82 (kvm: rename KVM_HINTS_DEDICATED to
> > KVM_HINTS_REALTIME) should be reverted according to several threads
> > discussion I think.
> >
> > Regards,
> > Wanpeng Li
>
> IMHO that is unrelated - these KVM hints are hints to *guest*.

Actually I really don't like the KVM_HINT_REALTIME renaming, there are
dedicated instances in public cloud environment consider security or
performance. The financial customers may prefer dedicated pCPUs when
considering security, and other gaming customers may prefer dedicated
pCPUs when considering performance. So "realtime" is not suitable.

Regards,
Wanpeng Li
