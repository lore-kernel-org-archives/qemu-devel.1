Received: from eggs.gnu.org ([2001:4830:134:3::10]:32956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCL04-0007u9-6k
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCL01-00031I-2y
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:42:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eCL00-000316-QV
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:42:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <CAFEAcA81ENKOYTCvhpBrXnreyy9zodk-EXqvwLZq=1w6UvkoAg@mail.gmail.com>
	<832ea538-6347-9b00-6a44-48159f94748f@redhat.com>
Date: Wed, 08 Nov 2017 08:42:09 +0100
In-Reply-To: <832ea538-6347-9b00-6a44-48159f94748f@redhat.com> (Thomas Huth's
	message of "Wed, 1 Nov 2017 07:22:16 +0100")
Message-ID: <871sl9w71q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] we allow passing -machine type=foo more than once
 but are confused about which to use...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 31.10.2017 19:33, Peter Maydell wrote:
>> (cc Markus because I know how much he likes weirdnesses in our
>> command line parsing :-))

Heh!

Let me give you a guided tour to this corner of the CLI swamp :)

>> https://stackoverflow.com/questions/46955244/qemu-run-arm-ubuntu-unsupported-machine-type/47042282
>> has a user who's run into a confusing error message, because
>> we allow the user to pass "-machine type=foo" more than once on
>> the command line. When we decide which one to use, we go with the
>> last one on the list. However if it's not valid, when we print the
>> "don't recognize that machine type" message, the name we use in
>> the message is the *first* one on the list :-)

As so often, this is a case of a perfectly decent initial design messed
up by a number of enhancements that all made sense in isolation, but
fall apart together.

QemuOpts was designed to collect all parsed option arguments of a
certain kind in one instance of QemuOptsList.  For example, the
arguments of all -mon options get collected in the QemuOptsList named
"mon".  Each of the -mon arguments must have a distinct value of "id".
Absent "id" counts as a distinct value, i.e. "id" may be absent at most
once.  Each argument is represented as an instance of QemuOpts.

Yours truly enhanced QemuOpts to track locations in member @loc (commit
ab5b027ee6..0f0bc3f1d5).  This is what enables error_report() to report
the location, both on the command line and in configuration files:

    $ qemu-system-x86_64 -chardev bogus,id=chr1
    qemu-system-x86_64: -chardev bogus,id=chr1: 'bogus' is not a valid char driver name
    $ qemu-system-x86_64 -readconfig example.cfg
    qemu-system-x86_64:example.cfg:4: Invalid parameter 'type'
    qemu-system-x86_64: -readconfig example.cfg: read config example.cfg: Invalid argument

Sometimes, it's convienient to build up configuration in multiple
places.  Say your example.cfg configures a QMP monitor on stdio like
this:

    # qemu config file

    [chardev "stdio"]
      backend = "stdio"

    [mon "qmp-stdio"]
      chardev = "stdio"
      mode = "control"

To set pretty=on just for a quick test run, you could add a line to the
file, run the test, then delete it again.  Or you can modify the test
run's configuration with -set:

    $ qemu-system-x86_64 -readconfig example.cfg -set mon.qmp-stdio.pretty=on

This is certainly one of the lesser known QemuOpts features.  It's
asymmetric: the -set is quite different from the -mon it modifies.
Location reporting works fine for parse errors:

    $ qemu-system-x86_64 -nodefaults -S -readconfig example.cfg -set mon.qmp-stdio.pretty=of
    qemu-system-x86_64: -set mon.qmp-stdio.pretty=of: Parameter 'pretty' expects 'on' or 'off'

It breaks down for errors detected after the -set was applied to the
QemuOpts:

    $ qemu-system-x86_64 -nodefaults -S -netdev user,id=net1 -device e1000,id=nic1 -set device.nic1.netev=net1
    qemu-system-x86_64: -device e1000,id=nic1: Property '.netev' not found

A certain Peter Maydell (*grin*) enhanced QemuOpts to permit symmetric
modifications (commit da93318), but only for certain options, currently
-machine, -accel, -boot, -name, -memory, -icount, -smp.  Example:

    $ qemu-system-x86_64 -machine accel=kvm -machine type=q35

Without this feature, the second -machine would be rejected as
duplicate.  With the feature, it is merged into the first -machine, so
the two together become equivalent to:

    $ qemu-system-x86_64 -machine accel=kvm,type=q35

However, there's still only *one* location, since there's just one
QemuOpts!

    $ qemu-system-x86_64 --machine accel=kvm -machine type=q36
    qemu-system-x86_64: --machine accel=kvm: unsupported machine type
    Use -machine help to list supported machines

>> Maybe we should just not allow users to pass the argument
>> more than once...?

Insufficient.  We'd have to revert the options merging wholesale, and
ditch -set.

To really fix this, we'd have to move the location information from
QemuOpts to QemuOpt (the thing representing a key=value within a
QemuOpt).  Lots of client code would have to be updated, too.

> I think we at least need that in some of our qtests - to override the
> default "-M accel=qtest" with "-M accel=tcg". So if we disallow to use
> the option more than once, we've got to find a different solution for
> the qtests.

I'm afraid this feature is used not just by qtest.

Of course, given how much I expect to suffer for CLI backward
compatibility during my CLI QAPIfication work, I'd be *delighted* to
have a nice precedent for breaking it some ;)
