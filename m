Received: from eggs.gnu.org ([2001:4830:134:3::10]:57309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cxzo0-00016Q-D5
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cxznv-0005Iw-Ha
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:42:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cxznv-0005Hx-B2
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:42:11 -0400
References: <20170411131733.27542-1-lvivier@redhat.com>
	<20170411131733.27542-3-lvivier@redhat.com>
	<20170411170250.GF5940@stefanha-x1.localdomain>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <560dec08-1b57-9850-ff30-5f326130a59d@redhat.com>
Date: Tue, 11 Apr 2017 19:42:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170411170250.GF5940@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-rng: stop virtqueue while the
 CPU is stopped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org

On 11/04/2017 19:02, Stefan Hajnoczi wrote:
> On Tue, Apr 11, 2017 at 03:17:33PM +0200, Laurent Vivier wrote:
>> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
>> index 9639f4e..d270d56 100644
>> --- a/hw/virtio/virtio-rng.c
>> +++ b/hw/virtio/virtio-rng.c
>> @@ -53,6 +53,15 @@ static void chr_read(void *opaque, const void *buf, size_t size)
>>          return;
>>      }
>>  
>> +    /* we can't modify the virtqueue until
>> +     * our state is fully synced
>> +     */
>> +
>> +    if (!runstate_check(RUN_STATE_RUNNING)) {
>> +        trace_virtio_rng_cpu_is_stopped(vrng);
>> +        return;
>> +    }
>> +
> 
> I'm concerned about what happens when the guest is stopped and resumed
> (e.g. 'stop' and 'cont' monitor commands).  Since we throw away the
> chr_read() callback the device will hang unless the guest kicks it
> again?
> 
> It's not clear to me that the rate limit timer will help us...

I think you're right (even if it seems hard to generate this case)

What is the best solution:

- re-arming the timer/the backend request by calling
virtio_rng_process() before the "return;"

or

- adding a vmstate change handler to call virtio_rng_process()?

Thanks,
Laurent
