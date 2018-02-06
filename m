Received: from eggs.gnu.org ([2001:4830:134:3::10]:56711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej4fz-0002dt-KA
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej4fv-00069v-2k
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:56:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ej4fu-00069Q-Ps
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:56:47 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-7-armbru@redhat.com>
	<05068311-b8db-69b0-9c86-50839994f630@redhat.com>
	<87lgga4f7s.fsf@dusky.pond.sub.org>
	<0e3ea662-418e-0574-3817-434b35e85887@redhat.com>
	<87a7wmfto1.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32d15942-9126-89c5-ac10-8513b62784a4@redhat.com>
Date: Tue, 6 Feb 2018 08:56:23 -0600
MIME-Version: 1.0
In-Reply-To: <87a7wmfto1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On 02/06/2018 01:45 AM, Markus Armbruster wrote:

>>>>> -def main(argv):
>>>>> -    (input_file, output_dir, do_c, do_h, prefix, opts) = parse_command_line()
>>>>> -
>>>>> -    blurb = '''
>>>>> - * Schema-defined QAPI/QMP commands
>>>>> -'''
>>>>> -
>>>>> +def gen_commands(schema, output_dir, prefix):
>>>>> +    blurb = ' * Schema-defined QAPI/QMP commands'
>>>>
>>>> Some churn on the definition of blurb; worth tidying this in the
>>>> introduction earlier in the series?
>>>
>>> Doesn't seem worth a separate patch, but I can try to reshuffle things
>>> to reduce churn.
>>
>> Yeah, my question was more about the conversion between multiline
>> '''...''' to single-line '...'; why not just use the single-line
>> construct earlier in the series when introducing the blurb variable.
> 
> Introduced in PATCH 01:
> 
>      -c_comment = '''
>      -/*
>      - * schema-defined QMP->QAPI command dispatch
>      +blurb = '''
>      + * Schema-defined QAPI/QMP commands
>        *
>        * Copyright IBM, Corp. 2011

Multiline made sense here.

> Shortened in PATCH 02:
> 
>       blurb = '''
>        * Schema-defined QAPI/QMP commands
>      - *
>      - * Copyright IBM, Corp. 2011
>      - *
>      - * Authors:
>      - *  Anthony Liguori   <aliguori@us.ibm.com>
        '''
> 

Where it is now a single line...


> Variable eliminated there in PATCH 17:
> 
>      -        blurb = ' * Schema-defined QAPI types'
>      -        self._genc = QAPIGenC(blurb, __doc__)
>      -        self._genh = QAPIGenH(blurb, __doc__)
>      +        self._module = {}
>      +        self._add_module(None, ' * Built-in QAPI types')

Oh, I didn't even notice that!

> 
> I could delay the reformatting until PATCH 16, or do it in PATCH 02.
> Feels like a wash to me, but if you have a preference...

I guess my preference is to reformat to single line in PATCH 02, then 
patch 6 doesn't have to touch it, and patch 16 can still get rid of it. 
But, as it disappears by the end of the series anyways, I'm also okay if 
you don't bother (churn is not necessarily bad, if it is still easy to 
review).


> The commit message talks only about the QAPI/QMP schema.  It's confusing
> because our poor taste in file names creates ambiguity: does
> qapi-schema.json refer to ./qapi-schema.json (i.e. the QAPI/QMP one),
> qga/qapi-schema.json, or both?
> 
> Perhaps I should rename qapi-schema.json to qapi/schema.json.

I'd be in favor of such a change.  We'd also rename qga/qapi-schema.json 
to qga/schema.json?

> 
> The commit message needs a note along the lines of "same for
> qga/qapi-schema.json".
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
