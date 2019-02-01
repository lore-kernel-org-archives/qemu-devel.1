Received: from eggs.gnu.org ([209.51.188.92]:51784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gpSJ2-0007fo-36
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 01:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gpSJ1-0007PU-A5
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 01:28:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gpSIz-0007L2-BT
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 01:28:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA8774947D
	for <qemu-devel@nongnu.org>; Fri,  1 Feb 2019 06:27:57 +0000 (UTC)
Date: Fri, 1 Feb 2019 07:27:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190201062752.h7zud3bqd7zhho4q@sirius.home.kraxel.org>
References: <20190131130016.17337-1-kraxel@redhat.com>
	<b7995d51-0486-728e-05d9-7606064824c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7995d51-0486-728e-05d9-7606064824c1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] scripts: use git archive in
 archive-source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com

  Hi,

> >  tar_file=$(realpath "$1")
> > -list_file="${tar_file}.list"
> > -vroot_dir="${tar_file}.vroot"
> > +sub_file=$(mktemp "${tar_file%.tar}.sub.XXXXXXXX.tar")
> > +sub_tdir=$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")
> 
> mktemp is not specified by POSIX; and FreeBSD man pages for mktemp
> suggest that if you don't use XXXXXX as the suffix that you are not
> guaranteed correct behavior.  Are you sure this is portable enough?  Do
> you need both a temp file and dir, or can you create the file name of
> your choice inside a temp dir, where only the dir has to have a
> randomized name?

Yes, storing temp tar in the temp dir should work.

> > +	status="$(git submodule status "$sm")"
> > +	smhash="${status# }"
> > +	smhash="${smhash#+}"
> > +	smhash="${smhash#-}"
> 
> These three lines can be consolidated into one:
> smhash=${status#[ +-]}

Ah, cool.  Learned a new trick.

> > +		smdir="$sub_tdir/$sm"
> > +		smurl="$(git config -f .gitmodules submodule.${sm}.url)"
> > +		echo "NOTICE: using temporary clone for submodule $sm"
> > +		git clone "$smurl" "$smdir"
> > +		test $? -ne 0 && error "failed to clone submodule $sm"
> 
> I know we don't want to affect the developer's normal checkout, but is
> it worth storing the temporary clone in a specifically-named
> subdirectory of their checkout instead

Hmm, we could do "git submodule init + git archive + git submodule
deinit".  With git storing a bare repo in .git/modules/$submodule these
days (and not deleting it on deinit) that'll effectively cache things.
It's a (temporary) modification of the checkout though.

Alternatively we could clone to $HOME/.cache/$somewhere, similar to the
vm tests which store downloads (and soon vm images too) below
$HOME/.cache/qemu-vm/.

cheers,
  Gerd
