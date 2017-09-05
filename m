Received: from eggs.gnu.org ([2001:4830:134:3::10]:36272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpCY2-0004qJ-4B
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpCXs-0006XF-Kk
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dpCXs-0006Wx-F5
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:01:32 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-18-david@redhat.com>
	<f162eece-8dd0-a8e9-f339-356465ab6587@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cdc6b4d0-117a-be80-cd3e-d2a4592f061d@redhat.com>
Date: Tue, 5 Sep 2017 14:01:14 +0200
MIME-Version: 1.0
In-Reply-To: <f162eece-8dd0-a8e9-f339-356465ab6587@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/19] s390x: CPU hot unplug via
 device_del cannot work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 05.09.2017 11:14, Christian Borntraeger wrote:
> On 09/04/2017 05:43 PM, David Hildenbrand wrote:
>> device_del on a CPU will currently do nothing. Let's emmit an error
>> telling that this is will never work (there is no architecture support
>> on s390x). Error message copied from ppc.
>>
>> (qemu) device_del cpu1
>> device_del cpu1
>> CPU hot unplug not supported on this machine
> 
> Given the fact that I get the question about unplug _every_ time when I give a presentation
> about KVM on z, I will try to get some architecture folks look at this. Maybe we can define
> something very simple like "if the CPU is in the stopped state we can remove this and just
> piggy back on the existing sclp EVENT_QUAL_CPU_CHANGE notification".
> 
> So maybe add  "currently"

Unfortunately it might not be that easy.

We would have to find a way that existing OS's don't break. If a guest
OS is not prepared for CPUs to get removed, we might run into
inconsistencies when simply deleting CPUs that are in the STOPPED state.

Especially, these CPUs would still show up in the guest as "offline".
Wonder what would then happen trying to "online" these.

But yes, I can add "currently".

-- 

Thanks,

David
