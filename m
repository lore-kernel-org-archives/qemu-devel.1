Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B27CC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F8320879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQPIUCmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F8320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43423 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRPY-0007eS-6v
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:36:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hTROH-0006yt-QY
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hTROG-0003vL-Ch
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:34:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hTROF-0003uF-To
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:34:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id b18so2312074wrq.12
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=PDpyfNYmslaP+4wSm4N3T4VAsDGVzTGz0XsZRcboFcM=;
	b=oQPIUCmbW0aaXllvmifF8iPcOV/bV92t+6Dz3i2xeKuLNJV8FHkMWexFNQDxybot5V
	ZfaKKPJoyxzGIUe4AwbrmeaFkl+vuGU/civkPylWz/x1QQZ9/2npMdhjnFyc6y+stdw0
	GFmY/dLinSJRo1LaudEDgAdCI+nhxwnQ7uqid9R31IBLOE0cZdJQQPjTLXm0JYvEUZge
	DJuIc4GGaAEv/x2L01tR2wC81thsXFbgqMDaAj7nPmmznaLuRB4x56Sakzp7YDNLdHpD
	mCGganqmY1HVegs6R67hTaoID308PfLqmMK5FMcSijnZi96V77TXggtZGM7O/c8vjT70
	afaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=PDpyfNYmslaP+4wSm4N3T4VAsDGVzTGz0XsZRcboFcM=;
	b=KG3oT3kTVoL+NJxNBDov5CU/nOvLM23iSdCj10w35pz7JUk9KxQ5leqsEWoCejq0Ft
	Z+Lvd3G2Y1C1UX8a0SdFQ3gOHwZSAIPdbTxnIl41PoL/Q50+laV8rE1Hc9ffQsMDjn6W
	04IE+ktHz+ibBoP5i1dY5WLfH/hKuSrXKtpovJOC4TjA/rcxoPyoJaB7Umj5XdOGFZ/2
	WAzklxvHS9B23yop+Mw+rLHJcZ/w92p/5JTtpgsUuozVAqluVjoAyKrztZBE5aspyciW
	jsS90VKPg3tgRDgnYR+kbiCdrvxKI2AZIeQNGfruR7g9Hw9hUVO+H74kNke5Www2VRbm
	GlHw==
X-Gm-Message-State: APjAAAVMdVHjDQwE6Jsyi1YYhcdaEaCtVenubmjMHjXftckhvfCOEKum
	OMkHig1zu0z9C/nsCIcYJCKRHYzePQ/5hUOl/oQ=
X-Google-Smtp-Source: APXvYqwYYACP9NdcCaZe0U01X+0Epf3y0XoO+tFalAcRMfi4OM/625WG6Qe/BDiEY/C4YUDlfNoPxg/Jek2auwEbWY0=
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr12034736wru.18.1558532081994; 
	Wed, 22 May 2019 06:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190519084815.7410-1-ppandit@redhat.com>
In-Reply-To: <20190519084815.7410-1-ppandit@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 May 2019 15:34:30 +0200
Message-ID: <CAJ+F1CLXdw4gE45vVEpStKrKsu-OYy1+5caC9wUduEtQRhjrpA@mail.gmail.com>
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2] qga: check length of command-line &
 environment variables
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
	"Daniel P . Berrange" <berrange@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Niu Guoxiang <niuguoxiang@huawei.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sun, May 19, 2019 at 10:55 AM P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Qemu guest agent while executing user commands does not seem to
> check length of argument list and/or environment variables passed.
> It may lead to integer overflow or infinite loop issues. Add check
> to avoid it.

Are you intentionally not telling where these overflow or loop happen?

Isn't the kernel already giving an error if given too much
environment/arguments on exec?

