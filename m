Received: from eggs.gnu.org ([2001:4830:134:3::10]:55837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnhyU-0007aj-2b
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnhyO-00053Z-PK
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:10:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnhyO-00052K-Ib
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:10:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1504190408-11143-1-git-send-email-thuth@redhat.com>
	<612870af-f8a4-039c-3e97-7590388b9e77@redhat.com>
Date: Fri, 01 Sep 2017 11:10:35 +0200
In-Reply-To: <612870af-f8a4-039c-3e97-7590388b9e77@redhat.com> (David
	Hildenbrand's message of "Thu, 31 Aug 2017 17:36:45 +0200")
Message-ID: <87o9qudbsk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] tests: Enable the drive_del test also
 on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michael S Tsirkin <mst@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

>>  static void test_drive_del_device_del(void)
>>  {
>> +    char *args;
>> +
>>      /* Start with a drive used by a device that unplugs instantaneously */
>> -    qtest_start("-drive if=none,id=drive0,file=null-co://,format=raw"
>> -                " -device virtio-scsi-pci"
>> -                " -device scsi-hd,drive=drive0,id=dev0");
>> +    args = g_strdup_printf("-drive if=none,id=drive0,file=null-co://,format=raw"
>> +                           " -device virtio-scsi-%s"
>> +                           " -device scsi-hd,drive=drive0,id=dev0",
>
> Would look better with the spaces at the end of the previous line (so
> all "-device" are aligned), but just my taste.

The -device *are* aligned, but I get what you mean.

The advantage of leading rather than trailing space is that the
intention "this is still the same string" is locally obvious both at the
first part's end (no comma) and at the second part's beginning (leading
space).

>> +                           qvirtio_get_dev_type());
>> +    qtest_start(args);
>>  
>>      /*
>>       * Delete the drive, and then the device
[...]
