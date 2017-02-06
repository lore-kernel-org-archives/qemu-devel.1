Received: from eggs.gnu.org ([2001:4830:134:3::10]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cahAI-0005fN-V7
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cahAI-0004BS-0f
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:08:58 -0500
Date: Mon, 6 Feb 2017 11:08:47 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170206110847.GH3029@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org> <20170204122150.GA15362@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170204122150.GA15362@lemon>
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Sat, Feb 04, 2017 at 08:21:50PM +0800, Fam Zheng wrote:
> On Thu, 02/02 20:42, Markus Armbruster wrote:
> > === Comparison ===
> > 
> > In my opinion, dotted keys are weird and ugly, but at least they don't
> > add to the quoting mess.  Structured values look better, except when
> > they do add to the quoting mess.
> > 
> > I'm having a hard time deciding which one I like less :)
> > 
> > Opinions?  Other ideas?
> 
> Here's my poor attempt:
> 
> The dotted syntax, as the simpler of two, can cover everyday use very well.  If
> we introduce an "@reference" extension to it which can help the expresiveness,
> we can have a hybrid solution. It's not the cleanest interface and syntax, but
> escaping, nesting and quoting can all be divide-and-conqured in their optimal way.
> What I'm imagining is something like:
> 
>     -json "id=children0,text=[
>                 { 'driver': 'null-co://' },
>                 { 'driver': 'null-co://' },
>                 { 'driver': 'null-co://' }
>             ]" \
>     -dot \
>       id=quorum0,driver=quorum,read-pattern=fifo,vote-threshold=1,children=@children0 \
>     -drive if=virtio,id=primary-disk0,driver=qcow2,file=@quorum0
> 
> IOW "-json" and "-dot" define options that is intended to be referenced from
> other dotted keys (quorum0 uses children0, and in turn primary-disk0 uses
> quorum0).
> 
> Note: "-dot" here could be replaced with a -blockdev in this specific case but
> I'm demostrating it just in case it is useful generically.

I'd be pretty wary of inventing this kind of magic. Having references
might sound neat, but I think this is pretty alien from POV of the code
generating such CLIs in libvirt. I think we'd sooner just use pure json
for everything than support such a feature in libvirt.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
