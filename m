Received: from eggs.gnu.org ([2001:4830:134:3::10]:40655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fpYS1-00064n-4A
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fpYS0-0003gL-2A
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:29:29 -0400
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
	<w5136vm8m8u.fsf@maestria.local.igalia.com>
	<ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
	<20180813112333.GD4323@localhost.localdomain>
	<e9a77f1e-6b9e-3fea-69c9-c18638961a2e@redhat.com>
	<20180813155856.GL4323@localhost.localdomain>
	<435d9dd8-f994-f011-f62e-4568dea8fd21@janustech.com>
	<20180814081849.GA5025@dhcp-200-186.str.redhat.com>
	<7d026f2f-99c2-a341-c5b8-da757a995877@janustech.com>
	<20180814114450.GJ5025@dhcp-200-186.str.redhat.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <ad004680-81d7-cc13-6e97-d00d671f61b1@janustech.com>
Date: Tue, 14 Aug 2018 15:29:05 +0300
MIME-Version: 1.0
In-Reply-To: <20180814114450.GJ5025@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 6/9] qcow2: Increase the default upper
 limit on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

On 8/14/18 2:44 PM, Kevin Wolf wrote:
> Am 14.08.2018 um 13:34 hat Leonid Bloch geschrieben:
>> On 8/14/18 11:18 AM, Kevin Wolf wrote:
>>> Am 13.08.2018 um 18:42 hat Leonid Bloch geschrieben:
>>>>> I don't actually think it's so bad to keep the cache permanently
>>>>> allocated, but I wouldn't object to a lower default for non-Linux hosts
>>>>> either. 1 MB may still be a little too low, 4 MB (covers up to 32 GB)
>>>>> might be more adequate. My typical desktop VMs are larger than 8 GB, but
>>>>> smaller than 32 GB.
>>>>
>>>> And for a Windows VM just the OS installation takes above 40 GB. While we
>>>> probably are not running Windows VMs for our own needs, it is very common
>>>> that a customer of, for example, some cloud service uses QEMU (unknowingly)
>>>> for a full-blown Windows. So 100 GB+ images which are quite heavily used is
>>>> not a rare scenario. 256 GB - yeah, that would be on the higher end.
>>>
>>> The OS installation is mostly sequential access, though. You only need
>>> that much cache when you have completely random I/O across the whole
>>> image. Otherwise the LRU based approach of the cache is good enough to
>>> keep those tables cached that are actually in use.
>>
>> Sorry, by "OS installation" I meant the installed size of the OS, which
>> should be available for fast and frequent access, not the installation
>> process itself. Obviously for one-time tasks like the installation process
>> it's not worth it, unless one installs all the time, instead of using ready
>> images, for some reason. :)
> 
> But you never use everything that is present in an OS installation of
> 40 GB (is it really _that_ huge these days?), and you don't read OS
> files non-stop. The most frequently used parts of the OS are actually in
> the guest RAM.

Yes, Windows 8.1, with all the desktop bloat - just above 40 GB. :]
I did a proper benchmarking indeed only on heavy I/O load, where full 
cache did show above 50% improvement, although just regular usage felt 
faster as well, but maybe it's just psychosomatic. :)

Leonid.

> 
> I don't think you'll really notice the difference in qcow2 unless you
> have a really I/O intensive workload - and that is not usually for OS
> files, but for user data. For only occasional accesses, the additional
> 64k for the metadata table wouldn't play a big role.
> 
> Kevin
> 
