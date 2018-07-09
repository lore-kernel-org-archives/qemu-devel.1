Received: from eggs.gnu.org ([2001:4830:134:3::10]:46114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcYIu-0004Mu-G9
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcYIr-0005mH-AV
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:42:20 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fcYIr-0005lq-0z
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:42:17 -0400
Received: by mail-wm0-x241.google.com with SMTP id b188-v6so21671146wme.3
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 08:42:16 -0700 (PDT)
References: <20180709125452.7utyomtsxr6xaxdi@vm.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180709125452.7utyomtsxr6xaxdi@vm.localdomain>
Date: Mon, 09 Jul 2018 16:42:14 +0100
Message-ID: <878t6ke7qh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fix gdbserver_state pointer validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stephane duverger <stephane.duverger@gmail.com>
Cc: qemu-devel@nongnu.org


stephane duverger <stephane.duverger@gmail.com> writes:

> Hi,
>
> This is a small patch to gdbstub rather insignificant at first sight:
> fix null pointer dereference. It actually allows to take benefit of
> gdb features (breakpoints/sstep) internally (ie. special purpose
> board) without connecting a gdb client to the Qemu instance gdbserver
> stub.

There don't seem to be any other patches attached? I would NACK a patch
that isn't actually used in-tree. I would also like to see how this
would be used because we certainly have different paths for KVM and TCG
break-point emulation that don't need to go through the gdbstub to
achieve what they are doing.

>
> Regards,
>
> Signed-off-by: Stephane Duverger <stephane.duverger@gmail.com>
> ---
>  gdbstub.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index d6ab95006c..788fd625ab 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1412,6 +1412,9 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>
>  void gdb_set_stop_cpu(CPUState *cpu)
>  {
> +    if (!gdbserver_state) {
> +        return;
> +    }
>      gdbserver_state->c_cpu =3D cpu;
>      gdbserver_state->g_cpu =3D cpu;
>  }


--
Alex Benn=C3=A9e
