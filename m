Received: from eggs.gnu.org ([2001:4830:134:3::10]:58884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhxOd-0004m5-L8
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhxOZ-0005u4-Kn
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:30:35 -0400
References: <1532421839-24512-1-git-send-email-thuth@redhat.com>
	<20180724151732.608d7183.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <378ab377-3ee8-18e7-c933-fd331250e35d@redhat.com>
Date: Tue, 24 Jul 2018 15:30:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180724151732.608d7183.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC PATCH v2] hw/s390x/virtio-ccw:
 Consolidate calls to virtio_ccw_unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 24.07.2018 15:17, Cornelia Huck wrote:
> On Tue, 24 Jul 2018 10:43:59 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> Currently, every virtio-ccw device explicitely sets its unrealize
>> function to virtio_ccw_unrealize() in its class_init function.
>> We can simplify this by using a common unrealize function, just like
>> it is already done for the realize functions.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/s390x/virtio-ccw.c | 22 +++++++---------------
>>  1 file changed, 7 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index 7ddb378..f3ad7aa 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -750,8 +750,9 @@ out_err:
>>      g_free(sch);
>>  }
>>  
>> -static void virtio_ccw_unrealize(VirtioCcwDevice *dev, Error **errp)
>> +static void virtio_ccw_device_unrealize(VirtioCcwDevice *dev, Error **errp)
>>  {
>> +    VirtIOCCWDeviceClass *dc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>>      CcwDevice *ccw_dev = CCW_DEVICE(dev);
>>      SubchDev *sch = ccw_dev->sch;
>>  
>> @@ -764,6 +765,10 @@ static void virtio_ccw_unrealize(VirtioCcwDevice *dev, Error **errp)
>>          release_indicator(&dev->routes.adapter, dev->indicators);
>>          dev->indicators = NULL;
>>      }
>> +
>> +    if (dc->unrealize) {
>> +        dc->unrealize(dev, errp);
>> +    }
>>  }
>>  
> 
> Hm... if any device type should have the need to do something in the
> unrealize path, it would probably want to do it before the common
> unrealize handling, I think. For example, it might want a valid sch.

Sure, I can move it!

 Thomas
