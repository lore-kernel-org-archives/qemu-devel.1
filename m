Received: from eggs.gnu.org ([2001:4830:134:3::10]:47130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVXEs-0007f7-Em
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVXEp-00027m-8z
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:09:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52780 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVXEp-00027d-3N
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:09:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180521181435.GN25013@localhost.localdomain>
	<ab91cf9f-95c3-59dc-36cb-641a3db1171b@linux.ibm.com>
	<20180521202616.GT25013@localhost.localdomain>
	<874liyivcs.fsf@dusky.pond.sub.org>
	<20180523122749.GC8988@localhost.localdomain>
	<87d0xmcqrl.fsf@dusky.pond.sub.org>
	<20180524185727.GI8988@localhost.localdomain>
	<87y3g8w8kc.fsf@dusky.pond.sub.org>
	<20180525203044.GO8988@localhost.localdomain>
	<87efhwp7jp.fsf@dusky.pond.sub.org>
	<20180529145545.GB8988@localhost.localdomain>
	<0f8421a3-8b03-e949-1ca9-6efbf39de718@linux.ibm.com>
Date: Wed, 20 Jun 2018 09:09:00 +0200
In-Reply-To: <0f8421a3-8b03-e949-1ca9-6efbf39de718@linux.ibm.com> (Daniel
	Henrique Barboza's message of "Tue, 19 Jun 2018 17:29:26 -0300")
Message-ID: <8736xikk8j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 1/3] qmp: adding
 'wakeup-suspend-support' in query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, danielhb413@gmail.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Anthony Perard <anthony.perard@citrix.com>, Igor Mammedov <imammedo@redhat.com>, dgilbert@redhat.com

Daniel Henrique Barboza <danielhb@linux.ibm.com> writes:

> Hi,
>
> Sorry for the delay. I'll summarize what I've understood from the discussion
> so far:
>
> - query-target is the wrong place for this flag. query-machines is
> (less) wrong
> because it is not a static property of the machine object
>
> - a new "query-current-machine" can be created to host these dynamic
> properties that belongs to the current instance of the VM
>
> - there are machines in which the suspend support may vary with a
> "-no-acpi" option that would disable both the suspend and wake-up
> support. In this case, I see no problem into counting this flag into
> the logic (assuming it is possible, of course) and setting it as "false"
> if there is -no-acpi present (or even making the API returning "yes",
> "no" or "acpi" like Markus suggested) somewhere.
>
>
> Based on the last email from Eduardo, apparently there is a handful
> of other machine properties that can be hosted in either this new
> query-current-machine API or query-machines. I believe that this is
> more of a long term goal, but this new query-current-machine API
> would be a good kick-off and we should go for it.
>
> Is this a fair understanding? Did I miss something?

Sounds fair to me.

Adding query-current-machine on the evidence of just one flag would be
questionable, but Eduardo expects there to be more, so it's okay.

Whether a property is static or dynamic can change over time, which
makes the choice of query-machines vs. query-current-machine
non-trivial.  We better write down how we plan to handle mispredictions,
i.e. what to do when a property we put into query-machines turns out to
be dynamic, or a property we put into query-current-machine turns out to
be static, or we'd like query-machines to cover a property that is
static except for a few machines.

Eduardo, anything to add?
