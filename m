Received: from eggs.gnu.org ([2001:4830:134:3::10]:36534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhFl8-0006Fx-H4
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 09:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhFl5-00028E-Ap
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 09:50:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhFl5-00027P-4w
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 09:50:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED588C070139
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 13:50:17 +0000 (UTC)
Date: Mon, 14 Aug 2017 14:50:10 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170814135010.GE8506@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-12-quintela@redhat.com>
	<20170811152256.GS2554@redhat.com> <87shguxo0x.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87shguxo0x.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v6 11/19] migration: Start of multiple fd
 work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Mon, Aug 14, 2017 at 03:43:58PM +0200, Juan Quintela wrote:
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > On Tue, Aug 08, 2017 at 06:26:21PM +0200, Juan Quintela wrote:
> >> We create new channels for each new thread created. We send through
> >> them a string containing <uuid> multifd <channel number> so we are
> >> sure that we connect the right channels in both sides.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> 
> 
> >> +/* Default uuid for multifd when qemu is not started with uuid */
> >> +static char multifd_uuid[] = "5c49fd7e-af88-4a07-b6e8-091fd696ad40";
> >
> > Why is this better than just using the qemu_uuid unconditionally.
> > UUIC, it'll just be 00000000-0000-0000-0000-000000000000.
> >
> > Either way you've got a non-unique UUID if multiple QEMUs are
> > started, so I dont see a benefit in inventing a new uuid here.
> 
> I hate a message full of zeros, it is the default value.  If you have
> more than one qemu and you don't set uuid, you are asking for trouble.
> 
> But if people preffer the 00000 uuid, it is also ok with me.

I don't see a fixed UUID of all-zeros being any different from
a fixed UUID hardcoded in the source code here. Both are simply
conceptually broken in the same way if you care about distinguishing
VMs.


> > I also think it is not nice to be formatting a string with printf
> > here, sending it and then using scanf to extract the data. If we
> > need to send structured data, then we should define a proper binary
> > format for it eg 
> >
> >   struct MigrateUUIDMsg {
> >       uint32_t chnanelid;
> >       QemuUUID uuid;
> >   } __attribute__((__packed__));
> >
> > and then just send the raw struct across.
> 
> Not that I believe that it still works (or that it worked ever), but
> qemu migration "on stream" was supposed to be Endian safe .....

The uuid field is just a byte array, so not endian sensitive. For
the channelid, just do a hton / ntoh call before/after writing/reading
the struct.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
