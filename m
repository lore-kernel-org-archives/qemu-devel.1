Received: from eggs.gnu.org ([2001:4830:134:3::10]:50246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1chIuV-00033J-CD
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1chIuU-0000xq-Dx
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:39:59 -0500
Date: Fri, 24 Feb 2017 16:39:48 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170224163948.GG17452@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<87o9xr60dp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o9xr60dp.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Feb 24, 2017 at 05:04:34PM +0100, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> [...]
> > === Dotted keys ===
> >
> > One sufficiently powerful syntax extension already exists: the dotted
> > key convention.  It's syntactically unambiguous only when none of the
> > KEYs involved contains '.'  To adopt it across the board, we'd have to
> > outlaw '.' in KEYs.  QAPI outlaws '.' already,
> 
> *Except* in __RFQDN_ prefixes.
> 
> Say example.com needs to add a downstream extension to block driver
> "raw".  Following QAPI rules, they add to to struct BlockdevOptionsRaw a
> new optional member:
> 
>     '*__com.example_medium-rare': 'bool'
> 
> On the command line, this looks like
> 
>     -blockdev node-name=foo,driver=raw,__com.example_medium-rare=on,file.driver=file,file.filename=foo.img
> 
> Dotted keys parse this as a reference to member __com's member
> example_medium-rare.
> 
> Possible solutions:
> 
> (a) Outlaw domain names with '_'.  If KEY starts with "__", everything
>     up to the third '_' is an __RFQDN_ prefix.
> 
> (b) Outlaw '_' in the name part that follows __RFQDN_.  If KEY starts
>     with "__", everything up to the last '_' is an __RFQDN_ prefix.
> 
> (c) Your bright idea.

Define a new downstream vendor naming convention. IMHO it is reasonable
to argue that the downstream vendor extensions are outside the scope of
backwards compatibility guarantees we normally apply for our CLI args.

Thus, simply say that vendors must replace all '.' with _ in their
namespace prefix. eg They should use '__com_example_medium.rare=on'
which would mean a property '__com_example_medium' which is a struct
containing a property rare with value on


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
