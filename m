Received: from eggs.gnu.org ([2001:4830:134:3::10]:35204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnn0x-0004yL-9T
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnn0p-00044y-NZ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:33:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnn0p-00044Z-IC
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:33:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DD638AE61
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 14:33:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1502389816-29772-1-git-send-email-armbru@redhat.com>
	<17b1385e-c14f-d933-661f-56217077ff79@redhat.com>
	<87shgy4gl8.fsf@dusky.pond.sub.org>
	<fe594ae6-09e7-6f74-faa0-4b56f8dcea4f@redhat.com>
Date: Fri, 01 Sep 2017 16:33:32 +0200
In-Reply-To: <fe594ae6-09e7-6f74-faa0-4b56f8dcea4f@redhat.com> (Thomas Huth's
	message of "Fri, 1 Sep 2017 15:55:27 +0200")
Message-ID: <877exi4hfn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tests/qmp-test: Add generic,
 basic test of query commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, crosa@redhat.com

Thomas Huth <thuth@redhat.com> writes:

> On 11.08.2017 11:08, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 08/10/2017 01:30 PM, Markus Armbruster wrote:
> [...]
>>>> We get basic test coverage for the following commands:
>>>
>>> Cool!
>>>
>>>>
>>>>     qom-list-types
>>>>     query-acpi-ospm-status
>>>>     query-balloon               (expected to fail)
>>>
>>>>     query-vm-generation-id      (expected to fail)
>>>
>>>> Most tested commands are expected to succeed.  The test does not check
>>>> the return value then.  A few commands are expected to fail because
>>>> they need special arguments to succeed, and this test is too dumb to
>>>> supply them.
>>>
>>> Sounds like it would just be a matter of adding additional command line
>>> parameters to the qemu being invoked for testing those commands?
>> 
>> In theory, setting up the state required for a query to succeed could be
>> too complex for this stupid test.
>> 
>> In practice, query-balloon should need just "-device virtio-balloon",
>> and query-vm-generation-id should need just "-device vmgenid" and ACPI
>> (I think).  Not all machines can do these devices.  Let's what I can do
>> in v2.
>
> FWIW: I think the balloon testing could also go into
> tests/virtio-balloon-test.c instead ... that test is only run on
> architectures where the device should be available.

A generic test like this one can only do basic smoke testing.  More than
that would be useful for many commands, including query-balloon.  It
doesn't have to be in this file, though.  virtio-balloon-test.c looks
like a fine choice for query-balloon testing.
