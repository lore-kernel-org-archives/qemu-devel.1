Received: from eggs.gnu.org ([209.51.188.92]:49773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5mu-0003Ue-Ef
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5mt-0004GP-G7
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hE5mt-0004G8-7W
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:28:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190409174018.25798-1-armbru@redhat.com>
	<f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
Date: Wed, 10 Apr 2019 07:28:36 +0200
In-Reply-To: <f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 9 Apr 2019 20:59:55
	+0200")
Message-ID: <874l764eez.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair.francis@wdc.com, slp@redhat.com, david@gibson.dropbear.id.au

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/9/19 7:40 PM, Markus Armbruster wrote:
>> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
>> computation of @dt_size overflows to a negative number, which then
>> gets converted to a very large size_t for g_malloc0() and
>> load_image_size().  In the (fortunately improbable) case g_malloc0()
>> succeeds and load_image_size() survives, we'd assign the negative
>> number to *sizep.  What that would do to the callers I can't say, but
>> it's unlikely to be good.
>>=20
>> Fix by rejecting images whose size would overflow.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  device_tree.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/device_tree.c b/device_tree.c
>> index 296278e12a..f8b46b3c73 100644
>> --- a/device_tree.c
>> +++ b/device_tree.c
>> @@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, int=
 *sizep)
>>                       filename_path);
>>          goto fail;
>>      }
>> +    if (dt_size > INT_MAX / 2 - 10000) {
>
> We should avoid magic number duplication.
> That said, this patch looks safe.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

> BTW how did you figure that out?

Downstream handling of upstream commit da885fe1ee8 led me to the
function.  I spotted dt_size =3D get_image_size(filename_path).
Experience has taught me to check the left hand side's type.  Bad.  Then
I saw how dt_size gets increased.  Worse.

>> +        error_report("Device tree file '%s' is too large", filename_pat=
h);
>> +        goto fail;
>> +    }
>>=20=20
>>      /* Expand to 2x size to give enough room for manipulation.  */
>>      dt_size +=3D 10000;
>>=20
