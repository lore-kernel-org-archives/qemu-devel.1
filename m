Received: from eggs.gnu.org ([2001:4830:134:3::10]:42780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ebk2Y-0006kr-B1
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ebk2V-0006dG-4D
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:29:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ebk2U-0006c7-Tf
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:29:47 -0500
References: <20180114090147.39255-1-marcel@redhat.com>
	<20180114090147.39255-4-marcel@redhat.com>
	<20180116040030-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <6aa6ebfb-1f45-7647-883a-58b81ececc7d@redhat.com>
Date: Wed, 17 Jan 2018 11:29:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180116040030-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V7 3/5] docs: add pvrdma device
 documentation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, f4bug@amsat.org

Hi Michael,

On 16/01/2018 4:06, Michael S. Tsirkin wrote:
> On Sun, Jan 14, 2018 at 11:01:45AM +0200, Marcel Apfelbaum wrote:
>> +5. Limitations
>> +==============
> 
> Limitations are fine but need to cause init failures since users
> don't poke in the internal documentation.
> 

Good point, thanks.

>> +- The device obviously is limited by the Guest Linux Driver features implementation
>> +  of the VMware device API.
>> +- Memory registration mechanism requires mremap for every page in the buffer in order
>> +  to map it to a contiguous virtual address range. Since this is not the data path
>> +  it should not matter much.
> 
> Depends on the size of the region I guess. Did you try this with several
> gigabytes of memory?

On a "standard" laptop it takes about 0.3 secs for 0.5G and about 0.5 secs for 1G.
There is no impact for memory regions less than 0.5G.

> If we are talking seconds of downtime,
> it's worth documenting so people aren't surprised. > Alternatively, limit the max size of MR?

We already limited the MAX MR to ~ 134MB. (1<<27), however the user can
change the parameter at command line.
I will add to documentation to pay attention than using 1G MRs can
take half second to register.

> 
>> +- The device requires target page size to be the same as the host page size.
> 
> Pls add code to fail init when this is not the case.
> 

Sure

>> +- QEMU cannot map guest RAM from a file descriptor if a pvrdma device is attached,
>> +  so it can't work with huge pages. The limitation will be addressed in the future,
>> +  however QEMU allocates Guest RAM with MADV_HUGEPAGE so if there are enough huge
>> +  pages available, QEMU will use them.
> 
> Same here.
> 

Will add for next re-spin.

>> +- As previously stated, migration is not supported yet, however with some hardware
>> +  support can be done.
> 
> I don't see a migration blocker.
> 

Will remove from the documentation, thanks.

Thank you for the review,
Marcel

> 
> 
