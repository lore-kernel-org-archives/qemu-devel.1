Received: from eggs.gnu.org ([2001:4830:134:3::10]:49323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhhD7-0003tq-GX
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhhD4-0003Do-94
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:09:05 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhhD4-0003Df-53
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:09:02 -0400
Received: by mail-qt0-x242.google.com with SMTP id c15so1577042qta.3
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 12:09:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170815163959.6632-1-f4bug@amsat.org>
	<20170815163959.6632-2-f4bug@amsat.org>
	<a2773ebe-e841-4f3f-0234-d89e48811336@redhat.com>
	<4837e428-461c-ef00-b584-42e4c22e8fc7@amsat.org>
	<6b25c2fb-6f18-37e3-b7dd-56b9d59c22ca@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <26895c93-c806-c50d-3c83-d67c88744d04@amsat.org>
Date: Tue, 15 Aug 2017 16:08:51 -0300
MIME-Version: 1.0
In-Reply-To: <6b25c2fb-6f18-37e3-b7dd-56b9d59c22ca@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] libqtest: add qtest_accel() to
 avoid warnings when kvm is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 08/15/2017 03:40 PM, Eric Blake wrote:
> On 08/15/2017 01:27 PM, Philippe Mathieu-Daudé wrote:
>> On 08/15/2017 03:13 PM, Eric Blake wrote:
>>> On 08/15/2017 11:39 AM, Philippe Mathieu-Daudé wrote:
>>>> only warn once about it.
>>>>
>>>> - kernel without kvm:
>>>>
>>>>       # make check-qtest-x86_64
>>>>         GTESTER check-qtest-x86_64
>>>>       Could not access KVM kernel module: No such device
>>>>       qemu-system-x86_64: failed to initialize KVM: No such device
>>>>       qemu-system-x86_64: Back to tcg accelerator
>>>
>>> How does this differ from what commit 2f6b38d1 was trying to do?
>>
>> I'd say 2f6b38d1 is for common end-user usage while this is for
>> QA/testers usage. If you run N qtests with the same machine arguments,
>> having this warning displayed only once is enough and allow you to focus
>> on the tests output.
> 
> I guess my question is: Are we still getting a warning output even with
> 2f6b38d1 applied?  If so, why, because the point of that commit was to
> avoid the warning.

The function this patch adds is called by gtester to prepare the QEMU 
command line options, usually this is done once in main(), then each 
qtest is run with the same QEMU command line.

Once started QEMU calls accel_init_machine() displaying warnings from 
303d4e865b7.

Having 3 lines of warnings for each test is way too verbose.
