Received: from eggs.gnu.org ([2001:4830:134:3::10]:58461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eixwV-0007V8-Km
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eixwS-0007b3-C5
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:45:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eixwR-0007aZ-SJ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:45:24 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-7-armbru@redhat.com>
	<05068311-b8db-69b0-9c86-50839994f630@redhat.com>
	<87lgga4f7s.fsf@dusky.pond.sub.org>
	<0e3ea662-418e-0574-3817-434b35e85887@redhat.com>
Date: Tue, 06 Feb 2018 08:45:18 +0100
In-Reply-To: <0e3ea662-418e-0574-3817-434b35e85887@redhat.com> (Eric Blake's
	message of "Mon, 5 Feb 2018 09:52:41 -0600")
Message-ID: <87a7wmfto1.fsf@dusky.pond.sub.org>
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/03/2018 03:03 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 02/02/2018 07:03 AM, Markus Armbruster wrote:
>>>> Whenever qapi-schema.json changes, we run six programs eleven times to
>>>> update eleven files.  This is silly.  Replace the six programs by a
>>>> single program that spits out all eleven files.
>>>
>>> Yay, about time!
>>>
>>> One program, but still invoked multiple times:
>>>
>
>>>>  rename scripts/{qapi2texi.py => qapi/doc.py} (92%)
>>>>  mode change 100755 => 100644
>>>
>>> Unintinentional?  We're inconsistent on which of our *.py files are
>>> executable in git.  Does it matter whether a file that is designed for
>>> use as a module is marked executable (if so, perhaps 5/21 should be
>>> adding the x attribute on other files, rather than this patch removing
>>> it on the doc generator).
>> 
>> qapi2texi.py is no longer runnable as a standalone program after this
>> patch.
>> 
>> So are qapi-{commands,events,introspect,types,visit}.py, but they never
>> had the executable bit set.
>
> Okay, so dropping the bit consistently makes sense; still, a mention in
> the commit message wouldn't hurt.

Can do.

>>>> +++ b/Makefile
>>>
>>>> +qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
>>>> +qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h \
>>>> +qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal.c \
>>>> +qga/qapi-generated/qga-qapi.texi: \
>>>> +qga/qapi-generated/qapi-gen-timestamp ;
>>>> +qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
>>>> +	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
>>>> +		-o qga/qapi-generated -p "qga-" $<, \
>>>> +		"GEN","$(@:%-timestamp=%)")
>>>> +	@>$@
>>>
>>> once for qga,
>> 
>> That's the QAPI/QGA schema.  The commit message talks about the QAPI/QMP
>> schema.  I wish the two weren't named the same.
>
> 7 files here,...
>
>> 
>> Modularization might make fusing them possible.  Whether that's a good
>> idea I don't know.
>> 
>>>> +qapi-types.c qapi-types.h \
>>>> +qapi-visit.c qapi-visit.h \
>>>> +qmp-commands.h qmp-marshal.c \
>>>> +qapi-event.c qapi-event.h \
>>>> +qmp-introspect.h qmp-introspect.c \
>>>> +qapi.texi: \
>>>> +qapi-gen-timestamp ;
>>>> +qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
>>>> +	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
>>>> +		-o "." -b $<, \
>>>> +		"GEN","$(@:%-timestamp=%)")
>>>> +	@>$@
>>>
>>> and again for the main level.  Still, a definite improvement!
>
> 11 files here,...
>
>> 
>> Perhaps I can find a way to clarify the commit message.
>> 
>
> [1]
>
>
>>>> -def main(argv):
>>>> -    (input_file, output_dir, do_c, do_h, prefix, opts) = parse_command_line()
>>>> -
>>>> -    blurb = '''
>>>> - * Schema-defined QAPI/QMP commands
>>>> -'''
>>>> -
>>>> +def gen_commands(schema, output_dir, prefix):
>>>> +    blurb = ' * Schema-defined QAPI/QMP commands'
>>>
>>> Some churn on the definition of blurb; worth tidying this in the
>>> introduction earlier in the series?
>> 
>> Doesn't seem worth a separate patch, but I can try to reshuffle things
>> to reduce churn.
>
> Yeah, my question was more about the conversion between multiline
> '''...''' to single-line '...'; why not just use the single-line
> construct earlier in the series when introducing the blurb variable.

