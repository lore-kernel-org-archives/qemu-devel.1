Received: from eggs.gnu.org ([209.51.188.92]:40107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goRmn-0004CN-8o
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goRmm-0003Ep-G9
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:42:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1goRmm-0003Dp-2x
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:42:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02F5544829
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 11:42:31 +0000 (UTC)
Date: Tue, 29 Jan 2019 11:42:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190129114226.GE2650@work-vm>
References: <20190128170321.16936-1-dgilbert@redhat.com>
	<20190128170321.16936-8-dgilbert@redhat.com>
	<cf3e5c3d-0802-42b0-a4eb-ffc2dfbf3706@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3e5c3d-0802-42b0-a4eb-ffc2dfbf3706@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/9] qmp: Add announce-self command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, berrange@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 1/28/19 11:03 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Add a qmp command that can trigger guest announcements.
> > 
> > It uses it's own announce-timer instance, and parameters
> 
> s/it's/its/ (here, you want the possessive form without apostrophe; the
> contraction form is correct only when you can use "it is" in the same place)

' removed

> > passed to it explicitly in the command.
> > 
> > Like most qmp commands, it's in the main thread/bql, so
> 
> Here, "it's" is correct.
> 
> > there's no racing with any outstanding timer.
> > 
> > Based on work of Germano Veit Michel <germano@redhat.com> and
> >                  Vladislav Yasevich <vyasevic@redhat.com>
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  net/announce.c |  8 ++++++++
> >  qapi/net.json  | 20 ++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> > 
> 
> > +++ b/qapi/net.json
> > @@ -707,3 +707,23 @@
> >              'max': 'int',
> >              'rounds': 'int',
> >              'step': 'int' } }
> > +
> > +##
> > +# @announce-self:
> > +#
> > +# Trigger generation of broadcast RARP frames to update network switches.
> > +# This can be useful when network bonds fail-over the active slave.
> > +#
> > +# @params: AnnounceParameters giving timing and repetition count of announce
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "announce-self"
> > +#      "arguments": { "initial": 50, "max": 550, "rounds": 10, "step": 50 } }
> 
> Again, can any of these have useful defaults to be left optional?

Nope, you have to state what you want fully.
However, that line is actually wrong, it should be:
# -> { "execute": "announce-self"
#      "arguments": { "params:" {
#          "initial": 50, "max": 550, "rounds": 10, "step": 50 } } }

(As I found when I wrote the test).
I've fixed that up.

Dave

> > +# <- { "return": {} }
> > +#
> > +# Since: 4.0
> > +##
> > +{ 'command': 'announce-self',
> > +  'data' : {'params': 'AnnounceParameters'} }
> > +
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
