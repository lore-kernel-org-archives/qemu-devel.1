Received: from eggs.gnu.org ([2001:4830:134:3::10]:50498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cWQX9-0003t7-Ki
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cWQX8-0000uq-Oe
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:34:55 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cWQX8-0000uj-Jn
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:34:54 -0500
Received: by mail-ot0-x241.google.com with SMTP id f9so24152113otd.0
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:34:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fe189d26-df27-9a8e-6de3-6f53d92f5d2e@redhat.com>
References: <CAC2QTZY0SJczV9_e3TwJbEXwyuTQXDQesAP5W6U0JeYvsV5uQg@mail.gmail.com>
	<c5202aa1-bf56-5d66-533a-a1e78a3eafa2@redhat.com>
	<20170125110715.GB15529@redhat.com> <87lgtz5r0f.fsf@emacs.mitica>
	<CAC2QTZaMTN5wnGrmTK-BKUP1F3fxuCpSMX7mCw2z0grcDhOJyA@mail.gmail.com>
	<fe189d26-df27-9a8e-6de3-6f53d92f5d2e@redhat.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 25 Jan 2017 22:04:53 +0530
Message-ID: <CAC2QTZZ042AKg3SpCR9-RaFXkPBUFoH2ZGBhPFYTqJw+r+_FWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] migration: QEMU aborts migration of "none" machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Jan 25, 2017 at 9:40 PM, Thomas Huth <thuth@redhat.com> wrote:
> On 25.01.2017 13:58, Ashijeet Acharya wrote:
>> On Wed, Jan 25, 2017 at 4:46 PM, Juan Quintela <quintela@redhat.com> wrote:
>>> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>>>> On Wed, Jan 25, 2017 at 11:53:06AM +0100, Thomas Huth wrote:
>>>>> On 25.01.2017 11:01, Ashijeet Acharya wrote:
>>>>>> Hi Thomas,
>>>>>>
>>>>>> I was able to reproduce the bug you encountered while trying to migrate
>>>>>> a "none" machine.
>>>>>>
>>>>>> After digging deep and debugging the problem with gdb, I found that
>>>>>> bitmap_new() is the function that crashes qemu as it always has
>>>>>> zero bits being passed to it.
>>>>>>
>>>>>> I had a discussion with Dave on the IRC yesterday and he suggested the
>>>>>> reason of crash being the absence of RAM ( since machine is "none")
>>>>>> while attempting the migration.
>>>>>>
>>>>>> I am not sure what the ideal solution will be in this case; Do any of
>>>>>> the maintainers have any suggestions or even a starting point which I
>>>>>> can ponder upon?
>>>>>
>>>>> I'm not that familiar with the migration code either, but maybe you
>>>>> could simply check for last_ram_offset() == 0 at the beginning of
>>>>> ram_save_setup() and return with an error in that case?
>>>>
>>>> Do we actually need/want migration to succeed when RAM is 0 or vCPU
>>>> count is 0 ?  If not, then we could just register a migration blocker
>>>> during machine init
>>>
>>> Only use that I can see for that is to test that we have setup things
>>> correctly, but for that we could also use an stopped machine.  So, I
>>> don't know if it really makes sense.
>>>
>>> If the only problem is that bitmap_new(0) returns 0, we can try to fix
>>> that, no?
>>
>> Yes, bitmap_new(0) aborts in this case. The only way I see to fix this
>> would be to error out rather than simply crashing?
>> Adding a migration blocker is one way too; although I am not aware of
>> the use cases of a "none" machine.
>
> The "none" machine is - so far - only used for the testing framework
> (see the tests/ directory in the QEMU sources). With the upcoming QEMU
> 2.9, it should also be possible to use it as a simple instruction set
> simulation board. But in both cases, we do not need migration for this
> machine, i.e. simply printing an error message (and refusing to migrate)
> instead of crashing should IMHO be OK here.
>

Okay, I will write a patch to print an error message and if more
suggestions come during that time, I will make the changes
accordingly.

Ashijeet
>  Thomas
>
