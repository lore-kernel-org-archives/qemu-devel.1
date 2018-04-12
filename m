Received: from eggs.gnu.org ([2001:4830:134:3::10]:45251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6hPa-0007wS-3E
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6hPV-0004Z2-8c
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:57:34 -0400
References: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
	<1523372486-13190-3-git-send-email-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <107962d1-87b5-2574-92a3-a6625757f9e7@redhat.com>
Date: Thu, 12 Apr 2018 20:57:25 +0200
MIME-Version: 1.0
In-Reply-To: <1523372486-13190-3-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] pc-bios/s390-ccw: fix loadparm
 initialization and int conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com
Cc: gor@linux.ibm.com, frankja@linux.ibm.com

On 10.04.2018 17:01, Collin Walling wrote:
> Rename the loadparm char array in main.c to loadparm_str and
> increase the size by one byte to account for a null termination
> when converting the loadparm string to an int via atoui. Also=20
> allow the boot menu to be enabled when loadparm is set to an=20
> empty string or a series of spaces.
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
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
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 9d9f8cf..26f9adf 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -15,11 +15,11 @@
>  char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>  static SubChannelId blk_schid =3D { .one =3D 1 };
>  IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
> -static char loadparm[8] =3D { 0, 0, 0, 0, 0, 0, 0, 0 };
> +static char loadparm_str[9] =3D { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>  QemuIplParameters qipl;
> =20
>  #define LOADPARM_PROMPT "PROMPT  "
> -#define LOADPARM_EMPTY  "........"
> +#define LOADPARM_EMPTY  "        "

Sorry for my ignorance, but why was the old string containing dots?

 Thomas
