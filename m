Received: from eggs.gnu.org ([209.51.188.92]:44128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <copymaster@howtolinux.de>) id 1gvgCd-000239-Tk
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <copymaster@howtolinux.de>) id 1gvgCc-0007uG-Qx
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:31:11 -0500
References: <1ee13520-b5f2-b539-7112-4e7de79e7c16@howtolinux.de>
	<20190218095141.GA5303@dhcp-200-176.str.redhat.com>
From: Alexander Marx <copymaster@howtolinux.de>
Message-ID: <ad648f62-2be8-5d24-3e5c-040830073b12@howtolinux.de>
Date: Mon, 18 Feb 2019 11:31:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190218095141.GA5303@dhcp-200-176.str.redhat.com>
Content-Language: de-DE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Please help corrupt filesystem image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Thank you for replying.

The error was in the underlying filesystem. I had to setup new servers.

Alex


Am 18.02.19 um 10:51 schrieb Kevin Wolf:
> Am 17.02.2019 um 05:13 hat Alexander Marx geschrieben:
>> Dear List!
>>
>> I have a big problem and hope you can help me.
>> I built a new windows 2016 domain with virtual servers. 2 dc and 9 rds
>> hosts.
>> I was nearly finished with the setup and ready to migrate the users from
>> old to new domain.
>>
>> Then i had to restart the physical servers. Unfortunately 1 dc and 2 rds
>> hosts could not be startet anymore.
>> Error says:
>>
>> qemu-img: Could not open 'vm-150-disk-0.qcow2': Could not read qcow2
>> header: Input/output error
> The very first thing the qcow2 driver in QEMU does is reading in the
> image file header, and this is the step that produces the error message
> you quoted. This is before even looking at any content of the file. So
> it looks to me as if the image file was corrupted on the file system
> level or even had bad sectors on the physical hard disk.
>
> You can try running 'qemu-img check' under 'strace -f' and double check
> which syscall returns an error before it errors out. I think it will be
> the first pread64() call, returning EIO. If not, please post the output
> you're getting.
>
> Another thing you could try is whether the image file is still
> accessible for tools like cp, dd or hexdump.
>
> If these tests confirm that there is a more general problem with the
> file, running fsck for your host file system that contains the image
> might be a good idea.
>
>> Even worst, a qemu-img check  also gave that error. and i was not able
>> to do anything i found in the internet to fix it.
>> always that error or the qemu-img could not determine the format.
>>
>> Is there a chance to fix these images? What can i do?
>>
>> I have no backup because the domain was not fully configured. But if i
>> have to rebuild the whole domain, i will need several weeks for it.
>> Any help is appreciated.
> If only the header is inaccessible, reconstructing it may be possible.
> Otherwise, probably not.
>
> We can look into this if your results for the above show that you can
> still access the image outside of QEMU, and what exactly is even going
> wrong.
>
> Kevin
