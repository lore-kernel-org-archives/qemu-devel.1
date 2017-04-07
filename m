Received: from eggs.gnu.org ([2001:4830:134:3::10]:38883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwYGE-0001go-Go
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 14:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwYGD-0003cu-Ma
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 14:05:26 -0400
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-7-famz@redhat.com>
	<20170407132850.GG16146@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <6f0d8984-d781-9dc3-a175-5428da83c6f7@redhat.com>
Date: Fri, 7 Apr 2017 14:05:12 -0400
MIME-Version: 1.0
In-Reply-To: <20170407132850.GG16146@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] tests/block-job-txn: Don't start
 block job before adding to txn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>



On 04/07/2017 09:28 AM, Stefan Hajnoczi wrote:
> On Fri, Apr 07, 2017 at 02:54:14PM +0800, Fam Zheng wrote:
>> Previously, before test_block_job_start returns, the job can already
>> complete, as a result, the transactional state of other jobs added to
>> the same txn later cannot be handled correctly.
>>
>> Move the block_job_start() calls to callers after
>> block_job_txn_add_job() calls.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  tests/test-blockjob-txn.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> CCing John Snow because he looked at block jobs completing during txn
> setup recently.
> 
> Stefan
> 

This matches the changes we made to qmp_transaction, but I forgot to (or
didn't take care to)  change the qtest as it didn't cause a regression
at the time.

I wonder if I should make it a runtime error to add a job to a
transaction which has already "started" to make sure that this interface
is not misused, as this test highlights that there were still some
remaining "bad" uses of the interface.

Regardless...

Thanks for the CC. ACK
