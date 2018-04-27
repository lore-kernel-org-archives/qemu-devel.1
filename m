Received: from eggs.gnu.org ([2001:4830:134:3::10]:55837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fC755-0005qe-Cl
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fC750-0002tW-Fj
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:22:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fC750-0002tA-AF
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:22:42 -0400
Date: Fri, 27 Apr 2018 18:22:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180427172230.GN2608@work-vm>
References: <20180420175721.18479-1-dgilbert@redhat.com>
	<20180425095312.GA14253@9.122.211.20>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425095312.GA14253@9.122.211.20>
Subject: Re: [Qemu-devel] [PATCH] migration: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

* Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> On Fri, Apr 20, 2018 at 06:57:21PM +0100, Dr. David Alan Gilbert (git) wrote:

> > +- Busses and devices should be able to explicitly specify addresses when
> > +  instantiated, and management tools should use those.  For example,
> > +  when hot adding USB devices it's important to specify the ports
> > +  and addresses, since implicit ordering based on the command line order
> > +  may be different on the destination.  This can result in the
> > +  device state being loaded into the wrong device.
> 
> Would you like to add a note about taking care of migrating drc states incase
> of hot adding devices, that could ensure hotunplug device safely after
> migration ?

That's something Power specific as I understand, but I don't know any
details of it.  What would you say as a general warning ?

> > +When we migrate a device, we save/load the state as a series
> > +of fields.  Some times, due to bugs or new functionality, we need to
> > +change the state to store more/different information.  Changing the migration
> > +state saved for a device can break migration comppatibility unless
> > +care is taken to use the appropriate techniques.  In general QEMU tries
> > +to maintain forward migration compaitibility (i.e. migrating from
> > +QEMU n->n+1) and there are users who benefit from backwards compatibility
> 
> typo - %s/backwards/backward

Interesting, I'd always said 'backwards' and there's only one
place I said 'backward', but I guess 'backward' is more consistent with
'forward' so I'll remove all the 's's

> > +Firmware
> > +========
> > +
> > +Migration migrates the copies of RAM and ROM, and thus when running
> > +on the destination it includes the firmware from the source. Even after
> > +resetting a VM, the old firmware is used.   Only once QEMU has been restarted
> 
> typo with 2 spaces

I seem to have 3 there; I use 2 in most places; so made it consistent.

Thanks,

Dave

> Only after QEMU has been restarted the new firmware will be used.
> 
> -- Bala
> 
> > +is the new firmware in use.
> > +
> > +- Changes in firmware size can cause changes in the required RAMBlock size
> > +  to hold the firmware and thus migration can fail.  In practice it's best
> > +  to pad firmware images to convenient powers of 2 with plenty of space
> > +  for growth.
> > +
> > +- Care should be taken with device emulation code so that newer
> > +  emulation code can work with older firmware to allow forward migration.
> > +
> > +- Care should be taken with newer firmware so that backwards migration
> > +  to older systems with older device emulation code will work.
> > +
> > +In some cases it may be best to tie specific firmware versions to specific
> > +versioned machine types to cut down on the combinations that will need
> > +support.  This is also useful when newer versions of firmware outgrow
> > +the padding.
> > +
> > -- 
> > 2.17.0
> > 
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
