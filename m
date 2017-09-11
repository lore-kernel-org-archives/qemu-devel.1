Received: from eggs.gnu.org ([2001:4830:134:3::10]:35990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drMBe-0004Hj-9q
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drMBb-0000nd-6m
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:43:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drMBb-0000n2-0t
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:43:27 -0400
Date: Mon, 11 Sep 2017 11:43:12 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170911104312.GI21444@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906113157.GD2215@work-vm> <20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<87inguaclr.fsf@dusky.pond.sub.org>
	<20170907132259.GM30609@redhat.com>
	<87h8weo186.fsf@dusky.pond.sub.org> <20170907180900.GV2098@work-vm>
	<87k219fuq5.fsf@dusky.pond.sub.org> <20170908093212.GA2095@work-vm>
	<87efrhcsve.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87efrhcsve.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On Fri, Sep 08, 2017 at 01:49:41PM +0200, Markus Armbruster wrote:
> > I also see the other problem as keeping the management level
> > understanding of which commands are asynchronous; Dan's suggestion is
> > that command where the management layer specifies which commands it
> > expects to be asynchronous, and qemu responds with which ones actually
> > are.
> 
> "Command supports out-of-band dispatch" would be visible in
> query-qmp-schema.
> 
> Design alternative: either switching on out-of-band mode (see 6.)
> switches all out-of-band commands to out-of-band dispatch, or it
> doesn't, and the client has to request out-of-band dispatch explicitly.
> The explicit request could either be per execute (say send {'exec-oob':
> COMMAND-NAME ...} instead of {'execute': COMMAND-NAME...}), or per
> session, i.e. with a new command to enable oob dispatch for a list of
> oob-capable commands.
> 
> I figure explicit is safer, because it lets us make more commands
> oob-capable without upsetting existing oob-aware QMP clients.

Yep, this is fine too - it achieves the same end goals as the approach
I suggest. Namely

 - clients can detect which commands can do OOB (via the schema)
 - clients can choose which commands to run OOB (via exec vs exec-oob)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
