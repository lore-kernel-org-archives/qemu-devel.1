Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF809C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 00:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F1921534
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 00:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8OIKcNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F1921534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLEj9-000320-8T
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 20:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLEh0-0001jr-3C
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 20:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLEgx-0005DE-7E
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 20:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600905654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZcH9Wrt54WJ7SZOZp1O/F7+SbKjXHbLyG10kXcF0r9w=;
 b=H8OIKcNitvGinSqVq2aYyVpYKMnoZAyNECoBskZiD+8bMxLh33T6bPEDd8K/o/ale3XFvj
 2HViXiS/3qpTnErTXxejf2jAA8j88hukwQcIM9baYoFvCg8a7E3rCVT8QlvVrCOKL7uTfV
 pztTdLOiWFQF/RkufDpXiyuPTJ+26Cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-DoJ0qmehO-W3x6CewDw-Og-1; Wed, 23 Sep 2020 20:00:45 -0400
X-MC-Unique: DoJ0qmehO-W3x6CewDw-Og-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22598425E3;
 Thu, 24 Sep 2020 00:00:44 +0000 (UTC)
Received: from [10.3.114.2] (ovpn-114-2.phx2.redhat.com [10.3.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C43E75D731;
 Thu, 24 Sep 2020 00:00:39 +0000 (UTC)
Subject: Re: [PATCH v8 4/7] scripts: add block-coroutine-wrapper.py
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-5-vsementsov@virtuozzo.com>
 <be6408ba-a430-0294-96e8-a38af7f94c1b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <73781605-a817-c627-fea9-183caf84c4b6@redhat.com>
Date: Wed, 23 Sep 2020 19:00:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <be6408ba-a430-0294-96e8-a38af7f94c1b@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 3:02 PM, Vladimir Sementsov-Ogievskiy wrote:
> 15.09.2020 19:44, Vladimir Sementsov-Ogievskiy wrote:
>> We have a very frequent pattern of creating coroutine from function
>> with several arguments:
>>
>>    - create structure to pack parameters
>>    - create _entry function to call original function taking parameters
>>      from struct
>>    - do different magic to handle completion: set ret to NOT_DONE or
>>      EINPROGRESS or use separate bool field
>>    - fill the struct and create coroutine from _entry function and this
>>      struct as a parameter
>>    - do coroutine enter and BDRV_POLL_WHILE loop
>>
>> Let's reduce code duplication by generating coroutine wrappers.
>>
>> This patch adds scripts/block-coroutine-wrapper.py together with some
>> friends, which will generate functions with declared prototypes marked
>> by 'generated_co_wrapper' specifier.
>>

>>
>>      4. add header with generated_co_wrapper declaration into
>>         COROUTINE_HEADERS list in Makefile

This phrase is out-of-date.  I also see 4 steps here,...

>>
>> Still, no function is now marked, this work is for the following
>> commit.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
>> ---
>>   docs/devel/block-coroutine-wrapper.rst |  54 +++++++
>>   block/block-gen.h                      |  49 +++++++
>>   include/block/block.h                  |  10 ++
>>   block/meson.build                      |   8 ++
>>   scripts/block-coroutine-wrapper.py     | 187 +++++++++++++++++++++++++
>>   5 files changed, 308 insertions(+)
>>   create mode 100644 docs/devel/block-coroutine-wrapper.rst
>>   create mode 100644 block/block-gen.h
>>   create mode 100755 scripts/block-coroutine-wrapper.py
> 
> 
> Also needed:
> 
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index 04773ce076..cb0abe1e69 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -31,3 +31,4 @@ Contents:
>      reset
>      s390-dasd-ipl
>      clocks
> +   block-coroutine-wrapper

I've squashed that in.

> +++ b/docs/devel/block-coroutine-wrapper.rst
> @@ -0,0 +1,54 @@
> +=======================
> +block-coroutine-wrapper
> +=======================
> +
> +A lot of functions in QEMJ block layer (see ``block/*``) can by called

QEMU

s/by called only/only be called/

> +only in coroutine context. Such functions are normally marked by

by the

> +coroutine_fn specifier. Still, sometimes we need to call them from
> +non-coroutine context, for this we need to start a coroutine, run the


s/context,/context;/

> +needed function from it and wait for coroutine finish in

in a

> +BDRV_POLL_WHILE() loop. To run a coroutine we need a function with one
> +void* argument. So for each coroutine_fn function, which needs

needs a

> +non-coroutine interface, we should define a structure to pack the
> +parameters, define a separate function to unpack the parameters and
> +call the original function and finally define a new interface function
> +with same list of arguments as original one, which will pack the
> +parameters into a struct, create a coroutine, run it and wait in
> +BDRV_POLL_WHILE() loop. It's boring to create such wrappers by hand, so
> +we have a script to generate them.
> 
> +Usage
> +=====
> +
> +Assume we have defined ``coroutine_fn`` function
> +``bdrv_co_foo(<some args>)`` and need a non-coroutine interface for it,
> +called ``bdrv_foo(<same args>)``. In this case the script can help. To
> +trigger the generation:
> +
> +1. You need ``bdrv_foo`` declaration somewhere (for example in
> +   ``block/coroutines.h`` with ``generated_co_wrapper`` mark,
> +   like this:

Missing a closing ).

> +
> +.. code-block:: c
> +
> +    int generated_co_wrapper bdrv_foor(<some args>);

s/foor/foo/

> +
> +2. You need to feed this declaration to block-coroutine-wrapper script.

to the block-

> +   For this, add .h (or .c) file with the declaration to
> +   ``input: files(...)`` list of ``block_gen_c`` target declaration in
> +   ``block/meson.build``
> +
> +You are done. On build, coroutine wrappers will be generated in

s/On/During the/

> +``<BUILD_DIR>/block/block-gen.c``.

...but 2 in the .rst.  Presumably, the .rst steps belong in the commit 
message as well.

> +++ b/block/block-gen.h

> +++ b/include/block/block.h
> @@ -10,6 +10,16 @@
>  #include "block/blockjob.h"
>  #include "qemu/hbitmap.h"
>  
> +/*
> + * generated_co_wrapper
> + *
> + * Function specifier, which does nothing but marking functions to be

s/marking/mark/

> + * generated by scripts/block-coroutine-wrapper.py
> + *
> + * Read more in docs/devel/block-coroutine-wrapper.rst
> + */
> +#define generated_co_wrapper
> +
>  /* block.c */
>  typedef struct BlockDriver BlockDriver;
>  typedef struct BdrvChild BdrvChild;
> diff --git a/block/meson.build b/block/meson.build
> index a3e56b7cd1..88ad73583a 100644
> --- a/block/meson.build
> +++ b/block/meson.build
> @@ -107,6 +107,14 @@ module_block_h = custom_target('module_block.h',
>                                 command: [module_block_py, '@OUTPUT0@', modsrc])
>  block_ss.add(module_block_h)
>  
> +wrapper_py = find_program('../scripts/block-coroutine-wrapper.py')
> +block_gen_c = custom_target('block-gen.c',
> +                            output: 'block-gen.c',
> +                            input: files('../include/block/block.h',
> +                                         'coroutines.h'),
> +                            command: [wrapper_py, '@OUTPUT@', '@INPUT@'])
> +block_ss.add(block_gen_c)
> +
>  block_ss.add(files('stream.c'))

I tested that this works (I'm not a meson expert, but if it works, your 
patch can't be too far off ;)

>  
>  softmmu_ss.add(files('qapi-sysemu.c'))
> diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
> new file mode 100755
> index 0000000000..d859c07a5f
> --- /dev/null
> +++ b/scripts/block-coroutine-wrapper.py
> @@ -0,0 +1,187 @@
> +#!/usr/bin/env python3
> +"""Generate coroutine wrappers for block subsystem.
> +
> +The program parses one or several concatenated c files from stdin,
> +searches for functions with 'generated_co_wrapper' specifier

with the

> +and generates corresponding wrappers on stdout.
> +
> +Usage: block-coroutine-wrapper.py generated-file.c FILE.[ch]...
> +
> +Copyright (c) 2020 Virtuozzo International GmbH.
> +
> +This program is free software; you can redistribute it and/or modify
> +it under the terms of the GNU General Public License as published by
> +the Free Software Foundation; either version 2 of the License, or
> +(at your option) any later version.
> +
> +This program is distributed in the hope that it will be useful,
> +but WITHOUT ANY WARRANTY; without even the implied warranty of
> +MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +GNU General Public License for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +"""

John had a patch that unified how copyrights are (or are not) placed in 
doc comments.  I'm of the opinion that it may be easier to apply this 
patch as written and let him touch it up later, rather than forcing it 
to delay longer waiting for his style patches to land first, but I'm 
open to discussion on alternate approaches.

> +
> +import sys
> +import re
> +import subprocess
> +import json
> +from typing import Iterator
> +
> +
> +def prettify(code: str) -> str:
> +    """Prettify code using clang-format if available"""

Nothing else in the codebase uses clang-format, yet.  Is this an 
optional dependency we should be documenting somewhere?

> +
> +    try:
> +        style = json.dumps({
> +            'IndentWidth': 4,
> +            'BraceWrapping': {'AfterFunction': True},
> +            'BreakBeforeBraces': 'Custom',
> +            'SortIncludes': False,
> +            'MaxEmptyLinesToKeep': 2
> +        })

Is it worth always using a trailing comma, so that future additions 
don't have as many lines to touch?

> +        p = subprocess.run(['clang-format', f'-style={style}'], check=True,
> +                           encoding='utf-8', input=code,
> +                           stdout=subprocess.PIPE)
> +        return p.stdout
> +    except FileNotFoundError:
> +        return code
> +
> +
> +def gen_header():
> +    copyright = re.sub('^.*Copyright', 'Copyright', __doc__, flags=re.DOTALL)
> +    copyright = re.sub('^(?=.)', ' * ', copyright.strip(), flags=re.MULTILINE)
> +    copyright = re.sub('^$', ' *', copyright, flags=re.MULTILINE)
> +    return f"""\
> +/*
> + * File is generated by scripts/block-coroutine-wrapper.py
> + *
> +{copyright}
> + */
> +
> +#include "qemu/osdep.h"
> +#include "block/coroutines.h"
> +#include "block/block-gen.h"
> +#include "block/block_int.h"\
> +"""
> +
> +
> +class ParamDecl:
> +    param_re = re.compile(r'(?P<decl>'
> +                          r'(?P<type>.*[ *])'
> +                          r'(?P<name>[a-z][a-z0-9_]*)'
> +                          r')')
> +
> +    def __init__(self, param_decl: str) -> None:
> +        m = self.param_re.match(param_decl.strip())
> +        if m is None:
> +            raise ValueError(f'Wrong parameter declaration: "{param_decl}"')
> +        self.decl = m.group('decl')
> +        self.type = m.group('type')
> +        self.name = m.group('name')
> +
> +
> +class FuncDecl:
> +    def __init__(self, return_type: str, name: str, args: str) -> None:
> +        self.return_type = return_type.strip()
> +        self.name = name.strip()
> +        self.args = [ParamDecl(arg.strip()) for arg in args.split(',')]
> +
> +    def gen_list(self, format: str) -> str:
> +        return ', '.join(format.format_map(arg.__dict__) for arg in self.args)
> +
> +    def gen_block(self, format: str) -> str:
> +        return '\n'.join(format.format_map(arg.__dict__) for arg in self.args)
> +
> +
> +# Match wrappers declared with a generated_co_wrapper mark
> +func_decl_re = re.compile(r'^int\s*generated_co_wrapper\s*'
> +                          r'(?P<wrapper_name>[a-z][a-z0-9_]*)'
> +                          r'\((?P<args>[^)]*)\);$', re.MULTILINE)
> +
> +
> +def func_decl_iter(text: str) -> Iterator:
> +    for m in func_decl_re.finditer(text):
> +        yield FuncDecl(return_type='int',
> +                       name=m.group('wrapper_name'),
> +                       args=m.group('args'))
> +
> +
> +def snake_to_camel(func_name: str) -> str:
> +    """
> +    Convert underscore names like 'some_function_name' to camel-case like
> +    'SomeFunctionName'
> +    """
> +    words = func_name.split('_')
> +    words = [w[0].upper() + w[1:] for w in words]
> +    return ''.join(words)
> +
> +
> +def gen_wrapper(func: FuncDecl) -> str:
> +    assert func.name.startswith('bdrv_')
> +    assert not func.name.startswith('bdrv_co_')
> +    assert func.return_type == 'int'
> +    assert func.args[0].type in ['BlockDriverState *', 'BdrvChild *']
> +
> +    name = 'bdrv_co_' + func.name[5:]
> +    bs = 'bs' if func.args[0].type == 'BlockDriverState *' else 'child->bs'
> +    struct_name = snake_to_camel(name)
> +
> +    return f"""\
> +/*
> + * Wrappers for {name}
> + */
> +
> +typedef struct {struct_name} {{
> +    BdrvPollCo poll_state;
> +{ func.gen_block('    {decl};') }
> +}} {struct_name};
> +
> +static void coroutine_fn {name}_entry(void *opaque)
> +{{
> +    {struct_name} *s = opaque;
> +
> +    s->poll_state.ret = {name}({ func.gen_list('s->{name}') });

Excuse my lack of python style awareness, but why are we mixing 
{nospace} and { space } on the same line?

> +    s->poll_state.in_progress = false;
> +
> +    aio_wait_kick();
> +}}
> +
> +int {func.name}({ func.gen_list('{decl}') })
> +{{
> +    if (qemu_in_coroutine()) {{
> +        return {name}({ func.gen_list('{name}') });
> +    }} else {{
> +        {struct_name} s = {{
> +            .poll_state.bs = {bs},
> +            .poll_state.in_progress = true,
> +
> +{ func.gen_block('            .{name} = {name},') }
> +        }};
> +
> +        s.poll_state.co = qemu_coroutine_create({name}_entry, &s);
> +
> +        return bdrv_poll_co(&s.poll_state);
> +    }}
> +}}"""
> +
> +
> +def gen_wrappers_file(input_code: str) -> str:
> +    res = gen_header()
> +    for func in func_decl_iter(input_code):
> +        res += '\n\n\n'
> +        res += gen_wrapper(func)
> +
> +    return prettify(res)  # prettify to wrap long lines
> +
> +
> +if __name__ == '__main__':
> +    if len(sys.argv) < 3:
> +        exit(f'Usage: {sys.argv[0]} OUT_FILE.c IN_FILE.[ch]...')
> +
> +    with open(sys.argv[1], 'w') as f_out:
> +        for fname in sys.argv[2:]:
> +            with open(fname) as f_in:
> +                f_out.write(gen_wrappers_file(f_in.read()))
> +                f_out.write('\n')

Tested-by: Eric Blake <eblake@redhat.com>

There's enough grammar fixes, and the fact that John is working on 
python cleanups, to make me wonder if we need a v9, or if I should just 
stage it where it is with any other cleanups as followups.  But I'm 
liking the reduced maintenance burden once it is in, and don't want to 
drag it out to the point that it needs more rebasing as other things 
land first.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


