Received: from eggs.gnu.org ([2001:4830:134:3::10]:51919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1df1ya-0005zn-AZ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1df1yX-0003rc-8O
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:43:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1df1yW-0003rF-Vk
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:43:01 -0400
References: <20170804112946.5247-1-cohuck@redhat.com>
	<20170804165934.4d6fb98f@gondolin> <20170808111542.16422571@gondolin>
	<798f1bb6-f21d-305c-5bcc-c7f828f284e1@redhat.com>
	<20170808114652.29e354ed@gondolin>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ee17aafb-bc3c-6b4f-2c3b-e70ccaf94454@redhat.com>
Date: Tue, 8 Aug 2017 12:42:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170808114652.29e354ed@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/9] s390x: zPCI detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On 08.08.2017 11:46, Cornelia Huck wrote:
> On Tue, 8 Aug 2017 11:29:50 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 08.08.2017 11:15, Cornelia Huck wrote:
>>> On Fri, 4 Aug 2017 16:59:34 +0200
>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>   
>>>> On Fri,  4 Aug 2017 13:29:37 +0200
>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>  
>>>>> Next version, not so many changes from v3.
>>>>>
>>>>> As you might have guessed, the goals are still the same:
>>>>> - Being able to disable PCI support in a build completely.
>>>>> - Properly fencing off PCI if the relevant facility bit is not provided.
>>>>>
>>>>> Changes v3->v4:
>>>>> - introduce pci_available boolean
>>>>> - use pci_available to fence off setting the zcpi facility bit
>>>>> - collected tags
>>>>>
>>>>> Branch is still git://github.com/cohuck/qemu no-zpci-cpumodel    
>>>>
>>>> make check on a build with pci disabled revealed an interesting
>>>> inconsistency: We create a virtio-9p-ccw device, but the base
>>>> virtio-9p-device is in code that is not built for !pci.
>>>>
>>>> If I remove the pci dependency for hw/9pfs/ and fsdev/, things look
>>>> fine (at least on s390x). We probably need a different dependency,
>>>> though.
>>>>
>>>> virtio-9p maintainers, any suggestions?  
>>>
>>> I have the patch below, which is ugly, but seems to work for me. Better
>>> ideas welcome :)  
>>
>> I haven't tried whether it works, but you could maybe change the define
>> of CONFIG_VIRTFS instead:
>>
>> diff --git a/configure b/configure
>> index dd73cce..64d21f6 100755
>> --- a/configure
>> +++ b/configure
>> @@ -5771,7 +5771,7 @@ if test "$libattr" = "yes" ; then
>>    echo "CONFIG_LIBATTR=y" >> $config_host_mak
>>  fi
>>  if test "$virtfs" = "yes" ; then
>> -  echo "CONFIG_VIRTFS=y" >> $config_host_mak
>> +  echo 'CONFIG_VIRTFS=$(call lor, $(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW)' >> $config_host_mak
>>  fi
>>  if test "$vhost_scsi" = "yes" ; then
>>    echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
>>
>> ... I think that should simplify the other statements quite a bit since
>> you then only have to test CONFIG_VIRTFS in the other locations?
>>
>>  Thomas
> 
> Would be a simplification if it worked, yes; not sure whether we should
> change the semantic of --enable-virtfs to error out if we don't have
> either virtio-pci or virtio-ccw?

I don't think that this would work: configure is run once for all
targets, but the CONFIG_PCI and CONFIG_CCW settings are only valid for
individual targets, so you can not use the value of these config
variables during "configure" yet.

 Thomas
