Received: from eggs.gnu.org ([2001:4830:134:3::10]:54461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1exxyr-0008Th-ME
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1exxyo-00017z-2n
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:49:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1exxyn-00017l-TZ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:49:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8F1A4068046
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 16:49:45 +0000 (UTC)
Date: Mon, 19 Mar 2018 16:49:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180319164939.GA3151@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] https:// for GIT submodules / "smart" HTTP protocol on
 git.qemu.git
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>

Most of QEMU regular developers are fortunate to have unfiltered internet
access which allows using the git:// protocol. People working in more
old fashioned / paranoid environments often find access to anything other
than http(s) blocked by firewalls. They'll get a bad experiance when trying
to build QEMU, when we try to initialize the git submodules and git://
protocol fails to connect.

We could improve life for people behind such nasty firewalls if we made our
GIT submodules use https:// URIs, instead of git:// URIs. There is one snag.

Historically git:// URIs were strongly preferred over http(s):// URIs for
reasons for performance. Modern GIT though, supports both the traditional
"dumb" HTTP protocol (which is horribly slow) and a modern "smart" HTTP
protocol whose performance matches that of git:/// URIs.

Unfortunately it seems that git.qemu.org is not configured to enable the
smart HTTP protocol.

So can we get a todo item for git.qemu.org get the web server setup to
enable the smart GIT protocol, so we can then enable use of http:// by
default for all the submodules to improve life for contributors.

FYI, you can validate if a server supports the smart protocol or not
by querying  $REPO_URI/info/refs?service=git-upload-pack and seeing
if the response includes a header

   Content-Type: application/x-git-upload-pack-advertisement

qemu.org does not:

  $ wget -S  'https://git.qemu.org/git/qemu.git/info/refs?service=git-upload-pack' 2>&1 | grep Content-Type

and shows terrible git clone performance for http:// uris

but github for example does

  $ wget -S  'https://github.com/qemu/qemu.git/info/refs?service=git-upload-pack' 2>&1 | grep Content-Type
  Content-Type: application/x-git-upload-pack-advertisement

and shows great performance for http:// URIs

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
