Received: from eggs.gnu.org ([2001:4830:134:3::10]:39419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dEMU7-0004Eb-J2
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dEMU2-0005n6-GP
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dEMU2-0005my-9l
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:09:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58C4E80511
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 21:09:17 +0000 (UTC)
Date: Fri, 26 May 2017 18:09:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170526210915.GA32274@thinpad.lan.raisama.net>
References: <20170526202316.22736-1-ehabkost@redhat.com>
	<20170526202316.22736-3-ehabkost@redhat.com>
	<1bf0456a-f9d1-1e9a-dcd4-ca9b3569b567@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bf0456a-f9d1-1e9a-dcd4-ca9b3569b567@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qmp: Include 'abstract' field on
 'qom-list-types' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Fri, May 26, 2017 at 03:51:53PM -0500, Eric Blake wrote:
> On 05/26/2017 03:23 PM, Eduardo Habkost wrote:
> > A client may be interested in getting the list of both abstract and
> > non-abstract types.  Instead of requiring them to make multiple queries
> > with different filter arguments, just return an 'abstract' field in
> > 'qom-list-types'.
> > 
> > In addition to the new test code for validating this field, update the
> > abstract-interfaces test case to query for all 'interface' subtypes
> > (including abstract ones), and to look at the 'abstract' field directly.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> 
> > +++ b/qapi-schema.json
> > @@ -3056,12 +3056,15 @@
> >  #
> >  # @name: the type name found in the search
> >  #
> > +# @abstract: the type is abstract and can't be directly instantiated.
> > +#            Omitted if false. (since 2.10)
> > +#
> 
> A little bit awkward in that libvirt will have to see if ANY entry in
> the large returned result has "abstract":true before it can assume
> "abstract":false on the remaining entries (that is, older qemu don't
> output abstract ever, but still mentions abstract types, so blindly
> writing code to assume absence of "abstract" means false breaks on those
> older versions).  Or a query of introspection to see if the field name
> is even supported would do.  Not insurmountable, though.

True.

I have the impression that management is not likely to look at
this field in the near future.  Probably the new field will be
more useful for automated test code like
device-instrospect-test.c and the device-crash-test script I
submitted recently.

> 
> >  # Since: 1.1
> >  #
> >  # Notes: This command is experimental and may change syntax in future releases.
> 
> Is this note still helpful, or should we delete it now?

The patch removing this line is already in a pending pull request
submitted by Markus last Tuesday.

> 
> >  ##
> >  { 'struct': 'ObjectTypeInfo',
> > -  'data': { 'name': 'str' } }
> > +  'data': { 'name': 'str', '*abstract': 'bool' } }
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

-- 
Eduardo
