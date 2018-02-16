Received: from eggs.gnu.org ([2001:4830:134:3::10]:46593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emk0O-0003z2-0f
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emk0I-00060k-MC
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:41:04 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:41475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emk0I-00060c-H5
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:40:58 -0500
Received: by mail-qt0-x241.google.com with SMTP id a9so4716967qtj.8
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 09:40:58 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180216134516.6269-1-peter.maydell@linaro.org>
	<20180216134516.6269-2-peter.maydell@linaro.org>
	<20180216172841.2ec69b8a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <98a92185-d5e0-48fd-79a7-1c77260c9aca@amsat.org>
Date: Fri, 16 Feb 2018 14:40:54 -0300
MIME-Version: 1.0
In-Reply-To: <20180216172841.2ec69b8a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/sysbus.h: New sysbus_init_child()
 helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, patches@linaro.org

On 02/16/2018 01:28 PM, Igor Mammedov wrote:
> On Fri, 16 Feb 2018 13:45:15 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
...
>>  static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent);
>>  static char *sysbus_get_fw_dev_path(DeviceState *dev);
>> @@ -372,6 +373,19 @@ BusState *sysbus_get_default(void)
>>      return main_system_bus;
>>  }
>>  
>> +void sysbus_init_child(Object *parent, const char *childname,
>> +                       void *child, size_t childsize,
>> +                       const char *childtype)
>> +{
> 
> 
>> +    object_initialize(child, childsize, childtype);
>> +    /* error_abort is fine here because this can only fail for
>> +     * programming-error reasons: child already parented, or
>> +     * parent already has a child with the given name.
>> +     */
>> +    object_property_add_child(parent, childname, OBJECT(child), &error_abort);
> It would be useful not only for sysbus devices.
> maybe we should extend object_initialize instead,
> something like this:
>    void object_initialize(void *data, size_t size, const char *typename,
>                           Object *parent, const char *name)
> and set parent in it.
> git counts about 152 uses, so it would be tree wide change
> but still not too much.

we can keep object_initialize() when no parent,
and add object_initialize_child(, const char *childname, Object *parent)
'parent' last because all previous args are child-related.

> 
> 
>> +    qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
> and then assuming we don't create sysbus devices, nor should be able to,
> which are not attached to sysbus_get_default() this one can go sysbus' instance_init()

good idea.

> 
> then there won't be need for sysbus specific helper,
> inheritance will do the rest of the job.
> 
>> +}
>> +
