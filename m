Received: from eggs.gnu.org ([2001:4830:134:3::10]:42981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFGvN-0004UZ-J2
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFGvK-0004y4-2G
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:25:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dFGvJ-0004xm-Pr
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:25:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C177E86647
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 09:25:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170513033316.22395-1-ehabkost@redhat.com>
	<20170513033316.22395-4-ehabkost@redhat.com>
	<87r2zf4ocg.fsf@dusky.pond.sub.org>
	<20170524163921.GO32274@thinpad.lan.raisama.net>
Date: Mon, 29 May 2017 11:25:03 +0200
In-Reply-To: <20170524163921.GO32274@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Wed, 24 May 2017 13:39:21 -0300")
Message-ID: <8737bo9frk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/3] scripts: Test script to look for
 -device crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, May 23, 2017 at 04:52:47PM +0200, Markus Armbruster wrote:
>> Beware, my review is rather superficial.
>> 
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > Test code to check if we can crash QEMU using -device. It will
>> > test all accel/machine/device combinations by default, which may
>> > take a few hours (it's more than 90k test cases). There's a "-r"
>> > option that makes it test a random sample of combinations.
>> >
>> > The scripts contains a whitelist for: 1) known error messages
>> > that make QEMU exit cleanly; 2) known QEMU crashes.
>> >
>> > This is the behavior when the script finds a failure:
>> >
>> > * Known clean (exitcode=1) error messages generate INFO messages
>> >   (visible only in verbose mode), to make script output shorter
>> > * Unknown clean error messages generate warnings
>> >   (visible by default)
>> > * Known crashes generate error messages, but are not fatal
>> > * Unknown crashes generate fatal error messages
>> >
>> > I'm unsure about the need to maintain a list of known clean error
>> > messages, but I wanted to at least document all existing failure
>> > cases to use as base to build more comprehensive test code.
>> >
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > ---
>> > Changes v1 -> v2:
>> > * New whitelist entries:
>> >   * "could not find stage1 bootloader"
>> >   * Segfaults when using devices: a15mpcore_priv, sb16, cs4231a, arm-gicv3
>> > * Format "success" line using formatTestCase(), and using DEBUg
>> >   loglevel
>> > * Reword "test case:" line with "running test case:", for clarity
>> > * Fix "pc-.*" whitelist to include "q35" too
>> > * Add --devtype option to test only a specific device type
>> > * Send all log messages to stdout instead of stderr
>> > * Avoid printing "obsolete whitelist entry?" messages if we know
>> >   we are not testing every single accel/machine/device
>> >   combination
>> > * --quick mode, to skip cases where failures are always expected,
>> >   and to print a warning in case we don't get an expected failure
>> > * Use qemu.QEMUMachine instead of qtest.QEMUQtestMachine, as we don't
>> >   use any of the QEMUQtestMachine features
>> > * Fix handling of multiple '-t' options
>> > * Simplify code that generate random sample of test cases
>> > ---
>> >  scripts/device-crash-test.py | 520 +++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 520 insertions(+)
>> >  create mode 100755 scripts/device-crash-test.py
>> >
>> > diff --git a/scripts/device-crash-test.py b/scripts/device-crash-test.py
>> > new file mode 100755
>> > index 0000000000..550da70ec7
>> > --- /dev/null
>> > +++ b/scripts/device-crash-test.py
>> > @@ -0,0 +1,520 @@
>> > +#!/usr/bin/env python2.7
>> > +#
>> > +# Run QEMU with all combinations of -machine and -device types,
>> > +# check for crashes and unexpected errors.
>> > +#
>> > +#  Copyright (c) 2017 Red Hat Inc
>> > +#
>> > +# Author:
>> > +#  Eduardo Habkost <ehabkost@redhat.com>
>> > +#
>> > +# This library is free software; you can redistribute it and/or
>> > +# modify it under the terms of the GNU Lesser General Public
>> > +# License as published by the Free Software Foundation; either
>> > +# version 2 of the License, or (at your option) any later version.
>> 
>> Any particular reason for "Lesser"?
>
> I don't remember, probably I used another script I had written
> before as reference.  Probably it's not even a valid license as
> I'm using a GPL module (qemu.py).  I will change it to GPL.

