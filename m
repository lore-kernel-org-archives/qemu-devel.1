Received: from eggs.gnu.org ([2001:4830:134:3::10]:47906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSil3-0003aZ-OT
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSikz-00076A-Q3
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:50:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54716 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fSikz-00075R-Kn
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:50:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0CA58314C
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 12:50:40 +0000 (UTC)
Date: Tue, 12 Jun 2018 13:50:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180612125033.GF24690@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180606135051.GR7451@localhost.localdomain>
	<1528372809-175770-1-git-send-email-imammedo@redhat.com>
	<20180608132105.GA24764@localhost.localdomain>
	<20180611151625.4b2420b8@redhat.com>
	<20180611190607.GU7451@localhost.localdomain>
	<20180611232924.6e04b6f8@igors-macbook-pro.local>
	<20180611223633.GG7451@localhost.localdomain>
	<5cef972d-250b-5464-7482-90fa24d36c80@redhat.com>
	<20180612144205.2169e7a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180612144205.2169e7a2@redhat.com>
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
Cc: Michal Privoznik <mprivozn@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, ldoktor@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, pkrempa@redhat.com

On Tue, Jun 12, 2018 at 02:42:05PM +0200, Igor Mammedov wrote:
> We can keep daemonizing flow in QEMU as it's now.
> But Eduardo's idea about libvirt created socked + letting QEMU connect to it
> has a merit. It should fix current deadlock issue with as monitor
> won't be depending on lead exit event.

NB, libvirt only ever uses --daemonize when probing capabilities, never
when launching QEMU for a real VM. In the latter case, we now use FD
passing, so libvirt opens the UNIX domain socket listener, and passes
this into QEMU. So libvirt knows it can connect to the listener
immediately and will only ever get a failure if QEMU has exited.

We can't use FD passing for the capabilities probing because of the
chicken & egg problem - we need to probe capabilities to find out
if FD passing it available or not. Fortunately with capabilities
probing, we don't care about using --preconfig, as were not running
a real VM

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
