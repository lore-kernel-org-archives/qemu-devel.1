Received: from eggs.gnu.org ([2001:4830:134:3::10]:48826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1exzWR-0000eL-G6
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1exzWN-0003ZU-Ms
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:28:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1exzWN-0003ZH-HN
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:28:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C625C8E684
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 18:28:23 +0000 (UTC)
Date: Mon, 19 Mar 2018 18:28:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180319182816.GA18216@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180319164939.GA3151@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180319164939.GA3151@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] https:// for GIT submodules / "smart" HTTP
 protocol on git.qemu.git
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

On Mon, Mar 19, 2018 at 04:49:39PM +0000, Daniel P. Berrang=C3=A9 wrote:
> Most of QEMU regular developers are fortunate to have unfiltered intern=
et
> access which allows using the git:// protocol. People working in more
> old fashioned / paranoid environments often find access to anything oth=
er
> than http(s) blocked by firewalls. They'll get a bad experiance when tr=
ying
> to build QEMU, when we try to initialize the git submodules and git://
> protocol fails to connect.
>=20
> We could improve life for people behind such nasty firewalls if we made=
 our
> GIT submodules use https:// URIs, instead of git:// URIs. There is one =
snag.
>=20
> Historically git:// URIs were strongly preferred over http(s):// URIs f=
or
> reasons for performance. Modern GIT though, supports both the tradition=
al
> "dumb" HTTP protocol (which is horribly slow) and a modern "smart" HTTP
> protocol whose performance matches that of git:/// URIs.
>=20
> Unfortunately it seems that git.qemu.org is not configured to enable th=
e
> smart HTTP protocol.
>=20
> So can we get a todo item for git.qemu.org get the web server setup to
> enable the smart GIT protocol, so we can then enable use of http:// by
> default for all the submodules to improve life for contributors.

FYI this doesn't seem to take much more than adding this to Apache
config:

  SetEnv GIT_PROJECT_ROOT /path/to/git/projects/root

  <Directory /usr/libexec/git-core>
   Require all granted
  </Directory>

  ScriptAliasMatch "^/git/(.*\.git/(HEAD|info/refs))$" \
    /usr/libexec/git-core/git-http-backend/$1
  ScriptAliasMatch "^/git/(.*\.git/git-(upload|receive)-pack)$" \
    /usr/libexec/git-core/git-http-backend/$1


And then touching the file 'git-daemon-export-ok' in each git repo
that is intended to be public.

  https://git.seveas.net/apache-gitweb-cgit-smart-http.html

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
