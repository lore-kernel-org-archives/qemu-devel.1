Received: from eggs.gnu.org ([2001:4830:134:3::10]:40680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj5YC-00061m-TJ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj5Y8-000658-L0
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:48:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cj5Y8-00064s-CQ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:48:16 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 527557DD34
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 14:48:16 +0000 (UTC)
Date: Wed, 1 Mar 2017 14:48:09 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170301144809.GE10160@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170301123223.12489-1-berrange@redhat.com>
	<a08dc58b-a169-cb17-2187-1b66c6878a39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a08dc58b-a169-cb17-2187-1b66c6878a39@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: allow clearing migration string
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Mar 01, 2017 at 08:36:03AM -0600, Eric Blake wrote:
> On 03/01/2017 06:32 AM, Daniel P. Berrange wrote:
> > Some of the migration parameters are strings, which default to NULL,
> > eg tls_hostname and tls_creds.
> > 
> > The mgmt app will set the tls_creds parameter on both source and target
> > QEMU instances, in order to trigger use of TLS for migration.
> > 
> > After performing a TLS encrypted migration though, migration might be
> > used for other reasons - for example, to save the QEMU state to a file.
> > We need TLS turned off when doing this, but the migrate-set-parameters
> > QAPI command does not provide any facility to clear/reset parameters
> > to their default state.
> > 
> > If you simply ommit the tls_creds parameter in migrate-set-parameters,
> 
> s/ommit/omit/
> 
> > then 'has_tls_creds' will be false and so no action will be taken. The
> > only option that works with migrate-set-parameters is to treat "" on
> > the wire as equivalent to requesting NULL. Failing that we would have
> > to create a new 'migrate-reset-parameters' method to explicitly put
> > a parameter back to its default value.
> 
> That happens to work in this case, because an empty string as the TLS
> parameter makes no sense.
> 
> A nicer solution would be to support JSON null on the wire, so the user
> can pass "tls-creds":null to explicitly request wiping out the
> credentials rather than making the empty string magic.  But that's more
> invasive (the QAPI parser would have to be enhanced to allow an
> alternate that visits either a string or null).  Ultimately, I think
> we'll have to do that when we come up with some string property where ""
> should not be given magic treatment.
> 
> So now we have a dilemma: do we special case "" here, to be stuck with
> it even if we later add nullable-string support later, or do we go all
> the way to nullable-string support now?  We've missed soft freeze for
> 2.9, so my vote is that it is okay to special case "" in  this instance,
> even though we'll have to continue to support it indefinitely even if we
> gain nullable-string QMP.

FYI, if QEMU ever sends a QMP reply whose value comes from a NULL string,
it turns that into "". IOW, on output "" and NULL are indistinguishable

So from that POV, treating JSON nil and "" as indistiguishable on input
would be consistent with what we do on output.

I'd only suggest allowing JSON nil on input, if we're willing change the
output code to map NULL -> nil, instead of NULL -> "".

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
