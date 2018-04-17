Received: from eggs.gnu.org ([2001:4830:134:3::10]:33106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f8Ltl-0007bP-OD
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f8Ltg-0006i4-So
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:23:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1f8Ltg-0006hW-Os
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:23:28 -0400
References: <0c14166c-28c4-a1ad-093b-ba63e373e790@redhat.com>
	<20180416175955.GO29865@localhost.localdomain>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <77dbce74-6d73-d671-c82f-9fc985957359@redhat.com>
Date: Tue, 17 Apr 2018 10:23:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180416175955.GO29865@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Purpose of memory-backend-file.discard-data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Zack Cornelius <zack.cornelius@kove.net>

On 04/16/2018 07:59 PM, Eduardo Habkost wrote:
> (CCing Zack Cornelius)
> 
> On Fri, Apr 13, 2018 at 08:21:26AM +0200, Michal Privoznik wrote:
>> Eduardo et al,
>>
>> I'm looking at 11ae6ed8affdd131e and I wanted to implement libvirt
>> support for that. But more I look at it less I understand it. My
>> understanding it is an optimization (although not very effective one
>> since madvise() is/should be immediately followed by munmap()). So any
>> application that is trying to keep track of guest memory  can stop doing
>> so as soon as it sees munmap(). Or does the optimization lies in fact
>> that madvise() is called sooner and thus the app can stop caring
>> slightly sooner?
> 
> munmap() or close() are not enough: it would still make the host
> kernel unnecessarily write data to backing storage.

Something like sync()? I though that mem access is always synchronous.
Or perhaps I don't understand why is kernel still touching data after
munmap().

>  The point of
> the madvise() call is to tell the kernel that data can be
> destroyed instead of being written back.
> 
> The original use case is described by Zack here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg473538.html
> 
> 
>>
>> Also, I don't quite understand why is this configurable. What's the harm
>> in turning it on by default? Yesterday I've posted some patches to
>> libvirt list [1] (although I have to admit I am still not fully
>> convinced about the design) and they implement just this - whenever qemu
>> supports the feature libvirt turns it on.S
> 
> The option can destroy the data on the backing file, so QEMU can't enable it by
> default.  libvirt can enable it as long as it knows it can destroy the data on
> the backing file.

Destroy data? Oh, okay then. I rather make it configurable. Although I'm
not quite sure about XML design yet.

Michal
