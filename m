Received: from eggs.gnu.org ([2001:4830:134:3::10]:35936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGSQd-0000jR-9l
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGSQc-00021r-Aa
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:54:27 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:36503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGSQc-00021d-5w
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:54:26 -0400
Received: by mail-it0-x244.google.com with SMTP id i206so6865625ita.3
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 08:54:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170601144915.20778-1-alex.bennee@linaro.org>
	<20170601144915.20778-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <93f2fcbc-5f8c-6d50-5ddf-18b37efa0785@amsat.org>
Date: Thu, 1 Jun 2017 12:54:23 -0300
MIME-Version: 1.0
In-Reply-To: <20170601144915.20778-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

On 06/01/2017 11:49 AM, Alex Bennée wrote:
> The thread-id of 0 means any CPU but we then ignore the fact we find
> the first_cpu in this case who can have an index of 0. Instead of
> bailing out just test if we have managed to match up thread-id to a
> CPU.
>
> Otherwise you get:
>   gdb_handle_packet: command='vCont;C04:0;c'
>   put_packet: reply='E22'
>
> The actual reason for gdb sending vCont;C04:0;c was fixed in a
> previous commit where we ensure the first_cpu's tid is correctly
> reported to gdb however we should still behave correctly next time it
> does send 0.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
> ---
> v2
>   - used Greg's less convoluted suggestion
>   - expand commit message
> ---
>  gdbstub.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 45a3a0b16b..6b1e72e9f7 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -937,23 +937,16 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
>              if (res) {
>                  goto out;
>              }
> -            idx = tmp;
> +
>              /* 0 means any thread, so we pick the first valid CPU */
> -            if (!idx) {
> -                idx = cpu_gdb_index(first_cpu);
> -            }
> +            cpu = tmp ? find_cpu(tmp) : first_cpu;
>
> -            /*
> -             * If we are in user mode, the thread specified is actually a
> -             * thread id, and not an index. We need to find the actual
> -             * CPU first, and only then we can use its index.
> -             */
> -            cpu = find_cpu(idx);
>              /* invalid CPU/thread specified */
> -            if (!idx || !cpu) {
> +            if (!cpu) {
>                  res = -EINVAL;
>                  goto out;
>              }
> +
>              /* only use if no previous match occourred */
>              if (newstates[cpu->cpu_index] == 1) {
>                  newstates[cpu->cpu_index] = cur_action;
>
