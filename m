Received: from eggs.gnu.org ([2001:4830:134:3::10]:39892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@pond.sub.org>) id 1gD80f-0007yM-4t
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@pond.sub.org>) id 1gD80b-0005m6-Rn
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:06:41 -0400
Received: from oxygen.pond.sub.org ([2a01:4f8:201:233:1::3]:33340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@pond.sub.org>) id 1gD80b-0005WZ-HG
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:06:37 -0400
Received: from blackfin.pond.sub.org (p5B0E2601.dip0.t-ipconnect.de
	[91.14.38.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by oxygen.pond.sub.org (Postfix) with ESMTPSA id 25ACF2A1F1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 15:06:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
References: <87efcqniza.fsf@dusky.pond.sub.org>
	<20181016132035.GF7995@redhat.com>
Date: Thu, 18 Oct 2018 15:06:31 +0200
Message-ID: <87o9brl7zc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] When it's okay to treat OOM as fatal?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Oct 16, 2018 at 03:01:29PM +0200, Markus Armbruster wrote:
>> We sometimes use g_new() & friends, which abort() on OOM, and sometimes
>> g_try_new() & friends, which can fail, and therefore require error
>> handling.
>>=20
>> HACKING points out the difference, but is mum on when to use what:
>>=20
>>     3. Low level memory management
>>=20
>>     Use of the malloc/free/realloc/calloc/valloc/memalign/posix_memalign
>>     APIs is not allowed in the QEMU codebase. Instead of these routines,
>>     use the GLib memory allocation routines g_malloc/g_malloc0/g_new/
>>     g_new0/g_realloc/g_free or QEMU's qemu_memalign/qemu_blockalign/qemu=
_vfree
>>     APIs.
>>=20
>>     Please note that g_malloc will exit on allocation failure, so there
>>     is no need to test for failure (as you would have to with malloc).
>>     Calling g_malloc with a zero size is valid and will return NULL.
>>=20
>>     Prefer g_new(T, n) instead of g_malloc(sizeof(T) * n) for the follow=
ing
>>     reasons:
>>=20
>>       a. It catches multiplication overflowing size_t;
>>       b. It returns T * instead of void *, letting compiler catch more t=
ype
>>          errors.
>>=20
>>     Declarations like T *v =3D g_malloc(sizeof(*v)) are acceptable, thou=
gh.
>>=20
>>     Memory allocated by qemu_memalign or qemu_blockalign must be freed w=
ith
>>     qemu_vfree, since breaking this will cause problems on Win32.
>>=20
>> Now, in my personal opinion, handling OOM gracefully is worth the
>> (commonly considerable) trouble when you're coding for an Apple II or
>> similar.  Anything that pages commonly becomes unusable long before
>> allocations fail.  Anything that overcommits will send you a (commonly
>> lethal) signal instead.  Anything that tries handling OOM gracefully,
>> and manages to dodge both these bullets somehow, will commonly get it
>> wrong and crash.
>
> FWIW, with the cgroups memory controller (with or without containers)
> you can be in an environment where there's a memory cap. This can
> conceivably cause QEMU to see ENOMEM, while the host OS in general
> is operating normally with no swap usage / paging.
>
> That said, no one has ever been able to come up with an algorithm that
> reliably predicts the "normal" QEMU peak memory usage. So any time the
> cgroups memory cap has been used, it has typically resulted in QEMU
> unreasonably aborting in normal operation. This makes it impractical
> to try to confine QEMU's memory usage with cgroups IMHO.
>
>> But others are entitled to their opinions as much as I am.  I just want
>> to know what our rules are, preferably in the form of a patch to
>> HACKING.
>
> I vaguely recall it being said that we should use g_try_new in code
> paths that can be triggered from monitor commands that would cause
> allocation of "significant" amounts of RAM, for some arbitrary
> defintiion of what "significant" means.
>
> eg hotplug a QXL PCI video card with 256 MB of video RAM, you might
> use g_try_new() for allocating this 256 MB chunk and return gracefully
> on failure, rather than the hotplug op causing QEMU to abort.

Funny you picked this example.  It happens to be one of the devices that
made me ask.

Device "qxl" creates a memory region "qxl.vgavram" with a size taken
from uint32_t property "ram_size", silently rounded up to the next power
of two.  It uses &error_fatal for error handling.

Let's play with it.

    $ upstream-qemu -monitor stdio -display none -device qxl,ram_size=3D214=
7483648
    QEMU 3.0.50 monitor - type 'help' for more information
    (qemu) info qtree
    bus: main-system-bus
      [...]
      dev: i440FX-pcihost, id ""
        pci-hole64-size =3D 2147483648 (2 GiB)
        short_root_bus =3D 0 (0x0)
        x-pci-hole64-fix =3D true
        bus: pci.0
          type PCI
          dev: qxl, id ""
--->        ram_size =3D 2147483648 (0x80000000)
            vram_size =3D 67108864 (0x4000000)
            [...]

Happily allocates 2GiB of RAM.  I could do this with a monitor command
(qxl is hot-pluggable), but I'm too lazy for that.

Adding another 26 of them for a total of 54 GiB also succeeds.  That's
more than this box has RAM and swap space combined.

Fun: scratch -display none, and Gtk starts spitting messages at seven
qxl devices, and SEGVs at eight.

Cherry on top:

    $ upstream-qemu -device qxl,ram_size=3D2147483649
    upstream-qemu: /home/armbru/work/qemu/exec.c:1891: find_ram_offset: Ass=
ertion `size !=3D 0' failed.
    Aborted (core dumped)

My points are:

1. Even if we 'should use g_try_new in code paths that can be triggered
   from monitor commands that would cause allocation of "significant"
   amounts of RAM', we actually don't, at least not anywhere near
   consistently.

2. And even when we don't, that's not the actual problem, simply because
   allocation stubbornly refuses to fail.  Instead we die of other
   causes.

> The problem with OOM handling is proving that the cleanup paths you
> take actually do something sensible / correct, rather than result
> in cascading failures due to further OOMs. You're going to need test
> cases that exercise the relevant codepaths, and a way to inject OOM
> at each individual malloc, or across a sequence of mallocs. This is
> extraordinarily expensive to test as it becomes a combinatorial
> problem.

Exactly.

> We've done such exhaustive malloc failure testing in libvirt before
> but it takes such a long time and it is hard to characterize "correct"
> output of the test suite. This meant we caught obvious mistakes that
> lead to SEGVs for the test, but needed hand inspection to identify
> cases where we incorrectly carried on executing with critical data
> missing due to the OOM.  It has been a while since I last tried todo
> OOM testing of libvirt, so I don't have high confidence in us doing
> something sensible.

If "extraordinary expensive" work results in low confidence, decaying
quickly to even lower confidence unless you expensively maintain it,
then it's a bad investment.

>                     The only thing in our favour is that we've designed
> our malloc API replacements so that the pointer to allocated memory is
> returned to the caller separately from the success/failure status.
> Combined with attribute((return_check)) this let us get compile time
> validation that we are actually checking for malloc failures. GLibs
> g_try_new API don't allow such compile time checking as they still
> overload the pointer with the success/failure status.

Forcing error handling into existence is the easy part.  Making sure it
actually works is much, much harder.
