Received: from eggs.gnu.org ([2001:4830:134:3::10]:50419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZv31-0000iP-Kd
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZv2x-00039Z-MF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:18:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZv2x-00039B-Fq
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:18:27 -0400
References: <1500522569-10760-1-git-send-email-jianjay.zhou@huawei.com>
	<20170721094943.GC2133@work-vm> <5971F246.5080000@huawei.com>
	<20170724153521.GD2127@work-vm>
	<9cea170f-90eb-78e5-6b52-8dd882efd160@redhat.com>
	<5976F364.1050705@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2abe2c11-a942-ab7c-a6a2-2fd3f8d08ac0@redhat.com>
Date: Tue, 25 Jul 2017 10:18:06 +0200
MIME-Version: 1.0
In-Reply-To: <5976F364.1050705@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: optimize the downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, rkrcmar@redhat.com
Cc: qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, zhang.zhanghailiang@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, aarcange@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On 25/07/2017 09:29, Jay Zhou wrote:
>>
>>
>> Maybe memory_global_dirty_log_stop can delay itself to the next vm_start
>> if it's called while runstate_running() returns false (which should be
>> always the case)?
> 
> It is logical, but then we need to put some migration related codes into
> the file of cpus.c(in my patch, I put some codes into the file of qmp.c),
> is there any elegant way to reduce the coupling?

See below:

>> It could even be entirely enclosed within memory.c if you do it with a
>> VMChangeStateHandler. 

If memory_global_dirty_log_stop runs with !runstate_running(), instead
of doing the memory transaction you set a VMChangeStateHandler and
return immediately.

The VMChangeStateHandler then does the actual work just before the VM
starts running.

memory_global_dirty_log_start also needs to delete the
VMChangeStateHandler if it is present.

Paolo
