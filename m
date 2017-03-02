Received: from eggs.gnu.org ([2001:4830:134:3::10]:53486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjPuw-0005Nq-9o
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 07:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjPut-0002Kn-5j
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 07:33:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjPus-0002KC-Vt
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 07:33:07 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1391061D02
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 12:33:07 +0000 (UTC)
Date: Thu, 2 Mar 2017 12:33:00 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170302123300.GJ29835@redhat.com>
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
> >      }
> >      if (params->has_tls_creds) {
> >          g_free(s->parameters.tls_creds);
> > -        s->parameters.tls_creds = g_strdup(params->tls_creds);
> > +        if (*params->tls_creds == '\0') {
> > +            s->parameters.tls_creds = NULL;
> 
> I'm wondering if you should also do s->parameters.has_tls_creds = false
> at this point?  The visitors expect that if has_tls_creds is true, then
> the string is non-NULL.

The fact that s->parameters contains has_* fields is completely ignored
by the migration code afaict. IOW the code behaves as if all the has_*
fields are hardwired to true in s->parameters, even though that is not
the case :-) The has_* fields are only used when the various migration
QMP methods are executed, and those all use a separate MigrationParameters
struct instance. 


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
