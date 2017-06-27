Received: from eggs.gnu.org ([2001:4830:134:3::10]:41066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dPlbo-0001YA-Ql
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dPlbj-0001mS-KG
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:12:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dPlbj-0001mD-DN
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:12:23 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170625192950.17677-1-f4bug@amsat.org>
Date: Tue, 27 Jun 2017 10:12:16 +0200
In-Reply-To: <20170625192950.17677-1-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun,
	25 Jun 2017 16:29:46 -0300")
Message-ID: <87podpluhr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] travis: run all coccinelle scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Another item from my 'automated testing' list: use travis-ci to run cocci=
nelle
> scripts. This series is more of a PoC. The idea would be to run it once a=
 day
> only on /master.
>
> Patch 1 is here only to speedup travis testing.
>
> Patch 3 add a script which run each cocci script sequencially. If the scr=
ipt
> modified any file from the repo, changes are commited. If the script gene=
rated
> some output (i.e. using python), this output is logged in an empty commit.
> Spatch is run thru a debian-based Docker image.
>
> Patch 4 is the travis job: it calls the previous script. To respect travi=
s time
> limit timeout, each script is limited to <10min. If any commit were
> generated, they are pushed to my gh-repo:
>
> https://github.com/philmd/qemu/compare/travis-cocci_v1...philmd:autogener=
ated-coccinelle-20170625-126
>
> Build output (Ran for 23 min 7 sec):
> https://travis-ci.org/philmd/qemu/builds/246848085
>
> Any idea is welcome :)

Are we sure all the Coccinelle scripts always produce desirable and
correct results?  I often use Coccinelle to do the tedious 95% of the
job, followed by a bit of manual cleanup.  What if manual cleanup is
required to make things compile cleanly?  Say because the transformation
leaves unused variables behind.  What if the transformation is wanted in
19 out of 20 cases?  Say because it replaces a bulky expression by the
helper call created for this purpose (good), including in the helper
function (bad)?
