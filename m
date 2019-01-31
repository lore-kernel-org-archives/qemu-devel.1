Received: from eggs.gnu.org ([209.51.188.92]:43796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gp9YZ-0007TL-Df
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gp9YX-000186-3y
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:26:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gp9YV-00015t-9q
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:26:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C3A189AE2
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 10:26:45 +0000 (UTC)
Date: Thu, 31 Jan 2019 10:26:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190131102636.GE19982@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190130065530.6371-1-kraxel@redhat.com>
	<20190130120422.GK15904@redhat.com>
	<20190131074143.qw6thiywzrgq7etd@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190131074143.qw6thiywzrgq7etd@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH] scripts: use git archive in archive-source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com

On Thu, Jan 31, 2019 at 08:41:43AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > +git archive --format tar $HEAD > "$tar_file"
> > > +test $? -ne 0 && error "failed to archive qemu"
> > >  for sm in $submodules; do
> > > -    git submodule update --init $sm
> > > -    test $? -ne 0 && error "failed to init submodule $sm"
> > > +	git submodule update --init "$sm"
> > 
> > The current archive-source.sh code is careful to not touch the
> > developer's current git checkout, because it runs  submodule
> > update in a clone'd tree. The earlier patch hunk gets rid of the
> > clone, so now submodule update is touching the developer's master
> > git checkout. IMHO this is not acceptable - running tests (which
> > use archive-source.sh) must never alter the developer's git checkout
> > status in any way.
> 
> Can easily be fixed, the sha1 can be pulled out of "git submodule
> status" instead of updating the submodules & use HEAD.
> 
> The only question is what to do best on uninitialized submodules.
> Options are:
>  * fetch the submodule into the developer tree (once).

As above, we shouldn't ever touch the developer's git state.

>  * clone the submodule into a temporary directory (each run).

IMHO this is the only option

>  * throw an error.

Definitely don't want this, as an uninitialized submodule is going to
be a common case for the 'dtc' module when people have the suitable
version already on their host, so this would break the CI scripts.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
