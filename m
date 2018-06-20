Received: from eggs.gnu.org ([2001:4830:134:3::10]:54250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVbJ5-0006or-GF
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVbJ2-0002cB-Cd
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:29:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fVbJ2-0002bg-7B
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:29:44 -0400
Date: Wed, 20 Jun 2018 12:29:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180620112938.GK2549@work-vm>
References: <20180620103555.1342-1-berrange@redhat.com>
	<20180620103555.1342-10-berrange@redhat.com>
	<20180620105800.GI2549@work-vm> <20180620111107.GJ3441@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180620111107.GJ3441@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/11] authz: add QAuthZListFile object
 type for a file access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Wed, Jun 20, 2018 at 11:58:01AM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > Add a QAuthZListFile object type that implements the QAuthZ interfa=
ce. This
> > > built-in implementation is a proxy around the QAtuhZList object typ=
e,
> > > initializing it from an external file, and optionally, automaticall=
y
> > > reloading it whenever it changes.
> > >=20
> > > To create an instance of this object via the QMP monitor, the synta=
x
> > > used would be:
> > >=20
> > >       {
> > >         "execute": "object-add",
> > >         "arguments": {
> > >           "qom-type": "authz-list-file",
> > >           "id": "authz0",
> > >           "parameters": {
> > >             "filename": "/etc/qemu/vnc.acl",
> > > 	    "refresh": "yes"
> > >           }
> > >         }
> > >       }
> > >=20
> > > If "refresh" is "yes", inotify is used to monitor the file,
> > > automatically reloading changes. If an error occurs during reloadin=
g,
> > > all authorizations will fail until the file is next successfully
> > > loaded.
> >=20
> > I'm curious about the 'refresh' stuff:
> >   a) If refresh=3Dno is there a way to explicitly ask for a refresh
> >      when some tool knows it's finished with fiddling with the file.
>=20
> If refresh=3Dno, then you can still use  object_del + object_add to
> recreate the ACL object which will cause new content to be picked
> up.

But if I have a VNC/NBD/etc listening, won't it be bound to the old
object, so I can't delete the old object?

> >   b) am I right in thinking you're actually monitoring the directory
> >      for changes and retriggering on directory changes?  So it'll
> >      trigger on the normal trick of renaming the modified file over t=
he
> >      original?
>=20
> I originally made the mistake of trying to monitor the file
> and discovered the awfulness of inotify :-(
>=20
> So, yeah, now we monitor the directory so we can trigger
> reloads even when the file is editted by doing a tmpfile+rename
> dance.
>=20
> The inotify support in the early patch in this series is intelligent
> so that if multiple objects all monitor the same directory we only
> use a single inotify watch.
>=20
> >   c) I'm a little concerned about making it automatic; if all the qem=
us
> >      on a  system all wake up and reparse the file at the same time.
>=20
> I don't think its a big deal in this case because the files in
> question are very small. Once one QEMU reads it, the kernel will
> have content in I/O cache, and the CPU overhead of parsing the JSON
> will be lost in the noise given likely file sizes IMHO.

OK.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