Thanks.

>> > +#
>> > +# This library is distributed in the hope that it will be useful,
>> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> > +# Lesser General Public License for more details.
>> > +#
>> > +# You should have received a copy of the GNU Lesser General Public
>> > +# License along with this library; if not, see <http://www.gnu.org/licenses/>.
>> > +#
>> > +
>> > +import sys, os, glob
>> > +sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'scripts'))
>> > +
>> > +from itertools import chain
>> > +from qemu import QEMUMachine
>> > +import logging, traceback, re, random, argparse
>> > +
>> > +logger = logging.getLogger('device-crash-test')
>> > +dbg = logger.debug
>> > +
>> > +# Valid whitelist entry keys:
>> > +# - accel: regexp, full match only
>> > +# - machine: regexp, full match only
>> > +# - device: regexp, full match only
>> > +# - log: regexp, partial match allowed
>> > +# - exitcode: if not present, defaults to 1. If None, matches any exitcode
>> > +# - warn: if True, matching failures will be logged as warnings
>> > +# - expected: if True, QEMU is expected to always fail every time
>> > +#   when testing the corresponding test case
>> > +ERROR_WHITELIST = [
>> > +  # Machines that won't work out of the box:
>> > +  #             MACHINE                         | ERROR MESSAGE
>> > +  dict(machine='niagara', expected=True),       # Unable to load a firmware for -M niagara
>> 
>> What's wrong with dictionary displays?
>> 
>>      {'expected': True, 'machine': 'niagara'}
>
> Nothing wrong.  I just prefer the dict(key=value) syntax to the
> colons and extra quotes in {'key': value}.

Since Python provides syntactic sugar ("dictionary displays")
specifically for creating dictionaries, shouldn't we use it?

As far as I can tell, existing Python code always uses dictionary
displays, never the equivalent constructor call.

q>> > +  dict(machine='boston', expected=True),        # Please provide either a -kernel or -bios argument
>> > +  dict(machine='leon3_generic', expected=True), # Can't read bios image (null)
>> > +
>> > +  # devices that don't work out of the box because they require extra options to "-device DEV":
>> > +  #            DEVICE                                    | ERROR MESSAGE
>> > +  dict(device='.*-(i386|x86_64)-cpu', expected=True),    # CPU socket-id is not set
[...]
>> > +  dict(log=r"could not find stage1 bootloader"),
>> > +
>> > +  # other exitcode=1 failures not listed above will generate warnings:
>> > +  dict(exitcode=1, loglevel=logging.WARN),
>        ^^^ [*]
>
>> > +
>> > +  # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
>> > +  dict(exitcode=None, fatal=True, loglevel=logging.FATAL),
>> > +]
>> 
>> How will we keep this whitelist up-to-date?
>
> We don't really have to.  Making a complete whitelist was useful
> to me when validating the script, but I don't think it will be
> worth the effort to keep it up to date.  The only consequence of
> an incomplete whitelist will be the warnings triggered by [*].
>
> We may consider changing the entry at [*] to logging.INFO, if it
> starts triggering too many warnings.
>
> I will add comments to the script noting 
>
>> 
>> Hmm, there seems to be code for detecting obsolete entries.  Can you
>> explain how it works, for dummies?
>
> The script simply lists the whitelist entries that didn't have
> any matches, because it is useful if somebody wants to remove
> obsolete entries from the whitelist.  The script can't be sure
> the entry is really obsolete, because the user might be testing
> just a subset of the QEMU binaries, or building it with some
> devices/features disabled.

Okay, so the script can tell us about failures not covered by the
whitelist, and about whitelist entries that appear unused.  The latter
is of course useful only when your testing with a sufficiently complete
QEMU.  Good enough for me.

