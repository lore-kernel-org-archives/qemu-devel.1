Received: from eggs.gnu.org ([2001:4830:134:3::10]:39151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cj0sx-00038O-GH
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cj0sw-0002hF-9B
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:49:27 -0500
Date: Wed, 1 Mar 2017 10:49:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170301094917.GA4799@noname.redhat.com>
References: <20170301081504.23595-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170301081504.23595-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] block: Tolerate existing writers on
 read only BdrvChild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 01.03.2017 um 09:15 hat Fam Zheng geschrieben:
> In an ideal world, read-write access to an image is inherently
> exclusive, because we cannot guarantee other readers and writers a
> consistency view of the whole image at all point. That's what the
> current permission system does, and it is okay as long as it is entirely
> internal. But that would change with the coming image locking. In
> practice, both end users and our test cases use tools like qemu-img and
> qemu-io to peek at images while guest is running.
> 
> Relax a bit and accept other writers in this case.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Hm. On the one hand I think you're right that people are using things
like this, on other hand it's also true that the result might not be
consistent and therefore image locking is right about forbidding these
actions.

I think your patch is too permissive, it allows even launching a second
long-running VM on the image, which will definitely see corrupted data
sooner or later.

Maybe what we can do is allow shared writers for read-only images if
CONSISTENT_READ isn't requested. It's still not 100% correct because we
can get inconsistent metadata and cause unexpected failure, but this is
probably tolerable. We would then have to change the allowed actions to
not request this permission.

In qemu-img, we have these read-only users:

* qemu-img check (without -r): Let's keep this blocked, it will only
  report lots of leaks and leads to invalid bug reports. I've had my
  share of them.

* qemu-img compare: Not sure if this makes sense with an image that is
  in active use?

* qemu-img convert source: Similarly to qemu-img compare, this doesn't
  make a whole lot of sense, with one exception: People are using -s to
  extract internal snapshots while the VM is still running, and this
  usually works because the snapshot doesn't change. However, I don't
  want to know what happens if you delete the snapshort from the qemu
  process while qemu-img convert is running... Doing 'qemu-img snapshot
  -s ...' with a running VM is more tolerated abuse than a supported
  feature.

* qemu-img info: This one makes perfect sense even with a running VM

* qemu-img map: Results are potentially meaningless with concurrent I/O,
  but there may be cases where it makes sense.

* qemu-img snapshot -l: Somewhat similar to qemu-img convert -s, except
  that it's very quick and doesn't access actual data (could even be
  BDRV_O_NOIO, I think). Allowing this makes sense, I guess.

* qemu-img rebase, safe mode, backing files: If we allowed concurrent
  writes, it wouldn't be safe.

* qemu-img bench: Well... No. You don't need this on an image with an
  active VM.

* qemu-img dd: Same as convert, except that there is no -s.

So the list of subcommands where we want to support it is rather short.
We can change blk_new_open() to clear CONSISTENT_READ for BDRV_O_NOIO,
which could cover 'info' and 'snapshot -l'.

That leaves us with qemu-io, 'convert -s' and 'map', all of which can be
imagined to be useful even with a running VM, but all of which can also
easily produce wrong results in this case. An explicit command line
option to disable CONSISTENT_READ might be the right tool here.

What do you think?

Kevin
