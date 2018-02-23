Received: from eggs.gnu.org ([2001:4830:134:3::10]:58879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1epBMp-0006EX-Tl
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1epBMp-0001Vs-1U
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:18:19 -0500
References: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
	<7c23f28d-ee14-c504-ae13-04414c4b032e@redhat.com>
	<20180222105755.GB4147@localhost.localdomain>
	<c374c10a-a46c-1870-8f2c-47a2841b8a44@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49f4e6eb-95b0-f513-f1af-183a215fce82@redhat.com>
Date: Fri, 23 Feb 2018 12:17:52 +0100
MIME-Version: 1.0
In-Reply-To: <c374c10a-a46c-1870-8f2c-47a2841b8a44@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Limiting coroutine stack usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 22/02/2018 18:06, John Snow wrote:
>=20
>=20
> On 02/22/2018 05:57 AM, Kevin Wolf wrote:
>> Am 20.02.2018 um 22:54 hat Paolo Bonzini geschrieben:
>>> On 20/02/2018 18:04, Peter Lieven wrote:
>>>> Hi,
>>>>
>>>> I remember we discussed a long time ago to limit the stack usage of =
all
>>>> functions that are executed in a coroutine
>>>> context to a very low value to be able to safely limit the coroutine
>>>> stack size as well.
>>>
>>> IIRC the only issue was that hw/ide/atapi.c has mutual recursion betw=
een
>>> ide_atapi_cmd_reply_end -> ide_transfer_start -> ahci_start_transfer =
->
>>> ide_atapi_cmd_reply_end.
>>>
>>> But perhaps it's not an issue, somebody needs to audit the code.
>>
>> I think John intended to get rid of the recursion sometime, but I doub=
t
>> he has had the time so far.
>>
>=20
> It hasn't been a priority for me.
>=20
> Paolo tried to fix ATAPI by adding a BH callback, but that added the
> possibility of a migration halfway through a data transfer IIRC.
>=20
> If anyone wants to tackle it, I'll dig up Paolo's patches.

A better possibility is to make it into tail recursion first and then a
while loop.  Maybe introducing some kind of ide_transfer_start_norecurse
that returns "true" if you have a start_transfer callback (so you need
to do another iteration immediately) and "false" if you don't.  I'll
take a look...

Paolo