> I will change these messages to be printed only in debug mode,
> and add comments explaining why they are there.
>
>> 
>> > +
>> > +def whitelistMatch(wl, f):
>> > +    t = f.get('testcase', {})
>> > +    return (not wl.has_key('machine') \
>> 
>> scripts/device-crash-test.py:212:19: W601 .has_key() is deprecated, use 'in'
>> 
>> Please feed this module to pylint and pep8, then use your judgement.
>
> Will do.
>
>> 
>> > +            or not t.has_key('machine') \
>> > +            or re.match(wl['machine'] +'$', t['machine'])) \
>> > +           and (not wl.has_key('accel') \
>> > +                or not t.has_key('accel') \
>> > +                or re.match(wl['accel'] +'$', t['accel'])) \
>> > +           and (not wl.has_key('device') \
>> > +                or not t.has_key('device') \
>> > +                or re.match(wl['device'] +'$', t['device'])) \
>> > +           and (wl.get('exitcode', 1) is None \
>> > +                or not f.has_key('exitcode')
>> > +                or f['exitcode'] == wl.get('exitcode', 1)) \
>> 
>> Could this be simplified to
>> 
>>               and (wl.get('exitcode', 1) is None
>>                    or f.get('exitcode') == wl.get('exitcode', 1))
>> 
>> ?
>
> Nope, because this:
>   checkWhitelist({'testcase':{'machine':'niagara'}})
> should return:
>   (0, {'expected': True, 'machine': 'niagara'})
> to make the check at [***] properly skip expected=True entries.
>
> Maybe I should write two separate functions, for clarity:
> whitelistTestCaseMatch() and whitelistTestCaseResultsMatch().
>
> The check at [***] then would use whitelistTestCaseMatch().  The
> check at [****] would use whitelistTestCaseResultsMatch().
>
>> 
>> > +           and (not wl.has_key('log') \
>> > +                or not f.has_key('log') \
>> > +                or re.search(wl['log'], f['log'], re.MULTILINE))
>> > +
>> > +def checkWhitelist(f):
>> > +    """Look up whitelist entry for failure dictionary
>> > +
>> > +    Returns index in ERROR_WHITELIST
>> > +    """
>> > +    for i,wl in enumerate(ERROR_WHITELIST):
>> 
>> Umm, sure you need to wrap enumerate() around ERROR_WHITELIST?
>
> I do, because I want to return the index of the entry also[**].
>
>> 
>> > +        #dbg("whitelist entry: %r", wl)
>> 
>> Debugging turd?  More of the same below.
>
> I will delete that.
>
>> 
>> > +        if whitelistMatch(wl, f):
>> > +            return i, wl
>                         ^^^ [**]
>
>> > +
>> > +    raise Exception("this should never happen")
>> > +
>> > +def qemuOptsEscape(s):
>> > +    return s.replace(",", ",,")
>> > +
>> > +def formatTestCase(t):
>> > +    return ' '.join('%s=%s' % (k, v) for k,v in t.items())
>> > +
>> > +def qomListTypeNames(vm, **kwargs):
>> > +    """Run qom-list-types QMP command, return type names"""
>> > +    types = vm.command('qom-list-types', **kwargs)
>> > +    return [t['name'] for t in types]
>> > +
>> > +def infoQDM(vm):
>> > +    """Parse 'info qdm' output"""
>> > +    args = {'command-line': 'info qdm'}
>> > +    devhelp = vm.command('human-monitor-command', **args)
>> > +    for l in devhelp.split('\n'):
>> > +        l = l.strip()
>> > +        if l == '' or l.endswith(':'):
>> > +            continue
>> > +        d = {'name': re.search(r'name "([^"]+)"', l).group(1),
>> > +             'no-user': (re.search(', no-user', l) is not None)}
>> > +        #dbg('info qdm item: %r', d)
>> > +        yield d
>> 
>> The need for HMP is sad, but you already proposed patches to remove it.
>
> Yep.
>
>> 
>> > +
>> > +
>> > +class QemuBinaryInfo:
>> > +    def __init__(self, binary, devtype):
>> > +        if devtype is None:
>> > +            devtype = 'device'
>> > +
>> > +        dbg("devtype: %r", devtype)
>> > +        args = ['-S', '-machine', 'none,accel=kvm:tcg']
>> > +        dbg("querying info for QEMU binary: %s", binary)
>> > +        vm = QEMUMachine(binary=binary, args=args)
>> > +        vm.launch()
>> > +        try:
>> > +            self.alldevs = set(qomListTypeNames(vm, implements=devtype, abstract=False))
>> > +            # there's no way to query cannot_instantiate_with_device_add_yet using QMP,
>> 
>> Update needed for the rename to user_creatable.
>
> Right.  I will update it.
>
>> 
>> > +            # so use 'info qdm':
>> > +            self.no_user_devs = set([d['name'] for d in infoQDM(vm, ) if d['no-user']])
>> > +            self.machines = list(m['name'] for m in vm.command('query-machines'))
>> > +            self.user_devs = self.alldevs.difference(self.no_user_devs)
>> > +            self.kvm_available = vm.command('query-kvm')['enabled']
>> > +        finally:
>> > +            vm.shutdown()
>> > +
>> > +BINARY_INFO = {}
>> > +def getBinaryInfo(args, binary):
>> > +    if not BINARY_INFO.has_key(binary):
>> > +        BINARY_INFO[binary] = QemuBinaryInfo(binary, args.devtype)
>> > +    return BINARY_INFO[binary]
>> > +
>> > +def checkOneCase(args, testcase):
>> > +    """Check one specific case
>> > +
>> > +    Returns a dictionary containing failure information on error,
>> > +    or None on success
>> > +    """
>> > +    binary = testcase['binary']
>> > +    accel = testcase['accel']
>> > +    machine = testcase['machine']
>> > +    device = testcase['device']
>> > +    info = getBinaryInfo(args, binary)
>> > +
>> > +    dbg("will test: %r", testcase)
>> > +
>> > +    args = ['-S', '-machine', '%s,accel=%s' % (machine, accel),
>> > +            '-device', qemuOptsEscape(device)]
>> > +    cmdline = ' '.join([binary] + args)
>> > +    dbg("will launch QEMU: %s", cmdline)
>> > +    vm = QEMUMachine(binary=binary, args=args)
>> > +
>> > +    exception = None
>> > +    try:
>> > +        vm.launch()
>> > +    except KeyboardInterrupt:
>> > +        raise
>> > +    except Exception,e:
>> > +        exception = e
>> > +    finally:
>> > +        vm.shutdown()
>> > +        ec = vm.exitcode()
>> > +        log = vm.get_log()
>> > +
>> > +    if exception is not None or ec != 0:
>> > +        f = dict(exception = exception,
>> > +                 exitcode = ec,
>> > +                 log = log,
>> > +                 testcase = testcase,
>> > +                 cmdline=cmdline)
>> > +        return f
>> 
>> Why not simply
>> 
>>           return {'exception': exception,
>>                   'exitcode': ec,
>>                   'log': log,
>>                   'testcase': testcase,
>>                   'cmdline': cmdline}
>
> About the 'f' variable: probably I had a debugging statement here
> in the past.  I will remove it.
>
> About the dict(key=value) syntax instead of {'key':value}: like
> above, it was just personal taste.
>
>> 
>> ?
>> 
>> > +
>> > +def binariesToTest(args, testcase):
>> > +    if args.qemu:
>> > +        r = args.qemu
>> > +    else:
>> > +        r = glob.glob('./*-softmmu/qemu-system-*')
>> > +    return r
>> > +
>> > +def accelsToTest(args, testcase):
>> > +    if getBinaryInfo(args, testcase['binary']).kvm_available:
>> > +        yield 'kvm'
>> > +    yield 'tcg'
>> 
>> If only "--accel help" showed just the ones that can actually work...
>
> I refuse to parse help output unless there's no equivalent QMP
> alternative.  But we could add a query-accelerators QMP command
> in the future.

Understand.

What you have is good enough for now.

[...]
