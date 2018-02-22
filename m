Received: from eggs.gnu.org ([2001:4830:134:3::10]:40369)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eopH5-0007D9-9e
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eopH2-0003Vz-8G
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:42:55 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:43068 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eopH1-0003V5-U6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:42:52 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:42:46 +0100
References: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
	<7c23f28d-ee14-c504-ae13-04414c4b032e@redhat.com>
	<20180222105755.GB4147@localhost.localdomain>
	<37efa6ac-8e36-9c96-84ef-a8639ba64937@kamp.de>
	<20180222113204.GC4147@localhost.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <460bd960-1258-9ec7-5430-74c24a743996@kamp.de>
Date: Thu, 22 Feb 2018 12:42:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180222113204.GC4147@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] Limiting coroutine stack usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, jsnow@redhat.com

Am 22.02.2018 um 12:32 schrieb Kevin Wolf:
> Am 22.02.2018 um 12:01 hat Peter Lieven geschrieben:
>> Am 22.02.2018 um 11:57 schrieb Kevin Wolf:
>>> Am 20.02.2018 um 22:54 hat Paolo Bonzini geschrieben:
>>>> On 20/02/2018 18:04, Peter Lieven wrote:
>>>>> Hi,
>>>>>
>>>>> I remember we discussed a long time ago to limit the stack usage of all
>>>>> functions that are executed in a coroutine
>>>>> context to a very low value to be able to safely limit the coroutine
>>>>> stack size as well.
>>>> IIRC the only issue was that hw/ide/atapi.c has mutual recursion between
>>>> ide_atapi_cmd_reply_end -> ide_transfer_start -> ahci_start_transfer ->
>>>> ide_atapi_cmd_reply_end.
>>>>
>>>> But perhaps it's not an issue, somebody needs to audit the code.
>>> I think John intended to get rid of the recursion sometime, but I doubt
>>> he has had the time so far.
>> Apart from this is is possible to define special cflags in the
>> Makefile.objs just for a subdirectory? I have patches ready to make
>> the block layer files and other coroutine users compile with
>> -Wstack-size=2048. But I do not want to specify each file separately.
> Our Makefiles have lines like this:
>
>     iscsi.o-cflags     := $(LIBISCSI_CFLAGS)
>
> I don't think there is a direct mechanism to apply cflags to a whole
> directory or just to block-obj-y/block-obj-m, but just looping over them
> could work. I'm not a Makefile expert at all, but after some toying with
> a simple example, something like this might work:
>
>     $(foreach x,$(block-obj-y),$(eval $x-cflags += -Wstack-size=2048))

Thanks for the hint.

If noone comes up with a better idea I will try this.

Peter
