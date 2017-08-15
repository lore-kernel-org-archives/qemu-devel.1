Received: from eggs.gnu.org ([2001:4830:134:3::10]:34785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZNk-0004qR-By
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZNg-0004Rc-8F
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:47:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhZNf-0004Qw-VR
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:47:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68862C04B31B
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 10:47:26 +0000 (UTC)
Date: Tue, 15 Aug 2017 18:47:22 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170815104722.GB14412@lemon>
References: <20170815093615.16453-1-berrange@redhat.com>
	<20170815093615.16453-2-berrange@redhat.com>
	<20170815100410.GH9674@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170815100410.GH9674@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 01/12] ui: add keycodemapdb repository
 as a GIT submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Tue, 08/15 11:04, Daniel P. Berrange wrote:
> On Tue, Aug 15, 2017 at 10:36:04AM +0100, Daniel P. Berrange wrote:
> > The https://gitlab.com/keycodemap/keycodemapdb/ repo contains a
> > data file mapping between all the different scancode/keycode/keysym
> > sets that are known, and a tool to auto-generate lookup tables for
> > different combinations.
> > 
> > It is used by GTK-VNC, SPICE-GTK and libvirt for mapping keys.
> > Using it in QEMU will let us replace many hand written lookup
> > tables with auto-generated tables from a master data source,
> > reducing bugs. Adding new QKeyCodes will now only require the
> > master table to be updated, all ~20 other tables will be
> > automatically updated to follow.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  .gitignore                    |  2 ++
> >  .gitmodules                   |  3 +++
> >  configure                     |  2 ++
> >  tests/docker/Makefile.include | 11 +++++++----
> >  tests/docker/run              |  4 +++-
> >  ui/Makefile.objs              | 18 ++++++++++++++++++
> >  ui/keycodemapdb               |  1 +
> >  7 files changed, 36 insertions(+), 5 deletions(-)
> >  create mode 160000 ui/keycodemapdb
> > 
> 
> > diff --git a/configure b/configure
> > index dd73cce62f..bd373ec2b4 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5258,6 +5258,8 @@ echo_version() {
> >      fi
> >  }
> >  
> > +(cd $source_path && git submodule update --init ui/keycodemapdb)
> > +
> 
> Urgh, no, this won't work because of course you don't have to
> have a git checkout when running configure.
> 
> Any suggestions on the "best" way to ensure that the ui/keycodemapdb
> git submodule is always checked out, without requiring developers to
> do something manually ?
> 
> I could try
> 
>   (cd $source_path && test -d .git && git submodule update --init ui/keycodemapdb)
> 
> but wonder if there's a better way ?

I think the way dtc handles this is okay: probe headers/libs, if failed, hint
the "git submodule update" command in the error message.  This is also a
familiar/friendly user interface to developers.

(If you looks at the test snippet that patchew runs, there is an explicit
submodule command:

    #!/bin/bash
    set -e
    git submodule update --init dtc
    # Let docker tests dump environment info
    export SHOW_ENV=1
    export J=8
    time make docker-test-quick@centos6
    time make docker-test-build@min-glib
    time make docker-test-mingw@fedora

as the libfdt devel package is not available in every docker images.)

Fam
