Received: from eggs.gnu.org ([2001:4830:134:3::10]:41397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT6RN-0001Ov-MS
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT6RK-0001rm-V2
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:08:01 -0400
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-8-david@redhat.com>
	<20180613150320.3d6d11ca@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <430ef63d-0e9b-5925-5d5a-b6804ec7d988@redhat.com>
Date: Wed, 13 Jun 2018 16:07:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180613150320.3d6d11ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/11] pc-dimm: get_memory_region() can
 never fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 13.06.2018 15:03, Igor Mammedov wrote:
> On Mon, 11 Jun 2018 14:16:51 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> We already verify when realizing that the memdev property has been
>> set. We have no more accesses to get_memory_region() before the device
>> is realized.
> this stems from assumption that get_memory_region shouldn't be called
> before devices realize is executed, which I don't agree to begin with.
> 
> However wrt error handling, we should probably leave device internal error
> up to devices and make check for error only in pre_plug handler
> (since pre_plug was successful, the rest machine helpers would have
> access to the same region until device is removed.
> 

Something like a generic Device "validate()"/"pre_realize()" function,
that can be called before realize() and validates all properties
(+initializes derived properties) would be something I could agree to.

Then we could drop all error handling from access functions (as they
have been validated early during pre_plug())

Moving all checks out of realize into pre_plug() looks ugly, because we
have implementation details split across c-files.

> 
>> So this function will never fail. Remove the stale check and the
>> error variable. Add a comment to the functions stating that they should
>> never be called on uninitialized devices.
>>


-- 

Thanks,

David / dhildenb
