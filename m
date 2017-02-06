Received: from eggs.gnu.org ([2001:4830:134:3::10]:46993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafxg-000694-1K
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafxc-0005mC-T4
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:51:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cafxc-0005ly-MT
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:51:48 -0500
References: <1485870329-79428-1-git-send-email-eswierk@skyportsystems.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb29fec4-b380-7b84-6e88-de3a83e17edc@redhat.com>
Date: Mon, 6 Feb 2017 10:51:44 +0100
MIME-Version: 1.0
In-Reply-To: <1485870329-79428-1-git-send-email-eswierk@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] char: drop data written to a disconnected
 pty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, berrange@redhat.com, marcandre.lureau@redhat.com, eblake@redhat.com, ben@skyportsystems.com



On 31/01/2017 14:45, Ed Swierk wrote:
> When a serial port writes data to a pty that's disconnected, drop the
> data and return the length dropped. This avoids triggering pointless
> retries in callers like the 16550A serial_xmit(), and causes
> qemu_chr_fe_write() to write all data to the log file, rather than
> logging only while a pty client like virsh console happens to be
> connected.
> 
> Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
> ---
>  qemu-char.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-char.c b/qemu-char.c
> index 676944a..ccb6923 100644
> --- a/qemu-char.c
> +++ b/qemu-char.c
> @@ -1528,7 +1528,7 @@ static int pty_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
>          /* guest sends data, check for (re-)connect */
>          pty_chr_update_read_handler_locked(chr);
>          if (!s->connected) {
> -            return 0;
> +            return len;
>          }
>      }
>      return io_channel_send(s->ioc, buf, len);
> 

Rebased and queued, thanks.

Paolo
