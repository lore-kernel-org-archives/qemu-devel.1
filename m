Received: from eggs.gnu.org ([2001:4830:134:3::10]:37281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fsmEd-00089O-VT
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fsmEb-0007ov-6i
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:48:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fsmEa-0007oB-Tt
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:48:57 -0400
Date: Thu, 23 Aug 2018 11:48:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180823094850.zycuwtjndmztgcm4@sirius.home.kraxel.org>
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-8-quintela@redhat.com>
	<0d3a215b-4916-b0a6-5654-5d64fcf6c996@redhat.com>
	<87y3cyo4ax.fsf@trasno.org>
	<20180823074321.wx7wix7jwsfrcbk5@sirius.home.kraxel.org>
	<9cb5f027-e49c-d943-7ffa-9e744537f174@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb5f027-e49c-d943-7ffa-9e744537f174@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/10] check: Only test boot-serial when
 sga is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

> > I remember we even discussed that a while back ...
> > Oh yes: https://git.kraxel.org/cgit/qemu/commit/?h=work/no-sgabios&id=408690999429fdf44011c49b3af6efa50f369b1e
> > Somehow never ended up being merged.
> 
> Sounds like a good idea! Could you repost the patch, with an update to
> qemu-deprecated.texi, please? Maybe also print the deprecation message
> in any case if !use_sgabios, e.g.:
> 
>     } else {
>         /*
>          * For this machine type we expect SeaBIOS to provide a
>          * serial console for -machine graphics=off.  No need to
>          * add the sgabios rom here.
>          */
>         warn_report("sgabios is deprecated and is not required anymore,"
>                     " SeaBIOS now has the same functionality, too");
>     }

Hmm, IIRC libvirt support is a bit tricky here as there is no easy way
to probe for serial console support in seabios.  So the idea was to just
allow both -machine graphics=off and -device sga, by turning -device sga
into a nop in case -machine graphics=off is present.

But given we meanwhile had some releases without this I suspect that
isn't a good idea any more.  With both -machine graphics=off -device sga
seabios and sgabios will fight over the serial device ...

So, maybe take a completely different route.  Add a deprecation_reason
field to DeviceClass.  Make it visible in qapi introspection, so libvirt
can see it and avoid adding it to the command line.  Then we can
deprecate -device sga (and possibly other devices too) that way.

For live migration compatibility reasons it'll be quite a while until we
can actually delete the device (much longer than the usual 2 releases
deprecation cycle).

cheers,
  Gerd
