Received: from eggs.gnu.org ([2001:4830:134:3::10]:50561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhYaE-0006kX-33
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhYaA-0006ay-75
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:56:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhYaA-0006Zg-0L
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:56:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F11CFC01416D
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:56:14 +0000 (UTC)
Date: Tue, 15 Aug 2017 10:56:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170815095607.GF9674@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808203935.30021-1-ehabkost@redhat.com>
	<20170808203935.30021-2-ehabkost@redhat.com>
	<87o9rhp3gv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o9rhp3gv.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2 1/5] qmp-shell: Use optparse
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Aug 15, 2017 at 11:47:28AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > It makes command-line parsing and generation of help text much
> > simpler.
> 
> There's really no excuse for parsing command line arguments by hand in
> Python.
> 
> > The optparse module is deprecated since Python 2.7, but argparse
> > is not available in Python 2.6 (the minimum Python version
> > required for building QEMU).
> 
> We have a few uses of argparse in the tree.  Are they okay?
> 
> We also use getopt in places.  Perhaps we should pick one way to parse
> command lines and stick to it.

I just came up against this problem with keycodemapdb which I'm adding as
a submodule to qemu.  I used argparse there because it is the modern
recommended API for python >= 2.7.   I examined possibilty of using
optparse instead, but it lacks key features - in particular the idea
of 'subcommands' is entirely missing from optparse.

The 'argparse' module is part of python core, but is *also* available
as a standalone module that is implemented in terms of optparse.

So, I would suggest that we just copy the 'argparse' module into the
QEMU 'scripts/thirdparty' directory.

Then in any files which need argparse, you can do this

  try:
      import argparse
  except:
      import os, sys
      sys.path.append(os.path.join(os.path.dirname(__file__), "thirdparty"))
      import argparse

so that it tries to use the argparse provided by python, and falls back
to pulling in the one in our scripts/thirdparty directory.

When we finally bump our min python to 2.7, we can simply drop this
compat code for the import statement.  This avoids need for us to
re-write code to use a deprecated API, with a worse feature set.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
