Received: from eggs.gnu.org ([2001:4830:134:3::10]:51351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZv9A-0003sJ-2W
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZv96-0005JQ-Ug
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:24:52 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:46346)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZv96-0005IW-I5
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:24:48 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<150091841019.30739.3661641061220051037.stgit@frigg.lan>
	<109e1849-1bf6-5875-b304-7cacbf45f068@redhat.com>
Date: Tue, 25 Jul 2017 11:24:35 +0300
In-Reply-To: <109e1849-1bf6-5875-b304-7cacbf45f068@redhat.com> (Eric Blake's
	message of "Mon, 24 Jul 2017 13:03:46 -0500")
Message-ID: <87wp6wgbzw.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/13] instrument: [qapi] Add library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Eric Blake writes:

> On 07/24/2017 12:46 PM, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> instrument/Makefile.objs |    1 +
>> instrument/qmp.c         |   71 ++++++++++++++++++++++++++++++++++++
>> qapi-schema.json         |    3 ++
>> qapi/instrument.json     |   92 ++++++++++++++++++++++++++++++++++++++++=
++++++
>> 4 files changed, 167 insertions(+)
>> create mode 100644 instrument/qmp.c
>> create mode 100644 qapi/instrument.json

> Adding new files; but I don't see a patch to MAINTAINERS to cover
> instrument/*.

Who should I put as a maintainer? Or does this go to the general maintainer=
(s)?


>> +++ b/qapi/instrument.json
>> @@ -0,0 +1,92 @@
>> +# *-*- Mode: Python -*-*
>> +#
>> +# QAPI trace instrumentation control commands.
>> +#
>> +# Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>> +# See the COPYING file in the top-level directory.
>> +
>> +##
>> +# @InstrLoadCode:
>> +#
>> +# Result code of an 'instr-load' command.
>> +#
>> +# @ok: Correctly loaded.
>> +# @unavailable: Service not available.
>> +# @error: Error with libdl (see 'msg').
>> +#
>> +# Since: 2.10

> This is a new feature, and you've missed soft freeze.  You'll want to
> use 2.11 throughout the file.

Thx!


>> +##
>> +{ 'enum': 'InstrLoadCode',
>> +  'data': [ 'ok', 'unavailable', 'error' ] }
>> +
>> +##
>> +# @InstrLoadResult:
>> +#
>> +# Result of an 'instr-load' command.
>> +#
>> +# @code: Result code.
>> +# @msg: Additional error message.

> Worth a comment that the message is for human consumption, and should
> not be further parsed by machine?

> Should msg be optional, present only when there is an error?

True.


>> +# @handle: Instrumentation library identifier (undefined in case of err=
or).

> Should it be an optional member, omitted when there is an error?

Also true.


>> +#
>> +# Since: 2.10
>> +##
>> +{ 'struct': 'InstrLoadResult',
>> +  'data': { 'code': 'InstrLoadCode', 'msg': 'str', 'handle': 'int' } }
>> +
>> +##
>> +# @instr-load:
>> +#
>> +# Load an instrumentation library.
>> +#
>> +# @path: path to the dynamic instrumentation library
>> +# @args: arguments to the dynamic instrumentation library
>> +#
>> +# Since: 2.10
>> +##
>> +{ 'command': 'instr-load',
>> +  'data':    { 'path': 'str', '*args': ['String'] },

> Why are you double-nesting things?  It's a lot nicer to use ['str']
> (that is, your way requires
>  "arguments":{"path":"/some/path",
>    "args": [ { "str": "string1" }, { "str": "string2" } ] }

> whereas mine only needs:
>  "arguments":{"path":"/some/path", "args":[ "string1", "string2" ]}

Aha, you mean the definition should be this instead?

  { 'command': 'instr-load',
    'data':    { 'path': 'str', '*args': ['str'] },
    'returns': 'InstrLoadResult' }


>> +  'returns': 'InstrLoadResult' }
>> +
>> +
>> +##
>> +# @InstrUnloadCode:
>> +#
>> +# Result code of an 'instr-unload' command.
>> +#
>> +# @ok: Correctly unloaded.
>> +# @unavailable: Service not available.
>> +# @invalid: Invalid handle.
>> +# @error: Error with libdl (see 'msg').
>> +#
>> +# Since: 2.10
>> +##
>> +{ 'enum': 'InstrUnloadCode',
>> +  'data': [ 'ok', 'unavailable', 'invalid', 'error' ] }
>> +
>> +##
>> +# @InstrUnloadResult:
>> +#
>> +# Result of an 'instr-unload' command.
>> +#
>> +# @code: Result code.
>> +# @msg: Additional error message.

> Again, should msg be optional?  Document that it is only for human
> consumption.

Ok.


>> +#
>> +# Since: 2.10
>> +##
>> +{ 'struct': 'InstrUnloadResult',
>> +  'data': { 'code': 'InstrUnloadCode', 'msg': 'str' } }
>> +
>> +##
>> +# @instr-unload:
>> +#
>> +# Unload an instrumentation library.
>> +#
>> +# @handle: Instrumentation library identifier (see #InstrLoadResult).
>> +#
>> +# Since: 2.10
>> +##
>> +{ 'command': 'instr-unload',
>> +  'data': { 'handle': 'int' },
>> +  'returns': 'InstrUnloadResult' }
>>=20
>>=20


Thanks,
  Lluis
