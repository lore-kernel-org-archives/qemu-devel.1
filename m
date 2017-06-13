Received: from eggs.gnu.org ([2001:4830:134:3::10]:41733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dKjDK-0001Ay-EJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dKjDJ-0002WY-GD
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:38:22 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:32794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dKjDJ-0002WN-87
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:38:21 -0400
Received: by mail-lf0-x243.google.com with SMTP id u62so12017528lfg.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 03:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <1497349303-3076-1-git-send-email-li.ping288@zte.com.cn>
In-Reply-To: <1497349303-3076-1-git-send-email-li.ping288@zte.com.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Jun 2017 10:38:09 +0000
Message-ID: <CAJ+F1CKf=pmcGAmDJ+SQefU-NVeNiF3NEaa9rri_2-At0=deFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] QEMU Guest Agent: Fix memory leak of
 device information set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Ping <li.ping288@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

On Tue, Jun 13, 2017 at 2:23 PM Li Ping <li.ping288@zte.com.cn> wrote:

> The caller of SetupDiGetClassDevs must delete the returned device
> information
>  set when it is no longer needed by calling SetupDiDestroyDeviceInfoList.
>
> Signed-off-by: Li Ping<li.ping288@zte.com.cn>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  qga/commands-win32.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 439d229..6f16457 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -512,7 +512,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Erro=
r
> **errp)
>              } else {
>                  error_setg_win32(errp, GetLastError(),
>                          "failed to get device name");
> -                goto out;
> +                goto free_dev_info;
>              }
>          }
>
> @@ -560,6 +560,9 @@ static GuestPCIAddress *get_pci_info(char *guid, Erro=
r
> **errp)
>          pci->bus =3D bus;
>          break;
>      }
> +
> +free_dev_info:
> +    SetupDiDestroyDeviceInfoList(dev_info);
>  out:
>      g_free(buffer);
>      g_free(name);
> --
> 1.8.3.1
>
>
>
> --
Marc-Andr=C3=A9 Lureau
