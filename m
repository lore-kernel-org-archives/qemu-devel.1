Received: from eggs.gnu.org ([209.51.188.92]:35229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvnLn-0006Mc-Hf
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvnLl-0007sa-KJ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:09:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvnLj-0007qJ-Jr
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:09:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
Date: Mon, 18 Feb 2019 19:08:59 +0100
In-Reply-To: <BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu> (Stephen
	Checkoway's message of "Mon, 18 Feb 2019 11:02:05 -0500")
Message-ID: <87ftsl2clg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Stephen Checkoway <stephen.checkoway@oberlin.edu> writes:

> On Feb 18, 2019, at 08:43, Thomas Huth <thuth@redhat.com> wrote:
>
>>On 18/02/2019 07.07, Stephen Checkoway wrote:
>>> Hi all,
>>> 
>>> I've been working on some improvements to the pflash_cfi02 block device (interleaved flash devices similar to pflash_cfi01, multi-sector erase, nonuniform sector sizes, and some bug fixes and I'm planning on implementing sector erase suspend/resume commands in the near future).

Any chance you could do multiple region support, too?

>>> There appear to be no existing tests for this device and I'm unsure what the appropriate way to add tests for sysbus devices is. -device can't be used because sysbus devices aren't user-creatable (and even if they were, creating the device wouldn't be sufficient since it wouldn't connect it to the sysbus).
>>> 
>>> Any suggestions would be appreciated.
>> 
>> I think you could use one of the machines that has a cfi02 on board. For
>> example: Write some random data to a temporary file. Run qemu with:
>> 
>> QTestState *qts;
>> qts = qtest_initf(" qemu-system-arm -M musicpal,accel=qtest "
>>                "-drive if=pflash,file=%s,format=raw", filename);
>
> If I do that, will it be possible for the test to override the properties set by pflash_cfi02_register? It looks like I should be able to use -global to set properties that aren't set explicitly.

Yes.

Won't work for properties set by pflash_cfi02_register(), though.  To
test the full range of values there, you'd have to make them
configurable somehow.  We currently don't have a good way to do that.
Please see

    Subject: Re: Configuring pflash devices for OVMF firmware
    Message-ID: <87mun8gd2x.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg01734.html
