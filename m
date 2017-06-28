Received: from eggs.gnu.org ([2001:4830:134:3::10]:47837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQE0E-0004l2-1f
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQE0C-0003FL-NM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:31:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQE0C-0003Et-Ey
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:31:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 475367D0C9
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 14:31:31 +0000 (UTC)
Date: Wed, 28 Jun 2017 15:31:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170628143126.GP29134@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170611123714.31292-1-mreitz@redhat.com>
	<afe9f097-e08f-4b11-3cf9-9af4c18915f0@redhat.com>
	<cc2667fa-b79f-148b-9d1a-69e668b1cd87@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc2667fa-b79f-148b-9d1a-69e668b1cd87@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Ignore SIGPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>

On Wed, Jun 28, 2017 at 04:27:00PM +0200, Max Reitz wrote:
> On 2017-06-27 19:09, Eric Blake wrote:
> > On 06/11/2017 07:37 AM, Max Reitz wrote:
> >> qemu proper has done so for 13 years
> >> (8a7ddc38a60648257dc0645ab4a05b33d6040063), qemu-img and qemu-io have
> >> done so for four years (526eda14a68d5b3596be715505289b541288ef2a).
> >> Ignoring this signal is especially important in qemu-nbd because
> >> otherwise a client can easily take down the qemu-nbd server by dropping
> >> the connection when the server wants to send something, for example:
> >>
> >> $ qemu-nbd -x foo -f raw -t null-co:// &
> >> [1] 12726
> >> $ qemu-io -c quit nbd://localhost/bar
> >> can't open device nbd://localhost/bar: No export with name 'bar' available
> >> [1]  + 12726 broken pipe  qemu-nbd -x foo -f raw -t null-co://
> >>
> >> In this case, the client sends an NBD_OPT_ABORT and closes the
> >> connection (because it is not required to wait for a reply), but the
> >> server replies with an NBD_REP_ACK (because it is required to reply).
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> > 
> > As mentioned in another thread, I'm trying to figure out if this patch
> > belongs as a third patch to fix CVE-2017-9524, or whether we want to
> > open a second CVE by considering this a slightly different
> > denial-of-service attack than what my patches fixed.
> 
> I think nobody would rip our heads off if we added it to it... I think
> it's similar in the regard that the NBD server tries to send something
> to a client that is no longer there, so it crashes (aborting in the
> original case, due to SIGPIPE here).
> 
> But strictly speaking it's a different issue, even from the user's
> perspective: In the original case you kill the server using nmap, here
> you do so using a real NBD client. Hm, not sure, how hard is it to
> assign a new CVE? O:-)

Have we issued a patch for CVE-2017-9524 yet ?  If so, then we *must*
request a new CVE, because vendors will need to track it as an
additional fix to backport & ship, if they've already shipped the
previous fix.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