>
> Reported-by: Niu Guoxiang <niuguoxiang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  qga/commands-posix.c   | 18 ++++++++++++++++++
>  qga/commands-win32.c   | 13 +++++++++++++
>  qga/commands.c         |  8 ++++++--
>  qga/guest-agent-core.h |  2 ++
>  4 files changed, 39 insertions(+), 2 deletions(-)
>
> Update v2: add helper function ga_get_arg_max()
>   -> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06360.html
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 7ee6a33cce..e0455722e0 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -60,6 +60,24 @@ extern char **environ;
>  #endif
>  #endif
>
> +size_t ga_get_arg_max(void)
> +{
> +    /* Since kernel 2.6.23, most architectures support argument size lim=
it
> +     * derived from the soft RLIMIT_STACK resource limit (see getrlimit(=
2)).
> +     * For these architectures, the total size is limited to 1/4 of the
> +     * allowed stack size. (see execve(2))
> +     *
> +     * struct rlimit r;
> +     *
> +     * getrlimit(RLIMIT_STACK, &r);
> +     * ARG_MAX =3D r.rlim_cur / 4;
> +     *
> +     * ARG_MAX is _NOT_ the maximum number of arguments. It is size of t=
he
> +     * memory used to hold command line arguments and environment variab=
les.
> +     */
> +    return sysconf(_SC_ARG_MAX);
> +}
> +
>  static void ga_wait_child(pid_t pid, int *status, Error **errp)
>  {
>      pid_t rpid;
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6b67f16faf..47bbddd74a 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -92,6 +92,19 @@ static OpenFlags guest_file_open_modes[] =3D {
>      g_free(suffix); \
>  } while (0)
>
> +size_t ga_get_arg_max(void)
> +{
> +    /* Win32 environment has different values for the ARG_MAX constant.
> +     * We'll go with the maximum here.
> +     *
> +     * https://devblogs.microsoft.com/oldnewthing/?p=3D41553
> +     *
> +     * ARG_MAX is _NOT_ the maximum number of arguments. It is size of t=
he
> +     * memory used to hold command line arguments and environment variab=
les.
> +     */
> +    return 32767;
> +}
> +
>  static OpenFlags *find_open_flag(const char *mode_str)
>  {
>      int mode;
> diff --git a/qga/commands.c b/qga/commands.c
> index 0c7d1385c2..425a4c405f 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -231,17 +231,21 @@ static char **guest_exec_get_args(const strList *en=
try, bool log)
>      int count =3D 1, i =3D 0;  /* reserve for NULL terminator */
>      char **args;
>      char *str; /* for logging array of arguments */
> -    size_t str_size =3D 1;
> +    size_t str_size =3D 1, arg_max;
>
> +    arg_max =3D ga_get_arg_max();
>      for (it =3D entry; it !=3D NULL; it =3D it->next) {
>          count++;
>          str_size +=3D 1 + strlen(it->value);
> +        if (str_size >=3D arg_max || count >=3D arg_max / 2) {
> +            break;

This seems to silently drop remaining arguments, which is probably not
what you want.

> +        }
>      }
>
>      str =3D g_malloc(str_size);
>      *str =3D 0;
>      args =3D g_malloc(count * sizeof(char *));
> -    for (it =3D entry; it !=3D NULL; it =3D it->next) {
> +    for (it =3D entry; it !=3D NULL && i < count; it =3D it->next) {
>          args[i++] =3D it->value;
>          pstrcat(str, str_size, it->value);
>          if (it->next) {
> diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
> index 60eae16f27..300ff7e482 100644
> --- a/qga/guest-agent-core.h
> +++ b/qga/guest-agent-core.h
> @@ -46,6 +46,8 @@ const char *ga_fsfreeze_hook(GAState *s);
>  int64_t ga_get_fd_handle(GAState *s, Error **errp);
>  int ga_parse_whence(GuestFileWhence *whence, Error **errp);
>
> +size_t ga_get_arg_max(void);
> +
>  #ifndef _WIN32
>  void reopen_fd_to_null(int fd);
>  #endif
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

