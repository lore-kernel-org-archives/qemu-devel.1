Received: from eggs.gnu.org ([2001:4830:134:3::10]:46576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eygz2-0006tB-V5
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eygyz-0002we-Tx
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:53:05 -0400
References: <20180319215335.1119213-1-eblake@redhat.com>
	<20180320104348.GA3268@yuvallap>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <777824c3-4fd9-9690-d3a0-8e17c45e46fc@redhat.com>
Date: Wed, 21 Mar 2018 18:52:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180320104348.GA3268@yuvallap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] rdma: Fix 32-bit compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 20/03/2018 12:43, Yuval Shaia wrote:
> On Mon, Mar 19, 2018 at 04:53:35PM -0500, Eric Blake wrote:
>> Use the correct printf formats, so that a 32-bit compile doesn't
>> spit out lots of warnings about %lx being incompatible with uint64_t.
>> Broken since initial commit ef6d4ccd.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> I don't know if 'make vm-build-ubuntu.i368' would catch this (it failed
>> for me for other reasons); I found it via a 32-bit rawhide VM.
>>
>>  hw/rdma/rdma_backend.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
>> index e306fba5344..89020fdcf62 100644
>> --- a/hw/rdma/rdma_backend.c
>> +++ b/hw/rdma/rdma_backend.c
>> @@ -656,7 +656,8 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp)
>>  #define CHK_ATTR(req, dev, member, fmt) ({ \
>>      pr_dbg("%s="fmt","fmt"\n", #member, dev.member, req->member); \
>>      if (req->member > dev.member) { \
>> -        warn_report("%s = 0x%lx is higher than host device capability 0x%lx", \
>> +        warn_report("%s = 0x%" PRIx64 " is higher than host device " \
>> +                    "capability 0x%" PRIx64, \
>>                      #member, (uint64_t)req->member, (uint64_t)dev.member); \
> 
> Hmmm, interesting.
> I wonder why in first place to cast all members to uint64_t.
> Can you try the method that is used above in the call to pr_dbg, i.e. to
> use the given argument fmt?
> > Something like this:
> 	warn_report("%s = "fmt" is higher than host device capability "fmt, \
> 	            #member, req->member, dev.member); \
> 
>>          req->member = dev.member; \
>>      } \


Right, it seems to be a better solution.

Eric/Yuval, will you send a patch for it?

Thanks!
Marcel


>> -- 
>> 2.14.3
>>
