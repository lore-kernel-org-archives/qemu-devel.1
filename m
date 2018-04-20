Received: from eggs.gnu.org ([2001:4830:134:3::10]:59583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9QNu-0005qU-LL
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9QNr-00040c-Bq
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:23:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f9QNr-00040E-7E
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:23:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180419212727.26095-1-f4bug@amsat.org>
	<20180419212727.26095-4-f4bug@amsat.org>
	<b79057ab-d36e-21f9-236c-33c45051b273@amsat.org>
Date: Fri, 20 Apr 2018 09:22:55 +0200
In-Reply-To: <b79057ab-d36e-21f9-236c-33c45051b273@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	19 Apr 2018 18:38:14 -0300")
Message-ID: <87bmee2vg0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qdev: Simplify the
 SysBusDeviceClass::init path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 04/19/2018 06:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> The SysBusDevice is the last DeviceClass::init user.
>>=20
>> Instead of using
>>   SysBusDeviceClass::realize
>>    -> DeviceClass::realize
>>        -> DeviceClass::init
>>            -> sysbus_device_init
>>               -> SysBusDeviceClass::init
>>=20
>> Simplify the path by directly calling SysBusDeviceClass::init
>> in SysBusDeviceClass::realize:
>>=20
>>   SysBusDeviceClass::realize
>>    -> SysBusDeviceClass::init
>>=20
>> Finally, remove the DeviceClass::init, there are no more users.
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  include/hw/qdev-core.h |  2 --
>>  hw/core/qdev.c         | 14 --------------
>>  hw/core/sysbus.c       | 15 ++++++++++-----
>>  3 files changed, 10 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index 9453588160..6f60748043 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -29,7 +29,6 @@ typedef enum DeviceCategory {
>>      DEVICE_CATEGORY_MAX
>>  } DeviceCategory;
>>=20=20
>> -typedef int (*qdev_initfn)(DeviceState *dev);
>>  typedef int (*qdev_event)(DeviceState *dev);
>>  typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
>>  typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
>> @@ -124,7 +123,6 @@ typedef struct DeviceClass {
>>      const struct VMStateDescription *vmsd;
>>=20=20
>>      /* Private to qdev / bus.  */
>> -    qdev_initfn init; /* TODO remove, once users are converted to reali=
ze */
>
> The DeviceClass documentation (top of this file) is now out of date :(
>
> If the maintainer taking this series prefer a respin, I plan to only
> remove the 'init' references in the big comment.

I'd move the actual removal into the next and final patch.  Lets us fix
up the comment in one go.

>>      qdev_event exit; /* TODO remove, once users are converted to unreal=
ize */
>>      const char *bus_type;
>>  } DeviceClass;
[...]
