Received: from eggs.gnu.org ([2001:4830:134:3::10]:60056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBNyD-000317-BX
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 13:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBNy8-0004SY-BO
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 13:12:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBNy8-0004Id-5j
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 13:12:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8525F10DF
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 17:12:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-6-lersek@redhat.com>
	<877eovahoq.fsf@dusky.pond.sub.org>
	<5ffb031a-554a-81c1-b374-eb82f410bf83@redhat.com>
Date: Wed, 25 Apr 2018 19:12:20 +0200
In-Reply-To: <5ffb031a-554a-81c1-b374-eb82f410bf83@redhat.com> (Laszlo Ersek's
	message of "Wed, 25 Apr 2018 15:20:13 +0200")
Message-ID: <87604f6wi3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/6] qapi: extract CpuInfoCommon to
 mitigate schema duplication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org

Laszlo Ersek <lersek@redhat.com> writes:

> On 04/25/18 09:06, Markus Armbruster wrote:
>> Laszlo Ersek <lersek@redhat.com> writes:
>> 
>>> @CpuInfo and @CpuInfoFast duplicate the following four fields: @qom-path,
>>> @thread-id, @props and @arch. From these, extract the first three to a
>>> common structure called @CpuInfoCommon. (More on @arch later.)
>>>
>>> Introduce two new mid-layer structures, @CpuInfoBase and @CpuInfoFastBase,
>>> to soak up the union base struct fields on top of @CpuInfoCommon that are
>>> specific to @query-cpus and @query-cpus-fast, respectively.
>
> [[
>
>>> This is
>>> necessary because the base struct spec in union definitions does not let
>>> us mix named fields with a recursive base struct. (In other words, we
>>> couldn't directly use @CpuInfoCommon *plus* some other fields within
>>> @CpuInfo and @CpuInfoFast as base struct).
>
> ]]
>
>> 
>> Yes, you can either specify a base type or inline common members.  If
>> "union's common members = base type plus additional inline members"
>> turns out to be desirable in more places, we can try to add the feature.
>> I'm not asking *you* to find out, let alone try :)
>
> [[
>
>>> @arch cannot be hoisted higher than to @CpuInfoBase and @CpuInfoFastBase
>>> because the union descriminator is only accepted from a direct base
>>> struct, not from an indirect one.
>
> ]]
>
>> That's a bit of a blemish.  Again, I'm not asking you to do anything
>> about it.
>
> If these characteristics of the generator are operating knowledge for
> QAPI developers, I can trim the commit message -- those traits don't
> bother me at all, I just felt that I needed to justify the code.
>
> IOW, should I drop:
> - the sentences marked with [[ ]] above,
> - and/or the "Notes:" on @arch in the schema itself (which are updated
>   to @target, in the next patch)
> ?

Let's keep them.

>
> [snip]
>
>>> @@ -512,70 +541,77 @@
>>>  #
>>>  # Since: 0.14.0
>>>  #
>>>  # Example:
>>>  #
>>>  # -> { "execute": "query-cpus" }
>>>  # <- { "return": [
>>>  #          {
>>>  #             "CPU":0,
>>>  #             "current":true,
>>>  #             "halted":false,
>>> -#             "qom_path":"/machine/unattached/device[0]",
>>> +#             "qom-path":"/machine/unattached/device[0]",
>>>  #             "arch":"x86",
>>>  #             "pc":3227107138,
>>> -#             "thread_id":3134
>>> +#             "thread-id":3134
>>>  #          },
>>>  #          {
>>>  #             "CPU":1,
>>>  #             "current":false,
>>>  #             "halted":true,
>>> -#             "qom_path":"/machine/unattached/device[2]",
>>> +#             "qom-path":"/machine/unattached/device[2]",
>>>  #             "arch":"x86",
>>>  #             "pc":7108165,
>>> -#             "thread_id":3135
>>> +#             "thread-id":3135
>>>  #          }
>>>  #       ]
>>>  #    }
>> 
>> Compatibility break, whoops!
>
> But, at least, I updated the example! :)

Thanks :)

>> CpuInfo and CpuInfoFast do share qom-path and thread-id *values*, but
>> the keys differ in '_' vs. '-'.  Sad.
>> 
>> What now?  Is there enough common stuff left to justify the refactoring?
>
> While working on the schema changes, I saw the '_' vs. '-' difference
> immediately, but I thought these two characters were treated
> equivalently by all QAPI clients.

I wish...

QEMU could do that on QMP input.  We've talked about it, but no patches.

On QMP output, we're screwed.

Tolerating '_' was one of the dumber mistakes in QAPI.

> Later I found (in the test suite) that this wasn't the case, so I
> thought my memories must have applied to libvirtd only. (Because,
> libvirt does map "_" to "-", right?) Anyway, I figured the best way to
> ask was to post the patch like this :)

Heh.  I would've appreciated a hint in the commit message, though.

> So, if I drop @qom-path and @thread-id from CpuInfoCommon, then only
> @props remains subject to hoisting, in this patch. In the next patch,
> @arch joins @props.
>
> I believe the refactoring is still worth doing, because otherwise, after
> the addition of @target, we'd end up with:
>
> { 'union' : 'CpuInfo',
>   'base'  : { 'CPU'       : 'int',
>               'current'   : 'bool',
>               'halted'    : 'bool',
>               'qom_path'  : 'str',
>               'thread_id' : 'int',
>               '*props'    : 'CpuInstanceProperties',
>               'arch'      : 'CpuInfoArch',
>               'target'    : 'SysEmuTarget' },
> ...
>
> { 'union' : 'CpuInfoFast',
>   'base'  : { 'cpu-index' : 'int',
>               'qom-path'  : 'str',
>               'thread-id' : 'int',
>               '*props'    : 'CpuInstanceProperties',
>               'arch'      : 'CpuInfoArch',
>               'target'    : 'SysEmuTarget' },
> ...
>
> and people would ask themselves ever after, "are there some common
> fields in there that we could extract ... hmmm, @props and @arch, okay,
> maybe, maybe not, grey area". Let's do it now and save them the thinking.

Works for me.

> [snip]
>
>>> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
>>> index 25bce78352b8..5bfd2ef1dd3b 100644
>>> --- a/qapi/qapi-schema.json
>>> +++ b/qapi/qapi-schema.json
>>> @@ -61,23 +61,23 @@
>>>          'query-migrate-cache-size',
>>>          'query-tpm-models',
>>>          'query-tpm-types',
>>>          'ringbuf-read' ],
>>>      'name-case-whitelist': [
>>>          'ACPISlotType',         # DIMM, visible through query-acpi-ospm-status
>>>          'CpuInfoMIPS',          # PC, visible through query-cpu
>>>          'CpuInfoTricore',       # PC, visible through query-cpu
>>>          'QapiErrorClass',       # all members, visible through errors
>>>          'UuidInfo',             # UUID, visible through query-uuid
>>>          'X86CPURegister32',     # all members, visible indirectly through qom-get
>>> -        'q_obj_CpuInfo-base'    # CPU, visible through query-cpu
>>> +        'CpuInfoBase'           # CPU, visible through query-cpu
>> 
>> Let's update this to "visible through query-cpus, query-cpus-fast" while
>> there.
>
> Right, I noticed the typo in the preexistent comment too late (and I
> didn't notice the "query-cpus-fast" omission at all).
>
> Thanks!

You're welcome!
