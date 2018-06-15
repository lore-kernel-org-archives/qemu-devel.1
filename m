Received: from eggs.gnu.org ([2001:4830:134:3::10]:48565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTovs-0006rb-1E
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTovn-0003cX-S7
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:38:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTovn-0003cK-MM
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:38:23 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1528905228-25694-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1528905228-25694-2-git-send-email-anton.nefedov@virtuozzo.com>
	<87sh5pomxj.fsf@dusky.pond.sub.org>
	<d6d3f6ec-3d6b-99b7-8e09-8b3072355916@virtuozzo.com>
Date: Fri, 15 Jun 2018 15:38:21 +0200
In-Reply-To: <d6d3f6ec-3d6b-99b7-8e09-8b3072355916@virtuozzo.com> (Anton
	Nefedov's message of "Thu, 14 Jun 2018 12:01:21 +0300")
Message-ID: <87602k186q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qapi: allow empty branches in flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Anton Nefedov <anton.nefedov@virtuozzo.com> writes:

> On 14/6/2018 10:19 AM, Markus Armbruster wrote:
>> Anton Nefedov <anton.nefedov@virtuozzo.com> writes:
>>
>>> It often happens that just a few discriminator values imply extra data in
>>> a flat union. Existing checks did not make possible to leave other values
>>> uncovered. Such cases had to be worked around by either stating a dummy
>>> (empty) type or introducing another (subset) discriminator enumeration.
>>>
>>> Both options create redundant entities in qapi files for little profit.
>>>
>>> With this patch it is not necessary anymore to add designated union
>>> fields for every possible value of a discriminator enumeration.
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
[...]
>>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>>> index 2462fc0..0f3d89b 100644
>>> --- a/scripts/qapi/common.py
>>> +++ b/scripts/qapi/common.py
>>> @@ -779,13 +779,6 @@ def check_union(expr, info):
>>>                                      "enum '%s'"
>>>                                      % (key, enum_define['enum']))
>>>   -    # If discriminator is user-defined, ensure all values are
>>> covered
>>> -    if enum_define:
>>> -        for value in enum_define['data']:
>>> -            if value not in members.keys():
>>> -                raise QAPISemError(info, "Union '%s' data missing '%s' branch"
>>> -                                   % (name, value))
>>> -
>>>     def check_alternate(expr, info):
>>>       name = expr['alternate']
>>> @@ -1644,6 +1637,10 @@ class QAPISchema(object):
>>>           if tag_name:
>>>               variants = [self._make_variant(key, value)
>>>                           for (key, value) in data.items()]
>>> +            # branches that are not explicitly covered get an empty type
>>> +            variants += [self._make_variant(key, 'q_empty')
>>> +                         for key in discriminator_find_enum_define(expr)['data']
>>
>> Long line, flagged by pycodestyle --diff.
>>
>
> Done.
>
>>> +                         if key not in data.keys()]
>>>               members = []
>>>           else:
>>>               variants = [self._make_simple_variant(key, value, info)
>>
>> The way you desugar the union is simple enough, but it uses
>> discriminator_find_enum_define() outside check_exprs(), which I'd rather
>> avoid.  Not something you could be reasonably expected to know.
>>
>> We could desugar in QAPISchemaObjectTypeVariants.check(), where we have
>> self.tag_member.type.values.
>>
>>     @@ -1346,10 +1346,17 @@ class QAPISchemaObjectTypeVariants(object):
>>                  v.set_owner(name)
>>
>>          def check(self, schema, seen):
>>     -        if not self.tag_member:    # flat union
>>     +        if not self.tag_member: # flat union
>>                  self.tag_member = seen[c_name(self._tag_name)]
>>                  assert self._tag_name == self.tag_member.name
>>              assert isinstance(self.tag_member.type, QAPISchemaEnumType)
>>     +        if self._tag_name:      # flat union
>>     +            cases = set([v.name for v in self.variants])
>>     +            for val in self.tag_member.type.values:
>>     +                if val.name not in cases:
>>     +                    v = QAPISchemaObjectTypeVariant(val.name, 'q_empty')
>>     +                    v.set_owner(self.tag_member.owner)
>>     +                    self.variants.append(v)
>>              for v in self.variants:
>>                  v.check(schema)
>>                  # Union names must match enum values; alternate names are
>>
>> Not so simple anymore.
>>
>> Simpler: desugar in check_union(), i.e. replace your two hunks by just
>>
>>     @@ -783,8 +783,7 @@ def check_union(expr, info):
>>          if enum_define:
>>              for value in enum_define['data']:
>>                  if value not in members.keys():
>>     -                raise QAPISemError(info, "Union '%s' data missing '%s' branch"
>>     -                                   % (name, value))
>>     +                members[value] = 'q_empty'
>>
>>
>>      def check_alternate(expr, info):
>>
>> What do you think?
>>
>
> it didn't feel right aesthetically to normalize by modifying the parsed
> expressions especially at check_exprs() stage. But maybe using
> discriminator_find_enum_define() is more sloppy, I can't quite see

The issue isn't sloppiness, it's adding to our technical debt.  To
explain this, I need to relate a bit of history.

In the beginning, we did everything with syntax trees.  Commit
ac88219a6c7 (Sep 2015) spliced in an intermediate representation.  Its
commit message explains:

    The QAPI code generators work with a syntax tree (nested dictionaries)
    plus a few symbol tables (also dictionaries) on the side.

    They have clearly outgrown these simple data structures.  There's lots
    of rummaging around in dictionaries, and information is recomputed on
    the fly.  For the work I'm going to do, I want more clearly defined
    and more convenient interfaces.
    
    Going forward, I also want less coupling between the back-ends and the
    syntax tree, to make messing with the syntax easier.

We accepted some technical debt back then.  Same commit message:

    Shortcut: the semantic analysis still relies on existing check_exprs()
    to do the actual semantic checking.  All this code needs to move into
    the classes.  Mark as TODO.

It's this one:

    #
    # Semantic analysis of schema expressions
    # TODO fold into QAPISchema
    # TODO catching name collisions in generated code would be nice
    #

check_exprs() is the only entry point into the code under this TODO.
Your patch adds another one.  I don't like that.

Nobody expects you to deduce this from the code by yourself :)

Now, I agree hacking up the syntax tree isn't particularly clean,
either.  Perhaps doing it in QAPISchemaObjectTypeVariants.check() is
best after all.  In case you feel unsure about making that change, I can
take your solution, and address its technical debt issue in a follow-up
patch.

[...]
