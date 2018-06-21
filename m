Received: from eggs.gnu.org ([2001:4830:134:3::10]:34563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVxXZ-0001rm-9F
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVxXU-0001lk-96
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:14:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180607144645.10187-1-f4bug@amsat.org>
	<20180607144645.10187-4-f4bug@amsat.org>
	<877en9bxoc.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8b533a03-0adf-a15c-a6e8-6e7641a9e3ac@amsat.org>
Date: Thu, 21 Jun 2018 08:14:03 -0300
MIME-Version: 1.0
In-Reply-To: <877en9bxoc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hw/arm/sysbus-fdt: Replace
 error_setg(&error_fatal) by error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Markus,

On 06/08/2018 03:27 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Use error_report() + exit() instead of error_setg(&error_fatal),
>> as suggested by the "qapi/error.h" documentation:
>>
>>    Please don't error_setg(&error_fatal, ...), use error_report() and
>>    exit(), because that's more obvious.
>>
>> This fixes CID 1352173:
>>     "Passing null pointer dt_name to qemu_fdt_node_path, which dereferences it."
>>
>> And this also fixes:
>>
>>     hw/arm/sysbus-fdt.c:322:9: warning: Array access (from variable 'node_path') results in a null pointer dereference
>>         if (node_path[1]) {
>>             ^~~~~~~~~~~~
>>
>> Fixes: Coverity CID 1352173 (Dereference after null check)
> 
> You lost
> 
>   Suggested-by: Eric Blake <eblake@redhat.com>
> 
> Intentional?

Not at all :/

> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/arm/sysbus-fdt.c | 42 +++++++++++++++++++++++-------------------
>>  1 file changed, 23 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
>> index e4c492ea44..8e2784fa11 100644
>> --- a/hw/arm/sysbus-fdt.c
>> +++ b/hw/arm/sysbus-fdt.c
>> @@ -91,7 +91,7 @@ static void copy_properties_from_host(HostProperty *props, int nb_props,
>>          r = qemu_fdt_getprop(host_fdt, node_path,
>>                               props[i].name,
>>                               &prop_len,
>> -                             props[i].optional ? &err : &error_fatal);
>> +                             &err);
>>          if (r) {
>>              qemu_fdt_setprop(guest_fdt, nodename,
>>                               props[i].name, r, prop_len);
>> @@ -102,6 +102,7 @@ static void copy_properties_from_host(HostProperty *props, int nb_props,
>>              } else {
>>                  error_free(err);
>>              }
>> +            assert(props[i].optional); /* mandatory property not found */
>>          }
>>      }
>>  }
> 
> This is not the conversion the commit message promised: it replaces
> exit(1) by abort().  Why?

I can't understand it either, I suppose I cherry-picked from an
incorrect branch, because I also added your R-b locally.

I'll resend.

Thanks,

Phil.
