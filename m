Received: from eggs.gnu.org ([2001:4830:134:3::10]:54275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d2Q9i-0008AC-LN
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d2Q9e-0007bM-3i
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:38:58 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d2Q9d-0007al-VL
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:38:54 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so7814545qkh.0
	for <qemu-devel@nongnu.org>; Sun, 23 Apr 2017 15:38:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170423223240.17917-1-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ae985b05-a8ad-adb8-0e7a-1ec6ba631402@amsat.org>
Date: Sun, 23 Apr 2017 19:38:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170423223240.17917-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/misc_helper.c: wrap
 s390_virtio_hypercall in BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

Hi Aurelien!

Why don't lock inside s390_virtio_hypercall() directly round the diag500 
dispatch call?

regards,

Phil.

On 04/23/2017 07:32 PM, Aurelien Jarno wrote:
> s390_virtio_hypercall can trigger IO events and interrupts, most notably
> when using virtio-ccw devices.
>
> Reviewed-by: Alexander Graf <agraf@suse.de>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/s390x/misc_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 4946b56ab3..aec737d707 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -307,7 +307,9 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
>      switch (num) {
>      case 0x500:
>          /* KVM hypercall */
> +        qemu_mutex_lock_iothread();
>          r = s390_virtio_hypercall(env);
> +        qemu_mutex_unlock_iothread();
>          break;
>      case 0x44:
>          /* yield */
>
