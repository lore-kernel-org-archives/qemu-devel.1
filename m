Received: from eggs.gnu.org ([2001:4830:134:3::10]:48085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dSoBI-0004Y6-6k
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dSoBF-00050v-0i
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:33:40 -0400
Received: from mail-eopbgr40130.outbound.protection.outlook.com
	([40.107.4.130]:45074
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dSoBE-00050I-4L
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:33:36 -0400
References: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1499263324-15184-4-git-send-email-anton.nefedov@virtuozzo.com>
	<8885ec44-52fc-6457-2d45-828e753aa9a0@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <04db742e-e15f-9743-caee-028b2f88aa0d@virtuozzo.com>
Date: Wed, 5 Jul 2017 20:33:28 +0300
MIME-Version: 1.0
In-Reply-To: <8885ec44-52fc-6457-2d45-828e753aa9a0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 03/13] char: chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, marcandre.lureau@redhat.com, amit@kernel.org, mst@redhat.com

On 07/05/2017 06:09 PM, Paolo Bonzini wrote:
> 
> 
> On 05/07/2017 16:01, Anton Nefedov wrote:
>> This patch adds a possibility to change a char device without a frontend
>> removal.
>>
>> 1. Ideally, it would have to happen transparently to a frontend, i.e.
>> frontend would continue its regular operation.
>> However, backends are not stateless and are set up by the frontends
>> via qemu_chr_fe_<> functions, and it's not (generally) possible to replay
>> that setup entirely in a backend code, as different chardevs respond
>> to the setup calls differently, so do frontends work differently basing
>> on those setup responses.
>> Moreover, some frontend can generally get and save the backend pointer
>> (qemu_chr_fe_get_driver()), and it will become invalid after backend change.
>>
>> So, a frontend which would like to support chardev hotswap has to register
>> a "backend change" handler, and redo its backend setup there.
>>
>> 2. Write path can be used by multiple threads and thus protected with
>> chr_write_lock.
>> So hotswap also has to be protected so write functions won't access
>> a backend being replaced.
> 
> Does this matter in practice?  CharBackend thread safety can be left to
> the front-end.
> 
> Paolo
> 

Hi Paolo,

So instead we'll need to use proper locks in each of the front-ends?
Or do you mean that it can be skipped for the most of them? I don't know
about all possible threading cases.
e.g. for serial/virtio-serial? Will they always share the same thread
with hmp/qmp driven chardev-change command? And won't yield and hotswap
in the middle of some write handler?

/Anton
