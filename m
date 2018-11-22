Received: from eggs.gnu.org ([2001:4830:134:3::10]:43452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPxjz-0002N8-Mp
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPxjw-0000og-JW
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:46:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPxjw-0000n2-DE
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:46:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so7041345wmi.3
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 14:46:28 -0800 (PST)
References: <20181122133207.29928-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0e3834f7-7345-2e23-9b85-254ac354d20b@redhat.com>
Date: Thu, 22 Nov 2018 23:46:26 +0100
MIME-Version: 1.0
In-Reply-To: <20181122133207.29928-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] audio/hda: fix guest triggerable assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Hi Gerd,

On 22/11/18 14:32, Gerd Hoffmann wrote:
> Guest writes to a readonly register trigger the assert in
> intel_hda_reg_write().  Add a check and just ignore them.

Is this 3.1 material? It seems to apply.

> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1628433
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/audio/intel-hda.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index 23a2cf6484..066532713c 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -929,6 +929,10 @@ static void intel_hda_reg_write(IntelHDAState *d, const IntelHDAReg *reg, uint32
>      if (!reg) {
>          return;
>      }
> +    if (!reg->wmask) {
> +        /* read-only register */

Can you add:

           qemu_log_mask(LOG_GUEST_ERROR,
                         "intel-hda: Register %s is read-only\n",
                         reg->name);

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        return;
> +    }
>  
>      if (d->debug) {
>          time_t now = time(NULL);
> 
