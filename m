Received: from eggs.gnu.org ([2001:4830:134:3::10]:48607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkaplans@redhat.com>) id 1eJjgy-0007B3-OR
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkaplans@redhat.com>) id 1eJjgw-0007do-IP
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:29:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkaplans@redhat.com>) id 1eJjgw-0007co-1S
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:29:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04DB98553D
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 17:29:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EEC0560BE5
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 17:29:04 +0000 (UTC)
Date: Tue, 28 Nov 2017 12:29:04 -0500 (EST)
From: Victor Kaplansky <vkaplans@redhat.com>
Message-ID: <1183103709.47097586.1511890144875.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171128181306-mutt-send-email-mst@kernel.org>
References: <20171128133123.17372-1-vkaplans@redhat.com>
	<20171128181306-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost-user spec: Clarify policy on setting
 log_base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, dgilbert@redhat.com

> From: "Michael S. Tsirkin" <mst@redhat.com>
> To: "Victor Kaplansky" <vkaplans@redhat.com>
> Cc: qemu-devel@nongnu.org, "Maxime Coquelin" <maxime.coquelin@redhat.com>
> Sent: Tuesday, November 28, 2017 6:16:32 PM
> Subject: Re: [PATCH] vhost-user spec: Clarify policy on setting log_base
> 
> On Tue, Nov 28, 2017 at 03:46:44PM +0200, Victor Kaplansky wrote:
> > From: Victor Kaplansky <vkaplans@dell9020.localdomain>
> > 
> > If we allow qemu to change logging area after it was already established,
> > it may require from the backend to acquire a lock on each access to
> > the log_base, which has a potential quite a big performance hit.

> 
> Do we actually issue VHOST_USER_SET_LOG_BASE when ring is started?
> 
> Can we put it simpler:
> 
> 	master must not send VHOST_USER_SET_LOG_BASE when ring
> 	is started and logging of used ring writes is started.
> 
> ?

I'm OK with this phrasing from DPDK point of view, the problem is
that right now qemu issues VHOST_USER_SET_LOG_BASE for each queue
pair, which causes backend to remap logging area, which is very
prone to race conditions without full fledged lock on log_base variable.

The several set_log_base requests by qemu are to the same logging area
with the same size, but a backend cannot know this, since the information is
passed by fd (file descriptor).

So, if we use the word *must* it will *require* a change in QEMU, to
issue single set_log_base for all queue pairs, and not once per queue
pair, as it is done now.

> 
> >  Note that when logging modifications to the used ring (when
> >  VHOST_VRING_F_LOG
> >  is set for this ring), log_guest_addr should be used to calculate the log
> >  offset: the write to first byte of the used ring is logged at this offset
> >  from
> > --
> > 2.14.2
> 
