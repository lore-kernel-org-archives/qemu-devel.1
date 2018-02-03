Received: from eggs.gnu.org ([2001:4830:134:3::10]:34443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtjs-0007dg-DC
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtjp-0005WQ-5E
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:04:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehtjo-0005WA-U0
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 04:03:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-7-armbru@redhat.com>
	<05068311-b8db-69b0-9c86-50839994f630@redhat.com>
Date: Sat, 03 Feb 2018 10:03:51 +0100
In-Reply-To: <05068311-b8db-69b0-9c86-50839994f630@redhat.com> (Eric Blake's
	message of "Fri, 2 Feb 2018 13:27:32 -0600")
Message-ID: <87lgga4f7s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 06/21] qapi-gen: New common driver for
 code and doc generators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/02/2018 07:03 AM, Markus Armbruster wrote:
>> Whenever qapi-schema.json changes, we run six programs eleven times to
>> update eleven files.  This is silly.  Replace the six programs by a
>> single program that spits out all eleven files.
>
> Yay, about time!
>
> One program, but still invoked multiple times:
>
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  Makefile                                           | 86 ++++++++++------------
>>  scripts/qapi-gen.py                                | 41 +++++++++++
>>  scripts/qapi/__init__.py                           |  0
>>  scripts/{qapi-commands.py => qapi/commands.py}     | 23 ++----
>>  scripts/{qapi.py => qapi/common.py}                |  0
>>  scripts/{qapi2texi.py => qapi/doc.py}              | 29 ++------
>>  scripts/{qapi-event.py => qapi/events.py}          | 23 ++----
>>  scripts/{qapi-introspect.py => qapi/introspect.py} | 32 ++------
>>  scripts/{qapi-types.py => qapi/types.py}           | 34 ++-------
>>  scripts/{qapi-visit.py => qapi/visit.py}           | 34 ++-------
>
> Maybe the commit message should mention:
>
> This requires moving some files around for proper use in python.

Yes, I should mention that I wrap the QAPI modules in a Python package.

>>  tests/Makefile.include                             | 56 +++++++-------
>>  tests/qapi-schema/test-qapi.py                     |  2 +-
>>  12 files changed, 140 insertions(+), 220 deletions(-)
>>  create mode 100755 scripts/qapi-gen.py
>>  create mode 100644 scripts/qapi/__init__.py
>>  rename scripts/{qapi-commands.py => qapi/commands.py} (94%)
>>  rename scripts/{qapi.py => qapi/common.py} (100%)
>>  rename scripts/{qapi2texi.py => qapi/doc.py} (92%)
>>  mode change 100755 => 100644
>
> Unintinentional?  We're inconsistent on which of our *.py files are
> executable in git.  Does it matter whether a file that is designed for
> use as a module is marked executable (if so, perhaps 5/21 should be
> adding the x attribute on other files, rather than this patch removing
> it on the doc generator).

qapi2texi.py is no longer runnable as a standalone program after this
patch.

So are qapi-{commands,events,introspect,types,visit}.py, but they never
had the executable bit set.

>> +++ b/Makefile
>
>> +qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
>> +qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h \
>> +qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal.c \
>> +qga/qapi-generated/qga-qapi.texi: \
>> +qga/qapi-generated/qapi-gen-timestamp ;
>> +qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
>> +	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
>> +		-o qga/qapi-generated -p "qga-" $<, \
>> +		"GEN","$(@:%-timestamp=%)")
>> +	@>$@
>
> once for qga,

That's the QAPI/QGA schema.  The commit message talks about the QAPI/QMP
schema.  I wish the two weren't named the same.

Modularization might make fusing them possible.  Whether that's a good
idea I don't know.

>> +qapi-types.c qapi-types.h \
>> +qapi-visit.c qapi-visit.h \
>> +qmp-commands.h qmp-marshal.c \
>> +qapi-event.c qapi-event.h \
>> +qmp-introspect.h qmp-introspect.c \
>> +qapi.texi: \
>> +qapi-gen-timestamp ;
>> +qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
>> +	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
>> +		-o "." -b $<, \
>> +		"GEN","$(@:%-timestamp=%)")
>> +	@>$@
>
> and again for the main level.  Still, a definite improvement!

