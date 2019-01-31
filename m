Received: from eggs.gnu.org ([209.51.188.92]:37886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gp6z0-00052K-AM
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gp6yv-0000m5-W6
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:41:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gp6yv-0000kB-QR
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:41:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B681804F3
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 07:41:50 +0000 (UTC)
Date: Thu, 31 Jan 2019 08:41:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190131074143.qw6thiywzrgq7etd@sirius.home.kraxel.org>
References: <20190130065530.6371-1-kraxel@redhat.com>
	<20190130120422.GK15904@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130120422.GK15904@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts: use git archive in archive-source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com

  Hi,

> > +git archive --format tar $HEAD > "$tar_file"
> > +test $? -ne 0 && error "failed to archive qemu"
> >  for sm in $submodules; do
> > -    git submodule update --init $sm
> > -    test $? -ne 0 && error "failed to init submodule $sm"
> > +	git submodule update --init "$sm"
> 
> The current archive-source.sh code is careful to not touch the
> developer's current git checkout, because it runs  submodule
> update in a clone'd tree. The earlier patch hunk gets rid of the
> clone, so now submodule update is touching the developer's master
> git checkout. IMHO this is not acceptable - running tests (which
> use archive-source.sh) must never alter the developer's git checkout
> status in any way.

Can easily be fixed, the sha1 can be pulled out of "git submodule
status" instead of updating the submodules & use HEAD.

The only question is what to do best on uninitialized submodules.
Options are:
 * fetch the submodule into the developer tree (once).
 * clone the submodule into a temporary directory (each run).
 * throw an error.

cheers,
  Gerd
