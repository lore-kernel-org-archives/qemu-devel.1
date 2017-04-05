Received: from eggs.gnu.org ([2001:4830:134:3::10]:57692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cvl45-0003DC-0h
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cvl41-0004Fj-LG
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:33:37 -0400
Received: from mail.ispras.ru ([83.149.199.45]:54784)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cvl41-0004FB-Cx
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:33:33 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170405132503.32125-1-alex.bennee@linaro.org>
	<20170405132503.32125-13-alex.bennee@linaro.org>
In-Reply-To: <20170405132503.32125-13-alex.bennee@linaro.org>
Date: Wed, 5 Apr 2017 16:33:32 +0300
Message-ID: <001001d2ae11$386f9700$a94ec500$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v2 12/12] replay: assert time only goes
 forward
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, rth@twiddle.net, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>=20
> If we find ourselves trying to add an event to the log where time has
> gone backwards it is because a vCPU event has occurred and the
> main-loop is not yet aware of time moving forward. This should not
> happen and if it does its better to fail early than generate a log
> that will have weird behaviour.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  replay/replay-internal.c | 4 ++++
>  replay/replay.c          | 4 ++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/replay/replay-internal.c b/replay/replay-internal.c
> index bea7b4aa6b..fca8514012 100644
> --- a/replay/replay-internal.c
> +++ b/replay/replay-internal.c
> @@ -195,6 +195,10 @@ void replay_save_instructions(void)
>      if (replay_file && replay_mode =3D=3D REPLAY_MODE_RECORD) {
>          replay_mutex_lock();
>          int diff =3D (int)(replay_get_current_step() - =
replay_state.current_step);
> +
> +        /* Time can only go forward */
> +        assert(diff >=3D 0);
> +
>          if (diff > 0) {

This "if" is useless then.

>              replay_put_event(EVENT_INSTRUCTION);
>              replay_put_dword(diff);
> diff --git a/replay/replay.c b/replay/replay.c
> index 9e0724e756..f810628cac 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -84,6 +84,10 @@ void replay_account_executed_instructions(void)
>          if (replay_state.instructions_count > 0) {
>              int count =3D (int)(replay_get_current_step()
>                                - replay_state.current_step);
> +
> +            /* Time can only go forward */
> +            assert(count >=3D 0);
> +
>              replay_state.instructions_count -=3D count;
>              replay_state.current_step +=3D count;
>              if (replay_state.instructions_count =3D=3D 0) {
> --
> 2.11.0


Pavel Dovgalyuk