Perhaps I can find a way to clarify the commit message.

>> +++ b/scripts/qapi-gen.py
>
>> +def main(argv):
>> +    (input_file, output_dir, do_c, do_h, prefix, opts) = \
>> +        parse_command_line('bu', ['builtins', 'unmask-non-abi-names'])
>> +
>> +    opt_builtins = False
>> +    opt_unmask = False
>> +
>> +    for o, a in opts:
>> +        if o in ('-b', '--builtins'):
>> +            opt_builtins = True
>> +        if o in ('-u', '--unmask-non-abi-names'):
>> +            opt_unmask = True
>> +
>> +    schema = QAPISchema(input_file)
>> +
>> +    gen_types(schema, output_dir, prefix, opt_builtins)
>> +    gen_visit(schema, output_dir, prefix, opt_builtins)
>> +    gen_commands(schema, output_dir, prefix)
>> +    gen_events(schema, output_dir, prefix)
>> +    gen_introspect(schema, output_dir, prefix, opt_unmask)
>> +    gen_doc(schema, output_dir, prefix)
>
> Rather simple, but definitely nicer all in one python file than as a
> series of make rules.
>
>> @@ -255,13 +255,8 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>>          self._regy += gen_register_command(name, success_response)
>>  
>>  
>> -def main(argv):
>> -    (input_file, output_dir, do_c, do_h, prefix, opts) = parse_command_line()
>> -
>> -    blurb = '''
>> - * Schema-defined QAPI/QMP commands
>> -'''
>> -
>> +def gen_commands(schema, output_dir, prefix):
>> +    blurb = ' * Schema-defined QAPI/QMP commands'
>
> Some churn on the definition of blurb; worth tidying this in the
> introduction earlier in the series?

Doesn't seem worth a separate patch, but I can try to reshuffle things
to reduce churn.

>> rename to scripts/qapi/introspect.py
>> index 09e7d1f140..2153060f2c 100644
>> --- a/scripts/qapi-introspect.py
>> +++ b/scripts/qapi/introspect.py
>> @@ -10,7 +10,7 @@ This work is licensed under the terms of the GNU GPL, version 2.
>>  See the COPYING file in the top-level directory.
>>  """
>>  
>> -from qapi import *
>> +from qapi.common import *
>>  
>>  
>>  # Caveman's json.dumps() replacement (we're stuck at Python 2.4)
>> @@ -168,22 +168,8 @@ const char %(c_name)s[] = %(c_string)s;
>>          self._gen_json(name, 'event', {'arg-type': self._use_type(arg_type)})
>>  
>>  
>> -def main(argv):
>> -    # Debugging aid: unmask QAPI schema's type names
>> -    # We normally mask them, because they're not QMP wire ABI
>> -    opt_unmask = False
>> -
>> -    (input_file, output_dir, do_c, do_h, prefix, opts) = \
>> -        parse_command_line('u', ['unmask-non-abi-names'])
>
> Hmm - we didn't have any docs about this hidden command line option; I
> see you still preserved it, but it may be worth mentioning in your
> pending doc updates for the series respin.

Maybe.

Providing --help would probably be more useful.  We should convert
qapi-gen.py to argparse.

>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -23,7 +23,16 @@ check-help:
>>  ifneq ($(wildcard config-host.mak),)
>>  export SRC_PATH
>>  
>> -qapi-py = $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.py
>> +# TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here
>> +qapi-py = $(SRC_PATH)/scripts/qapi/commands.py \
>> +$(SRC_PATH)/scripts/qapi/events.py \
>> +$(SRC_PATH)/scripts/qapi/introspect.py \
>> +$(SRC_PATH)/scripts/qapi/types.py \
>> +$(SRC_PATH)/scripts/qapi/visit.py \
>> +$(SRC_PATH)/scripts/qapi/common.py \
>> +$(SRC_PATH)/scripts/qapi/doc.py \
>> +$(SRC_PATH)/scripts/ordereddict.py \
>> +$(SRC_PATH)/scripts/qapi-gen.py
>
> So, were you counting these in the 11 generated files mentioned in the
> commit message? :)

I'm not sure I understand what you mean here...