Introduced in PATCH 01:

    -c_comment = '''
    -/*
    - * schema-defined QMP->QAPI command dispatch
    +blurb = '''
    + * Schema-defined QAPI/QMP commands
      *
      * Copyright IBM, Corp. 2011
      *
      * Authors:
      *  Anthony Liguori   <aliguori@us.ibm.com>
    - *
    - * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
    - * See the COPYING.LIB file in the top-level directory.
    - *
    - */
    -'''

Shortened in PATCH 02:

     blurb = '''
      * Schema-defined QAPI/QMP commands
    - *
    - * Copyright IBM, Corp. 2011
    - *
    - * Authors:
    - *  Anthony Liguori   <aliguori@us.ibm.com>
     '''

Reformatted in PATCH 06 (see above).

Moved in PATCH 16 to visitor's __init__ for types and visits (the rest
aren't implemented, yet):

     class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
    -    def __init__(self, opt_builtins):
    +    def __init__(self, opt_builtins, prefix):
             self._opt_builtins = opt_builtins
    -        self.decl = None
    -        self.defn = None
    -        self._fwdecl = None
    -        self._btin = None
    +        self._prefix = prefix
    +        blurb = ' * Schema-defined QAPI types'
    +        self._genc = QAPIGenC(blurb, __doc__)
    +        self._genh = QAPIGenH(blurb, __doc__)

Variable eliminated there in PATCH 17:

    -        blurb = ' * Schema-defined QAPI types'
    -        self._genc = QAPIGenC(blurb, __doc__)
    -        self._genh = QAPIGenH(blurb, __doc__)
    +        self._module = {}
    +        self._add_module(None, ' * Built-in QAPI types')

I could delay the reformatting until PATCH 16, or do it in PATCH 02.
Feels like a wash to me, but if you have a preference...

> You are right that creating blurb didn't need a separate patch, just
> less churn over the series.
>
>>>>  
>>>> -qapi-py = $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.py
>>>> +# TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here
>>>> +qapi-py = $(SRC_PATH)/scripts/qapi/commands.py \
>>>> +$(SRC_PATH)/scripts/qapi/events.py \
>>>> +$(SRC_PATH)/scripts/qapi/introspect.py \
>>>> +$(SRC_PATH)/scripts/qapi/types.py \
>>>> +$(SRC_PATH)/scripts/qapi/visit.py \
>>>> +$(SRC_PATH)/scripts/qapi/common.py \
>>>> +$(SRC_PATH)/scripts/qapi/doc.py \
>>>> +$(SRC_PATH)/scripts/ordereddict.py \
>>>> +$(SRC_PATH)/scripts/qapi-gen.py
>>>
>>> So, were you counting these in the 11 generated files mentioned in the
>>> commit message? :)
>> 
>> I'm not sure I understand what you mean here...
>
> [1] and 9 more files.  So, the commit message only mentioned the 11 QMP
> files, rather than all 27 (if I counted right) QAPI generated files.  My
> comments were trying to point out that you simplified more than just the
> QMP code generation into fewer script invocations, and the counts looked
> off since out of the three spots converted, only one of the spots had 11
> files.

The commit message talks only about the QAPI/QMP schema.  It's confusing
because our poor taste in file names creates ambiguity: does
qapi-schema.json refer to ./qapi-schema.json (i.e. the QAPI/QMP one),
qga/qapi-schema.json, or both?

Perhaps I should rename qapi-schema.json to qapi/schema.json.

The commit message needs a note along the lines of "same for
qga/qapi-schema.json".
