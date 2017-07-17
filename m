Received: from eggs.gnu.org ([2001:4830:134:3::10]:35998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX39F-0004qf-4S
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX39A-0000kQ-VU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:21:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dX39A-0000kC-Mj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:21:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1AFA85540
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:20:59 +0000 (UTC)
Date: Mon, 17 Jul 2017 11:20:53 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170717102053.GH3640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717063521.GA7393@lemon>
	<b718f71c-5208-298a-4fb9-0c2fea3146ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b718f71c-5208-298a-4fb9-0c2fea3146ec@redhat.com>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On Mon, Jul 17, 2017 at 11:41:38AM +0200, Thomas Huth wrote:
> On 17.07.2017 08:35, Fam Zheng wrote:
> > Hi all,
> > 
> > Today I've included a fourth type of the automatic patchew replies: FreeBSD.
> > 
> > So far we have these tests running by patchew on each patch series:
> > 
> >   * Docker tests
> >     Basically it is
> >         make docker-test-quick@centos6 \
> >              docker-test-build@min-glib \
> >              docker-test-mingw@fedora"
> > 
> >   * checkpatch.pl
> >     Each patch is fed to ./scripts/checkpatch.pl and all errors are reported.
> > 
> >   * s390x
> >     It runs on a machine shared by Fedora team, basically only "./configure and
> >     make", because "make check" hanging is tricky to deal with from an
> >     automation perspective. (Ideas?)
> 
> Is there any check that could hang "forever"? I think most of the checks
> should have a proper timeout of one or two minutes, don't they?
> 
> Maybe you could also simply run the "make check" with the "timeout"
> command to avoid that it hangs forever?
> 
> >   * FreeBSD
> >     Like s390x.
> > 
> > Q1: In the worst case, you get four individual auto replies from patchew. Is
> > that too many? Do you prefer one reply with all the results concatenated into
> > one?
> 
> One result would be nicer, I think.
> 
> > Q2: Some think the full log in the mail body is more than necessary. Is it
> > better or worse if it is a "tail -n 200" of the log in the body and the full log
> > attached?
> > 
> > Q3: What other tests do maintainers want? Different hosts? Different configure
> > combinations?
> 
> Not sure, but should we maybe also check compiling with the configure
> switches set to non-default values? E.g. --enable-debug --disable-slirp
> --enable-tcg-interpreter --disable-tcg etc. ?

I'm a little concerned about the fact that we've now got three different
sets of tests that are being run on pull requests. There are the tests
that Peter runs on various combinations at time of merge, the tests run 
by patchw at time of submissions, and the tests run by travis after
merge. Each of them is covering a different set of scenarios with only
partial overlap between them.

As a maintainer sending pull requests, I want to try to run all relevant
tests before sending a PR, to minimize chance of it being rejected. It
is hard to come up with a workflow that maximises my coverage across all
three test systems that are run.

I mostly trigger running of the travis tests by pushing to a github banch 
in my qemu clone, but that misses coverage of things done by patchw and by
Peter, sometimes requiring many re-submissions of a PR before all three 
test processes pass. I find this is quite frustrating & a time sink for
everyone involved.

My ideal view of the world would be a single testing system which we
feed with jobs from different places. eg patchw can feed it mail submissions,
Peter can feed it candidate merges before pushing to master, something can
feed it git master after push, and/or periodically, and contributors can
feed it personal branches. IOW, no matter who/what triggers the tests, we
always run the exact same set of tests.  BUilding and maintaining such a
system is hard work, potentially expensive (in terms of hardware required),
and an ongoing full time job for at least one person, ideally more. So I
realize I'm asking for magical dancing ponies here, but it is nice to be 
able to dream.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
