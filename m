Received: from eggs.gnu.org ([2001:4830:134:3::10]:41961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fBKVZ-0006M5-L9
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fBKVW-0004wu-IO
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:30:53 -0400
References: <20180425131828.15604-1-clg@kaod.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06ef1590-370a-4f76-f0bf-bfcce81328c1@redhat.com>
Date: Wed, 25 Apr 2018 15:30:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180425131828.15604-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cpus: tcg: fix never exiting loop on unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-stable <qemu-stable@nongnu.org>

On 25/04/2018 15:18, C=C3=A9dric Le Goater wrote:
> Commit 9b0605f9837b ("cpus: tcg: unregister thread with RCU, fix
> exiting of loop on unplug") changed the exit condition of the loop in
> the vCPU thread function but forgot to remove the beginning 'while (1)'
> statement. The resulting code :
>=20
> 	while (1) {
> 	...
> 	} while (!cpu->unplug || cpu_can_run(cpu));
>=20
> is a sequence of two distinct two while() loops, the first not exiting
> in case of an unplug event.
>=20
> Remove the first while (1) to fix CPU unplug.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  cpus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/cpus.c b/cpus.c
> index 38eba8bff334..e1d94038fd0d 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1648,7 +1648,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>      /* process any pending work */
>      cpu->exit_request =3D 1;
> =20
> -    while (1) {
> +    do {
>          if (cpu_can_run(cpu)) {
>              int r;
>              qemu_mutex_unlock_iothread();
>=20

Cc: qemu-stable@nongnu.org

Queued, thanks.

Paolo
