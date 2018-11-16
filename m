Received: from eggs.gnu.org ([2001:4830:134:3::10]:44070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNeCl-0002Ia-9M
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNeCZ-000360-24
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:30:32 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gNeCV-00033O-6F
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:30:23 -0500
Received: by mail-ot1-x343.google.com with SMTP id s5so21290172oth.7
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 05:30:20 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181115192446.17187-1-minyard@acm.org>
	<d23cb41c-b6a5-9573-32af-07a963f8f827@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <60277859-5c6d-4cf5-6ecd-c145b4889a05@acm.org>
Date: Fri, 16 Nov 2018 07:30:16 -0600
MIME-Version: 1.0
In-Reply-To: <d23cb41c-b6a5-9573-32af-07a963f8f827@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 00/12] RFC: Fix/add vmstate handling in
 some I2C code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 11/15/18 5:01 PM, Philippe Mathieu-Daudé wrote:
> Hi Corey,
>
> On 15/11/18 20:24, minyard@acm.org wrote:
>> These changes allow SMBus access while doing a state transfer.
>> Seems like a good idea to me in general.
>>
>> I have these queued for the SMBus IPMI driver work, of course.
>>
>> I had submitted this before and then lost track of the work since I
>> started finding all kinds of broken things in the I2C code.  I
>> have fixed the broken things I found first, and then added the
>> previous patches.
>>
>> I have tested this in q35 and it works without issue.  On piix4 the
>> pm_smbus code is broken on a migration, however. The device disappears
>> from the PCI bus on a migration, from what I can tell.  It's not the
>> fault of this code, something more fundamental is going on.  The
>> following comment in piix4.c may have something to do with it:
>>
>> /* qemu-kvm 1.2 uses version 3 but advertised as 2
>>   * To support incoming qemu-kvm 1.2 migration, change version_id
>>   * and minimum_version_id to 2 below (which breaks migration from
>>   * qemu 1.2).
>>
>> Anyway, I need to chase that down.
>>
>> I'm primarily submitting this to make sure I'm doing the backwards
>> compatability with .needed correctly.  I'm adding a new field in
>> the machine class and setting it in the initialization code for
>> older versions.  David, is this what you wanted?  It will have to
>> be adjusted for the proper version if/when it really goes in, of
>> course.  You can see those in the following commits:
>>    boards.h: Ignore migration for SMBus devices on
>>    i2c:pm_smbus: Fix state transfer
>>    i2c: Add vmstate handling to the smbus eeprom
>> I thought about adding a field to the pm_smbus code to only transfer
>> if it was accessed, but I'm assuming that most modern OSes will
>> at least initialized the device based on its presence on the PCI
>> bus.  So that didn't seem like it would add any value.
>>
>> I'm also submitting to see if all the fixes and cleanups look ok.
>> That's the first 5 commits.
>
> $ git diff origin/master --summary
>  delete mode 100644 hw/i2c/smbus.c
>  create mode 100644 hw/i2c/smbus_master.c
>  create mode 100644 hw/i2c/smbus_slave.c
>  create mode 100644 include/hw/i2c/smbus_eeprom.h
>  rename include/hw/i2c/{smbus.h => smbus_master.h} (56%)
>  create mode 100644 include/hw/i2c/smbus_slave.h
>
> Can you add the following files in the MAINTAINERS file:
> - hw/i2c/smbus_master.c
> - hw/i2c/smbus_slave.c
> - include/hw/i2c/smbus_eeprom.h
> - include/hw/i2c/smbus_master.h
> - include/hw/i2c/smbus_slave.h
>
Ok, but who should the maintainer be?  I guess I can take
it, if that is what you are implying.  But most of the files in
i2c are not maintained.

Thanks,

-corey
