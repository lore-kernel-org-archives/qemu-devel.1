Received: from eggs.gnu.org ([2001:4830:134:3::10]:50692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gUWGZ-0004FW-QN
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gUW7i-0000PB-CZ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:17:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gUW7i-0000OA-6L
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:17:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8904FC070E0B
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 12:17:48 +0000 (UTC)
Date: Wed, 5 Dec 2018 12:17:39 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181205121737.GA2391@work-vm>
References: <f60b8f1e-979b-4af9-7b48-a691c1937f6a@redhat.com>
	<4dd4e70a-7129-722c-971a-1b9f8b9aa349@redhat.com>
	<87wooql7c9.fsf@dusky.pond.sub.org>
	<de1686a3-1981-442d-a82a-704bca834922@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1686a3-1981-442d-a82a-704bca834922@redhat.com>
Subject: Re: [Qemu-devel] QMP accepts double dict keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

* Eric Blake (eblake@redhat.com) wrote:
> On 12/3/18 1:48 PM, Markus Armbruster wrote:
> > Eric Blake <eblake@redhat.com> writes:
> > 
> > > On 12/3/18 10:30 AM, Max Reitz wrote:
> > > > Hi,
> > > > 
> > > > QMP accepts double keys in dicts without complaining.  The value it is
> > > > using is apparently the last one specified:
> > > 
> > > JSON says it is undefined what happens when a client passes double
> > > keys. We are probably best off if we teach our parser to be strict and
> > > reject doubled keys in QMP as invalid.
> > 
> > Not bug-compatible.  Do we care?
> 
> I don't think so. Such a client was already invoking undefined behavior.
> Relying on first- or last-past-the-post to win is not portable, since JSON
> parsers are allowed to use hash tables with non-deterministic lookups. I
> think erroring out is nicer than silently accepting one thing, especially if
> that might have been different than what the client (incorrectly) expected.
> I'm not even sure that we would want a deprecation period.

Agreed, because it's the type of thing that ends up being potentially
dangerous, since if you had some form of security check that was looking
at QMP messages it might check one version of the field and not the
other.

Dave

> > 
> > > Hmm - can a client abuse QMP with duplicate keys to cause qemu to leak
> > > memory?
> > 
> > No.  parse_pair() inserts with qdict_put_obj(), which replaces the old
> > value without leaking it.
> 
> Good to know.
> 
> > > > 
> > > > Another test case is iotest 229 which specifies both mode=absolute-paths
> > > > and mode=existing (it wants the latter).
> 
> We'll have to fix such broken clients, of course. If it is just our iotests
> (and not libvirt), I'm less worried about the change in behavior.
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
