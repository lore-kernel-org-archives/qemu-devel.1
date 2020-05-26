Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98605C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 21:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE5A20870
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 21:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI04yCZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE5A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdhB6-000379-6s
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 17:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdhAD-0002a9-Lb
 for qemu-devel@nongnu.org; Tue, 26 May 2020 17:31:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43842
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdhAB-0007Oq-AX
 for qemu-devel@nongnu.org; Tue, 26 May 2020 17:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590528665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5R0oTpETcMP+RLPG2lb+5aFcW8JV7gzt4egng7UcXg=;
 b=EI04yCZa+qVmiz1MbxFYZOpjxRt2UDx+S+A7LeAU0hHzlDbgL24Ib19WcKV3sMhRoLvxZS
 LTlkqZOVR8OPndSmWH3e4Gw85n4he40kHea/M/CDK4jxDAIU43Qby6ijJhJ6paF/Elb3Hj
 n4W5UHkfQkLfNijaQCxaHU1UcXOFC6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-ZQHUVKLvOPmAOYgfHfGsXA-1; Tue, 26 May 2020 17:30:49 -0400
X-MC-Unique: ZQHUVKLvOPmAOYgfHfGsXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 271D084B8A5;
 Tue, 26 May 2020 21:30:48 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82BC410013D7;
 Tue, 26 May 2020 21:30:41 +0000 (UTC)
Subject: Re: [PATCH v4 3/5] block: generate coroutine-wrapper code
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200525100801.13859-1-vsementsov@virtuozzo.com>
 <20200525100801.13859-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7cd429d4-d346-b019-3f72-e98fa55593f9@redhat.com>
Date: Tue, 26 May 2020 16:30:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525100801.13859-4-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 5:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> We have a very frequent pattern of creating coroutine from function
> with several arguments:
> 
>    - create structure to pack parameters
>    - create _entry function to call original function taking parameters
>      from struct
>    - do different magic to handle completion: set ret to NOT_DONE or
>      EINPROGRESS, use separate bool for void functions
>    - fill the struct and create coroutine from _entry function and this
>      struct as a parameter
>    - do coroutine enter and BDRV_POLL_WHILE loop
> 
> Let's reduce code duplication. Here:
> 
> Functional part (BDRV_POLL_WHILE loop, aio_wait_kick()) moved to
> (non-generated) block/block-gen.h
> 
> Mechanical part (arguments packing, different kind of needed wrappers)
> are generated from template by scripts/coroutine-wrapper.py to
> resulting file block/block-gen.c
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> @@ -175,6 +177,10 @@ generated-files-y += $(TRACE_SOURCES)
>   generated-files-y += $(BUILD_DIR)/trace-events-all
>   generated-files-y += .git-submodule-status
>   
> +COROUTINE_HEADERS = include/block/block.h block/coroutines.h
> +block/block-gen.c: $(COROUTINE_HEADERS) $(SRC_PATH)/scripts/coroutine-wrapper.py
> +	$(call quiet-command, cat $(COROUTINE_HEADERS) | $(SRC_PATH)/scripts/coroutine-wrapper.py > $@,"GEN","$(TARGET_DIR)$@")
> +

Not VPATH-friendly; I posted a proposed fixup! separately.

>   trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
>   
>   tracetool-y = $(SRC_PATH)/scripts/tracetool.py
> diff --git a/Makefile.objs b/Makefile.objs
> index 99774cfd25..8cb20f94c3 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -14,7 +14,7 @@ chardev-obj-y = chardev/
>   authz-obj-y = authz/
>   
>   block-obj-y = block/ block/monitor/ nbd/ scsi/
> -block-obj-y += block.o blockjob.o job.o
> +block-obj-y += block.o blockjob.o job.o block/block-gen.o

It may be cleaner to add this in block/Makefile.objs rather than in 
top-level Makefile.objs.  In fact, rearranging your mail a bit...

 > diff --git a/block/Makefile.objs b/block/Makefile.objs
 > index 3635b6b4c1..05e4d033c1 100644
 > --- a/block/Makefile.objs
 > +++ b/block/Makefile.objs
 > @@ -45,6 +45,7 @@ block-obj-y += crypto.o
 >   block-obj-y += aio_task.o
 >   block-obj-y += backup-top.o
 >   block-obj-y += filter-compress.o
 > +block-obj-y += block-gen.o
 >   common-obj-y += monitor/
 >
 >   block-obj-y += stream.o

...you did just that.  Dropping the change to top-level Makefile.objs 
seems to make no difference to a correct build.

