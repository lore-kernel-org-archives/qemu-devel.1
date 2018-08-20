Received: from eggs.gnu.org ([2001:4830:134:3::10]:58183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1frkJm-0002wr-Rt
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1frkJk-0001rk-Vf
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:34:02 -0400
References: <20180818025600.21132-1-f4bug@amsat.org>
	<5123af35-773e-cf2a-2e41-2198e0af7c61@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <422f8f12-b6fe-3e25-6fb0-ac5ba680b80f@redhat.com>
Date: Mon, 20 Aug 2018 15:33:41 +0200
MIME-Version: 1.0
In-Reply-To: <5123af35-773e-cf2a-2e41-2198e0af7c61@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sheepdog: Replace strncpy() by g_strlcpy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Howard Spoelstra <hsp.cat7@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>, "open list:Sheepdog" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Liu Yuan <namei.unix@gmail.com>, Max Reitz <mreitz@redhat.com>

On 20.08.2018 15:28, Paolo Bonzini wrote:
> On 18/08/2018 04:56, Philippe Mathieu-Daud=C3=A9 wrote:
>> Fedora 29 comes with GCC 8.1 which added the 'stringop-truncation' che=
cks.
>>
>> Replace the strncpy() calls by g_strlcpy() to avoid the following warn=
ing:
>>
>>   block/sheepdog.c: In function 'find_vdi_name':
>>   block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals
>>   destination size [-Werror=3Dstringop-truncation]
>>        strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> See http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03723.h=
tml
>>
>>  block/sheepdog.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/sheepdog.c b/block/sheepdog.c
>> index b229a664d9..5dc3d0c39e 100644
>> --- a/block/sheepdog.c
>> +++ b/block/sheepdog.c
>> @@ -1224,19 +1224,19 @@ static int find_vdi_name(BDRVSheepdogState *s,=
 const char *filename,
>>      SheepdogVdiReq hdr;
>>      SheepdogVdiRsp *rsp =3D (SheepdogVdiRsp *)&hdr;
>>      unsigned int wlen, rlen =3D 0;
>> -    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
>> +    /* Ensures that the buffer is zero-filled,
>> +     * which is desirable since we'll soon be sending those bytes, an=
d
>> +     * don't want the send_req to read uninitialized data.
>> +     */
>> +    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN] =3D { };
>> =20
>>      fd =3D connect_to_sdog(s, errp);
>>      if (fd < 0) {
>>          return fd;
>>      }
>> =20
>> -    /* This pair of strncpy calls ensures that the buffer is zero-fil=
led,
>> -     * which is desirable since we'll soon be sending those bytes, an=
d
>> -     * don't want the send_req to read uninitialized data.
>> -     */
>> -    strncpy(buf, filename, SD_MAX_VDI_LEN);
>> -    strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>> +    g_strlcpy(buf, filename, SD_MAX_VDI_LEN);
>> +    g_strlcpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>> =20
>>      memset(&hdr, 0, sizeof(hdr));
>>      if (lock) {
>>
>=20
> The protocol doesn't require (as far as I can see) the strings to be
> NULL-terminated, therefore strncpy is the right function to use here.
>=20
> However, we should have a check on the length of filename and tag, so
> that no truncation is done.  This applies to both strncpy and g_strlcpy=
.
>=20
> Indeed I find g_strlcpy to be harmful because it encourages a style
> where truncations happen silently.  There are very few cases where
> silent truncation is the right thing to do, and in several cases where
> you _have to have_ fixed-size buffers, those buffers are sent on the
> wire---and then g_strlcpy is wrong, while strncpy is just as good as
> memset+strlen+memcpy (and shorter).

Yes, convinced, let's disable the warning.

>=20
> Paolo
>=20


--=20

Thanks,

David / dhildenb
