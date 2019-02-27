Received: from eggs.gnu.org ([209.51.188.92]:49500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyw01-0005pO-C6
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyw00-0000ES-IJ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:59:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gyw00-0000DI-B3
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:59:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 501FA307D98D
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 09:59:35 +0000 (UTC)
Date: Wed, 27 Feb 2019 09:59:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190227095931.GB2602@work-vm>
References: <20190226195959.28759-1-dgilbert@redhat.com>
	<20190226195959.28759-8-dgilbert@redhat.com>
	<87pnrdoh73.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnrdoh73.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v5 7/9] qmp: Add announce-self command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, quintela@redhat.com

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Add a qmp command that can trigger guest announcements.
> >
> > It uses its own announce-timer instance, and parameters
> > passed to it explicitly in the command.
> >
> > Like most qmp commands, it's in the main thread/bql, so
> > there's no racing with any outstanding timer.
> >
> > Based on work of Germano Veit Michel <germano@redhat.com> and
> >                  Vladislav Yasevich <vyasevic@redhat.com>
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> [...]
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 5face0c14b..c093087278 100644
> > --- a/qapi/net.json
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
> > +#      "arguments": { "params:" {
> > +#          "initial": 50, "max": 550, "rounds": 10, "step": 50 } } }
> > +# <- { "return": {} }
> > +#
> > +# Since: 4.0
> > +##
> > +{ 'command': 'announce-self',
> > +  'data' : {'params': 'AnnounceParameters'} }
> 
> Any particular reason for the additional level of nesting within
> "arguments"?

I'd just copied one of the other places;  boxed doesn't seem to be used
that often.

Dave

> Here's how to avoid it:
> 
>    { 'command': 'announce-self', 'boxed': true,
>      'data' : 'AnnounceParameters' }
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