> +++ b/block/block-gen.h
> @@ -0,0 +1,55 @@
> +/*
> + * Block layer I/O functions

Is this still the best one-line summary for this file?  Especially since...

> +
> +/* This function is called at the end of generated coroutine entries. */
> +static inline void bdrv_poll_co__on_exit(void)
> +{
> +    aio_wait_kick();
> +}
> +
> +/* Base structure for argument packing structures */
> +typedef struct BdrvPollCo {
> +    BlockDriverState *bs;
> +    bool in_progress;
> +    int ret;
> +    Coroutine *co; /* Keep pointer here for debugging */
> +} BdrvPollCo;
> +
> +static inline int bdrv_poll_co(BdrvPollCo *s)
> +{
> +    assert(!qemu_in_coroutine());
> +
> +    bdrv_coroutine_enter(s->bs, s->co);
> +    BDRV_POLL_WHILE(s->bs, s->in_progress);
> +
> +    return s->ret;
> +}

This part looks fine.


> +++ b/include/block/generated-co-wrapper.h
> @@ -0,0 +1,35 @@
> +/*
> + * Block layer I/O functions

...you repeat it here?

> +/*
> + * generated_co_wrapper
> + * Function specifier, which does nothing but marking functions to be
> + * generated by scripts/coroutine-wrapper.py
> + */
> +#define generated_co_wrapper
> +
> +#endif /* BLOCK_GENERATED_CO_WRAPPER_H */

Not sure if a separate header was needed for this, but I guess it 
doesn't hurt.  I might have just used block_int.h.

> diff --git a/block.c b/block.c
> index 7f06e82880..c1132ab323 100644
> --- a/block.c
> +++ b/block.c
> @@ -4640,43 +4640,6 @@ int coroutine_fn bdrv_co_check(BlockDriverState *bs,
>       return bs->drv->bdrv_co_check(bs, res, fix);
>   }
>   
> -typedef struct CheckCo {
> -    BlockDriverState *bs;
> -    BdrvCheckResult *res;
> -    BdrvCheckMode fix;
> -    int ret;
> -} CheckCo;

This patch is doing two things - introducing a new generator script that 
scans the code for generated_co_wrapper tags, _and_ adds the tags in as 
many places as possible.  It makes for a big patch.  Better might have 
been to introduce the script and the concept of a tag in one patch but 
not actually tag any new functions (so the generated file is basically 
empty, but you prove the build works and can audit the script without 
being bogged down by the mechanical changes), then do a separate patch 
with adding the tags and deleting the code now covered by the generator 
(which will be mostly mechanical).

> +++ b/scripts/coroutine-wrapper.py
> @@ -0,0 +1,168 @@
> +#!/usr/bin/env python3

My python review skills are weak, so you'll probably want another 
reviewer here (although I _can_ state that I checked the generated 
block/block-gen.c file and it makes sense).


> +import re
> +from typing import List, Iterator
> +
> +header = '''/*
> + * File is generated by scripts/coroutine-wrapper.py
> + */

It's worth also generating a short copyright blurb into the generated file.

> +
> +#include "qemu/osdep.h"
> +#include "block/coroutines.h"
> +#include "block/block-gen.h"'''
> +
> +template = """

Why ''' above and """ here?  While python accepts both forms, 
consistency is desirable.  I have no idea what pylint thinks of your 
code, though, so I may be completely overlooking idiomatic styles.

