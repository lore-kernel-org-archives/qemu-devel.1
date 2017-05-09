Received: from eggs.gnu.org ([2001:4830:134:3::10]:46113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8gFE-0001vP-EA
	for qemu-devel@nongnu.org; Thu, 11 May 2017 01:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8gFD-0003mT-Mq
	for qemu-devel@nongnu.org; Thu, 11 May 2017 01:02:32 -0400
References: <20170508141310.8674-1-pbonzini@redhat.com>
	<20170508141310.8674-6-pbonzini@redhat.com>
	<20170509170625.GB25411@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc30caa8-acbb-3640-f394-ada19891795d@redhat.com>
Date: Tue, 9 May 2017 19:09:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170509170625.GB25411@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/11] blockjob: separate monitor and
 blockjob APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com



On 09/05/2017 19:06, Jeff Cody wrote:
>> Keep the two APIs separate in the blockjob.c file too.  This will
>> be useful when transitioning away from the AioContext lock, because
>> there will be locking policies for the two categories, too---the
>> monitor will have to call new block_job_lock/unlock APIs, while blockjob
>> APIs will take care of this for the users.
>
> Would it make sense to split this out into separate files, rather than
> delineating it by placement in a single .c file?

Probably not, because the latter APIs do use several static functions in
blockjob.c.  For example, block_job_early_fail calls block_job_unref,
block_job_completed calls block_job_finish_sync (via
block_job_completed_txn_abort).

Given the file is <1000 lines of code, I think it's not worth the hassle.

Paolo
