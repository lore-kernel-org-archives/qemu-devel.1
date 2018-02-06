Received: from eggs.gnu.org ([2001:4830:134:3::10]:44049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ej5Xw-0004Pz-Fl
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ej5Xr-0006D7-Rc
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:52:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ej5Xr-0006CL-M3
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:52:31 -0500
References: <1517486372-22868-1-git-send-email-arei.gonglei@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2815392f-407f-b9f2-24e7-4bbca477f40c@redhat.com>
Date: Tue, 6 Feb 2018 16:52:27 +0100
MIME-Version: 1.0
In-Reply-To: <1517486372-22868-1-git-send-email-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: fix possible int overflow for
 qemu_timedate_diff()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Cc: shenghualong <shenghualong@huawei.com>

On 01/02/2018 12:59, Gonglei wrote:
> From: shenghualong <shenghualong@huawei.com>
>=20
> When the Windows guest users set the time to year 2099,
> the return value of qemu_timedate_diff() will overflow
> with variable clock mode as below format:
>=20
>  <clock offset=3D'variable' adjustment=3D'-1201568405' basis=3D'utc'>
>=20
> Let's change the return value of qemu_timedate_diff() from
> int to time_t to fix the possible overflow problem.
>=20
> Signed-off-by: shenghualong <shenghualong@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>

Thanks, this makes sense.  However, looking at the users, you should
also change the type of:

- the diff variable in hw/timer/m48t59.c function set_alarm;

- the offset argument of the RTC_CHANGE QAPI event (to int64)

- the sec_offset and alm_sec fields of MenelausState in hw/timer/twl92230=
.c

- the offset argument of qemu_get_timedate.

Thanks,

Paolo

> ---
>  include/qemu-common.h | 2 +-
>  vl.c                  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 05319b9..6fb80aa 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -33,7 +33,7 @@ int qemu_main(int argc, char **argv, char **envp);
>  #endif
> =20
>  void qemu_get_timedate(struct tm *tm, int offset);
> -int qemu_timedate_diff(struct tm *tm);
> +time_t qemu_timedate_diff(struct tm *tm);
> =20
>  #define qemu_isalnum(c)		isalnum((unsigned char)(c))
>  #define qemu_isalpha(c)		isalpha((unsigned char)(c))
> diff --git a/vl.c b/vl.c
> index e517a8d..9d225da 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -146,7 +146,7 @@ int nb_nics;
>  NICInfo nd_table[MAX_NICS];
>  int autostart;
>  static int rtc_utc =3D 1;
> -static int rtc_date_offset =3D -1; /* -1 means no change */
> +static time_t rtc_date_offset =3D -1; /* -1 means no change */
>  QEMUClockType rtc_clock;
>  int vga_interface_type =3D VGA_NONE;
>  static int full_screen =3D 0;
> @@ -812,7 +812,7 @@ void qemu_get_timedate(struct tm *tm, int offset)
>      }
>  }
> =20
> -int qemu_timedate_diff(struct tm *tm)
> +time_t qemu_timedate_diff(struct tm *tm)
>  {
>      time_t seconds;
> =20
>=20
