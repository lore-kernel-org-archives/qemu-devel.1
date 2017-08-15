Received: from eggs.gnu.org ([2001:4830:134:3::10]:58116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhhla-0004Dw-61
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhhlW-0003G6-6R
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:44:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhhlV-0003FO-UP
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:44:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B32B13A268
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 19:44:36 +0000 (UTC)
Date: Tue, 15 Aug 2017 16:44:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170815194427.GV3108@localhost.localdomain>
References: <20170814215748.5158-1-ehabkost@redhat.com>
	<aaa8f7cd-5f55-0e3b-6eee-c45c9b45cbff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaa8f7cd-5f55-0e3b-6eee-c45c9b45cbff@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 00/13] qmp: query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>

On Tue, Aug 15, 2017 at 01:57:50PM -0500, Eric Blake wrote:
> On 08/14/2017 04:57 PM, Eduardo Habkost wrote:
> > Changelog
> > ---------
> > 
> > Changes v3 -> v4:
> > * New compact representation of slot sets.
> > * New generic code to automatically merge similar slots
> >   into a single entry in the command output while keeping
> >   implementations of the method simpler.
> > * Example implementation of IDE and USB bus enumeration
> 
> > 
> > Slot sets are represented by a list of option names and sets of
> > possible values for each of those options.  The command uses a
> > compact representation for the set of valid values for an option.
> > For example, the following set of 5 PCI functions:
> > 
> >       bus: pcie.0
> >       device-number: 31
> >       functions: 1,4,5,6,7
> > 
> > would be represented in the JSON data as:
> > 
> >   {"available":false,"count":5,
> >    "device-types":["pci-device"],"hotpluggable":false,
> >    "opts":[
> >       {"option":"function","values":[1,[4,7]]},
> 
> A list (and not just a single-type list, but a list that mixes scalar
> and sublist),
> 
> >       {"option":"device-number","values":31},
> 
> vs. a scalar.  Why not a one-element array?

It was just to keep the representation as compact as possible, in
the common case of single-value sets.  Probably we can drop that
feature as it saves only 2 bytes in the JSON representation.

> 
> >       {"option":"bus","values":"pcie.0"}],
> >    "opts-complete":true}
> > 
> > I planned to use QAPI alternates to model/document that in the
> > schema, but it would require implementing a few missing features
> > in QAPI alternate support.
> 
> Yeah, I can see how existing QAPI alternates do not yet support arrays,
> which becomes important to your representation.  Do you need help
> getting the QAPI generator improved to support a particular feature that
> you found to be lacking?

I think the lack of support for lists on alternates was the main
obstacle.

Probably we would also need to remove the restriction against
alternates with ambiguous string representations, to allow a
list/number/string/bool alternate to be defined.

Being able to set constraints on the number of elements of a list
would be nice to have, but not required.

-- 
Eduardo
