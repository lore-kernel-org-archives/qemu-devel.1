Received: from eggs.gnu.org ([2001:4830:134:3::10]:53967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dIlM0-0006JT-Fv
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 20:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dIlLx-0002XK-DZ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 20:31:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dIlLx-0002X9-4A
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 20:31:09 -0400
Date: Thu, 8 Jun 2017 03:31:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170608032440-mutt-send-email-mst@kernel.org>
References: <20170607152825.12081-1-pbonzini@redhat.com>
	<20170607152825.12081-2-pbonzini@redhat.com>
	<CAFEAcA8CppP6YEPkGxVEyLnO=Kk1qirpGk2sh0bXedscxct8Jg@mail.gmail.com>
	<8229C6EB-56EA-475E-99D4-6D9B36B5D0A7@nutanix.com>
	<7a06506e-20ba-66b8-8c69-c500efe86301@redhat.com>
	<0281E149-DE28-4D6D-80E0-1132CAB8ABDB@nutanix.com>
	<1265195474.6852496.1496859744613.JavaMail.zimbra@redhat.com>
	<20170607212825-mutt-send-email-mst@kernel.org>
	<1191656469.6862786.1496861817272.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1191656469.6862786.1496861817272.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PULL 18/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Felipe Franciosi <felipe@nutanix.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Jun 07, 2017 at 02:56:57PM -0400, Paolo Bonzini wrote:
> 
> > > This could be documented,
> > 
> > It is documented AFAIK. Pls take a look at the spec documentation.
> 
> Found it now.  It's not under GET_VRING_BASE, it's under "starting
> and stopping rings"---fair enough.
> 
> In the case of vhost-user-scsi, however, QEMU also must not proceed
> until vhost-user-scsi has drained the pending I/O---and this pending
> I/O would be completed _after_ QEMU has sent GET_VRING_BASE.

Weird.  Doesn't QEMU wait for response to GET_VRING_BASE?
I think it does since we migrate the returned value.

Spec says:
	Client must only process each ring when it is started.
so this isn't expected. I guess whoever wrote vhost-user-scsi
understood "process" as "start processing".
What was intended is reading or writing any part of ring.
The used ring must not be updated after ring is stopped.
A spec clarification might in order.

> Is this handled by VHOST_USER_PROTOCOL_F_REPLY_ACK already?  If so,
> migration would be denied if the server lacks that protocol feature.
> 
> Paolo

GET_VRING_BASE does not need an ack, after respoding ring should
be stopped.

> > > but perhaps it's best to add a START_STOP
> > > feature and message to the vhost-user protocol?
> > 
> > We just never need to GET_VRING_BASE if ring keeps going -
> > makes no sense since base gets invalidated immediately.
> > 
> > 
> > 
> > > The feature then can be optional for vhost-user-net and mandatory for
> > > vhost-user-scsi.  When this is done we can remove .unmigratable.
> > > 
> > > Thanks,
> > > 
> > > Paolo
> > 
> > If vhost-user-scsi does not stop the ring after responding to
> > GET_VRING_BASE, it's just a bug that needs to be fixed.
> > 
> > > > > 
> > > > > Can you please send a version of your patch that uses .unmigratable?
> > > > 
> > > > Sure I can do that. We can work on the migration later on.
> > > > 
> > > > > 
> > > > > I'll send a v6 that momentarily drops vhost-scsi, but I intend to
> > > > > include it again in the next pull request.
> > > > 
> > > > Sounds good to me.
> > > > 
> > > > Felipe
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Paolo
> > > > 
> > > > 
> > 
