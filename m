Received: from eggs.gnu.org ([2001:4830:134:3::10]:54763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNQdg-0003Ow-Fp
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 18:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNQdY-0008EG-OP
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 18:01:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gNQdY-0008DP-De
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 18:01:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so19505616wmc.4
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 15:01:23 -0800 (PST)
References: <20181115192446.17187-1-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d23cb41c-b6a5-9573-32af-07a963f8f827@redhat.com>
Date: Fri, 16 Nov 2018 00:01:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181115192446.17187-1-minyard@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Hi Corey,

On 15/11/18 20:24, minyard@acm.org wrote:
> These changes allow SMBus access while doing a state transfer.
> Seems like a good idea to me in general.
> 
> I have these queued for the SMBus IPMI driver work, of course.
> 
> I had submitted this before and then lost track of the work since I
> started finding all kinds of broken things in the I2C code.  I
> have fixed the broken things I found first, and then added the
> previous patches.
> 
> I have tested this in q35 and it works without issue.  On piix4 the
> pm_smbus code is broken on a migration, however. The device disappears
> from the PCI bus on a migration, from what I can tell.  It's not the
> fault of this code, something more fundamental is going on.  The
> following comment in piix4.c may have something to do with it:
> 
> /* qemu-kvm 1.2 uses version 3 but advertised as 2
>   * To support incoming qemu-kvm 1.2 migration, change version_id
>   * and minimum_version_id to 2 below (which breaks migration from
>   * qemu 1.2).
> 
> Anyway, I need to chase that down.
> 
> I'm primarily submitting this to make sure I'm doing the backwards
> compatability with .needed correctly.  I'm adding a new field in
> the machine class and setting it in the initialization code for
> older versions.  David, is this what you wanted?  It will have to
> be adjusted for the proper version if/when it really goes in, of
> course.  You can see those in the following commits:
>    boards.h: Ignore migration for SMBus devices on
>    i2c:pm_smbus: Fix state transfer
>    i2c: Add vmstate handling to the smbus eeprom
> I thought about adding a field to the pm_smbus code to only transfer
> if it was accessed, but I'm assuming that most modern OSes will
> at least initialized the device based on its presence on the PCI
> bus.  So that didn't seem like it would add any value.
> 
> I'm also submitting to see if all the fixes and cleanups look ok.
> That's the first 5 commits.

$ git diff origin/master --summary
  delete mode 100644 hw/i2c/smbus.c
  create mode 100644 hw/i2c/smbus_master.c
  create mode 100644 hw/i2c/smbus_slave.c
  create mode 100644 include/hw/i2c/smbus_eeprom.h
  rename include/hw/i2c/{smbus.h => smbus_master.h} (56%)
  create mode 100644 include/hw/i2c/smbus_slave.h

Can you add the following files in the MAINTAINERS file:
- hw/i2c/smbus_master.c
- hw/i2c/smbus_slave.c
- include/hw/i2c/smbus_eeprom.h
- include/hw/i2c/smbus_master.h
- include/hw/i2c/smbus_slave.h

Thanks,

Phil.
