Received: from eggs.gnu.org ([2001:4830:134:3::10]:60235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRd4x-00040l-9V
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRd4s-0007Qr-S9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:07:02 -0500
References: <20181127114102.4319-1-david@redhat.com>
	<f31fb9d1-d1dd-7d06-7993-08e44bb77632@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <55d945eb-a9ba-9183-9c47-3a1e505d2d35@redhat.com>
Date: Tue, 27 Nov 2018 14:06:46 +0100
MIME-Version: 1.0
In-Reply-To: <f31fb9d1-d1dd-7d06-7993-08e44bb77632@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tod: properly stop the KVM TOD
 while the guest is not running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2018-11-27 13:43, Christian Borntraeger wrote:
> On 27.11.2018 12:41, David Hildenbrand wrote:
>> Just like on other architectures, we should stop the clock while the guest
>> is not running. This is already properly done for TCG. Right now, doing an
>> offline migration (stop, migrate, cont) can easily trigger stalls in the
>> guest.
>>
>> Even doing a
>>     (hmp) stop
>>     ... wait 2 minutes ...
>>     (hmp) cont
>> will already trigger stalls.
>>
>> So whenever the guest stops, backup the KVM TOD. When continuning to run
>> the guest, restore the KVM TOD.
> 
> We do a similar thing for managedsave so it probably makes sense to solve
> the stall warnings. Now: At the same time, we actually want to have the guest
> see the real time and maybe even share the TOD clock with the host in some
> way, while at the same time avoid the stall warnings.

Hmm, by the way, do we also have to consider the "-rtc clock=host|rt|vm"
option from the commandl line, or is this an orthogonal concept?

 Thomas
