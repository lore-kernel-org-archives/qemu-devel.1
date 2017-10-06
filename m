Received: from eggs.gnu.org ([2001:4830:134:3::10]:54816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0SDx-0002eB-JO
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0SDw-0001K5-Rj
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:59:29 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:46538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0SDw-0001JC-JB
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:59:28 -0400
Received: by mail-wm0-x235.google.com with SMTP id m72so7497929wmc.1
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 05:59:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 13:59:06 +0100
Message-ID: <CAFEAcA-xTX8sL-ybzTs0p68B522ME=ckLo6NL=A1WV8N8bSwoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, xen-devel@nongnu.org

On 4 October 2017 at 17:18, Ian Jackson <ian.jackson@eu.citrix.com> wrote:
> This allows the caller to specify a uid and gid to use, even if there
> is no corresponding password entry.  This will be useful in certain
> Xen configurations.
>
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---


> @@ -166,17 +187,19 @@ void os_parse_cmd_args(int index, const char *optarg)
>
>  static void change_process_uid(void)
>  {
> -    if (user_pwd) {
> -        if (setgid(user_pwd->pw_gid) < 0) {
> +    if (user_pwd || user_uid != (uid_t)-1) {
> +        if (setgid(user_pwd ? user_pwd->pw_gid : user_gid) < 0) {
>              fprintf(stderr, "Failed to setgid(%d)\n", user_pwd->pw_gid);

If you're changing the gid we pass to setgid() I think you should
also change the value we tell the user we tried to use in the
error message, or it could be rather confusing.

>              exit(1);
>          }
> -        if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
> +        if ((user_pwd
> +             ? initgroups(user_pwd->pw_name, user_pwd->pw_gid)
> +             : setgroups(1, &user_gid)) < 0) {
>              fprintf(stderr, "Failed to initgroups(\"%s\", %d)\n",
>                      user_pwd->pw_name, user_pwd->pw_gid);

...and here we might claim we failed initgroups() when we actually
failed setgroups().

>              exit(1);
>          }
> -        if (setuid(user_pwd->pw_uid) < 0) {
> +        if (setuid(user_pwd ? user_pwd->pw_uid : user_gid) < 0) {
>              fprintf(stderr, "Failed to setuid(%d)\n", user_pwd->pw_uid);

This error message should be updated too.

thanks
-- PMM
