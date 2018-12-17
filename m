Received: from eggs.gnu.org ([2001:4830:134:3::10]:60434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gYxmh-0002me-OA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gYxmf-0002U1-UB
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:38:31 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gYxmf-0002SP-KU
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:38:29 -0500
Received: by mail-wr1-x441.google.com with SMTP id z5so13341087wrt.11
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 10:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20181213184340.24037-1-armbru@redhat.com>
	<20181213184340.24037-33-armbru@redhat.com>
	<fde45953-c713-daf7-f3ce-47d63b050f7a@redhat.com>
In-Reply-To: <fde45953-c713-daf7-f3ce-47d63b050f7a@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 17 Dec 2018 22:38:14 +0400
Message-ID: <CAJ+F1CLEDbur0x1H59U52F2kyKUhn55qJHPOBhcdeTvJdaSJLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 32/32] qapi: add conditions to REPLICATION
 type/commands on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Hi

On Mon, Dec 17, 2018 at 8:01 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 2018-12-13 19:43, Markus Armbruster wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Add #if defined(CONFIG_REPLICATION) in generated code, and adjust the
> > code accordingly.
> >
> > Made conditional:
> >
> > * xen-set-replication, query-xen-replication-status,
> >   xen-colo-do-checkpoint
> >
> >   Before the patch, we first register the commands unconditionally in
> >   generated code (requires a stub), then conditionally unregister in
> >   qmp_unregister_commands_hack().
> >
> >   Afterwards, we register only when CONFIG_REPLICATION.  The command
> >   fails exactly the same, with CommandNotFound.
> >
> >   Improvement, because now query-qmp-schema is accurate, and we're one
> >   step closer to killing qmp_unregister_commands_hack().
> >
> > * enum BlockdevDriver value "replication" in command blockdev-add
> >
> > * BlockdevOptions variant @replication
> >
> > and related structures.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Message-Id: <20181213123724.4866-23-marcandre.lureau@redhat.com>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  migration/colo.c     | 16 ++++------------
> >  monitor.c            |  5 -----
> >  qapi/block-core.json | 13 +++++++++----
> >  qapi/migration.json  | 12 ++++++++----
> >  4 files changed, 21 insertions(+), 25 deletions(-)
>
> I think this might have broken compilation with --disable-replication:
>
>  https://gitlab.com/huth/qemu/-/jobs/135648240
>
> Any ideas how to fix it?

We introduced a regression by dropping osdep.h include from headers.

To me, it's best to include osdep.h in headers, since the ifdef exist
there. But I have been told we include it in .c instead. I'll upstream
the qapi/scripts to include it.

thanks for the report, sorry for the regression


--=20
Marc-Andr=C3=A9 Lureau
