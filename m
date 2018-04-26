Received: from eggs.gnu.org ([2001:4830:134:3::10]:54640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBfUA-0007nu-Qh
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBfUA-0001HH-0L
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:54:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87in8qf2w3.fsf@dusky.pond.sub.org>
	<62dba5cf-b497-1a98-0af5-971e169a3458@redhat.com>
Date: Thu, 26 Apr 2018 13:54:43 +0200
In-Reply-To: <62dba5cf-b497-1a98-0af5-971e169a3458@redhat.com> (Thomas Huth's
	message of "Thu, 26 Apr 2018 12:24:48 +0200")
Message-ID: <877eou2nek.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test devices
 with all machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> On 17.04.2018 14:12, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> Many device introspection crashes only happen if you are using a
>>> certain machine, e.g.:
>>>
>>> $ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=qtest -qmp stdio
>>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
>>>  "package": "build-all"}, "capabilities": []}}
>>> { 'execute': 'qmp_capabilities' }
>>> {"return": {}}
>>> { 'execute': 'device-list-properties',
>>>   'arguments': {'typename': 'macio-newworld'}}
>>> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
>>> Device 'serial0' is in use
>>> Aborted (core dumped)
>>>
>>> To be able to catch these problems, let's extend the device-introspect
>>> test to check the devices on all machine types. Since this is a rather
>>> slow operation, the test is only run in "SPEED=slow" mode.
>> 
>> If the device works with one machine type, it has a decent chance to
>> work with others, too.  Thus, testing each device with every machine
>> type is overkill.  I appreciate having overkill as an option :)
>> 
>> What I'd like to see for a quick "make check" is testing each device
>> once.  That should flush out most bugs.  
>
> That's already done with the "none" machine.

I was too terse.  We test each device with -machine none for every
target.  Fine if that's quick enough.  If not, we might want to reduce
redundancy there.

Actually, a worse offender in the "waste everybody's time via redunancy"
department could be qom-test.

> Anyway, do you think my patch here is useful and has a chance of getting
> included? I.e. shall I re-spin this as a non-RFC patch? Or shall we
> rather wait for Eduardo's python-based tests to get included into the
> repository?

I don't mind having make check SPEED=slow run more extensive tests.
Assuming we actually run them at least once in a while, which seems
doubtful.

>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  In case someone wants to help with creating some bug fix patches
>>>  during the QEMU hard freeze phase: This test can now be used to
>>>  trigger lots of introspection bugs that we were not aware of yet.
>>>  I think most of the bugs are due to wrong handling of instance_init
>>>  vs. realize functions.
>> 
>> Yes, that's a common class of bugs.  There's little guidance on what
>> kind of work belongs where, and plenty of bad examples.
>
> I think we urgently need a file in doc/devel/ that describes the various
> states / functions of a device, where we should properly describe the
> differences between instance_init and realize. ... I'll try to come up
> with something when I've got some spare time (unless somebody else
> volunteers to do that first).

Please do.

Widen the scope from just TYPE_DEVICE to all of QOM?
