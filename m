Received: from eggs.gnu.org ([2001:4830:134:3::10]:46782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgI8A-0006wC-8w
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgI85-0001eW-Bo
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:37:54 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgI85-0001dK-7i
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:37:49 -0500
Received: by mail-qk0-x242.google.com with SMTP id r90so1480961qki.3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 13:37:49 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170221190955.8616.21658.stgit@gimli.home>
	<0ec79096-c8b8-9565-9073-0b6e0a9e57f1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <49fb535b-7223-6ccf-d4ae-905d72e19133@amsat.org>
Date: Tue, 21 Feb 2017 18:37:45 -0300
MIME-Version: 1.0
In-Reply-To: <0ec79096-c8b8-9565-9073-0b6e0a9e57f1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vfio/pci: Report errors from qdev_unplug()
 via device request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org

On 02/21/2017 06:28 PM, Auger Eric wrote:
> Hi Alex,
>
> On 21/02/2017 20:10, Alex Williamson wrote:
>> Currently we ignore this error, report it with error_reportf_err()
>>
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> Eric

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
>> ---
>>  hw/vfio/pci.c |    6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 332f41d6627f..f2ba9b6cfafc 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2506,12 +2506,16 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
>>  static void vfio_req_notifier_handler(void *opaque)
>>  {
>>      VFIOPCIDevice *vdev = opaque;
>> +    Error *err = NULL;
>>
>>      if (!event_notifier_test_and_clear(&vdev->req_notifier)) {
>>          return;
>>      }
>>
>> -    qdev_unplug(&vdev->pdev.qdev, NULL);
>> +    qdev_unplug(&vdev->pdev.qdev, &err);
>> +    if (err) {
>> +        error_reportf_err(err, WARN_PREFIX, vdev->vbasedev.name);
>> +    }
>>  }
>>
>>  static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>>
>
