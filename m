Received: from eggs.gnu.org ([2001:4830:134:3::10]:47835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ewqiL-0001UR-O4
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ewqiI-0004h0-KM
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:52:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ewqiI-0004gc-Bp
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:52:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GEplR0070455
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:52:08 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2grcwc8a10-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:52:08 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 16 Mar 2018 14:52:05 -0000
References: <20180309131949.18640-1-stefanha@redhat.com>
	<20180309131949.18640-8-stefanha@redhat.com>
	<e8734962-9e78-6061-09fc-5f2eb663695f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 16 Mar 2018 15:52:00 +0100
MIME-Version: 1.0
In-Reply-To: <e8734962-9e78-6061-09fc-5f2eb663695f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <25e34cdb-813b-3ada-61d5-b3136e24472b@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 7/7] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 03/12/2018 08:05 PM, John Snow wrote:
> 
> 
> On 03/09/2018 08:19 AM, Stefan Hajnoczi wrote:
>> Commit 00d09fdbbae5f7864ce754913efc84c12fdf9f1a ("vl: pause vcpus before
>> stopping iothreads") and commit dce8921b2baaf95974af8176406881872067adfa
>> ("iothread: Stop threads before main() quits") tried to work around the
>> fact that emulation was still active during termination by stopping
>> iothreads.  They suffer from race conditions:
>> 1. virtio_scsi_handle_cmd_vq() racing with iothread_stop_all() hits the
>>    virtio_scsi_ctx_check() assertion failure because the BDS AioContext
>>    has been modified by iothread_stop_all().
>> 2. Guest vq kick racing with main loop termination leaves a readable
>>    ioeventfd that is handled by the next aio_poll() when external
>>    clients are enabled again, resulting in unwanted emulation activity.
>>
>> This patch obsoletes those commits by fully disabling emulation activity
>> when vcpus are stopped.
>>
>> Use the new vm_shutdown() function instead of pause_all_vcpus() so that
>> vm change state handlers are invoked too.  Virtio devices will now stop
>> their ioeventfds, preventing further emulation activity after vm_stop().
>>
>> Note that vm_stop(RUN_STATE_SHUTDOWN) cannot be used because it emits a
>> QMP STOP event that may affect existing clients.
>>
>> It is no longer necessary to call replay_disable_events() directly since
>> vm_shutdown() does so already.
>>
>> Drop iothread_stop_all() since it is no longer used.
>>
>> Cc: Fam Zheng <famz@redhat.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>> Message-id: 20180307144205.20619-5-stefanha@redhat.com
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Stefan, I see the same iotest regression that was reported by John Snow also
on s390. I can confirm that it works with this patch reverted.

Christian
