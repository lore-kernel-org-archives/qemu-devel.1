Received: from eggs.gnu.org ([2001:4830:134:3::10]:57166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g84SB-0002CS-3w
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g84S4-00009m-JE
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:18:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g84S1-0008P0-Om
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:18:04 -0400
References: <1538164055-23719-1-git-send-email-wei@redhat.com>
	<20181004134834.bvvovxyjvyjitkrk@kamzik.brq.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8ce54a31-61e7-b3e7-acd9-64b3316791ad@redhat.com>
Date: Thu, 4 Oct 2018 16:17:51 +0200
MIME-Version: 1.0
In-Reply-To: <20181004134834.bvvovxyjvyjitkrk@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] tests: Add migration test for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>
Cc: lvivier@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com

On 2018-10-04 15:48, Andrew Jones wrote:
> On Fri, Sep 28, 2018 at 03:47:35PM -0400, Wei Huang wrote:
[...]
>> diff --git a/tests/migration/aarch64/Makefile b/tests/migration/aarch64/Makefile
>> new file mode 100644
>> index 0000000..d440fa8
>> --- /dev/null
>> +++ b/tests/migration/aarch64/Makefile
>> @@ -0,0 +1,20 @@
>> +# To specify cross compiler prefix, use CROSS_PREFIX=
>> +#   $ make CROSS_PREFIX=aarch64-linux-gnu-
>> +
>> +.PHONY: all clean
>> +all: a-b-kernel.h
>> +
>> +a-b-kernel.h: aarch64.kernel
>> +	echo "$$__note" > header.tmp
>> +	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
>> +	mv header.tmp $@
>> +
>> +aarch64.kernel: aarch64.elf
>> +	$(CROSS_PREFIX)objcopy -O binary $< $@
>> +
>> +aarch64.elf: a-b-kernel.S
>> +	$(CROSS_PREFIX)gcc -o $@ -nostdlib -Wl,--build-id=none $<
>> +
>> +clean:
>> +	@rm -rf *.kernel *.elf
> 
> I don't think we need/want '-f'. Why not use $(RM)?

Does $(RM) work now in the QEMU Makefiles? AFAIK we are disabling the
standard variables in rules.mak ("MAKEFLAGS += -rR"), but never set RM
again...

 Thomas
