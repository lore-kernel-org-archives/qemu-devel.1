Received: from eggs.gnu.org ([2001:4830:134:3::10]:37659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dHz3d-0002ft-FE
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dHz3a-0004o9-DR
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:57:01 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dHz3a-0004nr-6d
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:56:58 -0400
Received: by mail-oi0-x244.google.com with SMTP id v74so53990oie.2
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 13:56:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170602130518.22943-1-alex.bennee@linaro.org>
	<20170602130518.22943-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <058c5b1b-d835-f40e-2233-b6d69e21012a@amsat.org>
Date: Mon, 5 Jun 2017 17:56:52 -0300
MIME-Version: 1.0
In-Reply-To: <20170602130518.22943-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/4] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

On 06/02/2017 10:05 AM, Alex Bennée wrote:
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
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

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
