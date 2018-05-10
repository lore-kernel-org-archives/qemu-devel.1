Received: from eggs.gnu.org ([2001:4830:134:3::10]:55549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGmFV-000141-0y
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGmFT-00039d-Ie
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:08:49 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec3886fb-04df-5ee1-5796-12d415335a02@redhat.com>
Date: Thu, 10 May 2018 09:08:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180509165530.29561-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/13] tests: Add QAPI optional
 discriminator tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/09/2018 11:55 AM, Max Reitz wrote:
> There already is an optional discriminator test, although it also noted
> the discriminator name itself as optional.  Changing that, and adding a
> default-variant field, makes that test pass instead of failing.

I'm not sure I agree with that one.  I think that you should instead add 
a positive test of a default variant into qapi-schema-test.json, 
especially since that is the one positive test where we also ensure that 
the C compiler is happy with the generated code (other positive tests 
prove that the generator produced something without error, but not that 
what it produced could be compiled).

>   17 files changed, 61 insertions(+), 4 deletions(-)
>   create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.json
>   create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.json
>   create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.json
>   create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.err
>   create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.exit
>   create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.out
>   create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.err
>   create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.exit
>   create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.out
>   create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.err
>   create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.exit
>   create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.out

Patch 1 converted 2 error messages into 6, where 2 of them look identical:

>> -        # The value of member 'discriminator' must name a non-optional
>> -        # member of the base struct.
>> +        # The value of member 'discriminator' must name a member of
>> +        # the base struct.
>>          check_name(info, "Discriminator of flat union '%s'" % name,
>>                     discriminator)

[0] check_name() checks that 'discriminator':'*name' is rejected - this 
check is unchanged

>> -        discriminator_type = base_members.get(discriminator)
>> -        if not discriminator_type:
>> -            raise QAPISemError(info,
>> -                               "Discriminator '%s' is not a member of base "
>> -                               "struct '%s'"
>> -                               % (discriminator, base))

The old code ensured that 'discriminator':'name' finds 'name' as a 
mandatory field in the base type; which changed into:

>> +        if default_variant is None:
>> +            discriminator_type = base_members.get(discriminator)
>> +            if not discriminator_type:
>> +                if base_members.get('*' + discriminator) is None:
>> +                    raise QAPISemError(info,
>> +                                       "Discriminator '%s' is not a member of "
>> +                                       "base struct '%s'"
>> +                                       % (discriminator, base))

[1] the discriminator type must be a member field (we didn't find either 
a mandatory or an optional field)

>> +                else:
>> +                    raise QAPISemError(info,
>> +                                       "Default variant must be specified for "
>> +                                       "optional discriminator '%s'"
>> +                                       % discriminator)

[2] without default_variant, the member field must be mandatory

>> +        else:
>> +            discriminator_type = base_members.get('*' + discriminator)
>> +            if not discriminator_type:
>> +                if base_members.get(discriminator) is None:
>> +                    raise QAPISemError(info,
>> +                                       "Discriminator '%s' is not a member of "
>> +                                       "base struct '%s'"
>> +                                       % (discriminator, base))

[3] the discriminator type must be a member field (we didn't find either 
a mandatory or an optional field), identical message to [1]

>> +                else:
>> +                    raise QAPISemError(info,
>> +                                       "Must not specify a default variant for "
>> +                                       "non-optional discriminator '%s'"
>> +                                       % discriminator)

[4] with default_variant, the member field must be optional

>> +
>>          enum_define = enum_types.get(discriminator_type)
>>          allow_metas = ['struct']
>>          # Do not allow string discriminator
>> @@ -763,6 +785,15 @@ def check_union(expr, info):
>>                                 "Discriminator '%s' must be of enumeration "
>>                                 "type" % discriminator)
>>  
>> +        if default_variant is not None:
>> +            # Must be a value of the enumeration
>> +            if default_variant not in enum_define['data']:
>> +                raise QAPISemError(info,
>> +                                   "Default variant '%s' of flat union '%s' is "
>> +                                   "not part of '%s'"
>> +                                   % (default_variant, name,
>> +                                      discriminator_type))
>> +

[5] the default discriminator value must belong to the discriminator's type

Of those 6 messages, you now have coverage of:

> 
> +++ b/tests/Makefile.include
> @@ -500,7 +500,10 @@ qapi-schema += flat-union-invalid-branch-key.json
>  qapi-schema += flat-union-invalid-discriminator.json

[1] no change to that test

>  qapi-schema += flat-union-no-base.json
>  qapi-schema += flat-union-optional-discriminator.json

the old test for [0] - you turned it into success. See more below...

> +qapi-schema += flat-union-optional-discriminator-no-default.json

new test for [2]

> +qapi-schema += flat-union-optional-discriminator-invalid-default.json

new test for [5]

>  qapi-schema += flat-union-string-discriminator.json
> +qapi-schema += flat-union-superfluous-default-variant.json

new test for [4]

I don't know if it is worth trying to explicitly test for [3], given 
that it is identical to [1], but the loss of the test for [0] bothers me.

> +++ b/tests/qapi-schema/flat-union-optional-discriminator.err
> @@ -1 +0,0 @@
> -tests/qapi-schema/flat-union-optional-discriminator.json:6: Discriminator of flat union 'MyUnion' does not allow optional name '*switch'

This used to be covered by [0] - but you rewrote the test by changing 
'discriminator':'*switch' to 'discriminator':'switch'.

I'd argue that you WANT to keep 'discriminator':'*switch' in this test, 
to keep the testing of error [0] (even when the discriminator type is 
optional, we spell it without leading '*' in the 'union' description), 
and then only qapi-schema-test.json gets a positive test, which also 
gives us the additional coverage that the C compiler likes our generated 
code.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
