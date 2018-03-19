Received: from eggs.gnu.org ([2001:4830:134:3::10]:57590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ey0Az-0002P9-7Z
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ey0Aw-0000we-2X
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:10:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1ey0Av-0000w0-SD
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:10:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5490E4015A53
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 19:10:29 +0000 (UTC)
Date: Mon, 19 Mar 2018 15:10:28 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180319191028.GL12302@localhost.localdomain>
References: <20180319164939.GA3151@redhat.com>
	<20180319182816.GA18216@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180319182816.GA18216@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Mar 19, 2018 at 06:28:16PM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Mar 19, 2018 at 04:49:39PM +0000, Daniel P. Berrang=E9 wrote:
> > Most of QEMU regular developers are fortunate to have unfiltered inte=
rnet
> > access which allows using the git:// protocol. People working in more
> > old fashioned / paranoid environments often find access to anything o=
ther
> > than http(s) blocked by firewalls. They'll get a bad experiance when =
trying
> > to build QEMU, when we try to initialize the git submodules and git:/=
/
> > protocol fails to connect.
> >=20
> > We could improve life for people behind such nasty firewalls if we ma=
de our
> > GIT submodules use https:// URIs, instead of git:// URIs. There is on=
e snag.
> >=20
> > Historically git:// URIs were strongly preferred over http(s):// URIs=
 for
> > reasons for performance. Modern GIT though, supports both the traditi=
onal
> > "dumb" HTTP protocol (which is horribly slow) and a modern "smart" HT=
TP
> > protocol whose performance matches that of git:/// URIs.
> >=20
> > Unfortunately it seems that git.qemu.org is not configured to enable =
the
> > smart HTTP protocol.
> >=20
> > So can we get a todo item for git.qemu.org get the web server setup t=
o
> > enable the smart GIT protocol, so we can then enable use of http:// b=
y
> > default for all the submodules to improve life for contributors.
>=20
> FYI this doesn't seem to take much more than adding this to Apache
> config:
>=20
>   SetEnv GIT_PROJECT_ROOT /path/to/git/projects/root
>=20
>   <Directory /usr/libexec/git-core>
>    Require all granted
>   </Directory>
>=20
>   ScriptAliasMatch "^/git/(.*\.git/(HEAD|info/refs))$" \
>     /usr/libexec/git-core/git-http-backend/$1
>   ScriptAliasMatch "^/git/(.*\.git/git-(upload|receive)-pack)$" \
>     /usr/libexec/git-core/git-http-backend/$1
>=20
>=20
> And then touching the file 'git-daemon-export-ok' in each git repo
> that is intended to be public.
>=20
>   https://git.seveas.net/apache-gitweb-cgit-smart-http.html
>=20

Daniel,

This is a good idea.  I'll look into implementing it (I'll wait until a t=
ime
of day that is relatively low-traffic).

-Jeff
