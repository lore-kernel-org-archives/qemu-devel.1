Received: from eggs.gnu.org ([209.51.188.92]:55789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmbQX-0001Ib-R8
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmbQT-0000Rz-VU
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:36:01 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
Date: Thu, 24 Jan 2019 10:35:52 +0100
In-Reply-To: <87o98sii5b.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 07 Jan 2019 16:47:44 +0100")
Message-ID: <87munqieiv.fsf@dusky.pond.sub.org>
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
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, "Richard W. M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 1/2/19 12:01 PM, Christophe Fergeau wrote:
>>> Adding Markus to cc: list, I forgot to do it when sending the patch.
>>
>> Also worth backporting via qemu-stable, now in cc.
>>
>>> 
>>> Christophe
>>> 
>>> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrote:
>>>> commit 8bca4613 added support for %% in json strings when interpolating,
>>>> but in doing so, this broke handling of % when not interpolating as the
>>>> '%' is skipped in both cases.
>>>> This commit ensures we only try to handle %% when interpolating.
>
> Impact?
>
> If you're unable to assess, could you give us at least a reproducer?
>
>>>> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
>>>> ---
>>>>  qobject/json-parser.c | 10 ++++++----
>>>>  tests/check-qjson.c   |  5 +++++
>>>>  2 files changed, 11 insertions(+), 4 deletions(-)
>>>>
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Patch looks good to me, but I'd like us to improve the commit message.

Let me try:

    json: Fix % handling when not interpolating

    Commit 8bca4613 added support for %% in json strings when interpolating,
    but in doing so broke handling of % when not interpolating.

    When parse_string() is fed a string token containing '%', it skips the
    '%' regardless of ctxt->ap, i.e. even it's not interpolating.  If the
    '%' is the string's last character, it fails an assertion.  Else, it
    "merely" swallows the '%'.

    Fix parse_string() to handle '%' specially only when interpolating.

    To gauge the bug's impact, let's review non-interpolating users of this
    parser, i.e. code passing NULL context to json_message_parser_init():

    * tests/check-qjson.c, tests/test-qobject-input-visitor.c,
      tests/test-visitor-serialization.c

      Plenty of tests, but we still failed to cover the buggy case.

    * monitor.c: QMP input

    * qga/main.c: QGA input

    * qobject_from_json():

      - qobject-input-visitor.c: JSON command line option arguments of
        -display and -blockdev

        Reproducer: -blockdev '{"%"}'

      - block.c: JSON pseudo-filenames starting with "json:"

        Reproducer: https://bugzilla.redhat.com/show_bug.cgi?id=1668244#c3

      - block/rbd.c: JSON key pairs

        Pseudo-filenames starting with "rbd:".

    Command line, QMP and QGA input are trusted.

    Filenames are trusted when they come from command line, QMP or HMP.
    They are untrusted when they come from from image file headers.
    Example: QCOW2 backing file name.  Note that this is *not* the security
    boundary between host and guest.  It's the boundary between host and an
    image file from an untrusted source.

    Neither failing an assertion nor skipping a character in a filename of
    your choice looks exploitable.  Note that we don't support compiling
    with NDEBUG.

    Fixes: 8bca4613e6cddd948895b8db3def05950463495b
    Cc: qemu-stable@nongnu.org

Comments?
