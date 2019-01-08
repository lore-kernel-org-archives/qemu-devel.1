Received: from eggs.gnu.org ([209.51.188.92]:45063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggokl-0008Le-Hn
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggokk-00015O-Kj
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:36:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
	<20190107163606.GL23773@natto.ory.fergeau.eu>
Date: Tue, 08 Jan 2019 11:36:55 +0100
In-Reply-To: <20190107163606.GL23773@natto.ory.fergeau.eu> (Christophe
	Fergeau's message of "Mon, 7 Jan 2019 17:36:06 +0100")
Message-ID: <87pnt7bflk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Copying block maintainers for help with assessing the bug's (non-)impact
on security.

Christophe Fergeau <cfergeau@redhat.com> writes:

> On Mon, Jan 07, 2019 at 04:47:44PM +0100, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>> > On 1/2/19 12:01 PM, Christophe Fergeau wrote:
>> >> Adding Markus to cc: list, I forgot to do it when sending the patch.
>> >
>> > Also worth backporting via qemu-stable, now in cc.
>> >
>> >> 
>> >> Christophe
>> >> 
>> >> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrote:
>> >>> commit 8bca4613 added support for %% in json strings when interpolating,
>> >>> but in doing so, this broke handling of % when not interpolating as the
>> >>> '%' is skipped in both cases.
>> >>> This commit ensures we only try to handle %% when interpolating.
>> 
>> Impact?
>> 
>> If you're unable to assess, could you give us at least a reproducer?
>
> This all came from https://lists.freedesktop.org/archives/spice-devel/2018-December/046644.html
> Setting up a VM with libvirt with <graphics type='spice' autoport='yes' passwd='password%'/>
> fails to start with:
>   qemu-system-x86_64: qobject/json-parser.c:146: parse_string: Assertion `*ptr' failed.
>
> If you use 'password%%' as the password instead, when trying to connect
> to the VM, you type 'password%' as the password instead of 'password%%'
> as configured in the domain XML.

Thanks.

As the commit message says, the bug bites when we parse a string
containing '%s' with !ctxt->ap.  The parser then swallows a character.
If it swallows the terminating '"', it fails the assertion.

We parse with !ctxt->ap in the following cases:

* Tests (tests/check-qjson.c, tests/test-qobject-input-visitor.c,
  tests/test-visitor-serialization.c)

  Plenty of tests, but we still failed to cover the buggy case :(

* QMP input (monitor.c)

* QGA input (qga/main.c)

* qobject_from_json()

  - JSON pseudo-filenames (block.c)

    These are pseudo-filenames starting with "json:".

  - JSON key pairs (block/rbd.c)

    As far as I can tell, these can come only from pseudo-filenames
    starting with "rbd:".

  - JSON command line option arguments of -display and -blockdev
    (qobject-input-visitor.c)

    Reproducer: -blockdev '{"%"}'

Command line, QMP and QGA input are trusted.

Filenames are trusted when they come from command line, QMP or HMP.
They are untrusted when they come from from image file headers.
Example: QCOW2 backing file name.  Note that this is *not* the security
boundary between host and guest.  It's the boundary between host and an
image file from an untrusted source.

I can't see how the bug could be exploited.  Neither failing an
assertion nor skipping a character in a filename of your choice is
interesting.  We don't support compiling with NDEBUG.

Kevin, Max, do you agree?
