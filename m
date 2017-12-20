Received: from eggs.gnu.org ([2001:4830:134:3::10]:52064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRebn-00052q-AA
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRebm-0008D8-1g
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:40:31 -0500
Date: Wed, 20 Dec 2017 13:40:18 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171220134018.GT21216@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
	<87ind4gxcb.fsf@dusky.pond.sub.org>
	<20171220104436.fzucmsombnpyxoke@eukaryote>
	<20171220105740.GQ21216@redhat.com>
	<20171220133354.GD6374@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171220133354.GD6374@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] Raw notes from a small block
 layer/QAPI/something pre-christmas meeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, pkrempa@redhat.com, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, Dec 20, 2017 at 02:33:54PM +0100, Kevin Wolf wrote:
> Am 20.12.2017 um 11:57 hat Daniel P. Berrange geschrieben:
> > On Wed, Dec 20, 2017 at 11:44:36AM +0100, Kashyap Chamarthy wrote:
> > > On Mon, Dec 18, 2017 at 11:11:00AM +0100, Markus Armbruster wrote:
> > > > Max Reitz <mreitz@redhat.com> writes:
> > > 
> > > [...]
> > > 
> > > Thanks, Max, for the detailed notes.
> > > 
> > > > > Image creation in qemu-system-* vs. qemu-img:
> > > > >   In order to get proper introspection for qemu-img create, we need a
> > > > >   QAPI schema.  If we have a QAPI schema, we might as well add
> > > > >   blockdev-create to QMP.
> > > > >   As long as we do not have a really-none (null, void, ...) machine type
> > > > >   for qemu-system-*, launching such a process just for creating an image
> > > > >   will bring quite a bit of overhead (e.g. with -M none -accel qtest).
> > > > >   However, as for libvirt, this is not exactly a regression since
> > > > >   libvirt currently cannot create images at all (apart from implicitly
> > > > >   through drive-mirror etc.).  Further work on voidifying qemu-system-*
> > > > >   will improve performance.
> > > > 
> > > > Another thought: do we want to give qemu-system-* the necessary
> > > > privileges for creating images?  Two cases: running with and without a
> > > > guest.
> > > 
> > > Related: Just curious -- was it an explicit design decision to not give
> > > `qemu-system-*` permissions to create disk images?
> > 
> > Our security model considers QEMU broadly untrustworthy, and so any resources
> > it needs to use must either be passed in by libvirt, or have permissions
> > explicitly assigned to permit usage by QEMU. QEMU is allowed to create tmp
> > files, and create RAM files for memory backing, but in general we don't want
> > to have QEMU able to create arbitrary files, only open things that are
> > already created.
> 
> Which kind of suggests that libvirt should use an external qemu-img
> process rather than a QMP command to create images?

That is my gut feeling, though Peter K might have other opinions as the
person doing most libvirt work in this area.

> Or would libvirt only create an empty file externally and then use QMP
> to create some image format in it? In other words, it would only ever
> use the QMP command to create formats like qcow2, but it would never use
> it to create the file-posix layer?

The complexity with creating an empty file externally, and then writing
the image format into it is figuring out the right size to use for the
empty "file".

We could just create an empty file and let it grow-on-demand but this
only works for things which really are file backed.

The problem still exists for qcow2-over-LVM or  LUKS-over-iSCSI, etc,
where there's no way for QEMU to ever create the underlying LVM or
iSCSI volume. Indeed libvirt probably can't create them either - the
higher level mgmt app (OpenSTack/OVirt) would have to. I guess this
is where the work Stefan did for a "measure" command would come into
play perhaps.

I'm inclined to say though that if libvirt has to create the base layer
externally with qemu-img, we might as well just crete the entire thing
externally. I'm not seeing the obvious benefit to creating the file
with qemu-img, and formatting it with a QMP command.

I think where QMP becomes interesting / useful, over qemu-img is when
populating the file with data (eg a qemu-img convert equiv), since we
can get proper API for progress monitoring & cancelling via block jobs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
