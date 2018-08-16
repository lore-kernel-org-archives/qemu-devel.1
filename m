Received: from eggs.gnu.org ([2001:4830:134:3::10]:53930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqBxF-0006fe-28
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 02:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqBx4-0005oh-CU
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 02:40:15 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180725151011.25951-1-armbru@redhat.com>
	<5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
	<20180725160144.GJ12855@redhat.com>
	<20180728043238.GC1325070@localhost.localdomain>
	<371fc437-1330-6873-7f6d-99af8d56c5df@redhat.com>
	<87ftzgnj4z.fsf@dusky.pond.sub.org>
	<8b037e11-87bf-9258-2615-ae17e34ab353@redhat.com>
Date: Thu, 16 Aug 2018 08:40:02 +0200
In-Reply-To: <8b037e11-87bf-9258-2615-ae17e34ab353@redhat.com> (Max Reitz's
	message of "Thu, 16 Aug 2018 01:55:36 +0200")
Message-ID: <87zhxmerwd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON
 and back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> On 2018-08-15 10:12, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>
> [...]
>
>>> To me personally the issue is that if you can specify a plain filename,
>>> bdrv_refresh_filename() should give you that plain filename back.  So
>>> rbd's implementation of that is lacking.  Well, it just doesn't exist.
>> 
>> I'm not even sure I understand what you're talking about.
>
> We have this bdrv_refresh_filename() thing which can do this:
>
> $ qemu-img info \
>     "json:{'driver':'raw',
>            'file':{'driver':'nbd','host':'localhost'}}"
> image: nbd://localhost:10809
> [...]
>
> So it can reconstruct a plain filename even if you specify it as options
> instead of just using a plain filename.
>
>
> Now here's my fault: I thought it might be necessary for a driver to
> implement that function (which rbd doesn't) so that you'd get a nice
> filename back (instead of just json:{} garbled things).   But you don't.
>  For protocol drivers, you'll just get the initial filename back.  (So
> my comment was just wrong.)
>
> So what I was thinking about was some case where you specified a normal
> plain filename and qemu would give you back json:{}.  (If rbd
> implemented bdrv_refresh_filename(), that wouldn't happen, because it
> would reconstruct a nice normal filename.)  It turns out, I don't think
> that can happen so easily.  You'll just get your filename back.
>
> Because here's what I'm thinking: If someone uses an option that is
> undocumented and starts with =, well, too bad.  If someone uses a normal
> filename, but gets back a json:{} filename...  Then they are free to use
> that anywhere, and their use of "=" is legitimized.
>
>
> Now that issue kind of reappears when you open an RBD volume, and then
> e.g. take a blockdev-snapshot.  Then your overlay has an overridden
> backing file (one that may be different from what its image header says)
> and its filename may well become a json:{} one (to arrange for the
> overridden backing file options).  Of course, if you opened the RBD
> volume with a filename with some of the options warranting
> =keyvalue-pairs, then your json:{} filename will contain those options
> under =keyvalue-pairs.
>
> So...  I'm not quite sure what I want to say?  I think there are edge
> cases where the user may not have put any weird option into qemu, but
> they do get a json:{} filename with =keyvalue-pairs out of it.  And I
> think users are free to use json:{} filenames qemu spews at them, and we
> can't blame them for it.

Makes sense.

More reason to deprecate key-value pairs in pseudo-filenames.

The only alternative would be to also provide them in QAPI
BlockdevOptionsRbd.  I find that as distasteful as ever, but if the
block maintainers decide we need it, I'll hold my nose.

>>>> If so, and we are comfortable changing the output the way this patch does
>>>> (technically altering ABI anyway), we might as well go all the way and
>>>> filter it out completely.  That would be preferable to cleaning up the json
>>>> output of the internal key/value pairs, IMO.
>>>
>>> Well, this filtering at least is done by my "Fix some filename
>>> generation issues" series.
>> 
>> Likewise.
>
> The series overhauls quite a bit of the bdrv_refresh_filename()
> infrastructure.  That function is also responsible for generating
> json:{} filenames.
>
> One thing it introduces is a BlockDriver field where a driver can
> specify which of the runtime options are actually important.  The rest
> is omitted from the generated json:{} filename.
>
> I may have taken the liberty not to include =keyvalue-pairs in RBD's
> "strong runtime options" list.

I see.

Permit me to digress a bit.

I understand one application for generating a json: filename is for
putting it into an image file header (say as a COW's backing image).

Having image file headers point to other images is not as simple as it
may look at first glance.  The basic case of image format plus plain
filename (not containing '/') is straightforward enough.  But if I make
the filename absolute (with a leading '/'), the image becomes less easy
to move to another machine.

Similarly, certain Ceph configuration bits may make no sense on another
machine, and putting them into an image file header may not be a good
idea.

Rather vague, I'm afraid.
