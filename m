Received: from eggs.gnu.org ([2001:4830:134:3::10]:52761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fSiyh-0004I7-37
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fSiyb-0007Wr-5m
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:04:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fSiya-0007Wd-WA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:04:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9131A7C6C4
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:04:44 +0000 (UTC)
References: <20180606135051.GR7451@localhost.localdomain>
	<1528372809-175770-1-git-send-email-imammedo@redhat.com>
	<20180608132105.GA24764@localhost.localdomain>
	<20180611151625.4b2420b8@redhat.com>
	<20180611190607.GU7451@localhost.localdomain>
	<20180611232924.6e04b6f8@igors-macbook-pro.local>
	<20180611223633.GG7451@localhost.localdomain>
	<5cef972d-250b-5464-7482-90fa24d36c80@redhat.com>
	<20180612144205.2169e7a2@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <1282921e-0d38-7bd2-de8b-64d327dd2549@redhat.com>
Date: Tue, 12 Jun 2018 15:04:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180612144205.2169e7a2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PATCH v6 2/2] vl: fix use of
 --daemonize with --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, ldoktor@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, berrange@redhat.com, pkrempa@redhat.com

On 06/12/2018 02:42 PM, Igor Mammedov wrote:

>>>
>>> Do we really need to make -daemonize and -preconfig work
>>> together?  libvirt uses -daemonize only for its initial
>>> capability probing, which shouldn't require -preconfig at all.
>>>
>>> Even on that case, I wonder why libvirt doesn't simply create a
>>> server socket and waits for QEMU to connect instead of using
>>> -daemonize as a sync point.
>>>   
>>
>> because libvirt views qemu as well behaved daemon. Should anything go
>> wrong libvirt reads qemu's stderr and reports error to upper layers.
> We can keep daemonizing flow in QEMU as it's now.
> But Eduardo's idea about libvirt created socked + letting QEMU connect to it
> has a merit. It should fix current deadlock issue with as monitor
> won't be depending on lead exit event.

Not sure about the benefits. Currently, libvirt spawns qemu, waits for
monitor to show up (currently, the timeout dynamic depending on some
black magic involving guest RAM size) and if it does not show up in time
it kills qemu. The same algorithm must be kept in place even for case
when libvirt would pass pre-opened socket to qemu in case qemu deadlocks
before being able to communicate over qmp. The only advantage I see is
libvirt would not need to label the socket (set uid:gid, selinux, ...).
On the other hand, since it would be libvirt creating the socket what
would happen on libvirtd restart?

> Can we do this way on libvirt side when --preconfig is in use
> (it might even be fine for normal flow without -preconfig)?

I think passing pre-opened socket and --preconfig are orthogonal. What
if somebody wants to use --preconfig does not pass any FD?

Michal
