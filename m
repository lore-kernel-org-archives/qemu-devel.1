Received: from eggs.gnu.org ([2001:4830:134:3::10]:51697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1emGhq-0000gE-O3
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1emGhp-0002wf-D1
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:23:58 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
	<b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
	<87tvuyf4it.fsf@dusky.pond.sub.org>
	<8639a69c-ca85-d11b-7aaa-e67ffb660991@virtuozzo.com>
Message-ID: <3066afcc-60e6-2bb9-5ea9-4befff726eb0@virtuozzo.com>
Date: Thu, 15 Feb 2018 13:23:45 +0300
MIME-Version: 1.0
In-Reply-To: <8639a69c-ca85-d11b-7aaa-e67ffb660991@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 8/8] qapi: query-blockstat: add driver
 specific file-posix stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, jsnow@redhat.com



On 12/2/2018 7:38 PM, Anton Nefedov wrote:
>=20
>=20
> On 3/2/2018 6:59 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 01/19/2018 06:50 AM, Anton Nefedov wrote:
>>>> +
>>>> +##
>>>> +# @BlockDriverStats:
>>>> +#
>>>> +# Statistics of a block driver (driver-specific)
>>>> +#
>>>> +# Since: 2.12
>>>> +##
>>>> +{ 'union': 'BlockDriverStats',
>>>> +=C2=A0 'data': {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'file': 'BlockDriverStatsFile'
>>>> +=C2=A0 } }
>>>
>>> Markus has been adamant that we add no new "simple unions" (unions with
>>> a 'discriminator' field) - because they are anything but simple in the
>>> long run.
>>
>> Indeed.=C2=A0 You could make this a flat union, similar to BlockdevOptio=
ns:
>>
>> { 'union': 'BlockDriverStats':
>> =C2=A0=C2=A0 'base': { 'driver': 'BlockdevDriver' },
>> =C2=A0=C2=A0 'discriminator': 'driver',
>> =C2=A0=C2=A0 'data': {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'file': 'BlockDriverStatsFile',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... } }
>>
>> However:
>>
>>>> +
>>>> +##
>>>> =C2=A0 # @BlockStats:
>>>> =C2=A0 #
>>>> =C2=A0 # Statistics of a virtual block device or a block backing devic=
e.
>>>> @@ -785,6 +819,8 @@
>>>> =C2=A0 #
>>>> =C2=A0 # @stats:=C2=A0 A @BlockDeviceStats for the device.
>>>> =C2=A0 #
>>>> +# @driver-stats: Optional driver-specific statistics. (Since 2.12)
>>>> +#
>>>> =C2=A0 # @parent: This describes the file block device if it has one.
>>>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Contain=
s recursively the statistics of the underlying
>>>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 protoco=
l (e.g. the host file for a qcow2 image). If=20
>>>> there is
>>>> @@ -798,6 +834,7 @@
>>>> =C2=A0 { 'struct': 'BlockStats',
>>>> =C2=A0=C2=A0=C2=A0 'data': {'*device': 'str', '*node-name': 'str',
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 'stats': 'BlockDeviceStats',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*driver=
-stats': 'BlockDriverStats',
>>
>> You're adding a union of driver-specific stats to a struct of generic
>> stats.=C2=A0 That's unnecessarily complicated.=C2=A0 Instead, turn the s=
truct of
>> generic stats into a flat union, like this:
>>
>> { 'union': 'BlockStats',
>> =C2=A0=C2=A0 'base': { ... the generic stats, i.e. the members of BlockS=
tats
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 before this patch ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'driver': 'BlockdevDriver' }
>> =C2=A0=C2=A0 'discriminator': 'driver',
>> =C2=A0=C2=A0 'data': {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'file': 'BlockDriverStatsFile',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... } }
>>
>>> ...[1] You are using it alongside a struct that already uses '-'
>>> (node-name), so you should use dashes.
>>>
>>> So, the difference between your proposal (a simple union) and using a
>>> "flat union", on the wire, is yours:
>>>
>>> "return": { ..., "driver-stats": { "type": "file", "data": {
>>> "discard_nb_ok: ... } } }
>>>
>>> vs. a flat union:
>>>
>>> "return": { ..., "driver-stats": { "driver": "file", "discard-nb-ok":
>>> ... } }
>>>
>>> where you can benefit from less nesting and a saner discriminator name.
>>
>> My proposal peels off yet another level of nesting.
>>
>=20
> The output is better indeed, thanks; a little drawback is now we need to
> pass the whole BlockStats to the driver so it fills its stats.
>=20
> e.g. the interface:
>=20
>  =C2=A0=C2=A0=C2=A0 void (*bdrv_get_stats)(BlockDriverState *bs, BlockSta=
ts *stats);
>=20
> And that BlockdevDriver subset type (or a generator patch) still seems
> to be needed
>=20
>  =C2=A0 { 'enum' : 'BlockdevDriverWithStats',
>  =C2=A0=C2=A0=C2=A0 'data' : [ 'file' ] }

Hmm, actually it seems the driver-specific-stats should either be
optional, or we need to handle the rest of the drivers in the generated
code.

(i.e. with the dummy enum as above, what should the mandatory 'driver'
field be when there's e.g. nbd driver? It will default to 0, and that is
BLOCKDEV_DRIVER_WITH_STATS_FILE, so it will be interpreted as 'file' in
qmp output)


If we patch the generator, I guess we could add smth like a new tag to
the union that has no data for some discriminators?

e.g.

{ 'union': 'BlockStats',
   'base': {'*device': 'str', '*node-name': 'str',
            'stats': 'BlockDeviceStats',
            '*parent': 'BlockStats',
            '*backing': 'BlockStats',
            'driver': 'BlockdevDriver'},
   'discriminator': 'driver',
   'data-optional': {                     <---- instead of 'data'
       'file': 'BlockDriverStatsFile',
   } }

Then the generator would need to:
   - pick either 'data-optional' or 'data' members
   - skip 'data missing branch' check for such unions
   - do not abort() when visiting the union and discriminator pointing
     to no data type

I can try and implement this if there's no other suggestion?

/Anton
