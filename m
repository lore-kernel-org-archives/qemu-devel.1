Received: from eggs.gnu.org ([2001:4830:134:3::10]:43017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f83Em-0003O7-5h
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f83Eh-00027r-5T
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:28:00 -0400
References: <1523657288-6587-1-git-send-email-walling@linux.ibm.com>
	<1523657288-6587-3-git-send-email-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <97821ab2-60aa-2760-313c-1130115f5884@redhat.com>
Date: Mon, 16 Apr 2018 14:27:40 +0200
MIME-Version: 1.0
In-Reply-To: <1523657288-6587-3-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 2/4] pc-bios/s390-ccw: fix
 loadparm initialization and int conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com
Cc: frankja@linux.ibm.com, gor@linux.ibm.com

On 14.04.2018 00:08, Collin Walling wrote:
> Rename the loadparm char array in main.c to loadparm_str and
> increased the size by one byte to account for a null termination
> when converting the loadparm string to an int  via atoui. We
> also allow the boot menu to be enabled when loadparm is set to
> an empty string or a series of spaces.
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c          |  2 ++
>  pc-bios/s390-ccw/main.c | 14 +++++++-------
>  2 files changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index fdeaec3..23b5b54 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -352,6 +352,8 @@ int s390_ipl_set_loadparm(uint8_t *loadparm)
>              loadparm[i] =3D ascii2ebcdic[(uint8_t) lp[i]];
>          }
> =20
> +        memset(loadparm + i, 0x40, 8 - i); /* fill with EBCDIC spaces =
*/
> +
>          g_free(lp);
>          return 0;
>      }

When compiling this code, my GCC (v4.8.5) complains:

  CC      s390x-softmmu/hw/s390x/ipl.o
In file included from /usr/include/string.h:638:0,
                 from /home/thuth/devel/qemu/include/qemu/osdep.h:69,
                 from /home/thuth/devel/qemu/hw/s390x/ipl.c:14:
In function =E2=80=98memset=E2=80=99,
    inlined from =E2=80=98s390_ipl_set_loadparm=E2=80=99 at
/home/thuth/devel/qemu/hw/s390x/ipl.c:376:15:
/usr/include/bits/string3.h:81:30: error: call to
=E2=80=98__warn_memset_zero_len=E2=80=99 declared with attribute warning:=
 memset used
with constant zero length parameter; this could be due to transposed
parameters [-Werror]
       __warn_memset_zero_len ();

I guess this might happen due to some internal loop unrolling of GCC or
something similar ... to make sure that we can compile the code also
without warnings, could you please add a check around the memset =C3=A0 l=
a:

    if (i < 8) {
        memset(loadparm + i, 0x40, 8 - i); /* fill with EBCDIC spaces */
    }

 Thanks,
  Thomas
