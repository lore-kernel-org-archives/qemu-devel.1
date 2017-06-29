Received: from eggs.gnu.org ([2001:4830:134:3::10]:57136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQawM-0000Zz-6b
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQawI-0005YC-RT
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:01:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQawI-0005Xp-HR
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:01:02 -0400
Date: Thu, 29 Jun 2017 16:00:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170629150054.GB22733@work-vm>
References: <20170611074817.13621-1-sf@sfritsch.de>
	<d95a3198-3ad0-4a75-dda2-a3b7502ede28@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95a3198-3ad0-4a75-dda2-a3b7502ede28@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Eric Blake (eblake@redhat.com) wrote:
> On 06/11/2017 02:48 AM, Stefan Fritsch wrote:
> > Sending a break on a serial console can be useful for debugging the
> > guest. But not all chardev backends support sending breaks (only telnet
> > and mux do). The chardev-send-break command allows to send a break even
> > if using other backends.
> > 
> > Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> > Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> > v2: added tests and Acked-by line
> > 
> 
> > +++ b/hmp-commands.hx
> > @@ -1745,6 +1745,22 @@ Removes the chardev @var{id}.
> >  ETEXI
> >  
> >      {
> > +        .name       = "chardev-send-break",
> > +        .args_type  = "id:s",
> > +        .params     = "id",
> > +        .help       = "send break on chardev",
> 
> Compare this wording,...
> 
> > +STEXI
> > +@item chardev-send-break id
> > +@findex chardev-send-break
> > +Sends break on the chardev @var{id}.
> 
> repeated here,
> 
> > +++ b/qapi-schema.json
> > @@ -5114,6 +5114,26 @@
> >  { 'command': 'chardev-remove', 'data': {'id': 'str'} }
> >  
> >  ##
> > +# @chardev-send-break:
> > +#
> > +# Send a break to a character device
> 
> ...with this wording.  I like 'send a break' better than 'send break',
> but even better might be 'send a break sequence' or even 'emulate a
> break sequence' (by definition, a break is NOT a character, but on bare
> metal character devices it IS a defined electrical sequence distinct
> from characters to make the recipient aware that the sender is trying to
> get attention).
> 
> Otherwise, the patch looks fine to me.  If all that changes is some
> word-smithing (and the maintainer may be willing to do that), you can add:
> Reviewed-by: Eric Blake <eblake@redhat.com>

I'll go with the 'send a break' - the official terminology seems to
be a 'break condition', but I've never heard anyone say that,
it's always been 'send a break'.

diff --git a/hmp-commands.hx b/hmp-commands.hx
index fc8d54b52a..275ccdfbc7 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1748,7 +1748,7 @@ ETEXI
         .name       = "chardev-send-break",
         .args_type  = "id:s",
         .params     = "id",
-        .help       = "send break on chardev",
+        .help       = "send a break on chardev",
         .cmd        = hmp_chardev_send_break,
         .command_completion = chardev_remove_completion,
     },
@@ -1756,7 +1756,7 @@ ETEXI
 STEXI
 @item chardev-send-break id
 @findex chardev-send-break
-Sends break on the chardev @var{id}.
+Send a break on the chardev @var{id}.

 ETEXI


Queued to HMP

Dave

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
