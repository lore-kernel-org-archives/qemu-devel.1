Received: from eggs.gnu.org ([2001:4830:134:3::10]:55784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5WzB-0001Pb-Ng
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5Wz5-0000GY-Pq
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:05:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e5Wz5-0000GO-G5
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:05:07 -0400
References: <87y3oqugm7.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171005121115.GD3946746@orkuz.home>
	<87y3ok7n2n.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171012120714.GA314661@orkuz.home>
	<87mv4m6pp5.fsf@marc-ibm.boeblingen.de.ibm.com>
	<7aa560cd-d35f-7feb-a9db-378d3e763a62@redhat.com>
	<20171020125056.GN130425@orkuz.home>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f43de685-b6d6-14fe-38d1-35481a6ac954@redhat.com>
Date: Fri, 20 Oct 2017 15:04:57 +0200
MIME-Version: 1.0
In-Reply-To: <20171020125056.GN130425@orkuz.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] Question about the host-model CPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On 20.10.2017 14:50, Jiri Denemark wrote:
> On Fri, Oct 20, 2017 at 13:37:42 +0200, David Hildenbrand wrote:
>> On 20.10.2017 13:09, Marc Hartmayer wrote:
>>> we recently encountered the problem that the 'host-model' [1] has to be
>>> related to the machine type of a domain. We have following problem:
>>>
>>>    Let's assume we've a z13 system with a QEMU 2.9 and we define a
>>>    domain using the default s390-virtio-ccw machine together with the
>>>    host-model CPU mode [1]. The definition will have the machine
>>>    expanded to s390-virtio-ccw-2.9 but retain the host-model CPU mode
>>>    in the domain definition. In a next step we upgrade to QEMU 2.10
>>>    (first version to recognize z14). Everything is still fine, even
>>>    though the machine runs in 2.9 compatibility mode. Finally we
>>>    upgrade to a z14. As a consequence it is not possible to start the
>>>    domain anymore as the machine type doesn't support our CPU host
>>>    model (which is expanded at start time of the domain).
>>
>> Yes, the host model may vary depending on QEMU version and to some
>> degree also on compatibility machines (although I always try to push
>> people to not introduce any new such stuff).
>>
>> Quoting for the libvirt documentation: https://libvirt.org/formatdomain.html
>>
>> "host-model
>>     The host-model mode is essentially a shortcut to copying host CPU
>> definition from capabilities XML into domain XML. Since the CPU
>> definition is copied just before starting a domain, exactly the same XML
>> can be used on different hosts while still providing the best guest CPU
>> each host supports."
>>
>> You're telling me that that copying does not happen, which seems to be
>> the problematic part about this in my opinion.
>>
>> So I am not sure if probing anything else (as you noted below) is the
>> correct thing to do. Copy it and you have a migration_safe and even
>> static version of the _current_ host CPU.
> 
> The thing is libvirt calls query-cpu-model-expansion to check what the
> host CPU is. This 'host-model' CPU is replaced with the probed CPU model
> when a domain starts. The problem described by Marc is that the probed
> CPU model cannot be used universally with all machine types. So starting
> a domain on such host with machine type s390-virtio-ccw-2.10 works, but
> a domain with machine type s390-virtio-ccw-2.9 fails to start with the
> same probed CPU model.
> 

My assumption would be that the CPU model is copied into the XML when
the domain fist starts. This is what the documentation describes.

So when upgrading QEMU, the CPU model in the XML is still the same
(z13), even though something different is now reported in the host info
after upgrading QEMU (z14).

In this case it would continue to work.

The problem is that the CPU model is not copied into the XML doesn't
remain there, right? It is suddenly replaced with a z14 host model.

> Jirka
> 


-- 

Thanks,

David
