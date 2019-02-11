Received: from eggs.gnu.org ([209.51.188.92]:48844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtEds-0000nc-PZ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtEdn-0000oC-Vp
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:41:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gtEQJ-0008GS-Pc
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:27:12 -0500
Date: Mon, 11 Feb 2019 16:20:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190211162002.GH27585@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190131202637.4062-1-jusual@mail.ru>
	<d21f68cf-31fa-db62-1d20-66f75e5a05b4@redhat.com>
	<20190211155106.GF27585@redhat.com>
	<f45e14e3-5866-b2fa-9ed8-aa7d8e33d478@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f45e14e3-5866-b2fa-9ed8-aa7d8e33d478@mail.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: Add whitelist support for QMP
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Jim Mussared <jim@groklearning.com>, Steffen =?utf-8?B?R8O2cnR6?= <contrib@steffen-goertz.de>, Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Feb 11, 2019 at 07:15:58PM +0300, Julia Suvorova wrote:
>=20
>=20
> On 11.02.2019 18:51, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Jan 31, 2019 at 03:03:21PM -0600, Eric Blake wrote:
> > > On 1/31/19 2:26 PM, Julia Suvorova via Qemu-devel wrote:
> > > > The whitelist option allows to run a reduced monitor with a subse=
t of
> > > > QMP commands. This allows the monitor to run in secure mode, whic=
h is
> > > > convenient for sending commands via the WebSocket monitor using t=
he
> > > > web UI. This is planned to be done on micro:bit board.
> > > >=20
> > > > The list of allowed commands should be written to a file, one per=
 line.
> > > > The command line will look like this:
> > > >      -mon chardev_name,mode=3Dcontrol,whitelist=3Dpath_to_file
> > > >=20
> > > > Signed-off-by: Julia Suvorova <jusual@mail.ru>
> > > > ---
> > >=20
> > > > -void monitor_init(Chardev *chr, int flags)
> > > > +static void process_whitelist_file(Monitor *mon, const char *whi=
telist_file)
> > > > +{
> > > > +    char cmd_name[256];
> > > > +    FILE *fd =3D fopen(whitelist_file, "r");
> > >=20
> > > If you use qemu_open() here (followed by fdopen if you still prefer
> > > fscanf over read), then you can support "/dev/fdset/NNN" to
> > > auto-magically support someone passing in the whitelist via an inhe=
rited
> > > file descriptor, rather than having to be somewhere on disk that qe=
mu
> > > can directly open().
> > >=20
> > > > +
> > > > +    if (fd =3D=3D NULL) {
> > > > +        error_report("Could not open whitelist file: %s", strerr=
or(errno));
> > > > +        exit(1);
> > > > +    }
> > > > +
> > > > +    mon->whitelist =3D g_hash_table_new_full(g_str_hash,
> > > > +                                           g_str_equal,
> > > > +                                           g_free,
> > > > +                                           NULL);
> > > > +
> > > > +    g_hash_table_add(mon->whitelist, g_strdup("qmp_capabilities"=
));
> > > > +    g_hash_table_add(mon->whitelist, g_strdup("query-commands"))=
;
> > > > +
> > > > +    while (fscanf(fd, "%255s", cmd_name) =3D=3D 1) {
> > >=20
> > > %255s fits your cmd_name array declaration and stops consuming at e=
ither
> > > 255 bytes or at the first whitespace encountered, but where do you =
check
> > > for overflow from a file that passes more than 255 non-whitespace b=
ytes
> > > without a newline?  Also, this is a bit sloppy in that it skips all
> > > leading whitespace, rather than ensuring that the user actually pas=
sed
> > > newline-separated command names.  Does glib provide any interfaces =
for
> > > more easily reading in an array of lines from a file?
> >=20
> > With glib, normally you'd use:
> >=20
> >    char *content;
> >    gsize len;
> >    GError *err =3D NULL;
> >    char **lines;
> >=20
> >    g_file_get_contents(filename, &contnet, &len, &err)
>=20
> With g_file_get_contents() I won't be able to do qemu_open() and suppor=
t
> "/dev/fdset/NNN". The workaround seems to me unnecessarily complex.

Yes, its a question of whether the /dev/fdset/NNN feature is needed or
not. At the very least though you should be using getline() rather than
fscanf so that we don't have a large hardcoded buffer on the stack.

>=20
> >    lines =3D g_str_split(content, "\n", 0);
> >=20
> >    g_free(content);
> >=20
> >    ...do something with lines
> >=20
> >    g_strfreev(lines);
> >=20
> >=20
> > The GIO library provides higher level functions for I/O but we don't
> > use that in QEMU

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
