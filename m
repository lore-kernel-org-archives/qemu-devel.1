Received: from eggs.gnu.org ([2001:4830:134:3::10]:56258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHsXS-0001XH-IJ
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHsXP-0000vk-Dl
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHsXP-0000v2-3J
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:36:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1540357921-4199-1-git-send-email-liq3ea@gmail.com>
	<9943c62b-3d87-3359-a17f-d975ae228c0c@redhat.com>
Date: Wed, 31 Oct 2018 16:36:00 +0100
In-Reply-To: <9943c62b-3d87-3359-a17f-d975ae228c0c@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	25 Oct 2018 01:00:09 +0200")
Message-ID: <874ld2qgbj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: print error message when reading
 splashfile failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, lersek@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 24/10/18 7:12, Li Qiang wrote:
>> Also remove unnecessary 'res' variable.
>>
>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>> ---
>>   hw/nvram/fw_cfg.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 946f765..f4a52d8 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -68,15 +68,14 @@ static char *read_splashfile(char *filename, gsize *=
file_sizep,
>>                                int *file_typep)
>>   {
>>       GError *err =3D NULL;
>> -    gboolean res;
>>       gchar *content;
>>       int file_type;
>>       unsigned int filehead;
>>       int bmp_bpp;
>>   -    res =3D g_file_get_contents(filename, &content, file_sizep,
>> &err);
>> -    if (res =3D=3D FALSE) {
>> -        error_report("failed to read splash file '%s'", filename);
>> +    if (!g_file_get_contents(filename, &content, file_sizep, &err)) {
>> +        error_report("failed to read splash file '%s', %s",
>
> Can you use a column like the rest of the codebase?
>
> i.e.: "failed to read splash file '%s': %s"

Yes, please.

Also, my remark on your "[PATCH] vl.c: print error message if loading
fw_cfg file failed" applies to this patch as well.  Please improve the
commit message.

> The maintainer taking this patch can do this minor change, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>> +                     filename, err->message);
>>           g_error_free(err);
>>           return NULL;
>>       }
>>
