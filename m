Received: from eggs.gnu.org ([2001:4830:134:3::10]:37107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOTdV-0003Cm-Pp
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOTdR-0007j0-N2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:53:25 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOTdR-0007iZ-Gm
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:53:21 -0400
Received: by mail-qt0-x241.google.com with SMTP id q13-v6so29358678qtp.4
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 12:53:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180531192419.4592-1-samuel.thibault@ens-lyon.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <784d48eb-5dc1-7bde-e32f-e3c27b6b65a1@amsat.org>
Date: Thu, 31 May 2018 16:53:17 -0300
MIME-Version: 1.0
In-Reply-To: <20180531192419.4592-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] slirp: Fix spurious error report when
 sending directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jan.kiszka@siemens.com

Hi Samuel,

On 05/31/2018 04:24 PM, Samuel Thibault wrote:
> When DEBUG is enabled, len needs to be updated.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  slirp/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/slirp/socket.c b/slirp/socket.c
> index e2a71c9b04..3182477ff5 100644
> --- a/slirp/socket.c
> +++ b/slirp/socket.c
> @@ -351,7 +351,7 @@ sosendoob(struct socket *so)
>  
>  	if (sb->sb_rptr < sb->sb_wptr) {
>  		/* We can send it directly */
> -		n = slirp_send(so, sb->sb_rptr, so->so_urgc, (MSG_OOB)); /* |MSG_DONTWAIT)); */
> +		len = n = slirp_send(so, sb->sb_rptr, so->so_urgc, (MSG_OOB)); /* |MSG_DONTWAIT)); */
>  	} else {
>  		/*
>  		 * Since there's no sendv or sendtov like writev,
> 

Isn't it cleaner to move the DEBUG code in the else { }?

        if (sb->sb_rptr < sb->sb_wptr) {
            /* We can send it directly */
            n = slirp_send(...
        } else {
            ...
            n = slirp_send(...
    #ifdef DEBUG
            if (n != len) {
                DEBUG_ERROR("Didn't send all data urgently ...
            }
    #endif
        }
