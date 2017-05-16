Received: from eggs.gnu.org ([2001:4830:134:3::10]:50140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAaIK-0006y3-3W
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAaIH-0000zU-EN
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAaIH-0000zI-5E
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:05:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170515134753.28412-1-stefanha@redhat.com>
	<87a86erypz.fsf@linaro.org>
	<20170516104556.GD27093@stefanha-x1.localdomain>
Date: Tue, 16 May 2017 13:05:23 +0200
In-Reply-To: <20170516104556.GD27093@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Tue, 16 May 2017 11:45:56 +0100")
Message-ID: <87o9ut6ozw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .gdbinit: load QEMU sub-commands when gdb
 starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Mon, May 15, 2017 at 03:17:28PM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>=20
>> > The scripts/qemu-gdb.py file is not easily discoverable.  Add a .gdbin=
it
>> > file so GDB either loads qemu-gdb.py automatically or prints a message
>> > informing the user how to enable them (some systems disable ./.gdbinit
>> > loading for security reasons).
>> >
>> > Suggested-by: Eric Blake <eblake@redhat.com>
>> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > ---
>> >  .gdbinit | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >  create mode 100644 .gdbinit
>> >
>> > diff --git a/.gdbinit b/.gdbinit
>> > new file mode 100644
>> > index 0000000..9d322fc
>> > --- /dev/null
>> > +++ b/.gdbinit
>> > @@ -0,0 +1,8 @@
>> > +# GDB may have ./.gdbinit loading disabled by default.  In that case =
you can
>> > +# follow the instructions it prints.  They boil down to adding the fo=
llowing to
>> > +# your home directory's ~/.gdbinit file:
>> > +#
>> > +#   add-auto-load-safe-path /path/to/qemu/.gdbinit
>> > +
>> > +# Load QEMU-specific sub-commands and settings
>> > +source scripts/qemu-gdb.py
>>=20
>> While this works well enough you might as well just comment the helper
>> script itself.
>
> People don't know scripts/qemu-gdb.py exists so adding a comment there
> doesn't help.
>
>> Would this script take precedence over a users ~/.gdbinit?
>
> All gdbinit files are loaded.  The order in which they are loaded is:
>
> 1. System-wide
> 2. Home directory
> 3. Current directory
>
> https://sourceware.org/gdb/onlinedocs/gdb/Startup.html#Startup
>
>> How would it work for out-of-tree builds?
>
> ./.gdbinit assumes your current working directory is the root of the
> QEMU source tree.  If gdb is launched outside this directory then
> nothing will happen (e.g. from arm-softmmu/ or from an out-of-tree
> build).
>
> I'm not sure if there is a simple way of making ./.gdbinit work from
> out-of-tree build directories.

Worth a try: ln -s $(SRC_PATH)/.gdbinit

If it works, we could have make create the link automatically.

[...]
