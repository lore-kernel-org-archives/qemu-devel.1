Received: from eggs.gnu.org ([209.51.188.92]:37415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMMF-000719-BA
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMMD-0001rb-8D
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJMMD-0001qo-2O
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:10:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8F398F302
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 18:10:55 +0000 (UTC)
Date: Wed, 24 Apr 2019 15:10:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190424181049.GF18406@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<2b1d825f-8bd3-ba25-3e1b-8415aeec8ce6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b1d825f-8bd3-ba25-3e1b-8415aeec8ce6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Apr 24, 2019 at 09:56:53AM +0200, Thomas Huth wrote:
> On 23/04/2019 23.22, Eduardo Habkost wrote:
> > This series adds machine type deprecation information to the
> > output of the `query-machines` QMP command.  With this, libvirt
> > and management software will be able to show this information to
> > users and/or suggest changes to VM configuration to avoid
> > deprecated machine types.
> > 
> > Eduardo Habkost (3):
> >   qapi: SupportStatusInfo struct
> >   machine: Use SupportStatusInfo for deprecation info
> >   qmp: Add deprecation information to query-machines
> > 
> >  qapi/common.json                   | 24 ++++++++++++++++++++++++
> >  qapi/misc.json                     |  5 ++++-
> >  include/hw/boards.h                |  7 ++++---
> >  hw/i386/pc_piix.c                  |  4 +++-
> >  hw/ppc/prep.c                      |  4 +++-
> >  vl.c                               | 19 +++++++++++++++----
> >  tests/acceptance/query_machines.py | 27 +++++++++++++++++++++++++++
> >  7 files changed, 80 insertions(+), 10 deletions(-)
> >  create mode 100644 tests/acceptance/query_machines.py
> 
> Good idea, but some questions come to my mind:
> 
> - What about devices? IIRC Gerd wrote a patch series last year that does
>   something similar for devices... It would be good to synchronize the
>   work, so that we do not have two completely interfaces between devices
>   and machines here in the end...

My plan is to support this on devices, too.  I even had a version
where documentation of SupportStatusInfo mentioned device types,
but I decided to leave that out until we actually implement a
device deprecation info API.

> 
> - Is deprecation as a status enough, or do we want to carry more
>   information here? E.g. is the machine maintained or orphan? Is it
>   stable or rather experimental? And didn't Gerd have also some
>   patches for this last year? ... yes, I think it was this series here:
>   http://lists.gnu.org/archive/html/qemu-ppc/2018-11/msg00039.html
>   ... actually, I like that idea with QemuSupportState... maybe you
>   could base your work on that series instead?

We might want to carry more information eventually.  The
possibility of extending the data later is the main reason I
called the struct SupportStatusInfo and not just DeprecationInfo.

But I'd really like us to export the existing information first,
before extending the data.  Having important data available
through stderr and not QMP is a bug.  Tracking additional data
may be desirable, but it would be an additional feature.

-- 
Eduardo
