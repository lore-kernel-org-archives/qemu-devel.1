Received: from eggs.gnu.org ([2001:4830:134:3::10]:48242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ehEde-0003hq-JA
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ehEdW-0003jI-O2
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:10:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1ehEdW-0003iD-HU
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:10:42 -0500
References: <20180129120932.12874-1-quintela@redhat.com>
	<CAFEAcA_DrUj0MdJVRMst91k--Cvc9j+QKy-tscp0R526cEttdQ@mail.gmail.com>
	<87d11r3lm0.fsf@secure.laptop>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <00350681-0f68-0a85-b7b1-2001a01e0aa3@redhat.com>
Date: Thu, 1 Feb 2018 14:10:34 +0100
MIME-Version: 1.0
In-Reply-To: <87d11r3lm0.fsf@secure.laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/13] Migration PULL request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 30/01/2018 07:29, Juan Quintela wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 29 January 2018 at 12:09, Juan Quintela <quintela@redhat.com> wrote:
>>> Hi
>>>
>>> - migrate_fd_connect cleanup (dave)
>>> - use MAX_VM_PACKAGED_SIZE
>>>   have to change (1<<32) for UINT32_MAX to get no warnings on win32
>>> - Use right s->threashord_size(wei)
>>> - patches reviewed from info/migrate, migration tests and multifd (me)
>>>
>>> Later, Juan.
>>>
>>> The following changes since commit 6233b4a8c2a32ef6955a921246fa08705bbb3676:
>>>
>>>   Merge remote-tracking branch
>>> 'remotes/ericb/tags/pull-nbd-2018-01-26' into staging (2018-01-26
>>> 17:29:14 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://github.com/juanquintela/qemu.git tags/migration/20180129
>>>
>>> for you to fetch changes up to 4b6bb0a77761b8a906a540e927c7a9dde99bc10f:
>>>
>>>   tests: Adjust sleeps for migration test (2018-01-29 12:10:22 +0100)
>>>
>>> ----------------------------------------------------------------
>>> migration/next for 20180129
>>
>> Hi. On aarch32 host I get this assert in the tests:
>>
>> TEST: tests/migration-test... (pid=605)
>>   /ppc64/migration/deprecated:                                         OK
>>   /ppc64/migration/precopy/unix:                                       OK
>>   /ppc64/migration/postcopy/unix:                                      OK
>>   /ppc64/migration/xbzrle/unix:
>> Unexpected 32 on dest_serial serial
>> **
>> ERROR:/home/peter.maydell/qemu/tests/migration-test.c:218:wait_for_serial:
>> code should not be reached
> 
> 1st time I see a problem on the xbzrle test.  I can resent the pull
> without that patch, but that is a *test*, the problem is that we have a
> xbzrle problem on aarch32 that we didn't know about yet.
> 
> So I will just try to do the PULL request anyways.  I will try to get
> access to an arm32 system tomorrow and see what is going on.
> 
> Thanks for checking it.

I have tested this on ppc32 (G4@900MHz) and I found it never converges.

If I increase the downtime limit, it works:

--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -674,7 +674,7 @@ static void test_xbzrle(const char *uri)
     wait_for_migration_pass(from);

     /* 300ms should converge */
-    migrate_set_parameter(from, "downtime-limit", "300");
+    migrate_set_parameter(from, "downtime-limit", "2000");

The test is also disabled if USERFAULTFD is disabled in the kernel,
whereas it doesn't need it. You should update the "if
(!ufd_version_check())" part.

Thanks,
Laurent
