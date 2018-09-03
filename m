Received: from eggs.gnu.org ([2001:4830:134:3::10]:49985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwnId-0001tY-Rp
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwnIY-0005D5-Ma
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:45:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwnIY-0005CW-Ez
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:45:38 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180903110813.hbamu4zuda6qpwuw@kamzik.brq.redhat.com> (Andrew
	Jones's message of "Mon, 3 Sep 2018 13:08:13 +0200")
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-2-git-send-email-wei@redhat.com>
	<20180903110813.hbamu4zuda6qpwuw@kamzik.brq.redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Sep 2018 13:45:33 +0200
Message-ID: <87k1o23iua.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V8 1/4] tests/migration: Convert x86 boot
 block compilation script into Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Wei Huang <wei@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com

Andrew Jones <drjones@redhat.com> wrote:
> On Sat, Sep 01, 2018 at 01:11:12AM -0400, Wei Huang wrote:
>> The x86 boot block header currently is generated with a shell script.
>> To better support other CPUs (e.g. aarch64), we convert the script
>> into Makefile. This allows us to 1) support cross-compilation easily,
>> and 2) avoid creating a script file for every architecture.
>> 
>> Note that, in the new design, the cross compiler prefix can be specified by
>> setting the CROSS_PREFIX in "make" command. Also to allow gcc pre-processor
>> to include the C-style file correctly, it also renames the
>> x86-a-b-bootblock.s file extension from .s to .S.
>> + * tests/migration/rebuild-x86-bootblock.sh to update,
>> + * and then remember to send both in your patch submission.
>> + */
>> +endef
>> +export __note
>> +
>> +.PHONY: all clean
>> +all: x86-a-b-bootblock.h
>> +
>> +x86-a-b-bootblock.h: x86.bootsect
>> +	echo "$$__note" > header.tmp
>> +	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
>> +	mv header.tmp $@
>
> The shell script this Makefile is replacing used mktemp
> for a randomly named tmp dir. Shouldn't we continue to
> use random names?

We shouldn't be trying to create the file twice in parallel, no?

>
>> +
>> +x86.bootsect: x86.boot
>> +	dd if=$< of=$@ bs=256 count=2 skip=124
>> +
>> +x86.boot: x86.o
>> +	$(CROSS_PREFIX)objcopy -O binary $< $@
>> +
>> +x86.o: x86-a-b-bootblock.S
>> +	$(CROSS_PREFIX)gcc -m32 -march=i486 -c $< -o $@
>> +
>> +clean:
>> +	@rm -rf *.boot *.o *.bootsect
>
> We don't want to remove the generated header file when cleaning?

No, because we only generated the header file when running native, have
the right crosscompilers, etc.  In general we only recompile it when we
change the test file, otherwise we store the generated ones.

Idea is:
We have a c file that does what we want.
We compile it (when we have a propper compiler) and store it on the
tree.
We compile it for each test.

This is more "like firmware" than normal "qemu" source code.

Later, Juan.
