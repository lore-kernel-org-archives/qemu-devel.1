Received: from eggs.gnu.org ([2001:4830:134:3::10]:59810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3efD-00042C-Ve
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3efB-00053M-9d
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d3efB-000539-45
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:20:33 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69303A08EF
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 08:20:31 +0000 (UTC)
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-8-pbonzini@redhat.com>
	<e733d2b3-4c20-e9a4-4807-86675661f2cc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3d9c513-444b-c0d1-8967-3430fe63776c@redhat.com>
Date: Thu, 27 Apr 2017 10:20:27 +0200
MIME-Version: 1.0
In-Reply-To: <e733d2b3-4c20-e9a4-4807-86675661f2cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/11] blockjob: introduce
 block_job_cancel_async, check iostatus invariants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org



On 26/04/2017 22:25, John Snow wrote:
>>  
>>  void block_job_iostatus_reset(BlockJob *job)
>>  {
>> +    if (job->iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
>> +        return;
>> +    }
>> +    assert(job->user_paused && job->pause_count > 0);
> Why assert that it's user-paused? Will that be true from:
> 
> (A) All users of block_job_cancel_async, including:
> 
> - block_job_cancel
> - block_job_completed
>     block_job_completed_txn_abort
> 
> (B) all users of blk_iostatus_reset:
> - blk_do_attach_dev
> - qmp_cont
> 
> It's ... not really clear to me that this is true, can you help me out?

Setting iostatus to not-ok only happens in block_job_iostatus_set_err, 
which is called from block_job_error_action:

    if (action == BLOCK_ERROR_ACTION_STOP) {
        /* make the pause user visible, which will be resumed from QMP. */
        block_job_user_pause(job);
        block_job_iostatus_set_err(job, error);
    }

Paolo
Paolo
