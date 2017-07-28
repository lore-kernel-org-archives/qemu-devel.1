Received: from eggs.gnu.org ([2001:4830:134:3::10]:36327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1db6Gb-0003Ka-An
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 10:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1db6GY-000830-9z
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 10:29:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1db6GY-00082D-0I
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 10:29:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6SEQSCV023218
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 10:29:20 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c0466uns2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 10:29:20 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 28 Jul 2017 15:29:18 +0100
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-4-bjsdjshi@linux.vnet.ibm.com>
	<20170727135910.27d9e42e@gondolin>
	<316dd24e-cc45-8469-dd23-491c8b15480e@linux.vnet.ibm.com>
	<20170727161457.58b3c7d1@gondolin>
	<abdfb954-d67b-d360-1627-b51bac263880@linux.vnet.ibm.com>
	<20170728121101.2a85216a@gondolin>
	<f183e2d8-4f75-2981-e148-02c88014a4b1@linux.vnet.ibm.com>
	<20170728145819.2dd0e608@gondolin>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 28 Jul 2017 16:29:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170728145819.2dd0e608@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <62b7ba7d-a8a8-df9c-2b35-0d8fe3e5fcd0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/css: generate channel path
 initialized CRW for channel path hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, rth@twiddle.net



On 07/28/2017 02:58 PM, Cornelia Huck wrote:
> On Fri, 28 Jul 2017 14:32:11 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 07/28/2017 12:11 PM, Cornelia Huck wrote:
>>> On Thu, 27 Jul 2017 18:15:07 +0200
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>>>> So my intention was to ask: What benefits do we expect from these 'real'
>>>> virtual channel paths?   
>>>
>>> Path grouping and friends come to mind. This depends on whether you
>>> want to pass-through channel paths to the guest, of course, but you
>>> really need management to deal with things like reserve/release on ECKD
>>> correctly.  
>>
>> Pass-through means dedicated in this case (that is the passed trough paths
>> are not used by the host -- correct me if my understanding is wrong).
> 
> There's nothing that speaks against path sharing, I think.

That is a nice to hear. I could not form an opinion on this
myself yet. Theoretically we speak about shared physical resources here,
and in such situations I'm wary of interference. A quick look into
the AR documents was not conclusive.

I'm still trying to figure out this whole channel path handling,
and frankly you are a big help right now.

> Especially as e.g. SetPGID is "first one gets to set it".

Hm, I don't understand this. (I've found a description of SETPGID
in "IBM 3880 Storage Control Models ... " but could not get your
point based no that.)

> 
>>
>> This whole multipath/grouping stuff is currently a gray spot for me. I've
>> tired to revisit the corresponding parts of the AR, but there ain't much
>> on it in the documents I have.
>>
>> Is the protocol for managing multipath equipment (device, maybe also CU)
>> dependent? The PoP (and the IO AR) talk about set-multipath-mode type
>> of command and similar (disband, resign) but how this type of command
>> looks like -- no idea. From the kernel code one can learn more details,
>> but that's just an implementation.
> 
> Path selection and friends should all be in the base I/O documentation
> (maybe something in the common I/O device commands, as well.) Path
> grouping is device-specific.
> 

Nod.

>>
>> Can you recommend me a publication where the controls you talk about
>> are specified?
> 
> For SetPGID etc., I'd recommend the DASD documentation (the one
> specifying the channel commands supported). Don't have the publication
> number handy, sorry.
> 

Thanks, based on your input I've found the pub mentioned above.

>>
>>> Also failover etc. Preferred channel paths are not relevant
>>> on modern hardware anymore, fortunately (AFAIK).
>>>  
>>
>> If I understand you correctly it ain't possible to handle these
>> in the host (and let the guest a simple 'non-real' virtual
>> channel path whose reliability depends on what the host does),
>> or?
> 
> It is possible. Mapping to a virtual channel path or not is basically a
> design decision (IIRC, z/VM supports both).
> 
> Mapping everything to a virtual chpid basically concentrates all
> path-related handling in the hypervisor. This allows for a dumb guest
> OS, but can make errors really hard to debug from the guest side.
> 

IMHO the same is true for virtio for example (the abstraction
hides the backend and the backing: if there is a problem there it's
hard to debug from the guest side).

Because of my lack of understanding, this option appeared simpler to
me: clear ownership, and probably also less places where things can
go wrong.

> Exposing real channel paths to the guest means that the guest OS needs
> to be able to deal with path-related things, but OTOH it has more
> control. As I don't think we'll ever want to support a guest OS that
> does not also run under LPAR, I'd prefer that way.

Nod. And this makes a full circle, namely the question of benefit of
having more control. But since we did one full circle I'm much smarter
now than at the beginning.

Thank you very much for all the background information and for your
patience.

Regards,
Halil
