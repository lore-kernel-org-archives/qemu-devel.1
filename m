Received: from eggs.gnu.org ([2001:4830:134:3::10]:42865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReVa-0008RK-ON
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReVW-0005h5-NU
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:34:06 -0500
Date: Wed, 20 Dec 2017 14:33:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171220133354.GD6374@localhost.localdomain>
References: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
	<87ind4gxcb.fsf@dusky.pond.sub.org>
	<20171220104436.fzucmsombnpyxoke@eukaryote>
	<20171220105740.GQ21216@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220105740.GQ21216@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, pkrempa@redhat.com, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Am 20.12.2017 um 11:57 hat Daniel P. Berrange geschrieben:
> On Wed, Dec 20, 2017 at 11:44:36AM +0100, Kashyap Chamarthy wrote:
> > On Mon, Dec 18, 2017 at 11:11:00AM +0100, Markus Armbruster wrote:
> > > Max Reitz <mreitz@redhat.com> writes:
> > 
> > [...]
> > 
> > Thanks, Max, for the detailed notes.
> > 
> > > > Image creation in qemu-system-* vs. qemu-img:
> > > >   In order to get proper introspection for qemu-img create, we need a
> > > >   QAPI schema.  If we have a QAPI schema, we might as well add
> > > >   blockdev-create to QMP.
> > > >   As long as we do not have a really-none (null, void, ...) machine type
> > > >   for qemu-system-*, launching such a process just for creating an image
> > > >   will bring quite a bit of overhead (e.g. with -M none -accel qtest).
> > > >   However, as for libvirt, this is not exactly a regression since
> > > >   libvirt currently cannot create images at all (apart from implicitly
> > > >   through drive-mirror etc.).  Further work on voidifying qemu-system-*
> > > >   will improve performance.
> > > 
> > > Another thought: do we want to give qemu-system-* the necessary
> > > privileges for creating images?  Two cases: running with and without a
> > > guest.
> > 
> > Related: Just curious -- was it an explicit design decision to not give
> > `qemu-system-*` permissions to create disk images?
> 
> Our security model considers QEMU broadly untrustworthy, and so any resources
> it needs to use must either be passed in by libvirt, or have permissions
> explicitly assigned to permit usage by QEMU. QEMU is allowed to create tmp
> files, and create RAM files for memory backing, but in general we don't want
> to have QEMU able to create arbitrary files, only open things that are
> already created.

Which kind of suggests that libvirt should use an external qemu-img
process rather than a QMP command to create images?

Or would libvirt only create an empty file externally and then use QMP
to create some image format in it? In other words, it would only ever
use the QMP command to create formats like qcow2, but it would never use
it to create the file-posix layer?

Kevin
