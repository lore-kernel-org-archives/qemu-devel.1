Received: from eggs.gnu.org ([2001:4830:134:3::10]:55029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cZzLt-0002Zx-4O
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cZzLs-0005tn-8Z
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:22:01 -0500
Date: Sat, 4 Feb 2017 20:21:50 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170204122150.GA15362@lemon>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org

On Thu, 02/02 20:42, Markus Armbruster wrote:
> === Comparison ===
> 
> In my opinion, dotted keys are weird and ugly, but at least they don't
> add to the quoting mess.  Structured values look better, except when
> they do add to the quoting mess.
> 
> I'm having a hard time deciding which one I like less :)
> 
> Opinions?  Other ideas?

Here's my poor attempt:

The dotted syntax, as the simpler of two, can cover everyday use very well.  If
we introduce an "@reference" extension to it which can help the expresiveness,
we can have a hybrid solution. It's not the cleanest interface and syntax, but
escaping, nesting and quoting can all be divide-and-conqured in their optimal way.
What I'm imagining is something like:

    -json "id=children0,text=[
                { 'driver': 'null-co://' },
                { 'driver': 'null-co://' },
                { 'driver': 'null-co://' }
            ]" \
    -dot \
      id=quorum0,driver=quorum,read-pattern=fifo,vote-threshold=1,children=@children0 \
    -drive if=virtio,id=primary-disk0,driver=qcow2,file=@quorum0

IOW "-json" and "-dot" define options that is intended to be referenced from
other dotted keys (quorum0 uses children0, and in turn primary-disk0 uses
quorum0).

Note: "-dot" here could be replaced with a -blockdev in this specific case but
I'm demostrating it just in case it is useful generically.

Fam
