Received: from eggs.gnu.org ([2001:4830:134:3::10]:56387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdIld-0000Pl-5C
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdIlZ-0000Td-Pg
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:42:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cdIlZ-0000TM-Jr
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:42:13 -0500
References: <1486210863-14924-1-git-send-email-ashijeetacharya@gmail.com>
	<20170210150403.GC13357@work-vm> <20170213151418.GD3086@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce057163-94ad-995d-189e-31f3c93440d7@redhat.com>
Date: Mon, 13 Feb 2017 16:42:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170213151418.GD3086@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] migrate: Introduce a 'dc->vmsd' check
 to avoid segfault for --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: quintela@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org



On 13/02/2017 16:14, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>> * Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
>>> Commit a3a3d8c7 introduced a segfault bug while checking for
>>> 'dc->vmsd->unmigratable' which caused QEMU to crash when trying to add
>>> devices which do no set their 'dc->vmsd' yet while initialization.
>>> Place a 'dc->vmsd' check prior to it so that we do not segfault for
>>> such devices.
>>>
>>> NOTE: This doesn't compromise the functioning of --only-migratable
>>> option as all the unmigratable devices do set their 'dc->vmsd'.
>>>
>>> Also, move the only_migratable check inside device_set_realized() to avoid
>>> code duplication and fix the bug to display only_migratable error message
>>> only if the device constructuon is right.
>>>
>>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>>
>> Queued
> 
> I've had to remove this;  it fails to build user-mode qemu's.
> I think the problem is only_migratable is in vl.c and doesn't
> get linked in user mode qemu; I tried adding a #ifndef CONFIG_USER_ONLY
> around the block and it didn't help, so back to you.\

It doesn't help because the file is compiled just once.  You can add it
to stubs/ (for example stubs/vmstate.c).

Paolo
