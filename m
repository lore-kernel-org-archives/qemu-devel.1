Received: from eggs.gnu.org ([2001:4830:134:3::10]:38491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQsOC-00023J-Ke
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQsOB-0000j7-FO
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:11:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
Date: Mon, 18 Dec 2017 11:11:00 +0100
In-Reply-To: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com> (Max Reitz's
	message of "Fri, 15 Dec 2017 17:38:00 +0100")
Message-ID: <87ind4gxcb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Raw notes from a small block layer/QAPI/something
 pre-christmas meeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

[...]
> == Image creation ==
>
> Image creation and op blockers:
>   At least for the time being, we probably just want file-posix to open
>   the new file with O_CREAT | O_RDWR, then claim the appropriate op
>   blockers (WRITE and RESIZE) and then invoke ftruncate().
>   Alternatively, we could somehow do the truncation from the generic
>   block layer, but this may not be possible with all protocols (and
>   currently we support file locking only over file-posix anyway).
>
> Image creation job:
>   We want to have this anyway (including QAPIfication of the creation
>   options), but when, alas, we cannot say.
>   Some ideas:
>   - Do creation per driver, not automatic "pass-through".
>     First, create the protocol file.  Then, format it using the format
>     driver.
>     So blockdev-create would take the same child BlockdevRefs as
>     blockdev-add, and then format those.  For protocol drivers, you just
>     don't pass any child and the file is thus created.
>     (You then open it with blockdev-add or just use it inline in the
>      format driver's blockdev-create to format the image.)
>
> Image creation in qemu-system-* vs. qemu-img:
>   In order to get proper introspection for qemu-img create, we need a
>   QAPI schema.  If we have a QAPI schema, we might as well add
>   blockdev-create to QMP.
>   As long as we do not have a really-none (null, void, ...) machine type
>   for qemu-system-*, launching such a process just for creating an image
>   will bring quite a bit of overhead (e.g. with -M none -accel qtest).
>   However, as for libvirt, this is not exactly a regression since
>   libvirt currently cannot create images at all (apart from implicitly
>   through drive-mirror etc.).  Further work on voidifying qemu-system-*
>   will improve performance.

Another thought: do we want to give qemu-system-* the necessary
privileges for creating images?  Two cases: running with and without a
guest.

>   On the other side, we can also add QAPI introspection to qemu-img.
>   (qemu-img already links to QAPI, so this should not be too hard.)

I agree that adding some kind of QAPI introspection shouldn't be too
hard, but providing it via a QMP monitor would be significantly harder,
because the QMP monitor is entangled with HMP and character devices,
which are in turn entangled with lots of stuff.  The disentangling
necessary to make QMP available for qemu-img might be expensive.

>   qemu-img will also need command-line introspection, though.

My RFC patches to provide command-line introspection don't cover this,
yet; they only provide via QMP.  Providing it directly on the command
line feels feasible.

>   Plan B:
>     libvirt can use qemu-img now with the currently supported options,
>     and as soon as libvirt needs anything better, we will have something
>     better done.
>     (Also, there is "qemu-img create -f $format -o help"!  Because
>      parsing help texts has worked so well in the past.)


[...]
