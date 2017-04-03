Received: from eggs.gnu.org ([2001:4830:134:3::10]:44437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv2XK-0008Cd-Oc
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv2XH-0002bK-D5
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:00:50 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv2XH-0002b2-8k
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:00:47 -0400
Received: by mail-qk0-x242.google.com with SMTP id k139so7946942qke.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 07:00:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a9540b31-d910-18c4-4798-f1ec1ba41af9@amsat.org>
Date: Mon, 3 Apr 2017 11:00:41 -0300
MIME-Version: 1.0
In-Reply-To: <20170403124524.10824-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 6/9] cpus: check cpu->running in
 cpu_get_icount_raw()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, dovgaluk@ispras.ru, rth@twiddle.net, pbonzini@redhat.com
Cc: mttcg@listserver.greensocs.com, peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, a.rigo@virtualopensystems.com, qemu-devel@nongnu.org, cota@braap.org, bobby.prani@gmail.com, fred.konrad@greensocs.com

On 04/03/2017 09:45 AM, Alex Bennée wrote:
> The lifetime of current_cpu is now the lifetime of the vCPU thread.
> However get_icount_raw() can apply a fudge factor if called while code
> is running to take into account the current executed instruction
> count.
>
> To ensure this is always the case we also check cpu->running.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  cpus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index 4e48b9c4ad..18b1746770 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -229,7 +229,7 @@ int64_t cpu_get_icount_raw(void)
>      CPUState *cpu = current_cpu;
>
>      icount = timers_state.qemu_icount;
> -    if (cpu) {
> +    if (cpu && cpu->running) {
>          if (!cpu->can_do_io) {
>              fprintf(stderr, "Bad icount read\n");
>              exit(1);
>
