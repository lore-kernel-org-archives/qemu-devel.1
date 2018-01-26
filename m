Received: from eggs.gnu.org ([2001:4830:134:3::10]:53067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ef8nH-0004g5-Hq
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ef8nD-0000ul-VD
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:32:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ef8nD-0000tP-Gy
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:32:03 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0QDmokK106947
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 08:50:29 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fr2ymwwtq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 08:50:28 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 26 Jan 2018 06:50:27 -0700
References: <20180126124845.19257-1-danielhb@linux.vnet.ibm.com>
	<20180126131150.GE2610@work-vm>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 26 Jan 2018 11:50:14 -0200
MIME-Version: 1.0
In-Reply-To: <20180126131150.GE2610@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <ef06cd9e-e435-57e5-7757-fbf73ed051d1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] migration/savevm.c: do not fail when len >
 MAX_VM_CMD_PACKAGED_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com



On 01/26/2018 11:11 AM, Dr. David Alan Gilbert wrote:
> * Daniel Henrique Barboza (danielhb@linux.vnet.ibm.com) wrote:
>> MAX_VM_CMD_PACKAGED_SIZE is a constant used in qemu_savevm_send_packaged
>> and loadvm_handle_cmd_packaged to determine whether a package is too
>> big to be sent or received. qemu_savevm_send_packaged is called inside
>> postcopy_start (migration/migration.c) to send the MigrationState
>> in a single blob to the destination, using the MIG_CMD_PACKAGED subcommand,
>> which will read it up using loadvm_handle_cmd_packaged. If the blob is
>> larger than MAX_VM_CMD_PACKAGED_SIZE, an error is thrown and the postcopy
>> migration is aborted. Both MAX_VM_CMD_PACKAGED_SIZE and MIG_CMD_PACKAGED
>> were introduced by commit 11cf1d984b ("MIG_CMD_PACKAGED: Send a packaged
>> chunk ..."). The constant has its original value of 1ul << 24 (16MB).
>>
>> The current MAX_VM_CMD_PACKAGED_SIZE value is not enough to support postcopy
>> migration of bigger pseries guests. The blob size for a postcopy migration of
>> a pseries guest with the following setup:
>>
>> qemu-system-ppc64 --nographic -vga none -machine pseries,accel=kvm -m 64G \
>> -smp 1,maxcpus=32 -device virtio-blk-pci,drive=rootdisk \
>> -drive file=f27.qcow2,if=none,cache=none,format=qcow2,id=rootdisk \
>> -netdev user,id=u1 -net nic,netdev=u1
>>
>> goes around 12MB. Bumping the RAM to 128G makes the blob sizes goes to 20MB.
>> With 256G the blob goes to 37MB - more than twice the current maximum size.
>> At this moment the pseries machine can handle guests with up to 1TB of RAM,
>> making this postcopy blob goes to 128MB of size approximately.
> Ouch!  One problem with that is that the size of the blob translates
> into extra downtime on both precopy and postcopy; with a 10Gbps
> connection, 128MB is 128ms - and in precopy that will get sent as part
> of the device state as well.
> Which device is it that's creating that much data?
>
>> One solution is to bump MAX_VM_CMD_PACKAGED_SIZE up to bigger values. A value
>> of 1ul << 27 would be enough for pseries guests up to 1TB of RAM, but there
>> are 2 problems with this approach:
>>
>> - we'll keep supporting bigger and bigger guests as time goes by. This constant
>> would be bumped from time to time;
>>
>> - if we're willing to bump the constant every time we need a bigger blob, why
>> have the constant in the first place? Considering that its current value
>> is 16MB, bumping it to 128MB already makes it 'unreasonably large' considering
>> the original design of MIG_CMD_PACKAGED.
>>
>> A better long term solution is to determine whether the design of
>> MIG_CMD_PACKAGED can be changed to send partial blobs of smaller sizes or
>> even get rid of the size limitation.
>>
>> Until then, this patch changes both qemu_savevm_send_packaged and
>> loadvm_handle_cmd_packaged to not bail out if the blob len is greater than
>> MAX_VM_CMD_PACKAGED_SIZE. To not fully ignore the occurrence (something can go
>> wrong and the MigrationState can inadvertently grow beyond expected), we also
>> change the traces of both functions to report both the current blob size and the
>> current recommended maximum. This way we allow big guests to execute postcopy
>> migration while retaining the information for debug purposes.
> Given that the length is sent as a 32bit int, we need to have a limit at
> 2^32 on the sending side, so we need to keep that.
> If you're saying the blob hits 128MB for a 1TB guest, then hmm that's
> 1GB for an 8TB guest, and 4GB for a 32TB guest.
> I suggest we limit to 4GB to avoid truncation, and then if anyone needs
> a 32TB guest, they come and ask.  But we should look at what that device
> is doing before then.

Makes sense. I'll send the patch setting the limit to 4GB and I'll follow up
in the investigation of which device is getting greedy with the blob.


Daniel

>
> Dave
>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>> ---
>>   migration/savevm.c     | 15 ++-------------
>>   migration/trace-events |  4 ++--
>>   2 files changed, 4 insertions(+), 15 deletions(-)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index b7908f62be..c7b9d69578 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -861,15 +861,9 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
>>   {
>>       uint32_t tmp;
>>   
>> -    if (len > MAX_VM_CMD_PACKAGED_SIZE) {
>> -        error_report("%s: Unreasonably large packaged state: %zu",
>> -                     __func__, len);
>> -        return -1;
>> -    }
>> -
>>       tmp = cpu_to_be32(len);
>>   
>> -    trace_qemu_savevm_send_packaged();
>> +    trace_qemu_savevm_send_packaged(len, MAX_VM_CMD_PACKAGED_SIZE);
>>       qemu_savevm_command_send(f, MIG_CMD_PACKAGED, 4, (uint8_t *)&tmp);
>>   
>>       qemu_put_buffer(f, buf, len);
>> @@ -1718,12 +1712,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
>>       QIOChannelBuffer *bioc;
>>   
>>       length = qemu_get_be32(mis->from_src_file);
>> -    trace_loadvm_handle_cmd_packaged(length);
>> -
>> -    if (length > MAX_VM_CMD_PACKAGED_SIZE) {
>> -        error_report("Unreasonably large packaged state: %zu", length);
>> -        return -1;
>> -    }
>> +    trace_loadvm_handle_cmd_packaged(length, MAX_VM_CMD_PACKAGED_SIZE);
>>   
>>       bioc = qio_channel_buffer_new(length);
>>       qio_channel_set_name(QIO_CHANNEL(bioc), "migration-loadvm-buffer");
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 6f29fcc686..646963ffec 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -6,10 +6,10 @@ qemu_loadvm_state_section_command(int ret) "%d"
>>   qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>>   qemu_loadvm_state_post_main(int ret) "%d"
>>   qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>> -qemu_savevm_send_packaged(void) ""
>> +qemu_savevm_send_packaged(size_t len, size_t max) "size=%zu, max recommended=%zu"
>>   loadvm_state_setup(void) ""
>>   loadvm_state_cleanup(void) ""
>> -loadvm_handle_cmd_packaged(unsigned int length) "%u"
>> +loadvm_handle_cmd_packaged(size_t len, size_t max) "size=%zu, max recommended=%zu"
>>   loadvm_handle_cmd_packaged_main(int ret) "%d"
>>   loadvm_handle_cmd_packaged_received(int ret) "%d"
>>   loadvm_postcopy_handle_advise(void) ""
>> -- 
>> 2.14.3
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
