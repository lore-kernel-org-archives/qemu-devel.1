Received: from eggs.gnu.org ([2001:4830:134:3::10]:35685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAB7T-0005w7-NY
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAB7Q-00013D-H0
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:49:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gAB7Q-00012d-9F
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:49:28 -0400
References: <20181003114454.5662-1-marcandre.lureau@redhat.com>
	<20181003114454.5662-4-marcandre.lureau@redhat.com>
	<9fa8a684-8d5d-1644-3aee-86a196d31f8d@redhat.com>
	<20181010094411.GA2411@work-vm>
From: David Hildenbrand <david@redhat.com>
Message-ID: <79e58e5c-4d78-e93d-ebe8-4b1bb65752fe@redhat.com>
Date: Wed, 10 Oct 2018 11:49:17 +0200
MIME-Version: 1.0
In-Reply-To: <20181010094411.GA2411@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] memory-mapping: skip non-volatile
 memory regions in GuestPhysBlockList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 10/10/2018 11:44, Dr. David Alan Gilbert wrote:
> * Laszlo Ersek (lersek@redhat.com) wrote:
>> On 10/03/18 13:44, Marc-Andr=C3=A9 Lureau wrote:
>>> GuestPhysBlockList is currently used to produce dumps. Given the size
>>> and the typical usage of NVDIMM for storage, they are not a good idea
>>> to have in the dumps. We may want to have an extra dump option to
>>> include them. For now, skip non-volatile regions.
>>>
>>> The TCG memory clear function is going to use the GuestPhysBlockList
>>> as well, and will thus skip NVDIMM for similar reasons.
>>>
>>> Cc: lersek@redhat.com
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  memory_mapping.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/memory_mapping.c b/memory_mapping.c
>>> index 775466f3a8..724dd0b417 100644
>>> --- a/memory_mapping.c
>>> +++ b/memory_mapping.c
>>> @@ -206,7 +206,8 @@ static void guest_phys_blocks_region_add(MemoryLi=
stener *listener,
>>> =20
>>>      /* we only care about RAM */
>>>      if (!memory_region_is_ram(section->mr) ||
>>> -        memory_region_is_ram_device(section->mr)) {
>>> +        memory_region_is_ram_device(section->mr) ||
>>> +        memory_region_is_nonvolatile(section->mr)) {
>>>          return;
>>>      }
>>> =20
>>>
>>
>> I've peeked at the first two patches as well. Seems OK to me. (Famous
>> last words?)
>>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>=20
> This also looks good to me; just cc'ing in David H as well though.
>=20

Thanks Dave. Yes, just like the guest will exclude NVDIMMs from dumps,
so should we. (if somebody ever want to have this e.g. because the
NVDIMM is based on RAM in the host, we can introduce what you describe -
extra dump option).

Reviewed-by: David Hildenbrand <david@redhat.com>


--=20

Thanks,

David / dhildenb
