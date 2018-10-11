Received: from eggs.gnu.org ([2001:4830:134:3::10]:33351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gAbKL-0005jd-Nw
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gAbKG-0003lL-Oo
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:48:33 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gAbKC-0003cf-IM
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:48:25 -0400
Received: by mail-ot1-x342.google.com with SMTP id k9so8936222otl.10
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 06:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
	<20181010133516.24538.63822.stgit@pasha-VirtualBox>
In-Reply-To: <20181010133516.24538.63822.stgit@pasha-VirtualBox>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu, 11 Oct 2018 19:48:06 +0600
Message-ID: <CANzW0muL8Qi+N0E0j0j=MZB-YUDbJw6Ua7YF=4SJf91fz5G5sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 18/19] replay: init rtc after enabling
 the replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.com, dovgaluk@ispras.ru, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, kwolf@redhat.com, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

I guess 'configure_rtc' function is not the only one which call should be
postponed. Since record/replay uses its 'hooks' at very low levels of qemu
core, any option processing is subject to potential indirect dependence on
effects of 'replay_configure' call. The most apparent example would be
'qemu_clock_get_*(QEMU_CLOCK_HOST)' calls, which are used widely.
Furthermore, right now I submitting a patch which adds one such call in
place before any option parsed yet, so it will also need to be moved to
follow this patch. Even if such calls aren't involved in current version,
no guarantees that they will not appear in future (like I already doing
it), because there are nothing which prevents developers from doing so.

One way, how this could be enforced, is to add something like
'REPLAY_MODE_INVALID' to 'ReplayMode' enum, replace initialization of
global 'replay_mode' variable with this value and add corresponding
checks/assertions to 'REPLAY_CLOCK' macro, etc.

But it would be more reliable to move 'icount_opts' processing out of
common processing loop (marked as 'second pass of option parsing') and
place it to new pass, located before current 'second' one (like it already
done for '-nouserconfig' option), and also move 'replace_configure' right
after it. Probably it will also require to tune 'icount_opts' processing
and record/replay initialization. Since record/replay feature is very
specific, I consider it's worth to make such exception for it.

=D1=81=D1=80, 10 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 19:32, Pavel Dovga=
lyuk <Pavel.Dovgaluk@ispras.ru>:

> This patch postpones the call of 'configure_rtc' function. This call
> uses host clock to configure the rtc, but host clock access should be
> recorded when using icount record/replay mode. Therefore now rtc
> is configured after switching record/replay mode on.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  vl.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index a3e2e47..f910072 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2932,6 +2932,7 @@ int main(int argc, char **argv, char **envp)
>      DisplayState *ds;
>      QemuOpts *opts, *machine_opts;
>      QemuOpts *icount_opts =3D NULL, *accel_opts =3D NULL;
> +    QemuOpts *rtc_opts =3D NULL;
>      QemuOptsList *olist;
>      int optind;
>      const char *optarg;
> @@ -3738,12 +3739,11 @@ int main(int argc, char **argv, char **envp)
>                  warn_report("This option is ignored and will be removed
> soon");
>                  break;
>              case QEMU_OPTION_rtc:
> -                opts =3D qemu_opts_parse_noisily(qemu_find_opts("rtc"),
> optarg,
> -                                               false);
> -                if (!opts) {
> +                rtc_opts =3D qemu_opts_parse_noisily(qemu_find_opts("rtc=
"),
> +                                                   optarg, false);
> +                if (!rtc_opts) {
>                      exit(1);
>                  }
> -                configure_rtc(opts);
>                  break;
>              case QEMU_OPTION_tb_size:
>  #ifndef CONFIG_TCG
> @@ -3954,6 +3954,9 @@ int main(int argc, char **argv, char **envp)
>      loc_set_none();
>
>      replay_configure(icount_opts);
> +    if (rtc_opts) {
> +        configure_rtc(rtc_opts);
> +    }
>
>      if (incoming && !preconfig_exit_requested) {
>          error_report("'preconfig' and 'incoming' options are "
>
> --

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
