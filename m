Received: from eggs.gnu.org ([209.51.188.92]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghrar-0004ni-5A
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 02:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghraq-0002Nl-BE
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 02:51:05 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
	<20190108122021.GB11492@linux.fritz.box>
	<91dfd3e9-7293-4301-e3ac-852d8a038d4e@janustech.com>
	<87d0p4he0v.fsf@dusky.pond.sub.org>
	<316c67a6-54aa-3312-1994-64baec94c164@janustech.com>
Date: Fri, 11 Jan 2019 08:50:55 +0100
In-Reply-To: <316c67a6-54aa-3312-1994-64baec94c164@janustech.com> (Leonid
	Bloch's message of "Thu, 10 Jan 2019 16:53:24 +0000")
Message-ID: <87ef9jaazk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Leonid Bloch <lbloch@janustech.com> writes:

> On 1/10/19 2:51 PM,  wrote:
>> Leonid Bloch <lbloch@janustech.com> writes:
>> 
>>> Hi,
>>>
>>> On 1/8/19 2:20 PM, Kevin Wolf wrote:
>>>> Am 03.01.2019 um 22:33 hat Leonid Bloch geschrieben:
>>>>> The lookup table for power-of-two sizes is now auto-generated during the
>>>>> build, and not hard-coded into the units.h file.
>>>>>
>>>>> This partially reverts commit 540b8492618eb.
>>>>>
>>>>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>>>>
>>>> During a downstream review, Max found a problem with the table that we
>>>> could fix while we're touching it:
>>>>
>>>>       Upstream: All >= S_2GiB are not valid ints.  (qemu assumes that
>>>>       sizeof(int) == 4, right?)  So S_2GiB should be 2147483648u and all
>>>>       above should be ...ull or better UINT64_C().
>> 
>> So their (integer) type can vary.  Whether that's a problem depends on
>> how the macros are used.
>> 
>>> But the initial reasoning for this table was to have a pure number
>>> there. If there will be strings like "2147483648u/ull" or
>>> "UINT64_C(...)" there, they will be stringified, literally, and will
>>> appear as such inside the binary.
>> 
>> "Macro that expands to an integer constant that stringify() turns into a
>> decimal number" is a rather peculiar contract.
>> 
>>>                                    If specifying the unit64 type is
>>> really needed, one can always use, e.g., 2 * GiB, from units.h.
>> 
>> Right now I suspect these S_ macros should generally be avoided.
>> 
>> We have 54 of them.  I count six uses:
>> 
>>      block/qcow2.h:#define QCOW_MAX_REFTABLE_SIZE S_8MiB
>>      block/qcow2.h:#define QCOW_MAX_L1_SIZE S_32MiB
>>      block/qcow2.h:#define DEFAULT_L2_CACHE_MAX_SIZE S_32MiB
>>      block/qcow2.h:#define DEFAULT_L2_CACHE_MAX_SIZE S_8MiB
>>      block/qcow2.h:#define DEFAULT_CLUSTER_SIZE S_64KiB
>>      block/vdi.c:#define DEFAULT_CLUSTER_SIZE S_1MiB
>> 
>> Which if them truly need stringify-able integers?
>> 
>
> These two:
>
> block/qcow2.h:#define DEFAULT_CLUSTER_SIZE
> block/vdi.c:#define DEFAULT_CLUSTER_SIZE.

Compared to the complexity visible in this thread,

    .def_value_str = "65536", /* must match DEFAULT_CLUSTER_SIZE */

looks attractively stupid to me then.