> +
> +/*
> + * Wrappers for $name$
> + */
> +
> +typedef struct $struct_name$ {
> +    BdrvPollCo poll_state;
> +    $fields$
> +} $struct_name$;
> +
> +static void coroutine_fn $name$_entry(void *opaque)
> +{
> +    $struct_name$ *s = opaque;
> +
> +    $assign_ret$$name$($args_from_s$);

Creates a long line. Doesn't matter since this is generated code, so I 
don't know if it's worth trying to coerce python into generating 
something that is wrapped nicely.

> +
> +    s->poll_state.in_progress = false;
> +
> +    bdrv_poll_co__on_exit();

That function only calls aio_wait_kick().  Why did you not want to call 
that directly here, instead of going through such a one-line wrapper 
function?

> +}
> +
> +$ret_type$ $wrapper_name$($args_def$)
> +{
> +    if (qemu_in_coroutine()) {
> +        $do_return$$name$($arg_names$);

Would it be any simpler to teach bdrv_co_invalidate_cache() to return a 
value, so that you can eliminate the need for $do_return$ and just 
hard-code 'return ' here?  The .bdrv_co_invalidate_cache driver callback 
can still return void, and just have the wrapper in block.c return 0. 
But if you want to do that, it would be a separate prerequisite patch.

> +    } else {
> +        $struct_name$ s = {
> +            .poll_state.bs = $bs$,
> +            .poll_state.in_progress = true,
> +
> +            $initializers$
> +        };
> +
> +        s.poll_state.co = qemu_coroutine_create($name$_entry, &s);
> +
> +        $do_return$bdrv_poll_co(&s.poll_state);

Another spot impacted by that one outlier.

> +    }
> +}"""
> +
> +# We want to use python string.format() formatter, which uses curly brackets
> +# as separators. But it's not comfortable with C. So, we used dollars instead,
> +# and now is the time to escape curly brackets and convert dollars.
> +template = template.replace('{', '{{').replace('}', '}}')
> +template = re.sub(r'\$(\w+)\$', r'{\1}', template)

I'll leave it to others to decide if your approach has a more idiomatic 
python solution.  I'm used to the qapi generator using code like this in 
script/qapi/visit.py:

def gen_visit_members_decl(name):
     return mcgen('''

void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error 
**errp);
''',
                  c_name=c_name(name))

which has the same end goal of inserting named tags into a format 
string, but which uses %(tag) for tags rather than your novel approach 
of $tag$ with post-processing.

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
> +        self.decl = m.group('decl')
> +        self.type = m.group('type')
> +        self.name = m.group('name')
> +
> +
> +class FuncDecl:
> +    def __init__(self, return_type: str, name: str, args: str) -> None:
> +        self.return_type = return_type.strip()
> +        self.name = name.strip()
> +        self.args: List[ParamDecl] = []
> +        self.args = [ParamDecl(arg) for arg in args.split(',')]
> +
> +    def get_args_decl(self) -> str:
> +        return ', '.join(arg.decl for arg in self.args)
> +
> +    def get_arg_names(self) -> str:
> +        return ', '.join(arg.name for arg in self.args)
> +
> +    def gen_struct_fields(self) -> str:
> +        return '\n    '.join(f'{arg.decl};' for arg in self.args)
> +
> +    def gen_struct_initializers(self, indent: int) -> str:
> +        sep = '\n' + ' ' * indent
> +        return sep.join(f'.{a.name} = {a.name},' for a in self.args)
> +
> +
> +# Match wrappers declaration, with generated_co_wrapper mark

s/declaration, with/declared with a/

> +func_decl_re = re.compile(r'^(?P<return_type>(int|void))'
> +                          r'\s*generated_co_wrapper\s*'
> +                          r'(?P<wrapper_name>[a-z][a-z0-9_]*)'
> +                          r'\((?P<args>[^)]*)\);$', re.MULTILINE)
> +
> +
> +def func_decl_iter(text: str) -> Iterator:
> +    for m in func_decl_re.finditer(text):
> +        yield FuncDecl(return_type=m.group('return_type'),
> +                       name=m.group('wrapper_name'),
> +                       args=m.group('args'))
> +
> +
> +def struct_name(func_name: str) -> str:
> +    """some_function_name -> SomeFunctionName"""
> +    words = func_name.split('_')
> +    words = [w[0].upper() + w[1:] for w in words]
> +    return ''.join(words)
> +
> +
> +def make_wrapper(func: FuncDecl) -> str:
> +    assert func.name.startswith('bdrv_')
> +    co_name = 'bdrv_co_' + func.name[5:]
> +
> +    has_ret = func.return_type != 'void'
> +
> +    params = {
> +        'name': co_name,
> +        'do_return': 'return ' if has_ret else '',
> +        'assign_ret': 's->poll_state.ret = ' if has_ret else '',

See my comments above about possibly normalizing the one outlier of 
bdrv_co_invalidate_cache first.

> +        'struct_name': struct_name(co_name),
> +        'wrapper_name': func.name,
> +        'ret_type': func.return_type,
> +        'args_def': func.get_args_decl(),
> +        'arg_names': func.get_arg_names(),
> +        'fields': func.gen_struct_fields(),
> +        'initializers': func.gen_struct_initializers(12),

12 looks like a magic number.

> +        'args_from_s': ', '.join(f's->{a.name}' for a in func.args),
> +    }
> +
> +    if func.args[0].type == 'BlockDriverState *':
> +        params['bs'] = 'bs'
> +    else:
> +        assert func.args[0].type == 'BdrvChild *'
> +        params['bs'] = 'child->bs'
> +
> +    return template.format(**params)
> +
> +
> +if __name__ == '__main__':
> +    import sys
> +
> +    print(header)
> +    for func in func_decl_iter(sys.stdin.read()):
> +        print(make_wrapper(func))
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


