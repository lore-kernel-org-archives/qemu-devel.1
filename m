Received: from eggs.gnu.org ([2001:4830:134:3::10]:40542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAeUE-0008SM-IE
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAeUD-0008LY-DH
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:34:10 -0400
Date: Tue, 16 May 2017 17:33:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170516153354.GG4438@noname.redhat.com>
References: <20170515203114.9477-1-hpoussin@reactos.org>
	<20170515203114.9477-9-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170515203114.9477-9-hpoussin@reactos.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/13] vvfat: correctly create long names
 for non-ASCII filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 15.05.2017 um 22:31 hat Herv=E9 Poussineau geschrieben:
> Assume that input filename is encoded as UTF-8, so correctly create UTF=
-16 encoding.
> Reuse long_file_name structure to give back to caller the generated lon=
g name.
> It will be used in next commit to transform the long file name into sho=
rt file name.
>=20
> Reference: http://stackoverflow.com/questions/7153935/how-to-convert-ut=
f-8-stdstring-to-utf-16-stdwstring
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> ---
>  block/vvfat.c | 132 ++++++++++++++++++++++++++++++++++++++++++--------=
--------
>  1 file changed, 97 insertions(+), 35 deletions(-)
>=20
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 7da07068b8..5f6356c834 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -357,6 +357,23 @@ typedef struct BDRVVVFATState {
>      Error *migration_blocker;
>  } BDRVVVFATState;
> =20
> +typedef struct {
> +    /*
> +     * Since the sequence number is at most 0x3f, and the filename
> +     * length is at most 13 times the sequence number, the maximal
> +     * filename length is 0x3f * 13 bytes.
> +     */
> +    unsigned char name[0x3f * 13 + 1];
> +    int checksum, len;
> +    int sequence_number;
> +} long_file_name;
> +
> +static void lfn_init(long_file_name *lfn)
> +{
> +   lfn->sequence_number =3D lfn->len =3D 0;
> +   lfn->checksum =3D 0x100;
> +}
> +
>  /* take the sector position spos and convert it to Cylinder/Head/Secto=
r position
>   * if the position is outside the specified geometry, fill maximum val=
ue for CHS
>   * and return 1 to signal overflow.
> @@ -418,29 +435,90 @@ static void init_mbr(BDRVVVFATState *s, int cyls,=
 int heads, int secs)
> =20
>  /* direntry functions */
> =20
> -/* dest is assumed to hold 258 bytes, and pads with 0xffff up to next =
multiple of 26 */
> -static inline int short2long_name(char* dest,const char* src)
> -{
> -    int i;
> -    int len;
> -    for(i=3D0;i<129 && src[i];i++) {
> -        dest[2*i]=3Dsrc[i];
> -        dest[2*i+1]=3D0;
> +/* fills lfn with UTF-16 representation of src filename */
> +/* return true if src is valid UTF-8 string, false otherwise */
> +static bool filename2long_name(long_file_name *lfn, const char* src)
> +{
> +    uint8_t *dest =3D lfn->name;
> +    int i =3D 0, j;
> +    int len =3D 0;
> +    while (src[i]) {
> +        uint32_t uni =3D 0;
> +        size_t todo;
> +        uint8_t ch =3D src[i++];
> +        if (ch <=3D 0x7f) {
> +            uni =3D ch;
> +            todo =3D 0;
> +        } else if (ch <=3D 0xbf) {
> +            return false;
> +        } else if (ch <=3D 0xdf) {
> +            uni =3D ch & 0x1f;
> +            todo =3D 1;
> +        } else if (ch <=3D 0xef) {
> +            uni =3D ch & 0x0f;
> +            todo =3D 2;
> +        } else if (ch <=3D 0xf7) {
> +            uni =3D ch & 0x07;
> +            todo =3D 3;
> +        } else {
> +            return false;
> +        }
> +        for (j =3D 0; j < todo; j++) {
> +            uint8_t ch;
> +            if (src[i] =3D=3D '\0') {
> +                return false;
> +            }
> +            ch =3D src[i++];
> +            if (ch < 0x80 || ch >=3D 0xbf) {
> +                return false;
> +            }
> +            uni <<=3D 6;
> +            uni +=3D ch & 0x3f;
> +        }

I'm not sure if we really want to add an ad-hoc UTF-8 parser here...
Shouldn't we be using something like g_utf8_get_char() instead?

> +        if (uni >=3D 0xd800 && uni <=3D 0xdfff) {
> +            return false;
> +        } else if (uni >=3D 0x10ffff) {
> +            return false;
> +        }
> +        if (uni <=3D 0xffff) {
> +            dest[len++] =3D uni & 0xff;
> +            dest[len++] =3D uni >> 8;
> +        } else {
> +            uint16_t w;
> +            uni -=3D 0x10000;
> +            w =3D (uni >> 10) + 0xd800;
> +            dest[len++] =3D w & 0xff;
> +            dest[len++] =3D w >> 8;
> +            w =3D (uni & 0x3ff) + 0xdc00;
> +            dest[len++] =3D w & 0xff;
> +            dest[len++] =3D w >> 8;
> +        }

Who guarantees that src was short enough that we don't overrun the
buffer in lfn->name?

> +    }
> +    dest[len++] =3D 0;
> +    dest[len++] =3D 0;
> +    while (len % 26 !=3D 0) {
> +        dest[len++] =3D 0xff;
>      }
> -    len=3D2*i;
> -    dest[2*i]=3Ddest[2*i+1]=3D0;
> -    for(i=3D2*i+2;(i%26);i++)
> -        dest[i]=3D0xff;
> -    return len;
> +    lfn->len =3D len;
> +    return true;
>  }

Kevin
