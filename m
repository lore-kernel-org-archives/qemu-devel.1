Received: from eggs.gnu.org ([2001:4830:134:3::10]:44605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPy58-0007zu-FH
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPy54-0000hh-Hk
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:31:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPy54-0000hR-BG
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:31:30 -0400
Date: Tue, 27 Jun 2017 18:31:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170627213127.GC12152@localhost.localdomain>
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<20170613165313.20954-16-ehabkost@redhat.com>
	<20170615121407.GA2399@work-vm>
	<20170617193349.GM22043@thinpad.lan.raisama.net>
	<20170619084843.GB2104@work-vm>
	<CAFEAcA8G475i8JE_X+5UHGfz7HP8gbOkmQJ8bbSFOoGbULy_tA@mail.gmail.com>
	<20170619132654.GP5016@thinpad.lan.raisama.net>
	<aa23c822-0f0b-133f-fc45-9e344b8e3a93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa23c822-0f0b-133f-fc45-9e344b8e3a93@redhat.com>
Subject: Re: [Qemu-devel] [RFC 15/15] [test only] Use 'Error *err[static 1]'
 instead of 'Error **errp' to catch NULL errp arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, Jun 27, 2017 at 03:12:25PM -0500, Eric Blake wrote:
> On 06/19/2017 08:26 AM, Eduardo Habkost wrote:
> 
> >> Is gcc's __attribute__((nonnull)) any better? It seems to apply
> >> to the whole function prototype rather than an individual argument
> >> though so probably not :-(
> > 
> > It's possible to specify which arguments are non-null with
> > nonnull(<arg-index>, ...).  It's harder to use, but probably more
> > Coccinelle-friendly.
> 
> Libvirt uses it, wrapped in a macro; for example:
> 
> int ATTRIBUTE_NONNULL(1) ATTRIBUTE_NONNULL(2)
> virCPUDefCopyModel(virCPUDefPtr dst,
>                    const virCPUDef *src,
>                    bool resetPolicy)
> { ...
> 
> and at least Coverity is able to use that information (libvirt had
> problems in the past where older gcc _silently_ mis-optimized a program
> that used the attribute, and ended up having our macro defined only
> during Coverity and not during normal compilation; but I think that's
> finally been resolved now that newer gcc is saner in its behavior). I
> don't know how much smarts Coccinelle has for coming up with the right
> parameter number in an automated conversion patch, though.

In the worst case, the script could have a dozen transformations, one
transformation for each possible number of function arguments.

However, I hit this Coccinelle bug when trying to implement that:
https://github.com/coccinelle/coccinelle/issues/107

-- 
Eduardo
