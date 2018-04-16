Received: from eggs.gnu.org ([2001:4830:134:3::10]:46009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1f7xWC-0007dr-9R
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 02:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1f7xW8-0002I0-7w
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 02:21:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:8173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1f7xW7-0002E0-Sq
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 02:21:32 -0400
References: <22f7f184-c295-4e18-c186-3fd9fdcce213@linux.intel.com>
	<20180323160252.GA27131@stefanha-x1.localdomain>
	<1e0e5f9b-18b4-7f0f-dbd1-696ef1f7039c@linux.intel.com>
	<e638d7a3-5c38-7a10-cef9-d1791e5b8fc7@linux.intel.com>
	<20180404094537.GI4467@stefanha-x1.localdomain>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <893131b0-cd13-3c41-5a01-973a0302792c@linux.intel.com>
Date: Mon, 16 Apr 2018 14:21:26 +0800
MIME-Version: 1.0
In-Reply-To: <20180404094537.GI4467@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Consult] nfs-vsocks support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: yang.zhong@intel.com, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>



On 4/4/2018 5:45 PM, Stefan Hajnoczi wrote:
> On Wed, Mar 28, 2018 at 07:25:21PM +0800, Liu, Jing2 wrote:
>> On 3/26/2018 6:12 PM, Liu, Jing2 wrote:
>>> Hi Stefan,
>>>
>>> Thank you very much for the response! It truly gave me much help.
>>>
>>> On 3/24/2018 12:02 AM, Stefan Hajnoczi wrote:
>> [...]
>>>>> Could you give me some help and thanks in advance!
>>>>
>>>> Here is a script that launches nfsd and runs a guest:
>>>> https://github.com/stefanha/linux/commit/38cbc15661a6dd44b69c4f318091f2047d707035#diff-05f3fe8941076453942a8c059b409009
>>>>
>>
>> Using the script, I met some problems making the
>> initramfs.gz. It confused me a lot... I don't have busybox under
>> /usr/bin or /usr/sbin. Where to get it?
> 

> It may be easier to use a full guest disk image instead of the disk
> image generation in my go.sh script.  The initramfs is very specific to
> the development machine I was using at the time.  The main thing to look
> at the in the go.sh script is how the NFS services are launched on the
> host.
> 
> Busybox is a package that is available on most Linux distributions.

I realized the rhel-7.x doesn't has busybox anymore. And yes, I used 
some other image to continue.

> Before you spend more time on this, NFS over AF_VSOCK is only suitable
> for developers right now.  It is not ready for production and I am not
> supporting it for end users.  So if you want to hack on NFS, please go
> ahead, but otherwise it's probably not what you want.
> 
Yes, so far we didn't plan for production. And thank you very much for 
your kind response.

Jing

> Stefan
> 
>> (host)$./go.sh nfs_tcp
>>
>> File /usr/sbin/busybox could not be opened for reading
>>   line 55
>> File /lib64/libtirpc.so.3 could not be opened for reading
>>   line 306
>> File nc-vsock could not be opened for reading
>>   line 321
>> File ../netperf-2.7.0/src/netserver could not be opened for reading
>>   line 325
>>
>> It results in guest kernel_panic when gdb launches the guest:
>>
>> [    0.425738] Failed to execute /init (error -2)
>> [    0.426074] Kernel panic - not syncing: No working init found.  Try
>> passing .
>> [    0.427077] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0+ #3
>> [    0.427507] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> rel-4
>> [    0.428354] Call Trace:
>> [    0.428538]  dump_stack+0x63/0x89
>> [    0.428774]  ? rest_init+0x60/0xc0
>> [    0.429017]  panic+0xeb/0x245
>> [    0.429225]  ? putname+0x53/0x60
>> [    0.429455]  ? rest_init+0xc0/0xc0
>> [    0.429722]  kernel_init+0xf1/0x104
>> [    0.430017]  ret_from_fork+0x25/0x30
>>
>> Looking forward to the kind reply.
>> BTW, for the following questions that I sent two days ago, I have some
>> ideas in mind and it could be ignored now.
>>
>> Jing
>>
>>> I have updated both host and guest kernel with vsock-nfsd repo and
>>> installed nfs-utils in both host and guest successfully.
>>>
>>> There're two different manuals in
>>> https://www.spinics.net/lists/linux-nfs/msg64563.html(Quickstart 3~7)
>>> and nfs-utils (README step 3 DAEMON STARTUP ORDER).
>>> Which one should be the best usage?
>>>
>>> For the first quickstart manual step 7-Mount the export from the guest,
>>> two questions as follows.
>>> 1. why hypervisor's CID is 2? I didn't notice when it is specified?
>>> 2. Though I did step 3~7 successfully, I can't see the synchronistical
>>> changing on host folder /export/ and guest /mnt? So how to test the
>>> communcation between host and guest on the folder?
>>>
>>> Thanks again!
>>>
>>> Jing
>> [...]
>>>>
>>>> Stefan
>>>>
>>>
>>
