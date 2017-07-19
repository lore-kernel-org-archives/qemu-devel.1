Received: from eggs.gnu.org ([2001:4830:134:3::10]:36785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXqaN-0007da-0z
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXqaJ-0007FQ-SG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:08:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXqaJ-0007FG-LU
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:08:19 -0400
Date: Wed, 19 Jul 2017 16:07:58 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170719150758.GK30084@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <201707191247531805742@zte.com.cn>
	<20170719061651.GE2757@localhost.localdomain>
	<20170719121628.GI2103@work-vm>
	<20170719124147.GH2757@localhost.localdomain>
	<f870ca6c-a8fb-a88c-f171-a66f4158671d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f870ca6c-a8fb-a88c-f171-a66f4158671d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, wang.yi59@zte.com.cn, liu.yunh@zte.com.cn, qemu-devel@nongnu.org, "libvir-list@redhat.com" <libvir-list@redhat.com>, pbonzini@redhat.com, Liu.Jianjun3@zte.com.cn, rth@twiddle.net

On Wed, Jul 19, 2017 at 10:02:04AM -0500, Eric Blake wrote:
> [adding libvirt]
> 
> On 07/19/2017 07:41 AM, Eduardo Habkost wrote:
> 
> >> virsh  qemu-monitor-command --domain rhel6.8 --hmp --cmd "cpu 1"
> >> virsh  qemu-monitor-command --domain rhel6.8 --hmp --cmd "info lapic"
> >> dumping local APIC state for CPU 0
> > 
> > Right, the "cpu" command is useless inside a
> > 'human-monitor-command' QMP command.  The 'cpu-index' argument
> > should be used instead. should make "cpu" print an error if ran
> > inside 'human-monitor-command' instead of silently pretend it
> > worked.
> > 
> > If virsh doesn't support the 'cpu-index' argument to
> > 'human-monitor-command',
> 
> It doesn't.  Perhaps we should add that as a future libvirt-qemu.so API
> addition, although it's probably easier to just use QMP than HMP when
> using 'virsh qemu-monitor-command' if HMP doesn't do what you want.

Or special case the "cpu 1" command - ie notice that it is being
requested and don't execute 'human-montor-command'. Instead just
record the CPU index, and use that for future "human-monitor-command"
invokations, so we get full compat with the (dubious) stateful HMP
semantics that traditionally existed.

> 
> > it's possible to work around that
> > limitation by building your own QMP command.  e.g.:
> > 
> >   # virsh qemu-monitor-command f26test '{"execute":"human-monitor-command", "arguments":{"command-line":"info lapic", "cpu-index":1}}' | jq -r '.return'
> 
> Indeed, there's the use of QMP to work around the HMP deficiency.
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
