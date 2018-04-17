Received: from eggs.gnu.org ([2001:4830:134:3::10]:53142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8Rpo-0004fz-7r
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8Rpi-0007dY-75
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:43:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f8Rph-0007aM-TU
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:43:46 -0400
Date: Tue, 17 Apr 2018 11:42:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180417144256.GW29865@localhost.localdomain>
References: <20180329213857.15499-1-ehabkost@redhat.com>
	<20180329213857.15499-18-ehabkost@redhat.com>
	<87vacqf3da.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vacqf3da.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC 17/18] validator.py script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Amador Pahim <apahim@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Apr 17, 2018 at 02:01:53PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > See cover letter for a description of the new test system.
> >
> > TODO: code clean up
> > TODO: write description.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  scripts/validator.py | 724 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 724 insertions(+)
> >  create mode 100755 scripts/validator.py
> >
> > diff --git a/scripts/validator.py b/scripts/validator.py
> > new file mode 100755
> > index 0000000000..4312571feb
> > --- /dev/null
> > +++ b/scripts/validator.py
> > @@ -0,0 +1,724 @@
> > +#!/usr/bin/env python
> > +#
> > +#  Copyright (c) 2018 Red Hat Inc
> > +#
> > +# Author:
> > +#  Eduardo Habkost <ehabkost@redhat.com>
> > +#
> > +# This program is free software; you can redistribute it and/or modify
> > +# it under the terms of the GNU General Public License as published by
> > +# the Free Software Foundation; either version 2 of the License, or
> > +# (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License along
> > +# with this program; if not, write to the Free Software Foundation, Inc.,
> > +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > +
> > +"""
> > +QEMU validator script
> > +=====================
> > +
> > +This script will get test YAML test case specifications or Python
> > +modules as input, and generate/run test cases based on them.
> > +
> > +USAGE
> > +-----
> > +
> > +validator.py <specification-file>... -V VAR1=value1 VAR1=value2 VAR2=value3
> > +
> > +specification-file is a YAML file containing the test specification.
> 
> I can see the "test YAML test case specifications", but not the "Python
> modules".
> 
> Should we introduce yet another markup language into QEMU?  (pardon the
> pun).

Fair question.  What are the existing markup languages in QEMU we
could use?

JSON is an option, but I believe YAML is more readable.

> 
> > +
> > +Example::
> > +
> > +    # this test specification is equivalent to the
> > +    # "device/introspect/list" test case in device-introspect-test.c
> 
> If we merge this, not for long :)
> 
> > +    command-line: '$QEMU -nodefaults -machine none'
> > +    monitor-commands:
> > +    - qmp:
> > +      - execute: qom-list-types
> > +        arguments:
> > +          implements: 'device'
> > +          abstract: true
> > +    - hmp: 'device_add help'
> > +
> > +
> > +VARIABLE EXPANSION
> > +------------------
> > +
> > +The test runner will try to run the test cases with all possible values
> > +for variables appearing in the test specification.
> > +
> > +Some built-in variables are automatically expanded:
> > +
> > +* `$MACHINE` - Expands to a machine-type name supported by $QEMU
> > +* `$ACCEL` - Expands to an accelerator name supported by $QEMU
> > +* `$DEVICE` - Expands to a (user-creatable) device type name supported by $QEMU
> > +* `$CPU` - Expands to a CPU model name supported by $QEMU
> > +
> > +Note that the $QEMU variable must be specified in th
> 
> Yes?

Heh.  It must be specified in the command-line.  I will fix that.

> 
> > +
> > +TEST SPECIFICATION FIELDS
> > +-------------------------
> > +
> > +command-line
> > +~~~~~~~~~~~~
> > +
> > +List or string, containing the QEMU command-line to be run.
> > +
> > +Default: '$QEMU'
> > +
> > +
> > +monitor-commands
> > +~~~~~~~~~~~~~~~~
> > +
> > +Mapping or list-of-mappings containing monitor commands to run.  The key on each
> > +item can be ``hmp`` or ``qmp``.  The value on each entry can be a string,
> > +mapping, or list.
> > +
> > +Default: None.
> > +
> > +TODO: not implemented yet.
> 
> The whole monitor-commands feature?

Outdated comment, sorry.

> 
> Can I do
> 
>     monitor-commands:
>     - qmp:
>       - execute: eins
>     - hmp: zwei
>     - qmp:
>       - execute: drei
> 
> to execute eins, zwei, drei in this order?

Yes, it can.  See the test specification examples.

> 
> > +
> > +
> > +qmp
> > +~~~
> > +
> > +Boolean.  If true (the default), a QMP monitor is configured on the command-line
> > +automatically.
> > +
> > +If true, the test runner will issue a ``quit`` command automatically when
> > +testing is finished.  If false, the test runner will wait until QEMU exits by
> > +itself.
> > +
> > +Example::
> > +
> > +    # just run $QEMU -help and ensure it won't crash
> > +    command-line: ['$QEMU', '-help']
> > +    qmp: false
> > +
> > +
> > +TODO: whitelist
> > +TODO: validate output against reference output
> > +TODO: configure defaults for variables
> > +TODO: compatibility with Avocado multiplexer?
> > +"""
> 
> This is a DSL to write tests.  I applaud the idea to write more tests at
> a higher level than C.  We just need to be careful not to create too
> many different ways to write tests, or else readability will suffer.
> Ideally, the way to use for a test should be fairly obvious.

Agreed we need to keep this in mind.

Replacing the DSL with very short and simple Python code is a
possibility I was considering, but I'm not sure yet if this is
the way to go.  I don't want this to create a whole new test
framework.


> 
> Looking forward to your next iteration.

Thanks!

-- 
Eduardo
